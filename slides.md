---
# try also 'default' to start simple
theme: default

background: /Euclid_Deep_Field_South_16x_zoom.jpg
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
transition: view-transition # slide-left
# enable Comark Syntax: https://comark.dev/syntax/markdown
comark: true
# duration of the presentation
duration: 35min
# fix stuck goto menu
# css: style.css

aspectRatio: 16/9
canvasWidth: 960

hideInToc: true
---

<img src="/SDU-logo.svg" class="absolute top-10 left-10 h-12" alt="SDU Logo" />

<img src="/frontpic.png" 
     class="absolute top-1/2 right-12 w-1/3 -translate-y-1/2" 
     alt="Density Simulation" />

<div class="absolute top-1/2 left-12 -translate-y-1/2 w-1/2 pr-8 mt-8">

## Relativistic Effects in Inhomogeneous Cosmology

Examining the inhomogeneous universe through simulations, machine learning, and cosmography

<div class="mt-16 text-lg opacity-90 leading-relaxed font-light">
  <span class="font-bold">Jonas Broe Bendtsen</span> <br>
  CP3-Origins <br>
  University of Southern Denmark
 <br><br>
 Supervised by<span class="font-bold"> Sofie Marie Koksbang</span>
</div>

</div>

<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->

---
layout: two-cols
hideInToc: true
transition: fade
---

# Outline

<GradientBox width="w-520px">

* Examine relativistic effects of inhomogeneities
* Simulate universes with backreaction
* Train CNNs to infer backreaction effects
* Perform cosmographic expansions of $d_A$
* Compare to ray tracing results in LTB models
</GradientBox>

<div class="absolute right-10 top-7 w-66">
  <Toc text :columns="1" minDepth="1" maxDepth="2" />
</div>

<style scoped>  
/* 1. Force the main lists to use standard bullet points */
:deep(.slidev-toc ul), 
:deep(.slidev-toc ol) {
  list-style-type: disc !important;
  padding-left: 0rem !important;
}

/* 2. Style the top-level main sections (Bold + Spacing) */
:deep(.slidev-toc > ul > li),
:deep(.slidev-toc > ol > li) {
  margin-bottom: 0rem !important; /* Huge gap between main sections */
}
:deep(.slidev-toc > ul > li a),
:deep(.slidev-toc > ol > li a) {
  font-weight: 800 !important; /* True bold */
  font-size: 1rem !important;
}

/* 3. Style the nested sub-sections (Normal weight + Indented) */
:deep(.slidev-toc li li) {
  margin-left: 1rem !important;
  margin-top: -0.3rem !important;
  margin-bottom: -0.3rem !important;
  list-style-type: circle !important; /* Hollow circle bullets for sub-items */
}
:deep(.slidev-toc li li a) {
  font-weight: 400 !important; /* Standard, un-bolded weight */
  font-size: 1rem !important;
  opacity: 0.8 !important;
}
</style>


---
level: 1
layout: section
---

# Inhomogeneous Cosmology



---
level: 2
routeAlias: flrw
transition: slide-left
---

# FLRW Cosmology

Friedman and Lemaitre and Robertson and Walker

---
level: 2
routeAlias: lcdm
transition: slide-left
---

# ΛCDM model

Standard dark energy and cold dark matter paradigm


---
level: 2
routeAlias: buchert
transition: slide-left
---

# Buchert equations

<v-click>
  <CyclistRace />
</v-click>

---
level: 2
routeAlias: ltb
transition: fade
---

# LTB models

---
level: 1
layout: section
---

# Simplified Silent Universes


---
level: 2
transition: slide-left
---

# The Simsilun equations
Turning a complicated set of tensor equations into four coupled ODEs

$$\begin{align}
    \dot{\rho} &= -\rho \Theta\\
    \dot{\Theta} &= -\frac{1}{3}\Theta^2 - \frac{1}{2}\kappa \rho - 6 \Sigma^2 + \Lambda\\
    \dot{\Sigma} &= -\frac{2}{3}\Theta \Sigma + \Sigma^2 - \mathcal{W}\\
    \dot{\mathcal{W}} &= -\Theta \mathcal{W} - \frac{1}{2}\kappa \rho \Sigma - 3 \Sigma \mathcal{W}
\end{align}$$


---
level: 2
transition: slide-left
---

# The simulations


---
level: 2
transition: fade
---

# Training CNNs


---
level: 1
layout: section
---

# Cosmography

---
level: 2
transition: slide-left
---

# Theory

---
level: 2
transition: slide-left
---

# Fiducial rays

---
level: 2
transition: fade
---

# Skymaps

---
level: 1
layout: section
---

# Conclusions


---
level: 2
transition: slide-left
---

# Future work

---
level: 2
transition: fade
---

# Summary


---
layout: end
---

# Questions?


<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->
