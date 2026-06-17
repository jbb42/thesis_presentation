<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount, nextTick } from 'vue'
import { useNav } from '@slidev/client'

const { clicks } = useNav()

const cx = 200
const cy = 200
const k = 0.2
const BASE_RADIUS = 70
const MAX_RADIUS = 190

const t = ref(0)
const scale = ref(1)
const isFinished = ref(false)

let rafId = null
let last = 0
let started = false
let isVisible = false          

const raisins = [
  [10, -20], [-15, 25], [18, 30], [-22, -18],
  [35, 10], [-40, 15], [25, -35], [-30, -40],
  [45, 20], [-50, -10], [12, 50], [-10, -55],
  [55, -15], [-60, 5], [20, -60], [-25, 55],
  [60, 30], [-55, 35], [30, 60], [-35, -60],
  [65, 0], [-60, -25], [15, -45], [-20, 40],
  [0, 0]
]

const pieData = [
  { value: 0.050, color: '#2ea381', label: 'SM' },
  { value: 0.265, color: '#4287DE', label: 'DM' },
  { value: 0.685, color: '#a45cb8', label: 'DE' }
]

function step(now) {
  const dt = (now - last) / 1000
  last = now
  t.value += dt
  
  const nextScale = Math.exp(k * t.value)
  
  if (BASE_RADIUS * nextScale >= MAX_RADIUS) {
    scale.value = MAX_RADIUS / BASE_RADIUS
    isFinished.value = true
    return
  }
  
  scale.value = nextScale
  rafId = requestAnimationFrame(step)
}

function reset() {                       
  cancelAnimationFrame(rafId)
  rafId = null
  t.value = 0
  scale.value = 1
  started = false
  isFinished.value = false
}

function start() {
  if (started) return
  started = true
  last = performance.now()
  rafId = requestAnimationFrame(step)
}

async function tryStart() {
  await nextTick()
  const el = document.querySelector('.raisin-bun')
  if (!el) return
  const nowVisible = !el.closest('.slidev-vclick-hidden')
  if (nowVisible && !isVisible) {        
    reset()
    start()
  }
  isVisible = nowVisible                 
}

onMounted(tryStart)
watch(clicks, tryStart)
onBeforeUnmount(() => {
  cancelAnimationFrame(rafId)
})

const transformedRaisins = computed(() =>
  raisins.map(([x, y]) => ({
    x: cx + x * scale.value,
    y: cy + y * scale.value,
  }))
)

const pieSlices = computed(() => {
  let accumulatedAngle = 0
  
  return pieData.map(slice => {
    const startAngle = accumulatedAngle
    const endAngle = accumulatedAngle + slice.value * 2 * Math.PI
    accumulatedAngle = endAngle

    const x1 = cx + MAX_RADIUS * Math.sin(startAngle)
    const y1 = cy - MAX_RADIUS * Math.cos(startAngle)
    const x2 = cx + MAX_RADIUS * Math.sin(endAngle)
    const y2 = cy - MAX_RADIUS * Math.cos(endAngle)

    const largeArcFlag = slice.value > 0.5 ? 1 : 0

    const pathData = `
      M ${cx} ${cy}
      L ${x1} ${y1}
      A ${MAX_RADIUS} ${MAX_RADIUS} 0 ${largeArcFlag} 1 ${x2} ${y2}
      Z
    `

    const midAngle = startAngle + (slice.value * Math.PI) 
    
    // NARROW SLICE FIX: If a slice is under 10%, push the text further outward
    // so it doesn't get squished or bleed into other slices near the center.
    const isNarrow = slice.value < 0.1
    const labelRadius = MAX_RADIUS * (isNarrow ? 0.82 : 0.60) 
    
    const labelX = cx + labelRadius * Math.sin(midAngle)
    const labelY = cy - labelRadius * Math.cos(midAngle)

    const percentage = parseFloat((slice.value * 100).toFixed(1)) + '%'

    return {
      d: pathData,
      color: slice.color,
      label: slice.label,
      percentage,
      labelX,
      labelY,
      fontSize: isNarrow ? '20' : '20' // Scale down font slightly if narrow
    }
  })
})
</script>

<template>
  <div class="flex justify-center items-center h-full raisin-bun">
    <svg width="400" height="400" viewBox="0 0 400 400">
      <g v-if="isFinished">
        <g v-for="(slice, i) in pieSlices" :key="i">
          <path 
            :d="slice.d" 
            :fill="slice.color"
            stroke="#ffffff"
            stroke-width="2"
          />
          <text
            :x="slice.labelX"
            :y="slice.labelY"
            fill="#ffffff"
            :font-size="slice.fontSize"
            font-family="sans-serif"
            font-weight="bold"
            text-anchor="middle"
            dominant-baseline="middle"
            style="text-shadow: 1px 1px 2px rgba(0,0,0,0.4);"
          >
            <tspan :x="slice.labelX" dy="-0.4em">{{ slice.label }}</tspan>
            <tspan :x="slice.labelX" dy="1.2em" font-weight="normal" opacity="0.9">
              {{ slice.percentage }}
            </tspan>
          </text>
        </g>
      </g>

      <g v-else>
        <ellipse
          :cx="cx"
          :cy="cy"
          :rx="70 * scale"
          :ry="70 * scale"
          fill="#FFF8E7"
          stroke="#8b7355"
          stroke-width="2"
        />
        <circle
          v-for="(r, i) in transformedRaisins"
          :key="i"
          :cx="r.x"
          :cy="r.y"
          r="4"
          fill="#4b2c20"
        />
      </g>
    </svg>
  </div>
</template>