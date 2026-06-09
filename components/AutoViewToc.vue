<script setup>
import { computed } from 'vue'
import { useNav } from '@slidev/client'

// Access Slidev's global internal navigation properties
const { toc } = useNav()

// Format strings safely into valid CSS transition identifiers (e.g., "FLRW Cosmology" -> "toc-flrw-cosmology")
const formatTransitionName = (title) => {
  if (!title) return ''
  return `toc-${title.toLowerCase().replace(/[^a-z0-9]/g, '-')}`
}
</script>

<template>
  <div class="grid grid-cols-1 gap-4 mt-8 max-w-xl mx-auto">
    <div 
      v-for="item in toc" 
      :key="item.id" 
      class="text-left text-xl py-2 px-4 border-l-2 border-white/10 hover:border-emerald-400 transition-colors"
    >
      <!-- Inject an automated, unique transition name on every heading title link -->
      <span 
        class="font-light tracking-wide inline-block"
        :style="{ 'view-transition-name': formatTransitionName(item.title) }"
      >
        {{ item.title }}
      </span>
    </div>
  </div>
</template>