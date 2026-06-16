<template>
  <div class="equation-reveal-container">
    
    <div class="phantom">
      <slot name="full"></slot>
    </div>
    
    <div v-show="$slidev.nav.clicks === 1" class="step">
      <slot name="step1"></slot>
    </div>
    
    <div v-show="$slidev.nav.clicks === 2" class="step">
      <slot name="step2"></slot>
    </div>
    
    <div v-show="$slidev.nav.clicks >= 3" class="step">
      <slot name="step3"></slot>
    </div>

  </div>
</template>

<style scoped>
.equation-reveal-container {
  position: relative;
  width: 100%;
}
.phantom {
  opacity: 0;
  pointer-events: none;
  user-select: none;
}
.step {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
}
/* This natively fixes the Markdown spacing bug! */
:deep(p) {
  margin: 0 !important;
}
</style>