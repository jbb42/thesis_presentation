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
Thank you all for coming, especially thanks to my supervisor Sofie for great help and guidance.
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

<div class="absolute right-5 top-0 translate-y-5 w-60 z-50">
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

<!--
* We will examine relativistic effects of inhomogeneities in two ways:
* First we will look at global effects of the universe, seeing how it contribute to curvature and accelerated expansion.
* This is done through simulations, with CNNs then employed as a proof-of-concept of how to extract values from observations.
* In the second part, we look at how local observations are affected by inhomogeneitites. To do that, we use cosmograpy, which is a method to extract comsological parameters from observables without assuming an underlying model. We do this by comparing exact ray-tracing results to a cosmographic expansion.
* We will start with a brief theoretical introduction to inhomogeneous cosmology:
-->

---
level: 1
layout: section
---

# Inhomogeneous Cosmology

<!--
First, I will go through our standard model of the universe, then i will break the assumption of homogeneity to obtain Buchert and LTB
-->

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

$$ \begin{aligned}
\bigg(\frac{\dot{a}}{a}\bigg)^2 &\equiv H^2 = \frac{\kappa}{3} \rho - \frac{k}{a^2} + \frac{\Lambda}{3} \\
\frac{\ddot{a}}{a} &= -\frac{\kappa}{6} (\rho+3p) + \frac{\Lambda}{3} 
\end{aligned}
$$

Flat universe with accelerating expansion --- $\Lambda$CDM model
</v-click>



::right::

<v-click>
  <RaisinBun />
</v-click>

<!--
* Modern cosmology is based on general relativity.
* Curvature = matter-energy
* Hard to solve by putting everything into RHS, we need to make assumption
* Homo-iso is the simplest assumption we can make, but works remarkably well
* FLRW metric with scale factor (expansion/contraction) and GLOBAL curvature
* By solving Einstein eq for this metric, we get Friedmann. Describes dynamics of universe.
* What we observe is a flat universe where everything moves away from us faster and faster (accelerated expansion, raisin bun).
* Our current best model of the universe is the LCDM model, which plugs 5% standard model matter, 26% DM and 69% DE (cosmological constant) into the FLRW model.
* Works well, but is slightly wrong.
-->

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
\begin{aligned}
    3\bigg(\frac{\dot{a}_\mathcal{D}}{a_\mathcal{D}}\bigg)^2 &= 3H_\mathcal{D}^2 = {\color{CadetBlue}- \frac{1}{2} \langle{}^{(3)}\mathcal{R}\rangle_\mathcal{D}} + \kappa \langle\rho\rangle_\mathcal{D} + \Lambda - {\color{CadetBlue}\frac{1}{2} Q_\mathcal{D}}\\
    3\frac{\ddot{a}_\mathcal{D}}{a_\mathcal{D}} &= {\color{CadetBlue}Q_\mathcal{D}} - \frac{\kappa}{2}\langle \rho \rangle_\mathcal{D} + \Lambda\\
    Q_\mathcal{D} &= \frac{2}{3}\big(\langle \Theta^2 \rangle_\mathcal{D} - \langle \Theta \rangle_\mathcal{D}^2\big)  - 2\langle \sigma^2 \rangle_\mathcal{D}
\end{aligned}
$$
</v-click>

<v-click>

Cosmological accelerated expansion without local acceleration!

</v-click>

<v-click>
<div class="flex justify-center items-center gap-8 text-xl">
    <span color="#3B88C3">Blue team (voids): 20 km/h</span> 
    <span color="#DD2E44">Red team (overdensities): 10 km/h</span>
</div>
  <CyclistRace />
</v-click>

<!--
* We see that spatial averages and time derivatives do not commute.
* This means that what we did before wasn't entirely correct.
* We instead average local equations over a domain, to take effect into account.
* Gives the Buchert equations, Friedmann with replaced curvature term and new kinematical backreaction.
* Q depends on the variance of the expansion and the shear -- we can get global accelerated expansion without any local region accelerating.
* Confused? We look at a simple example of two teams of cyclists. Rules: double every ten kilometers. Blue is faster, doubles more often than red, increases average velocity.
* Blue are actually cosmic voids, red are overdense regions
-->

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

