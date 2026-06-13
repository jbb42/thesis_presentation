<template>
  <div class="relative w-full h-full flex flex-col items-center">
    <div class="grid grid-cols-4 gap-2 w-full">
      <div v-for="(path, i) in currentPaths" :key="i">
        <img :src="path" class="w-full h-full object-contain dark:hidden" />
        <img :src="path.replace('.svg', '_dark.svg')" class="w-full h-full object-contain hidden dark:block" />
      </div>
    </div>

    <div class="mt-4 flex gap-2 bg-gray-200 dark:bg-gray-700 p-2 rounded-lg border dark:border-gray-600">
      <button @click="step = 0" class="p-2 hover:bg-gray-300 dark:hover:bg-gray-600 rounded">Reset</button>
      <button @click="step = Math.max(0, step - 1)" class="p-2 hover:bg-gray-300 dark:hover:bg-gray-600 rounded">«</button>
      <span class="px-4 py-2 font-mono">z = {{ getActiveAnchor }}</span>
      <button @click="step = Math.min(3, step + 1)" class="p-2 hover:bg-gray-300 dark:hover:bg-gray-600 rounded">»</button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const props = defineProps({
  voidPath: { type: String, required: true },
  diovPath: { type: String, required: true }
})

const step = ref(0)
const voidAnchors = ['0.000', '0.007', '0.013', '0.019']
const diovAnchors = ['0.000', '0.001', '0.003', '0.005']

const getActiveAnchor = computed(() => voidAnchors[step.value] + " / " + diovAnchors[step.value])

const currentPaths = computed(() => {
  const vA = voidAnchors[step.value]
  const dA = diovAnchors[step.value]
  const orders = [0, 1, 2, 3]
  
  // Row 1: Void | Row 2: Diov
  const voidPlots = orders.map(o => `${props.voidPath}/error_order_${o}_anchor_${vA}.svg`)
  const diovPlots = orders.map(o => `${props.diovPath}/error_order_${o}_anchor_${dA}.svg`)
  
  return [...voidPlots, ...diovPlots]
})
</script>