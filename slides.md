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
 Supervised by <span class="font-bold">Sofie Marie Koksbang</span>
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

:deep(.slidev-toc > ul > li a),
:deep(.slidev-toc > ol > li a) {
  font-weight: 800 !important; /* True bold */
  font-size: 1rem !important;
}

:deep(.slidev-toc li li a) {
  font-weight: 400 !important; /* Standard, un-bolded weight */
  font-size: 0.9rem !important;
  opacity: 0.7 !important;
}
</style>


---
level: 1
layout: section
---

# Inhomogeneous Cosmology



---
level: 2
transition: slide-left
layout: two-cols
---

# FLRW cosmology

<span></span>

Modelling the Universe using general relativity

$$ R_{\mu\nu} - \frac{1}{2} R g_{\mu\nu} + \Lambda g_{\mu\nu} = \kappa T_{\mu\nu} $$

<v-click>
Assuming homogeneity and isotropy gives us FLRW metric

$$ \mathrm{d} s^2 = -\mathrm{d} t^2 + a(t)^2 \bigg( \frac{1}{1-kr^2} \mathrm{d} r^2 + r^2 \mathrm{d} \Omega^2 \bigg)  $$
</v-click>

<v-click>
Friedmann equations describe the dynamics of the Universe

$$ \begin{align*}
\frac{\dot{a}^2}{a^2} &\equiv H^2 = \frac{\kappa}{3} \rho - \frac{k}{a^2} + \frac{\Lambda}{3} \\
\frac{\ddot{a}}{a} &= -\frac{\kappa}{6} (\rho+3p) + \frac{\Lambda}{3} 
\end{align*}
$$

Flat universe with accelerating expansion --- $\Lambda$CDM model
</v-click>



::right::

<v-click>
  <RaisinBun />
</v-click>


---
level: 2
transition: slide-left
---

# Buchert equations

<span></span>

Spatial averaging and time derivatives do not commute: $\langle \Psi \rangle\dot{}_\mathcal{D}\neq\langle \dot{\Psi} \rangle_\mathcal{D}$

<v-click>
Large-scale effects from small-scale inhomogeneities?
</v-click>

<v-click>
$$
\begin{align*}
    3\frac{\dot{a}_\mathcal{D}^2}{a_\mathcal{D}^2} &= 3H_\mathcal{D}^2 = {\color{CadetBlue}- \frac{1}{2} \langle{}^{(3)}\mathcal{R}\rangle_\mathcal{D}} + \kappa \langle\rho\rangle_\mathcal{D} + \Lambda - {\color{CadetBlue}\frac{1}{2} Q_\mathcal{D}}\\
    3\frac{\ddot{a}_\mathcal{D}}{a_\mathcal{D}} &= {\color{CadetBlue}Q_\mathcal{D}} - \frac{\kappa}{2}\langle \rho \rangle_\mathcal{D} + \Lambda\\
    Q_\mathcal{D} &= \frac{2}{3}\big(\langle \Theta^2 \rangle_\mathcal{D} - \langle \Theta \rangle_\mathcal{D}^2\big)  - 2\langle \sigma^2 \rangle_\mathcal{D}
\end{align*}
$$
</v-click>

<v-click>

Cosmological accelerated expansion without local acceleration!

</v-click>

<v-click>
<div class="flex justify-center items-center gap-8 text-xl">
  <div class="text-blue-500">
    <span class="font-bold">Blue team (voids):</span> 20 km/h
  </div>
  
  
  <div class="text-red-500">
    <span class="font-bold">Red team (overdensities):</span> 10 km/h
  </div>
</div>
  <CyclistRace />
</v-click>


---
level: 2
transition: fade
layout: two-cols
---

# LTB models

<span></span>

Lemaître--Tolman--Bondi (LTB) models

<v-click>

Inhomogeneous and spherically symmetric exact solutions