<span color="#3d7fc2">Void surrounded by overdensity</span> and <span color="#e16171">Gaussian overdensity</span>

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

<!--
* We will look at a way to model these effects.
* Introducing Lemaitre--Tolman--Bondi metric.
* Resembles FLRW due to spherical symmetry, but a is replaced by areal radius A, which has an r dependence. Curvature is also r dependent now.
* By varying the curvature function, we can model different universes. We use a very typical void compensated by an overdensity, and an overdensity.
* We can calculate parameters from solving this model, including expansion and shear, hence backreaction!
* Turns out, not that much backreaction even when taking LTB to its TARDIS limits (Lavinto, Räsänen, and Szybka)
-->

---
level: 1
layout: section
---

# Simplified Silent Universes

<!--
We thus choose another approach, namely cosmological simulations based on the simplified silent universe approximations.

We will train a neural network from these as a proof of concept of how to extract effects from observations
-->

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

$$\begin{aligned}
    \dot{\rho} &= -\rho \Theta\\
    \dot{\Theta} &= -\frac{1}{3}\Theta^2 - \frac{1}{2}\kappa \rho - 6 \Sigma^2 + \Lambda\\
    \dot{\Sigma} &= -\frac{2}{3}\Theta \Sigma + \Sigma^2 - \mathcal{W}\\
    \dot{\mathcal{W}} &= -\Theta \mathcal{W} - \frac{1}{2}\kappa \rho \Sigma - 3 \Sigma \mathcal{W}\\
    \dot{V} &= \Theta V
\end{aligned}$$

</div>

</v-click>

<v-click>

Solve for each cell to simulate universes

</v-click>

<!--
* First, we discuss what a cosmological simulation is.
*  Always an approximation of the universe
* N-body are really good at structures like galaxies and clusters. Typically Newtonian, and often required periodic boundary conditions. These limit the curvature and hence backreaction due to the torus geometry and the integrability condition.
* We thus use another scheme, the simplified silent universe, which is a relativistic numerical simulation without periodic boundary conditions.
* The cost we pay instead is the silent universe: no long range interaction, with irrotational, pressureless dust and vanishing magnetic Weyl.
* We get coupled dynamic equations for density, expansion rate, shear, Weyl curvature and volume.
* No spatial derivatives, thus we can simulate regions independently.
* We can simulate the universe on a grid by evolving each cell
-->

---
level: 3
transition: slide-left
layout: two-cols
---

# Simsilun equations
Simplifying initial conditions


Perturbation theory from density contrast $\delta$

$$
\begin{aligned}
    \rho_i &= \bar{\rho}(1 + \delta_i) \\
    \Theta_i &= \bar{\Theta}\bigg(1 - \frac{1}{3}\delta_i\bigg) \\
    \Sigma_i &= \frac{1}{9}\bar{\Theta} \delta_i \\
    \mathcal{W}_i &= -\frac{\kappa}{6}\bar{\rho} \delta_i\\
    V_i &= \frac{1}{1+\delta_i}
\end{aligned}
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

<!--
* To simulate we need initial conditions to start with
* Based on perturbation theory linear in density contrast $\delta$
* To test these against a known model, we compare to LTB
* Initial, perturbed, exact final, silun, simsilun
* $\rho$ of course has perfect initial conditoons per definition. Silun very good, Simsilun not so. $Theta$ similar
* $\Sigma$ not so good. Initial conditions deviate significantly, due to flat but non-background void (absolute vs gradient). Same with Weyl.
* Corrupts the entire simulation. Not good, but how bad? Mostly bad for structures spanning many cells, which our structures do not.
* We proceed to generate $\delta_i$ by making CLASS powerspectrum and using inverse Fourier create Gaussian random field.
-->

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

