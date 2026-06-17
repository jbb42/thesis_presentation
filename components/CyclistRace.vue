<template>
  <div ref="container" class="simulation-container">
    <div ref="track" class="track">
      <canvas ref="plotCanvas" width="800" height="85" class="road-canvas"></canvas>
      
      <div 
        v-for="(mark, index) in milestones" 
        :key="'mark-' + index" 
        class="milestone-line"
        :style="{ left: `${mark.ratio * 100}%` }"
      >
        <span class="milestone-label">{{ mark.label }}</span>
      </div>
      
      <div class="speed-hud">⟨v⟩ = {{ (currentAvgSpeed / 4).toFixed(1) }} km/h</div>

      <div
        v-for="c in cyclists"
        :key="c.id"
        class="cyclist"
        :style="{ transform: `translate(${c.x}px, ${c.y}px) scaleX(-1)` }"
      >
        <svg width="28px" height="28px" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img">
          <path fill="#7C533E" d="M10 5c-1 1 0 2 0 3s2 0 2 0s1-1 2 1s4 1 3-1s-4-1-4-3s-3 0-3 0z" />
          <path fill="#664131" d="M19 16s-3 2-3 3s4 4 5 5s3 1 2-1s-4-7-4-7z" />
          <path fill="#7C533E" d="M19.999 17s-2 3-2 4s1 4 1 7s2 3 2 2s1.581-5.419 0-7c-1-1 2-4 2-4l-3-2zm-4.314-3.703l-2.75-.784c-.447 1.956-3.023 4.486-3.935 4.486c-1 0-2 0-2 1s0 1 2 1s4-2 5-3c.65-.65 1.309-1.757 1.685-2.702z" />
          <path fill="#DD551F" d="M19 29s1 1 2 0s1 2 1 2s-3 2-5 2s-1-1 0-2l2-2zM11 2c2-1 6 0 4 2c-1 1-7 2-7 2c0-1 1-3 3-4z" />
          <path fill="#0B0200" d="M14.347 2.901c-.745-.684-2.861-1.006-3.922.248c-.899.018-1.073.91-.906 1.372c.133.369 1.086.286 1.46.963c.128-.213.099-.592.026-.783c.353.229.369 1.007 1.634 1.272c1.223.256 1.217 1.294 1.217 1.294s.541-.397.863-.957c.614-1.071.448-2.654-.372-3.409z" />
          <path :fill="c.color === 'red' ? '#962d2d' : '#224d70'" d="M20.634 23.021s1.173.789 1.962-.385c.789-1.174 1.365 1.771 1.365 1.771s-2.559 2.539-4.521 2.924c-1.962.385-1.173-.789-.385-1.962l1.579-2.348z" />
          <path :fill="c.color === 'red' ? '#962d2d' : '#224d70'" d="M21.999 13L18 16l3 3z" />
          <path fill="#292F33" d="M7 22a7 7 0 1 0 0 14a7 7 0 0 0 0-14zm0 12a5 5 0 1 1 0-10a5 5 0 0 1 0 10zm22-12a7 7 0 1 0 .001 14.001A7 7 0 0 0 29 22zm0 12a5 5 0 1 1 0-10a5 5 0 0 1 0 10z" />
          <g :fill="c.color === 'red' ? '#98414d' : '#395f7c'">
            <path d="M22 20c0-.553-.484-1-1.083-1H10.083C9.485 19 9 19.447 9 20c0 .553.485 1 1.083 1h10.833c.6 0 1.084-.447 1.084-1zm8 9a1 1 0 0 0-1-1H18a1 1 0 1 0 0 2h11a1 1 0 0 0 1-1z" />
            <path d="M21.224 17l-4.166 11.664a1 1 0 0 0 1.884.672L23.348 17h-2.124z" />
            <path d="M29.001 30c-.33 0-.654-.164-.845-.463l-7-11a1 1 0 1 1 1.688-1.074l7 11A1 1 0 0 1 29.001 30zM19 25.734l-8.387-6.524a1 1 0 1 0-1.227 1.579l9 7a.987.987 0 0 0 .613.211H19v-2.266z" />
            <path d="M7 30a1 1 0 0 1-.948-1.317l2.772-8.316l-3.423-2.568a1 1 0 0 1 1.2-1.6l4.577 3.433l-3.228 9.684A1.004 1.004 0 0 1 7 30z" />
          </g>
          <path fill="#292F33" d="M26.383 19a.665.665 0 0 1-.089-.006l-5.672-.708a.708.708 0 0 1 .087-1.413c.041 0 4.067-.018 5.989-1.299a.713.713 0 0 1 .824.026a.712.712 0 0 1 .241.788l-.709 2.127a.705.705 0 0 1-.671.485zM11 18H6a1 1 0 0 1 0-2h5a1 1 0 0 1 0 2z" />
          <path :fill="c.color === 'red' ? '#DD2E44' : '#3B88C3'" d="M21.999 13l-3 4l4 3s5-5 5-7s-3-3-3-3l-3 3z" />
          <path :fill="c.color === 'red' ? '#DD2E44' : '#3B88C3'" d="M20.999 6.999c-3-1-5.585-.414-7 1c-1 1-1 2-1 4c0 .176-.03.362-.073.55l2.744.784c.202-.509.33-.984.33-1.334c0-1 1-1 2 0s2 2 3 2s6-4 6-4c-3.001-1-4.103-2.368-6.001-3z" />
        </svg>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, nextTick, watch } from 'vue'
