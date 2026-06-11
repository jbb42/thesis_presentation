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

<div class="absolute right-10 top-6 w-66">
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
transition: slide-left
layout: two-cols
---

# FLRW cosmology

<span></span>

Using general relativity to solve the Universe

$$ R_{\mu\nu} - \frac{1}{2} R g_{\mu\nu} + \Lambda g_{\mu\nu} = \kappa T_{\mu\nu} $$

<v-click>
Assuming homogeneity and isotropy gives us FLRW metric

$$ \mathrm{d} s^2 = -\mathrm{d} t^2 + a(t)^2 \bigg( \frac{1}{1-kr^2} \mathrm{d} r^2 + r^2 \mathrm{d} \Omega^2 \bigg)  $$
</v-click>

<v-click>
Friedmann equtions describe dynamics of the entire Universe

$$ \begin{align*}
\frac{\dot{a}^2}{a^2} &\equiv H^2 = \frac{\kappa}{3} \rho - \frac{k}{a^2} + \frac{\Lambda}{3} \\
\frac{\mathrm{d}ot{a}}{a} &= -\frac{\kappa}{6} (\rho+3p) + \frac{\Lambda}{3} 
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

Large-scale effects from small-scale inhomogeneities?

<v-click>
Spatial averages and time derivatives does not commute. Averaging local equations:

$$
\begin{align*}
    3\frac{\dot{a}_\mathcal{D}^2}{a_\mathcal{D}^2} &= 3H_\mathcal{D}^2 = - \frac{1}{2} \langle{}^{(3)}\mathcal{R}\rangle_\mathcal{D} + \kappa \langle\rho\rangle_\mathcal{D} + \Lambda - \frac{1}{2} Q_\mathcal{D}\\
    3\frac{\ddot{a}_\mathcal{D}}{a_\mathcal{D}} &= Q_\mathcal{D} - \frac{\kappa}{2}\langle \rho \rangle_\mathcal{D} + \Lambda\\
    Q_\mathcal{D} &= \frac{2}{3}\big(\langle \Theta^2 \rangle_\mathcal{D} - \langle \Theta \rangle_\mathcal{D}^2\big)  - 2\langle \sigma^2 \rangle_\mathcal{D}
\end{align*}
$$
</v-click>

<v-click>

Kinematical backreaction $Q_\mathcal{D}$ and non-zero average curvature $\langle{}^{(3)}\mathcal{R}\rangle_\mathcal{D}$ changes cosmological dynamics.
Accelerating cosmological expansion without local accelerating expansion anywhere.

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

Void surrounded by overdensity

</v-click>

<v-click>

We can derive $\Theta$ and $\sigma^2$

$$
\Theta = \frac{\dot{A}'}{A'} + 2\frac{\dot{A}}{A}\,,\quad
\sigma^2 = \frac{1}{3} \bigg( \frac{\dot{A}'}{A'} - \frac{\dot{A}}{A} \bigg)^2 
$$

</v-click>

<v-click>

Difficult to produce significant backreaction <ArXiv id="1308.6731" />

</v-click>

::right::

### INSERT DENSITY LTB PLOT
<div class="h-full flex items-center justify-center" v-click="2">
  <img src="/frontpic.png" />
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

# The Simsilun equations
Motivation and derivation


Cosmological simulations are approximations of the Universe


<v-click>
N-body simulations successfully produce structures, but require periodic boundary conditions

</v-click>

<v-click>

Simplified silent universe (Simsilun) as a numerical approach without PBCs <ArXiv id="1708.09143" />

</v-click>

<v-click>

Starting with general fluid decription:

$$
\begin{align*}
  \dot{\rho} &= - (\rho + p)\Theta - \pi^{\mu\nu} \sigma_{\mu\nu} - q^{\nu}{}_{;\nu} -  q^\mu A_\mu\\
  \dot{\Theta} &= A_\mu A^\mu + \mathrm{D}_\mu A^\mu - 2(\sigma^2 -\omega^2) - \frac{1}{3}\Theta^2 - \frac{\kappa}{2}(\rho + 3 p) + \Lambda \\
  \dot{\sigma}_{\langle\mu\nu\rangle} &= A_{\langle\mu} A_{\rangle\nu}
    + \mathrm{D}_{\langle\mu}A_{\nu\rangle} - \sigma_{\langle\mu|\rho}\sigma^\rho{}_{\nu\rangle} - \omega_{\langle\mu} \omega_{\nu\rangle} 
    - \frac{2}{3}\Theta\sigma_{\mu\nu} -E_{\mu\nu} + \frac{\kappa}{2}\pi_{\mu\nu} \\
    \dot{E}_{\langle\mu\nu\rangle} &= -\Theta E_{\mu\nu} + \mathrm{curl}\, H_{\mu\nu} - \frac{\kappa}{2} (\rho + p) \sigma_{\mu\nu} - \frac{\kappa}{2} \dot{\pi}_{\mu\nu} - \frac{\kappa}{6} \Theta \pi_{\mu\nu} + 3 \sigma_{\langle\mu}{}^\alpha \left( E_{\nu\rangle\alpha} - \frac{\kappa}{6} \pi_{\nu\rangle\alpha} \right)
\end{align*}
$$

Complicated set of tensor equations

</v-click>

---
level: 3
transition: view-transition
---

# The Simsilun equations
Silencing the Universe

Assuming irrotational pressureless dust and vanishing magnetic Weyl tensor:

$$
    \omega_{\mu\nu} = 0\,,\quad
    A_\mu = 0\,,\quad
    q_\mu = 0\,,\quad
    p = 0\,,\quad
    \pi_{\mu\nu} = 0\,,\quad
    H_{\mu\nu} = 0
$$

<v-click>

Using $\sigma_{\mu\nu} = \Sigma e_{\mu\nu}$ and $E_{\mu\nu} = \mathcal{W} e_{\mu\nu}$ yields five scalar differential equations

$$\begin{align*}
    \dot{\rho} &= -\rho \Theta\\
    \dot{\Theta} &= -\frac{1}{3}\Theta^2 - \frac{1}{2}\kappa \rho - 6 \Sigma^2 + \Lambda\\
    \dot{\Sigma} &= -\frac{2}{3}\Theta \Sigma + \Sigma^2 - \mathcal{W}\\
    \dot{\mathcal{W}} &= -\Theta \mathcal{W} - \frac{1}{2}\kappa \rho \Sigma - 3 \Sigma \mathcal{W}\\
    \dot{V} &= \Theta V
\end{align*}$$

Solve for each cell to simulate universe

</v-click>

---
level: 3
transition: slide-left
layout: two-cols
---

# The Simsilun equations
Simplifying initial conditons


::right::
### INSERT LTB COMPARISON
<div class="h-full flex items-center justify-center" v-click="1">
  <img src="/frontpic.png" />
</div>

<style>
.slidev-layout.two-columns {
  grid-template-columns: 60% 40%;
}
</style>

---
level: 2
transition: slide-left
---

# The simulations


---
level: 2
transition: view-transition
---

# Training CNNs
CNN architecture

---
level: 3
transition: fade
---

# Training CNNs
CNN results

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
Ray tracing

---
level: 3
transition: slide-left
---

# Theory
Cosmographic expansion

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
level: 3
---

# Thank you for listening! Questions?


<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->