<!--
* We then simulate universes until background $(\delta=0)$ Hubble parameter equals measured Hubble constant.
* Even in comoving coordinates, we see matter clumping resembling our universe with voids and small clumps of matter in between.
* We perform a large number of simulations in intervals around our best estimates of density/Hubble parameters. More low-res universes due to computational cost.
* We see backreaction effects in N=64. Look at top of cornerplot. Numbers are smaller for m and L, larger for k. We get more curvature, and also some Q, and h changes.
* Mostly similar for N=128. Slightly larger effects due to less smoothening, but also more sparse due to less simulations
-->

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
 | Sidelength $N$  | $64$ | $128$| $64$ |
 | # Simulations  |$92610$|$6655$|$6655$| 

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

<!--
* We then move on to training a CNN to predict density parameters and Hubble parameter, both initial and final, from final density map (somewhat resembling what we see today).
* We train three versions. Low-res, high-res, control
* All use same network and hyperparameters. Extra input layer to downscale N=128 data.
* Split into training, validation and test data. Equal number of each kind of universe.
* Train for up to 250 epochs, usually a lot shorter due to early stopping after 20 epochs without improvement.
-->

---
level: 3
transition: view-transition
---

# Training CNNs
Convolutional neural network architecture

<div class="w-full flex items-center justify-center mt-0">
  <img src="/cnn.svg" class="w-full mx-auto dark:hidden" alt="CNN Architecture Light" />
  <img src="/cnn_dark.svg" class="w-full mx-auto hidden dark:block" alt="CNN Architecture Dark" />
</div>

<!--
* Structure of the network. Input is 3d-density cube (drawing shows only 2d)
* Four convolutional blocks, consisting of convolution (trains filters to recognise structures), batch normalisation (for stability), and max-pooling (for downscaling)
* After downscaling we reduce to 128 values by global average pooling the remaining spatial
* Fully connected layer (like perceptron) connected to output layer (with dropout to decrease overfitting)
* Takes "observation" as input, outputs density parameters and Hubble parameter at both initial and final time.
-->

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

<!--
* What do we then see? Very accurate predictions for CNN1, both initial and final.
* Less good for CNN2, especially final.
* Actually better for CNN3. Surprising, CNN2 should be at least as good.
* Loss part of explanation. CNN1 and CNN3 flatten, CNN2 does not.
* All in all, I demonstrate it works as proof of concept.
* We cannot yet use simulations directly with our network.
-->

---
level: 1
layout: section
---

# Cosmography

<!--
We have now seen how to obtain global backreaction effects.

We will proceed to what we can learn about the inhomogeneous universe from local observations.
-->

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

<!--
* Imhomogeneities change global dynamics of the Universe through backreaction.
* But how do inhomogeneitites change what we locally observe?
* To look at that, we would like to introduce a framework that does not rely on an underlying model. Thus no LTB og slient universe, only what we can learn directly from observations.
* We look at lensing and kinematical effects on observation, not at global effects like backreaction.
* To do that, we perform a cosmographic expansion of an observable parameter. We do that in form of Taylor expanding the angular diameter distance around the redshift z.
-->

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

<!--
* Before making the cosmographic expansion, we start with exact ray tracing
* To do this, we look at geodesic equation and transport equation (geodesic deviation equation) for light rays.
* Path travelled, and how light bundle behaves.
* We can define an optical tidal matrix to describe the focusing and shear of light ray bundle.
* Depends on Ricci (density) and Weyl (tidal effects) respectively.
* By using the linearity of the deviation vector, we can write it in terms of a Jacobian D. We can obtain this Jacobian through its second derivative.
* This yields the angular diameter distance. Essentially from area and solid angle.
-->

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
* We then do cosmographic expansion of $d_A$.
* Use relation between affine parameter $\lambda$ and redshift $z$, along with definition of $d_A$ in terms of ray bundle expansion
* First order term: Actually positive, since rays are converging, meaning $\hat{\theta}$ is negative.
* Second order terms:
  * First: Similar to above, but negative -> contributes to smaller d_A
  * Second and third: both begative, both negligible (required much matter). Traditional view of lensing
  * Fourth: Initially negative (minus, theta minus and negative differential as H decreases with \lambda (increases with z) on slope towards centre), positive from centre of void, flips dramatically to negative at overdensity due to derivative chaning sign again. Zero in background due to derivative being zero.