$$\mathrm{d} s^2 = -\mathrm{d} t^2 + \frac{A'(t, r)^2}{1-k(r)} \mathrm{d} r^2 + A(t, r)^2 \mathrm{d} \Omega^2 $$

</v-click>

<v-click>

<font color="#3d7fc2">Void surrounded by overdensity</font> and <font color="#e16171">Gaussian overdensity</font>

</v-click>

<v-click at="3">

We can derive $\Theta$ and $\sigma^2$

$$
\Theta = \frac{\dot{A}'}{A'} + 2\frac{\dot{A}}{A}\,,\quad
\sigma^2 = \frac{1}{3} \bigg( \frac{\dot{A}'}{A'} - \frac{\dot{A}}{A} \bigg)^2 
$$

</v-click>

<v-click at="4">

Difficult to produce significant backreaction <ArXiv id="1308.6731" />

</v-click>

::right::

<div class="h-full w-[calc(100%+70px)] -ml-7 flex items-center justify-center relative">

  <div v-click="2" class="absolute inset-0 flex items-center justify-center">
    <img src="/rho_r.svg" class="w-full h-auto dark:hidden" />
    <img src="/rho_r_dark.svg" class="w-full h-auto hidden dark:block" />
  </div>
</div>

---
level: 1
layout: section
---

# Simplified Silent Universes


---
level: 2
transition: view-transition
---

# Simsilun equations
Silencing the Universe


Cosmological simulations are approximations of the Universe


<v-click>
N-body simulations successfully produce structures, but require periodic boundary conditions

</v-click>

<v-click>

Simplified silent universe (Simsilun) as a numerical approach without PBCs <ArXiv id="1708.09143" />

</v-click>

<v-click>

Assuming irrotational, pressureless dust and vanishing magnetic Weyl tensor:

<div class="text-16px">

$$\begin{align*}
    \dot{\rho} &= -\rho \Theta\\
    \dot{\Theta} &= -\frac{1}{3}\Theta^2 - \frac{1}{2}\kappa \rho - 6 \Sigma^2 + \Lambda\\
    \dot{\Sigma} &= -\frac{2}{3}\Theta \Sigma + \Sigma^2 - \mathcal{W}\\
    \dot{\mathcal{W}} &= -\Theta \mathcal{W} - \frac{1}{2}\kappa \rho \Sigma - 3 \Sigma \mathcal{W}\\
    \dot{V} &= \Theta V
\end{align*}$$

</div>

</v-click>

<v-click>

Solve for each cell to simulate universes

</v-click>


---
level: 3
transition: slide-left
layout: two-cols
---

# Simsilun equations
Simplifying initial conditions


Perturbation theory from density contrast $\delta$

$$
\begin{align*}
    \rho_i &= \bar{\rho}(1 + \delta_i) \\
    \Theta_i &= \bar{\Theta}\bigg(1 - \frac{1}{3}\delta_i\bigg) \\
    \Sigma_i &= \frac{1}{9}\bar{\Theta} \delta_i \\
    \mathcal{W}_i &= -\frac{\kappa}{6}\bar{\rho} \delta_i\\
    V_i &= \frac{1}{1+\delta_i}
\end{align*}
$$


<v-click>

Compare with LTB model

</v-click>

<v-click at="6">

$\delta_i$ generated with CLASS <ArXiv id="1104.2933"/>

</v-click>


::right::

<div class="h-full w-[calc(100%+70px)] -ml-7 flex items-center justify-center relative">

  <div v-click class="absolute inset-0 flex items-center justify-center">
    <img src="/density_LTB.svg" class="w-full h-auto dark:hidden" />
    <img src="/density_LTB_dark.svg" class="w-full h-auto hidden dark:block" />
  </div>

  <div v-click class="absolute inset-0 flex items-center justify-center">
    <img src="/expansion_LTB.svg" class="w-full h-auto dark:hidden" />
    <img src="/expansion_LTB_dark.svg" class="w-full h-auto hidden dark:block" />
  </div>

  <div v-click class="absolute inset-0 flex items-center justify-center">
    <img src="/shear_LTB.svg" class="w-full h-auto dark:hidden" />
    <img src="/shear_LTB_dark.svg" class="w-full h-auto hidden dark:block" />
  </div>

  <div v-click class="absolute inset-0 flex items-center justify-center">
    <img src="/weyl_LTB.svg" class="w-full h-auto dark:hidden" />
    <img src="/weyl_LTB_dark.svg" class="w-full h-auto hidden dark:block" />
  </div>

</div>

<style>
.slidev-layout.two-columns {
  grid-template-columns: 45% 55%;
}
</style>



---
level: 2
transition: slide-left
layout: two-cols
---

# Simulations

<span></span>

Simulating universes numerically by solving Simsilun ODEs until $H_\mathrm{bg}=H_0$

<div class="text-16px">

<v-click at="2">

|            | $N = 64$       | $N = 128$      |
| ---------- | -------------- | -------------- |
| $\Omega_m$ | $[0.20, 0.40]$ | $[0.20, 0.40]$ |
| $\Omega_\Lambda$|$[0.60, 0.80]$|$[0.60, 0.80]$|
| $h$        | $[0.60, 0.80]$ | $[0.60, 0.80]$ |
| Increment  | $0.01$         | $0.02$         |
| Versions   | $10$           | $5$            |
| Total      | $92610$        | $6655$         | 

</v-click>

</div>

::right::
<div class="h-full w-full flex items-center justify-center relative">

  <div v-click-hide="1" class="absolute inset-0 flex items-center justify-center">
    <img src="/cube_initial.svg" loading="eager" decoding="sync" class="w-full h-full dark:hidden" />
    <img src="/cube_initial_dark.svg" loading="eager" decoding="sync" class="w-full h-[80%] hidden dark:block" />
  </div>

  <div v-click="1" class="absolute inset-0 flex items-center justify-center">
    <img src="/cube_final.svg" loading="eager" decoding="sync" class="w-full h-full dark:hidden" />
    <img src="/cube_final_dark.svg" loading="eager" decoding="sync" class="w-full h-[80%] hidden dark:block" />
  </div>

  <div v-click="3" class="absolute inset-0 flex items-center justify-center">
    <img src="/cornerplots/backreaction_corner_plot_64.svg" class="w-full h-auto dark:hidden" />
    <img src="/cornerplots/backreaction_corner_plot_64_dark_fixed.svg" class="w-full h-auto hidden dark:block" />
  </div>

  <div v-click="4" class="absolute inset-0 flex items-center justify-center">
    <img src="/cornerplots/backreaction_corner_plot_128.svg" class="w-full h-auto dark:hidden" />
    <img src="/cornerplots/backreaction_corner_plot_128_dark_fixed.svg" class="w-full h-auto hidden dark:block" />
  </div>

</div>

<style>
.slidev-layout.two-columns {
  grid-template-columns: 40% 60%;
}
</style>

---
level: 2
transition: view-transition
---

# Training CNNs
Using machine learning to predict parameters

Training three networks to predict $\Omega_m$, $\Omega_\Lambda$, $\Omega_k$, $\Omega_Q$, and $h$ from final density maps

<v-click>

 |      | CNN1 | CNN2 | CNN3 |
 | ---- | ---- | ---- | ---- |
 | $N$  | $64$ | $128$| $64$ |
 | $#$  |$92610$|$6655$|$6655$| 

</v-click>

<v-click>

Same network architecture and hyperparameters (extra input layer for CNN2)

</v-click>

<v-click>

60%/20%/20% split between training/validation/test data

</v-click>

<v-click>

Training for up to 250 epochs with early stopping after 20

</v-click>


---
level: 3
transition: view-transition
---

# Training CNNs
Convolutional neural network architecture

<div class="h-full">
  <LightOrDark>
    <template #light>
      <img src="/cnn.svg" class="w-full mx-auto" alt="CNN Architecture Light" />
    </template>
    <template #dark>
      <img src="/cnn_dark.svg" class="w-full mx-auto" alt="CNN Architecture Dark" />
    </template>
  </LightOrDark>
</div>



---
level: 3
transition: fade
layout: two-cols
---

# Training CNNs
CNN results

Accurate predictions for $N=64$

<span v-click="2">Less accurate for $N=128$</span> <span v-click="4">and $N=64$ subset</span>

<v-click at="6">

Difference in loss curves

</v-click>

<v-click at="7">

Demonstrates proof of concept

</v-click>

<v-click at="8">

More work needed for observations

</v-click>

::right::

<div v-if="$clicks < 1" class="absolute top-0 right-0 h-full w-[60%] grid grid-cols-2 grid-rows-2 gap-2 py-5 pr-10">
  <div>
    <img src="/CNN_results/parity_plots_individual/cnn_Omega_m_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual/cnn_Omega_m_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual/cnn_Omega_Lambda_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual/cnn_Omega_Lambda_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual/cnn_Omega_k_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual/cnn_Omega_k_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual/cnn_Omega_Q_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual/cnn_Omega_Q_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
</div>

<div v-click="1" v-if="$clicks < 2"  class="absolute top-0 right-0 h-full w-[60%] py-5 pr-10">
  <div class="w-full h-full grid grid-cols-2 grid-rows-2 gap-2">
    <div>
      <img src="/CNN_results/parity_plots_individual/cnn_Omega_m_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual/cnn_Omega_m_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual/cnn_Omega_Lambda_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual/cnn_Omega_Lambda_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual/cnn_Omega_k_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual/cnn_Omega_k_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual/cnn_Omega_Q_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual/cnn_Omega_Q_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
  </div>
</div>


<div v-click="2" v-if="$clicks < 3" class="absolute top-0 right-0 h-full w-[60%] grid grid-cols-2 grid-rows-2 gap-2 py-5 pr-10">
  <div>
    <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_m_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_m_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_Lambda_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_Lambda_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_k_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_k_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_Q_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_Q_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
</div>

<div v-click="3" v-if="$clicks < 4"  class="absolute top-0 right-0 h-full w-[60%] py-5 pr-10">
  <div class="w-full h-full grid grid-cols-2 grid-rows-2 gap-2">
    <div>
      <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_m_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_m_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_Lambda_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_Lambda_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_k_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_k_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_Q_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual_128/cnn_Omega_Q_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
  </div>
</div>


<div v-click="4" v-if="$clicks < 5" class="absolute top-0 right-0 h-full w-[60%] grid grid-cols-2 grid-rows-2 gap-2 py-5 pr-10">
  <div>
    <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_m_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_m_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_Lambda_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_Lambda_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_k_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_k_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
  <div>
    <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_Q_i.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_Q_i_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
</div>

<div v-click="5" v-if="$clicks < 6"  class="absolute top-0 right-0 h-full w-[60%] py-5 pr-10">
  <div class="w-full h-full grid grid-cols-2 grid-rows-2 gap-2">
    <div>
      <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_m_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_m_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_Lambda_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_Lambda_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_k_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_k_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
    <div>
      <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_Q_f.svg" class="w-full h-full object-contain dark:hidden" />
      <img src="/CNN_results/parity_plots_individual_ss/cnn_Omega_Q_f_dark.svg" class="w-full h-full object-contain hidden dark:block" />
    </div>
  </div>
</div>


<div v-click="6"  class="absolute top-0 right-0 h-full w-[60%] py-5 pr-10 flex items-center justify-center">
  <div class="w-full h-full">
    <img src="/CNN_results/plots_tikz/loss_comparison_single.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/CNN_results/plots_tikz/loss_comparison_single_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
</div>

<style>
.slidev-layout.two-columns {
  grid-template-columns: 33% 66%;
}
</style>

---
level: 1
layout: section
---

# Cosmography

---
level: 2
transition: view-transition
---

# Theory
Exploring the inhomogeneous universe from observations

* **Motivation**

  * We have shown how inhomogeneities affect global dynamics through backreaction.
  * How do inhomogeneities affect local observations?

<v-click>

* **Model-independent framework**

  * Examining local effects without assuming an underlying model
  * Looking at lensing and kinematical effects, not global backreaction

</v-click>

<v-click>

* **Cosmographic expansion**

  * Taylor expansion of observable
  * Traditionally expanded around $z=0$ to constrain local parameters like $H_0$ and $q_0$
  * Extending the expansion to an arbitrary redshift $z_*$

</v-click>

---
level: 3
transition: view-transition
---

# Theory
Ray tracing

Geodesic equation and transport equation for light rays:
$$\frac{\mathrm{d} k^\mu}{\mathrm{d} \lambda} + \Gamma^\mu_{\nu\alpha} k^\nu k^\alpha = 0$$


$$\frac{\mathrm{d}^2 \xi^a}{\mathrm{d} \lambda^2} = R_{\mu\rho\nu\sigma} k^\rho k^\nu E^{a\mu} E^\sigma_b \xi^b =: T^a_b \xi^b $$

<v-click>

$$
  T_{ab} = \begin{pmatrix}
        \mathbf{R}-\Re(\mathbf{F}) & \Im(\mathbf{F}) \\
        \Im(\mathbf{F}) & \mathbf{R}+\Re(\mathbf{F})
    \end{pmatrix}
$$

$$\mathbf{R} = -\frac{1}{2}R_{\mu\nu} k^\mu k^\nu\,,\quad
\mathbf{F} = -\frac{1}{2}C_{\rho\mu\nu\alpha} (e^*)^\rho k^\mu k^\nu (e^*)^\alpha$$
</v-click>

<v-click>

The linear relation $\xi^a = D^a_b \dot{\xi}_0^b$ yields the Jacobi equation $\ddot{D}^a_b = T^a_c D^c_b$, from which we define:
$$d_A = \sqrt{\lvert\det{D}\rvert}$$
</v-click>

---
level: 3
transition: slide-left
---

# Theory
Cosmographic expansion


Relating redshift $z$ and affine parameter $\lambda$ through  $\frac{\mathrm{d} z}{\mathrm{d} \lambda} = -E_o\mathcal{H} (1+z)^2$ and using $\frac{\mathrm{d} d_A}{\mathrm{d} \lambda} = \frac{1}{2}\hat{\theta}d_A$:


<div class="text-15px mt--4 mb-10">

<EquationReveal>

  <template #full>
    <div class="text-15px">

  $$
  \begin{aligned}
  \frac{\mathrm{d} d_A}{\mathrm{d} z} &= - \frac{\hat{\theta}}{2(1+z)^2 E_o\mathcal{H}} d_A \\
  \frac{\mathrm{d}^2 d_A}{\mathrm{d} z^2} &= \frac{d_A}{2(1+z)^4 E_o^2 \mathcal{H}^2} \bigg[2{\hat{\theta}} E_o \mathcal{H}(1+z) - 2{\lvert\hat{\sigma}\rvert^2} - k^\mu k^\nu {R_{\mu\nu}} - \frac{\hat{\theta}}{\mathcal{H}}\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda}  \bigg] \\
  \frac{\mathrm{d}^3 d_A}{\mathrm{d} z^3} &= \frac{d_A}{2(1+z)^6 E_o^3 \mathcal{H}^3} \bigg[
      6\bigg(2 E_o \mathcal{H}{\lvert\hat{\sigma}\rvert^2} + E_o \mathcal{H} k^\mu k^\nu R_{\mu\nu} + E_o {\hat{\theta}} \frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} \bigg) (1+z) - 6 E_o^2 \mathcal{H}^2 {\hat{\theta}} (1+z)^2 -3 {\hat{\theta}} {\lvert\hat{\sigma}\rvert^2} \\
      &\quad- \frac{3}{\mathcal{H}}\bigg({2{\lvert\hat{\sigma}\rvert^2}} + {k^\mu k^\nu R_{\mu\nu}}\bigg)\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} - \frac{3{\hat{\theta}}}{\mathcal{H}^2}\bigg(\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} \bigg)^2 + \frac{\hat{\theta}}{\mathcal{H}}\frac{\mathrm{d}^2 \mathcal{H}}{\mathrm{d} \lambda^2} - 2 k^\alpha k^\beta C_{\rho\alpha\sigma\beta} \hat{\sigma}^{\rho\sigma} + \frac{\hat{\theta} k^\mu k^\nu R_{\mu\nu}}{2} + \frac{\mathrm{d} (k^\mu k^\nu R_{\mu\nu})}{\mathrm{d} \lambda} \bigg]
  \end{aligned}
  $$
  </div>
  </template>


  <template #step1>
    <div class="text-15px">

  $$
  \begin{aligned}
  \frac{\mathrm{d} d_A}{\mathrm{d} z} &= - \frac{\hat{\theta}}{2(1+z)^2 E_o\mathcal{H}} d_A \\
  \phantom{\frac{\mathrm{d}^2 d_A}{\mathrm{d} z^2}} &\phantom{= \frac{d_A}{2(1+z)^4 E_o^2 \mathcal{H}^2} \bigg[2{\hat{\theta}} E_o \mathcal{H}(1+z) - 2{\lvert\hat{\sigma}\rvert^2} - k^\mu k^\nu {R_{\mu\nu}} - \frac{\hat{\theta}}{\mathcal{H}}\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda}  \bigg]} \\
  \phantom{\frac{\mathrm{d}^3 d_A}{\mathrm{d} z^3}} &\phantom{= \frac{d_A}{2(1+z)^6 E_o^3 \mathcal{H}^3} \bigg[ 6\bigg(2 E_o \mathcal{H}{\lvert\hat{\sigma}\rvert^2} + E_o \mathcal{H} k^\mu k^\nu R_{\mu\nu} + E_o {\hat{\theta}} \frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} \bigg) (1+z) - 6 E_o^2 \mathcal{H}^2 {\hat{\theta}} (1+z)^2 -3 {\hat{\theta}} {\lvert\hat{\sigma}\rvert^2} } \\
  &\phantom{\quad- \frac{3}{\mathcal{H}}\bigg({2{\lvert\hat{\sigma}\rvert^2}} + {k^\mu k^\nu R_{\mu\nu}}\bigg)\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} - \frac{3{\hat{\theta}}}{\mathcal{H}^2}\bigg(\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} \bigg)^2 + \frac{\hat{\theta}}{\mathcal{H}}\frac{\mathrm{d}^2 \mathcal{H}}{\mathrm{d} \lambda^2} - 2 k^\alpha k^\beta C_{\rho\alpha\sigma\beta} \hat{\sigma}^{\rho\sigma} + \frac{\hat{\theta} k^\mu k^\nu R_{\mu\nu}}{2} + \frac{\mathrm{d} (k^\mu k^\nu R_{\mu\nu})}{\mathrm{d} \lambda} \bigg]}
  \end{aligned}
  $$
  </div>
  </template>


  <template #step2>
    <div class="text-15px">

  $$
  \begin{aligned}
  \frac{\mathrm{d} d_A}{\mathrm{d} z} &= - \frac{\hat{\theta}}{2(1+z)^2 E_o\mathcal{H}} d_A \\
  \frac{\mathrm{d}^2 d_A}{\mathrm{d} z^2} &= \frac{d_A}{2(1+z)^4 E_o^2 \mathcal{H}^2} \bigg[2{\hat{\theta}} E_o \mathcal{H}(1+z) - 2{\lvert\hat{\sigma}\rvert^2} - k^\mu k^\nu {R_{\mu\nu}} - \frac{\hat{\theta}}{\mathcal{H}}\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda}  \bigg] \\
  \phantom{\frac{\mathrm{d}^3 d_A}{\mathrm{d} z^3}} &\phantom{= \frac{d_A}{2(1+z)^6 E_o^3 \mathcal{H}^3} \bigg[ 6\bigg(2 E_o \mathcal{H}{\lvert\hat{\sigma}\rvert^2} + E_o \mathcal{H} k^\mu k^\nu R_{\mu\nu} + E_o {\hat{\theta}} \frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} \bigg) (1+z) - 6 E_o^2 \mathcal{H}^2 {\hat{\theta}} (1+z)^2 -3 {\hat{\theta}} {\lvert\hat{\sigma}\rvert^2} } \\
  &\phantom{\quad- \frac{3}{\mathcal{H}}\bigg({2{\lvert\hat{\sigma}\rvert^2}} + {k^\mu k^\nu R_{\mu\nu}}\bigg)\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} - \frac{3{\hat{\theta}}}{\mathcal{H}^2}\bigg(\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} \bigg)^2 + \frac{\hat{\theta}}{\mathcal{H}}\frac{\mathrm{d}^2 \mathcal{H}}{\mathrm{d} \lambda^2} - 2 k^\alpha k^\beta C_{\rho\alpha\sigma\beta} \hat{\sigma}^{\rho\sigma} + \frac{\hat{\theta} k^\mu k^\nu R_{\mu\nu}}{2} + \frac{\mathrm{d} (k^\mu k^\nu R_{\mu\nu})}{\mathrm{d} \lambda} \bigg]}
  \end{aligned}
  $$
  </div>
  </template>


  <template #step3>
    <div class="text-15px">

  $$
  \begin{aligned}
  \frac{\mathrm{d} d_A}{\mathrm{d} z} &= - \frac{\hat{\theta}}{2(1+z)^2 E_o\mathcal{H}} d_A \\
  \frac{\mathrm{d}^2 d_A}{\mathrm{d} z^2} &= \frac{d_A}{2(1+z)^4 E_o^2 \mathcal{H}^2} \bigg[2{\hat{\theta}} E_o \mathcal{H}(1+z) - 2{\lvert\hat{\sigma}\rvert^2} - k^\mu k^\nu {R_{\mu\nu}} - \frac{\hat{\theta}}{\mathcal{H}}\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda}  \bigg] \\
  \frac{\mathrm{d}^3 d_A}{\mathrm{d} z^3} &= \frac{d_A}{2(1+z)^6 E_o^3 \mathcal{H}^3} \bigg[
      6\bigg(2 E_o \mathcal{H}{\lvert\hat{\sigma}\rvert^2} + E_o \mathcal{H} k^\mu k^\nu R_{\mu\nu} + E_o {\hat{\theta}} \frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} \bigg) (1+z) - 6 E_o^2 \mathcal{H}^2 {\hat{\theta}} (1+z)^2 -3 {\hat{\theta}} {\lvert\hat{\sigma}\rvert^2} \\
      &\quad- \frac{3}{\mathcal{H}}\bigg({2{\lvert\hat{\sigma}\rvert^2}} + {k^\mu k^\nu R_{\mu\nu}}\bigg)\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} - \frac{3{\hat{\theta}}}{\mathcal{H}^2}\bigg(\frac{\mathrm{d} \mathcal{H}}{\mathrm{d} \lambda} \bigg)^2 + \frac{\hat{\theta}}{\mathcal{H}}\frac{\mathrm{d}^2 \mathcal{H}}{\mathrm{d} \lambda^2} - 2 k^\alpha k^\beta C_{\rho\alpha\sigma\beta} \hat{\sigma}^{\rho\sigma} + \frac{\hat{\theta} k^\mu k^\nu R_{\mu\nu}}{2} + \frac{\mathrm{d} (k^\mu k^\nu R_{\mu\nu})}{\mathrm{d} \lambda} \bigg]
  \end{aligned}
  $$
  </div>
  </template>

