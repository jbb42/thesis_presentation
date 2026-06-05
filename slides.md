---
# try also 'default' to start simple
theme: default
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: /Euclid_Deep_Field_South_16x_zoom.jpg #https://cover.sli.dev
# some information about your slides (markdown enabled)
title: Relativistic Effects in Inhomogeneous Cosmology
info: |
  ## Thesis defence
  Relativistic Effects in Inhomogeneous Cosmology
# apply UnoCSS classes to the current slide
class: text-center
# https://sli.dev/features/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable Comark Syntax: https://comark.dev/syntax/markdown
comark: true
# duration of the presentation
duration: 35min
# fix stuck goto menu
# css: style.css

hideInToc: true
---

<img src="/SDU-logo.svg" class="absolute top-10 left-10 h-12" alt="SDU Logo" />

<img src="/frontpic.png" 
     class="absolute top-1/2 right-12 w-1/3 -translate-y-1/2" 
     alt="Density Simulation" />

<div class="absolute top-1/2 left-12 -translate-y-1/2 w-1/2 pr-8">

## Relativistic Effects in Inhomogeneous Cosmology

Examining the inhomogeneous universe through simulations, machine learning, and cosmography

<div class="mt-16 text-lg opacity-90 leading-relaxed font-light">
  <span class="font-bold">Jonas Broe Bendtsen</span> <br>
  CP3-Origins <br>
  University of Southern Denmark
</div>

</div>

<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->

---
layout: two-cols
layoutClass: gap-16
hideInToc: true
---

# Table of contents

<Toc text-sm minDepth="1" maxDepth="2" />


<style>
/* This catches the level-2 class Slidev generates and forces the indent */
.slidev-toc-item.level-2, 
.slidev-toc-item-level-2,
.slidev-toc-list .slidev-toc-list {
  margin-left: 2rem !important;
  opacity: 0.8; 
}
</style>

---
level: 1
layout: section
---

# Inhomogeneous Cosmology

---
level: 2
---

# FLRW
Friedman and Lemaitre and Robertson and Walker


---
level: 2
transition: fade-out
---

# ΛCDM
This is our current standard model


---
level: 2
---

# Buchert equations


---
level: 1
layout: section
---

# Simplified Silent Universes


---
level: 1
layout: section
---

# Cosmography


<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->
