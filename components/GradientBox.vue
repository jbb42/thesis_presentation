<template>
  <div :class="[width, 'bg-[linear-gradient(135deg,#2ea381_0%,#a45cb8_100%)] p-10 rounded-2xl shadow-xl mt-10 mr-4 text-white']">
    
    <div v-if="title" class="font-bold text-2xl mb-3 tracking-wide">{{ title }}</div>
    
    <div class="text-xl leading-relaxed">
      <slot />
    </div>
    
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    default: ''
  },
  width: {
    type: String,
    default: 'w-full' /* This acts as a safe default if you forget to type a width */
  }
})
</script>