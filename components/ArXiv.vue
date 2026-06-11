<script setup>
defineProps({
  id: {
    type: String,
    required: true
  }
})
</script>

<template>
  <a 
    :href="`https://arxiv.org/abs/${id}`" 
    target="_blank" 
    class="text-sm text-gray-800 dark:text-gray-200 no-underlines"
  >
    [arXiv:{{ id }}]
  </a>
</template>