import { useNav } from '@slidev/client'

const { clicks } = useNav()

const container = ref(null)
const track = ref(null)
const plotCanvas = ref(null)
const cyclists = ref([])
let id = 0

const milestones = [
  { ratio: 0.22, label: '10 km' },
  { ratio: 0.44, label: '20 km' },
  { ratio: 0.66, label: '30 km' },
  { ratio: 0.88, label: '40 km' }
]

const redSpeed = 40
const blueSpeed = 80
const currentAvgSpeed = ref(60)

const plotHistory = ref([])
const redDoublings = ref(0)
const blueDoublings = ref(0)

const slots = [
  { row: 0, col: 0 }, { row: 1, col: 0 }, { row: 2, col: 0 }, { row: 3, col: 0 },
  { row: 0, col: 1 }, { row: 1, col: 1 }, { row: 2, col: 1 }, { row: 3, col: 1 },
  { row: 0, col: 2 }, { row: 1, col: 2 }, { row: 2, col: 2 }, { row: 3, col: 2 },
  { row: 0, col: 3 }, { row: 1, col: 3 }, { row: 2, col: 3 }, { row: 3, col: 3 },
]

// ─── loop control ────────────────────────────────────────────────────────────
let rafId = null
let last = 0
let isVisible = false
let resizeObserver = null // Keeps track of our observer

function stopLoop() {
  if (rafId !== null) {
    cancelAnimationFrame(rafId)
    rafId = null
  }
}

function startLoop() {
  stopLoop()
  last = performance.now()
  function loop(now) {
    let dt = (now - last) / 1000
    if (dt > 0.1) dt = 0.1 
    
    updateSimulation(dt)
    last = now
    rafId = requestAnimationFrame(loop)
  }
  rafId = requestAnimationFrame(loop)
}
// ─────────────────────────────────────────────────────────────────────────────

function restartSimulation() {
  redDoublings.value = 0
  blueDoublings.value = 0
  currentAvgSpeed.value = 60
  id = 0
  cyclists.value = []
  plotHistory.value = []

  spawn('red', redSpeed, 0, 0)
  spawn('blue', blueSpeed, 0, 0)
}

function spawn(color, speed, leaderX, nextMarkIndex) {
  const visibleCount = cyclists.value.filter(c => c.color === color).length
  if (visibleCount >= slots.length) return

  const layout = slots[visibleCount]
  const finalY = 5 + (layout.row * 15)
  const diagonalGap = 24
  const columnGap = 36
  const calculatedX = leaderX - (layout.row * diagonalGap) - (layout.col * columnGap)

  cyclists.value.push({
    id: id++,
    color,
    x: Math.max(0, calculatedX),
    y: finalY,
    speed,
    nextMarkIndex
  })
}