</EquationReveal>


</div>


<v-click at="4">

Constructing a third-order Taylor expansion around $z_*$:

$$d_A(z) \approx d_A(z_*) + d'_A(z_*)(z-z_*) + \frac{1}{2} d_A''(z_*)(z-z_*)^2 + \frac{1}{6}d_A'''(z_*)(z-z_*)^3$$

</v-click>


<!--
First order term: Actually positive, since rays are converging, meaning θ is negative.
Second order terms:
First: Negative -> contributes to smaller d_A
Second and third: both begative, both negligible (required much matter)
Fourth: Initially negative (minus, theta minus and negative differential as H decreases with \lambda (increases with z) on slope towards centre), positive from centre of void, flips dramatically to negative at overdensity due to derivative chaning sign again. Zero in background due to derivative being zero.
-->


---
level: 2
transition: slide-left
---


# Fiducial ray

<div class="relative h-full w-full flex items-center justify-center">
  <div v-show="$clicks === 0" class="grid grid-cols-2 gap-4 items-center justify-items-center h-full w-full">
    <div class="flex flex-col items-center justify-center h-full">
      <img src="/rho_r.svg" class="h-full w-auto object-contain dark:hidden" />
      <img src="/rho_r_dark.svg" class="h-full w-auto object-contain hidden dark:block" />
    </div>
    <div class="flex flex-col items-center justify-center h-full">
      <img src="/rho_z.svg" class="h-full w-auto object-contain dark:hidden" />
      <img src="/rho_z_dark.svg" class="h-full w-auto object-contain hidden dark:block" />
    </div>
  </div>

  <span v-click="1" class="absolute w-0 h-0 overflow-hidden" />
  <span v-click="2" class="absolute w-0 h-0 overflow-hidden" />