* Third order contains combinations and derivatives of these. We won't go through it but will use it.
* We make a Taylor expansion to third order to approximate the angular diameter distance by expanding around arbitrary redshift.
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

  <div v-show="$clicks === 1" class="absolute inset-0 flex items-end justify-end pb-4">
    <img src="/fiducial_vs_expansion.svg" class="w-full h-full object-contain dark:hidden" />
    <img src="/fiducial_vs_expansion_dark.svg" class="w-full h-full object-contain hidden dark:block" />
  </div>

  <div v-show="$clicks === 2" class="absolute inset-0 flex items-center justify-center">
    <img src="/dA_zz_terms.svg" class="h-full w-auto object-contain dark:hidden" />
    <img src="/dA_zz_terms_dark.svg" class="h-full w-auto object-contain hidden dark:block" />
  </div>
</div>

<!--
* To examine the expansion, we start by looking at a fiducial ray -- a well-chosen light ray in a random direction.
* We place an observer close to large density gradients in each model. RHS plot shows what they see along line of sight.
* Looking at expansion vs exact ray-traced ray, we see why it is relevant to expand around arbitrary z. z=0 diverges quickly.
* Expansion around large density contrasts even worse. Not a problem in LTB2.
* The terms in the second order term shows that only first and last term contribute significantly. Too little matter to get significant Ricci lensing, but important kinematical effects, especially last term.
-->

---
level: 2
transition: slide-up
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
  <div v-show="$clicks === clickIdx" class="grid grid-cols-[30px_1fr_1fr_1fr_1fr] grid-rows-2 gap-y-4 gap-x-2 mt-8 items-center">
    <div class="flex justify-center items-center h-full">
      <div class="-rotate-90 text-sm font-bold tracking-widest opacity-70 whitespace-nowrap">LTB1 at <i>z<sub>*</sub></i> = {{ anchors.v }}</div>
    </div>
    <div v-for="f in ['dA_contrast', 'dA_z_contrast', 'dA_zz_contrast', 'dA_zzz_contrast']" :key="'v'+f">
      <img :src="`${base}plots/z_${anchors.v}/${f}.svg`" class="w-full dark:hidden" />
      <img :src="`${base}plots/z_${anchors.v}/${f}_dark.svg`" class="w-full hidden dark:block" />
    </div>
    <div class="flex justify-center items-center h-full">
      <div class="-rotate-90 text-sm font-bold tracking-widest opacity-70 whitespace-nowrap">LTB2 at <i>z<sub>*</sub></i> = {{ anchors.d }}</div>
    </div>
    <div v-for="f in ['dA_contrast', 'dA_z_contrast', 'dA_zz_contrast', 'dA_zzz_contrast']" :key="'d'+f">
      <img :src="`${base}plots_diov/z_${anchors.d}/${f}.svg`" class="w-full dark:hidden" />
      <img :src="`${base}plots_diov/z_${anchors.d}/${f}_dark.svg`" class="w-full hidden dark:block" />
    </div>
    
  </div>
</template>

