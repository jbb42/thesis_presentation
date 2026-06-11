<template>
  <footer
    v-if="$slidev.nav.currentLayout !== 'cover'"
    class="absolute bottom-4 right-4 text-sm text-gray-400"
  >
    {{ $slidev.nav.currentPage }}
  </footer>
</template>