<Transition name="fade">
  <div v-if="$clicks === 1" class="absolute inset-0 flex items-end justify-end pb-4">
    <img src="/fiducial_vs_expansion.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/fiducial_vs_expansion_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>
</Transition>

  <Transition name="fade">
    <div v-if="$clicks === 2" class="absolute inset-0 flex items-center justify-center">
      <img src="/dA_zz_terms.svg" class="h-full w-auto object-contain dark:hidden" />
      <img src="/dA_zz_terms_dark.svg" class="h-full w-auto object-contain hidden dark:block" />
    </div>
  </Transition>
</div>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.1s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>

---
level: 2
transition: view-transition
---

<script setup>
const base = import.meta.env.BASE_URL
</script>

# Skymaps

Comparing exact $d_A$ and derivatives to FLRW counterparts
<span v-click="1" class="absolute w-0 h-0 overflow-hidden" />
<span v-click="2" class="absolute w-0 h-0 overflow-hidden" />
<span v-click="3" class="absolute w-0 h-0 overflow-hidden" />

<template v-for="(anchors, clickIdx) in [
  { v: '0.001', d: '0.001' },
  { v: '0.007', d: '0.004' },
  { v: '0.013', d: '0.007' },
  { v: '0.019', d: '0.010' },
]" :key="clickIdx">
  <div v-show="$clicks === clickIdx" class="grid grid-cols-4 grid-rows-2 gap-4 mt-8">
    <div v-for="f in ['dA_contrast', 'dA_z_contrast', 'dA_zz_contrast', 'dA_zzz_contrast']" :key="'v'+f">
      <img :src="`${base}plots/z_${anchors.v}/${f}.svg`" class="w-full dark:hidden" />
      <img :src="`${base}plots/z_${anchors.v}/${f}_dark.svg`" class="w-full hidden dark:block" />
    </div>
    <div v-for="f in ['dA_contrast', 'dA_z_contrast', 'dA_zz_contrast', 'dA_zzz_contrast']" :key="'d'+f">
      <img :src="`${base}plots_diov/z_${anchors.d}/${f}.svg`" class="w-full dark:hidden" />
      <img :src="`${base}plots_diov/z_${anchors.d}/${f}_dark.svg`" class="w-full hidden dark:block" />
    </div>
  </div>
