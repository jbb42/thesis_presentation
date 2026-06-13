<script setup>
import { ref, computed, watch, onUnmounted } from 'vue'
import { useNav } from '@slidev/client'

const props = defineProps(['basePath', 'diovPath', 'comparison', 'triggerClick'])

const { clicks } = useNav()
const currentIndex = ref(0)
const isPlaying = ref(false)
let timer = null

const zIndices = Array.from({ length: 20 }, (_, i) => (0.001 + i * 0.001).toFixed(3))

const toggle = () => {
  isPlaying.value = !isPlaying.value
  if (isPlaying.value) {
    timer = setInterval(() => next(), 500)
  } else {
    clearInterval(timer)
  }
}

const next = () => currentIndex.value = (currentIndex.value + 1) % zIndices.length
const prev = () => currentIndex.value = (currentIndex.value - 1 + zIndices.length) % zIndices.length
const reset = () => { currentIndex.value = 0; isPlaying.value = false; clearInterval(timer) }

onUnmounted(() => clearInterval(timer))

watch(clicks, (val) => {
  if (props.triggerClick !== undefined && val === props.triggerClick && !isPlaying.value) {
    toggle()
  }
})

const currentPaths = computed(() => {
  const z = zIndices[currentIndex.value]
  const base = ['dA_contrast', 'dA_z_contrast', 'dA_zz_contrast', 'dA_zzz_contrast']
  let paths = base.map(f => `${props.basePath}/z_${z}/${f}.svg`)
  if (props.comparison && props.diovPath) {
    let diov = base.map(f => `${props.diovPath}/z_${z}/${f}.svg`)
    return [...paths, ...diov]
  }
  return paths
})
</script>

<template>
  <div class="relative w-full h-full">
    <div class="grid gap-2" :class="comparison ? 'grid-cols-4 grid-rows-2' : 'grid-cols-4 grid-rows-1'">
      <div v-for="(path, i) in currentPaths" :key="i">
        <img :src="path" class="w-full h-full object-contain dark:hidden" />
        <img :src="path.replace('.svg', '_dark.svg')" class="w-full h-full object-contain hidden dark:block" />
      </div>
    </div>
    <div class="fixed bottom-4 left-1/2 -translate-x-1/2 z-50 flex gap-2 bg-gray-200 dark:bg-gray-700 p-2 rounded-lg shadow-xl border dark:border-gray-600">
      <button @click="prev" title="Step Back" class="p-2 hover:bg-gray-300 dark:hover:bg-gray-600 rounded">
        <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M11 18V6l-8.5 6 8.5 6zm7-12l-8.5 6 8.5 6V6z"/></svg>
      </button>
      <button @click="reset" title="Reset" class="p-2 hover:bg-gray-300 dark:hover:bg-gray-600 rounded">
        <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M6 6h12v12H6z"/></svg>
      </button>
      <button @click="toggle" title="Play/Pause" class="p-2 hover:bg-gray-300 dark:hover:bg-gray-600 rounded">
        <svg v-if="!isPlaying" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
        <svg v-else viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/></svg>
      </button>
      <button @click="next" title="Step Forward" class="p-2 hover:bg-gray-300 dark:hover:bg-gray-600 rounded">
        <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M4 18l8.5-6L4 6v12zm9-12v12l8.5-6L13 6z"/></svg>
      </button>
    </div>
  </div>
</template>