<!--
* Centre is from position and radially inwards towards the centre of the void (overdensity). At second redshift we therefore see a ring of light rays still coming from inside the void (overdensity) being smaller (larger) than FLRW.
* What we should notice here: higher order derivatives grow in magnitude, making LTB1 not converge.
* LTB1 is primarily bad around the large density contrasts, seen by the rings.
* LTB2 is more well-behaved due to less density contrast.
-->

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
  <div v-show="$clicks === clickIdx" class="grid grid-cols-[30px_1fr_1fr_1fr_1fr] grid-rows-2 gap-y-4 gap-x-2 mt-8 items-center">
    <div class="flex justify-center items-center h-full">
      <div class="-rotate-90 text-sm font-bold tracking-widest opacity-70 whitespace-nowrap">LTB1 at <i>z</i> = 0.010</div>
    </div>
    <div v-for="o in [0,1,2,3]" :key="'v'+o">
      <img :src="`${base}plots/expansion_errors_at_z0.010/error_order_${o}_anchor_${anchors.v}.svg`" class="w-full dark:hidden" />
      <img :src="`${base}plots/expansion_errors_at_z0.010/error_order_${o}_anchor_${anchors.v}_dark.svg`" class="w-full hidden dark:block" />
    </div>
    <div class="flex justify-center items-center h-full">
      <div class="-rotate-90 text-sm font-bold tracking-widest opacity-70 whitespace-nowrap">LTB2 at <i>z</i> = 0.002</div>
    </div>
    <div v-for="o in [0,1,2,3]" :key="'d'+o">
      <img :src="`${base}plots_diov/expansion_errors_at_z0.002/error_order_${o}_anchor_${anchors.d}.svg`" class="w-full dark:hidden" />
      <img :src="`${base}plots_diov/expansion_errors_at_z0.002/error_order_${o}_anchor_${anchors.d}_dark.svg`" class="w-full hidden dark:block" />
    </div>
    
  </div>
</template>

<!--
* Looking at the error at a specific redshift, by comparing expansion at different orders to ray-tracing results
* Zeroth order at $z_*=0$ is zero, so only numerical error shown there.
* What we expect: higher order -> improve, redshift closer to eval _> improve.
* We see that for LTB2
* LTB1 gets worse, but again in a narrow ring, actually gets better in most directions.
* When all rays come from outside, we do not have a problem with sharp density contrasts.
-->

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

<!--
* As a last test, we combine expansions around multiple points.
* Blue line shows mean error of skymap, red/green standard deviation (due to anisotropy).
* We expect error to become smaller with more expansion points.
* True for LTB2, not exactly true for LTB1.
* Around first ray from outside and last ray from inside, so "uncompensated" extremes.
* We could consider using a rolling mean.
-->

---
level: 1
layout: section
transition: view-transition
---

# Conclusions

<!--
We have now seen both global and local effects. We will now proceed onto what could be done in the future, and summarise our findings.
-->

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

<!--
* We are not done here. To actually use the results in the future, we have to make some improvements.
* For simsilun, we first of all need more accurate simulations. Simsilun is a toy model, and is good for small experiments, but to actually compare to observations, we need a more realistic relativistic simulation framework.
* We also need to prepare our simulation to produce maps that resemble actual observational data, or alternatively make some preprocessing of observational data, to train our networks to predict real data. With this, we can use CNNs as an interesting first step in how to infer backreaction effects in our universe.
* For the cosmographic expansion, we saw problematic effects from large density gradients. We could use a rolling mean or another type of expansion to mitigate these.
* To use the expansion to predict parameters by fitting, we can look at which terms are negligible also in more complex model, to reduce amount of free parameters.
* When method is improved and we get extensive amounts of new data, we can test our method on the data and try to infer parameters like local effective Hubble parameter.
* All in all, it makes sense for further look into aspects of inhomogeneous cosmology, as it has both local and global effects we should not ignore.
-->

---
level: 2
transition: fade
---

# Summary

<GradientBox width="w-full">

* Backreaction effects occured in the Simsilun simulations
<v-clicks>

* CNNs predict the effects well, especially using many low-resolution simulations
* Cosmography with arbitrary $z$ is useful, large density gradients prove a challenge
* Can be used to determine the local effective Hubble parameter
* More work required to determine relativistic effects in inhomogeneous cosmology
</v-clicks>
</GradientBox>

<!--
* We see backreaction effects in the Simsilun universes, and can predict these using CNNs. Works best with a large amount of low-res universes.
* We proved the usefulness of doing cosmographic expansions around arbitrary points, but also shows how large density contrasts proves a challenge. It does, however, show a possible method for determining local effective Hubble parameter at different redshifts and locations in the sky.
* We are not done here, further work is required to determine the relativistic effects in inhomogeneous cosmology.
-->

---
layout: end
level: 3
---

# Thank you for listening! Questions?

<!--
(Smil, bliv stående, lign en vinder)

Og gå tilbage til summary!
-->