</template>



---
level: 3
transition: fade
---

<script setup>
const base = import.meta.env.BASE_URL
</script>

# Skymaps

Accuracy of different expansion orders evaluated at $z = 0.010$ and $z = 0.002$

<span v-click="1" class="absolute w-0 h-0 overflow-hidden" />
<span v-click="2" class="absolute w-0 h-0 overflow-hidden" />
<span v-click="3" class="absolute w-0 h-0 overflow-hidden" />

<template v-for="(anchors, clickIdx) in [
  { v: '0.000', d: '0.000' },
  { v: '0.007', d: '0.001' },
  { v: '0.013', d: '0.003' },
  { v: '0.019', d: '0.005' },
]" :key="clickIdx">
  <div v-show="$clicks === clickIdx" class="grid grid-cols-4 grid-rows-2 gap-4 mt-8">
    <div v-for="o in [0,1,2,3]" :key="'v'+o">
      <img :src="`${base}plots/expansion_errors_at_z0.010/error_order_${o}_anchor_${anchors.v}.svg`" class="w-full dark:hidden" />
      <img :src="`${base}plots/expansion_errors_at_z0.010/error_order_${o}_anchor_${anchors.v}_dark.svg`" class="w-full hidden dark:block" />
    </div>
    <div v-for="o in [0,1,2,3]" :key="'d'+o">
      <img :src="`${base}plots_diov/expansion_errors_at_z0.002/error_order_${o}_anchor_${anchors.d}.svg`" class="w-full dark:hidden" />
      <img :src="`${base}plots_diov/expansion_errors_at_z0.002/error_order_${o}_anchor_${anchors.d}_dark.svg`" class="w-full hidden dark:block" />
    </div>
  </div>
