<template>
  <div class="slidev-layout section w-full h-full flex flex-col justify-center text-center bg-[linear-gradient(135deg,#2ea381_0%,#a45cb8_100%)]">
    
    <slot />

    <div class="flex justify-center mt-8 text-xl">
      <Toc class="inline-menu mb-4" text :columns="1" minDepth="2" maxDepth="2" mode="onlyCurrentTree" />
    </div>

  </div>
</template>

<style scoped>
/* --- Main Slide Styles --- */

/* Change all text to white */
.section :deep(h1),
.section :deep(h2),
.section :deep(h3),
.section :deep(p) {
  color: white !important;
}

/* Add a drop shadow back to the main title */
.section :deep(h1) {
  text-shadow:
    0 4px 10px rgba(0, 0, 0, 0.5)   /* Wide, soft drop shadow for floating depth */
    !important;
  margin-bottom: -1rem !important; /* Pulls the TOC up tight against the text */
  view-transition-name: none !important;
}

/* --- Global Inline TOC Menu --- */

/* 1. Force the main wrapper to never wrap */
.section :deep(.inline-menu.slidev-toc) {
  white-space: nowrap !important;
  width: 100% !important;
  view-transition-name: outline-menu; 
}

/* 2. Lock the list container into a single horizontal track */
.section :deep(.inline-menu.slidev-toc ul) {
  display: flex !important;
  justify-content: center !important;
  flex-wrap: nowrap !important; 
  white-space: nowrap !important;
  padding: 0 !important;
  margin: 0 !important;
  list-style: none !important;
}

/* 3. Force list items to be inline elements */
.section :deep(.inline-menu.slidev-toc li) {
  display: inline-flex !important;
  align-items: center !important;
  white-space: nowrap !important;
  width: auto !important; 
  margin: 0 !important;
}

/* 4. Turn off Slidev's hidden counters/bullets */
.section :deep(.inline-menu.slidev-toc li::before) {
  display: none !important;
}

/* 5. Inject the separators with hardcoded spacing and pure white color */
.section :deep(.inline-menu.slidev-toc li:not(:last-child)::after) {
  content: "|" !important;
  margin-left: 1rem !important;
  margin-right: 1rem !important;
  color: white !important; /* Force the pipe to be white */
  opacity: 0.5 !important; /* Keep it slightly faded so the links pop */
  pointer-events: none !important;
}

/* 6. Clean up the links and apply the hover effect */
.section :deep(.inline-menu.slidev-toc a) {
  display: inline-block !important;
  white-space: nowrap !important;
  font-weight: 350 !important;
  letter-spacing: 0.025em !important;
  color: white !important; /* Force all link text to be white */
  transition: color 0.15s ease-in-out !important;
  opacity: 1 !important;
}

/* 7. Override Slidev's default gray/dimming for inactive items */
.section :deep(.slidev-toc .opacity-50) {
  opacity: 0.6 !important; /* Dims inactive links, but keeps them white instead of gray */
}

.section :deep(.slidev-toc li:nth-child(1) a) {
  display: inline-block !important;
  view-transition-name: morph-title !important; 
}
</style>