function updateSimulation(dt) {
  const width = track.value?.clientWidth || 1
  const currentLength = cyclists.value.length

  const redLeader = cyclists.value.find(c => c.color === 'red' && c.y === 5)
  const blueLeader = cyclists.value.find(c => c.color === 'blue' && c.y === 5)

  if (redLeader && (redLeader.x / width) >= 1.10) {
    restartSimulation()
    return
  }

  for (let i = 0; i < currentLength; i++) {
    cyclists.value[i].x += cyclists.value[i].speed * dt
  }

  if (redLeader) {
    const redProgress = redLeader.x / width
    const targetRatio = 0.22 * (redDoublings.value + 1)
    if (redProgress >= targetRatio) {
      redDoublings.value++
      if (redDoublings.value <= 4) {
        const spawnAmount = Math.pow(2, redDoublings.value - 1)
        for (let j = 0; j < spawnAmount; j++) {
          spawn('red', redSpeed, redLeader.x, redDoublings.value)
        }
      }
    }
  }

  if (blueLeader) {
    const blueProgress = blueLeader.x / width
    const targetRatio = 0.22 * (blueDoublings.value + 1)
    if (blueProgress >= targetRatio) {
      blueDoublings.value++
      if (blueDoublings.value <= 4) {
        const spawnAmount = Math.pow(2, blueDoublings.value - 1)
        for (let j = 0; j < spawnAmount; j++) {
          spawn('blue', blueSpeed, blueLeader.x, blueDoublings.value)
        }
      }
    }
  }

  const totalRedsCalculated = Math.pow(2, redDoublings.value)
  const totalBluesCalculated = Math.pow(2, blueDoublings.value)
  const weightedAverage = ((totalRedsCalculated * redSpeed) + (totalBluesCalculated * blueSpeed)) / (totalRedsCalculated + totalBluesCalculated)
  currentAvgSpeed.value = weightedAverage

  plotHistory.value.push(weightedAverage)
  drawPlotOnRoad()
}

function drawPlotOnRoad() {
  const canvas = plotCanvas.value
  if (!canvas) return
  if (canvas.width <= 0 || canvas.height <= 0) return

  const ctx = canvas.getContext('2d')
  ctx.clearRect(0, 0, canvas.width, canvas.height)

  const history = plotHistory.value
  if (history.length < 2) return

  const totalPoints = history.length
  const stepX = canvas.width / totalPoints

  ctx.lineWidth = 3
  ctx.strokeStyle = 'rgba(63, 108, 110, 0.8)' 
  ctx.lineCap = 'round'
  ctx.lineJoin = 'round'
  ctx.beginPath()

  for (let i = 0; i < history.length; i++) {
    const x = i * stepX
    const y = canvas.height - ((history[i] - 35) * (canvas.height / 50))
    if (i === 0) ctx.moveTo(x, y)
    else ctx.lineTo(x, y)
  }
  ctx.stroke()
}

function resizeCanvas() {
  if (track.value && plotCanvas.value) {
    plotCanvas.value.width = track.value.clientWidth
    plotCanvas.value.height = track.value.clientHeight
  }
}

async function tryStart() {
  await nextTick()
  const el = container.value
  if (!el) return
  const nowVisible = !el.closest('.slidev-vclick-hidden')

  if (nowVisible && !isVisible) {
    resizeCanvas() // Forces a recalculation exactly when Slidev makes it visible
    restartSimulation()
    startLoop()
  } else if (!nowVisible && isVisible) {
    stopLoop()
  }
  isVisible = nowVisible
}

onMounted(() => {
  nextTick().then(() => {
    // Bulletproof dynamic resizing observer
    if (track.value) {
      resizeObserver = new ResizeObserver(() => {
        resizeCanvas()
      })
      resizeObserver.observe(track.value)
    }
    
    tryStart()
  })
})

watch(clicks, tryStart)

onBeforeUnmount(() => {
  stopLoop()
  if (resizeObserver && track.value) {
    resizeObserver.unobserve(track.value)
    resizeObserver.disconnect()
  }
})
</script>

<style scoped>
.simulation-container {
  width: 100%;
  font-family: sans-serif;
}

.track {
  position: absolute;
  bottom: 0px;
  left: -54px;   
  right: -54px;  
  height: 85px; 
  background: #cccc;
  overflow: hidden;
}

.road-canvas {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

.milestone-line {
  position: absolute;
  top: 0;
  bottom: 0;
  width: 1px;
  border-left: 2px dashed rgba(10, 10, 10, 0.5);
  pointer-events: none;
  z-index: 1;
}

.milestone-label {
  position: absolute;
  top: 6px;
  transform: translateX(-50%);
  font-size: 12px;
  font-weight: bold;
  color: rgba(10, 10, 10, 0.5);
  white-space: nowrap;
}

.cyclist {
  position: absolute;
  top: 0;
  left: 0;
  width: 28px;
  height: 28px;
  will-change: transform;
  z-index: 2;
}

.speed-hud {
  position: absolute;
  bottom: 6px;
  left: 64px; 
  color: rgb(63, 108, 110);
  font-size: 24px;
  font-weight: bold;
  pointer-events: none;
  z-index: 3;
}
</style>