</template>

---
level: 3
transition: fade
---

<script setup>
const envBase = import.meta.env.BASE_URL
</script>

# Skymaps
Error using multiple expansion points

<span v-click="1" class="absolute w-0 h-0 overflow-hidden" />
<span v-click="2" class="absolute w-0 h-0 overflow-hidden" />

<div class="grid grid-cols-2 gap-4 w-full my-10">
  <div v-for="folder in ['plots', 'plots_diov']" :key="folder" class="flex items-center justify-center">
    <template v-for="(n, i) in [6, 11, 21]" :key="n">
      <template v-if="$clicks === i">
        <img :src="`${envBase}${folder}/relative_error${n}.svg`" class="w-full object-contain dark:hidden" />
        <img :src="`${envBase}${folder}/relative_error${n}_dark.svg`" class="w-full object-contain hidden dark:block" />
      </template>
    </template>
  </div>
</div>


---
level: 1
layout: section
transition: view-transition
---

# Conclusions


---
level: 2
transition: slide-left
---

# Future work

* **Simsilun**

  * More accurate relativistic simulations
  * Prepare for real data
  * Use CNNs to determine backreaction in our Universe

<div v-click class="mt-4">

* **Cosmography**

  * Improve cosmographic expansion by using rolling mean, Padé approximant, or more terms
  * Determine dominant terms using more complex models
  * Apply method to observational data

</div>

<div v-click class="mt-4">

* Further examine these and other aspects of inhomogeneous cosmology

</div>

---
level: 2
transition: fade
---

# Summary

<v-clicks>

* Backreaction effects in Simsilun simulations

* Neural networks predicted the effects well

* Many low-resolution simulations better than few high-resolution

* Cosmography around arbitrary expansion points is useful

* Large density contrasts prove a challenge

* Can be used to determine the local effective Hubble parameter

* Further work required to determine the relativistic effects in inhomogeneous cosmology

</v-clicks>


---
layout: end
level: 3
---

# Thank you for listening! Questions?