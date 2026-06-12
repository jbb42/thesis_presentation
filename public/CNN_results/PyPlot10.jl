using PyPlot
using NPZ
using Statistics
using Printf
using PlotUtils
using Colors

# ============================================================
# Global Theme Settings (PyPlot / Matplotlib)
# ============================================================
# Use standard serif fonts and Computer Modern math fonts to mimic LaTeX
rc("font", family="serif", size=12)
rc("axes", titlesize=12, labelsize=12)
rc("xtick", labelsize=10)
rc("ytick", labelsize=10)
rc("mathtext", fontset="cm")

# ============================================================
# Load data
# ============================================================

data = npzread("./run_artifacts/results64.npz")

test_true = data["test_true"]
test_pred = data["test_pred"]

order = [1, 2, 3, 4, 9, 5, 6, 7, 8, 10]

test_true = test_true[:, order]
test_pred = test_pred[:, order]

# scale H
for col in [5, 10]
    test_true[:, col] .*= 306.5926758 / 1.0227e-1
    test_pred[:, col] .*= 306.5926758 / 1.0227e-1
end

# ============================================================
# Labels & Colors
# ============================================================

labels = [
    raw"\Omega_{m,i}", raw"\Omega_{\Lambda,i}", raw"\Omega_{k,i}", raw"\Omega_{Q,i}", raw"h_i",
    raw"\Omega_{m,f}", raw"\Omega_{\Lambda,f}", raw"\Omega_{k,f}", raw"\Omega_{Q,f}", raw"h_f"
]

safe_names = [
    "Omega_m_i","Omega_Lambda_i","Omega_k_i","Omega_Q_i","h_i",
    "Omega_m_f","Omega_Lambda_f","Omega_k_f","Omega_Q_f","h_f"
]

# Extract Tol colors and convert to Hex strings for PyPlot
tol_colors = PlotUtils.palette(:tol_bright)
colors = ["#" * hex(c) for c in repeat(
    [tol_colors[1], tol_colors[2], tol_colors[3], tol_colors[5], tol_colors[4]], 
    2
)]

# ============================================================
# R2 Metric
# ============================================================

r2(y, ŷ) = 1 - sum((y .- ŷ).^2) / sum((y .- mean(y)).^2)

# ============================================================
# Output Initialization
# ============================================================

outdir = "parity_plots_individual"
mkpath(outdir)

println("Generating Clean Hybrid Parity PDFs (PyPlot.jl)...")

# ============================================================
# MAIN LOOP
# ============================================================

for i in eachindex(labels)

    t = test_true[:, i]
    p = test_pred[:, i]
    score = round(r2(t, p), digits=3)
    
    lo = min(minimum(t), minimum(p))
    hi = max(maximum(t), maximum(p))
    pad = 0.05 * (hi - lo)

    # Create figure (3.8x3.8 inches is roughly ~270px at standard DPI)
    fig, ax = plt.subplots(figsize=(3.8, 3.8))

    # --------------------------------------------------------
    # MATPLOTLIB MAGIC: 1 line replaces 30 lines of Makie code
    # This forces scientific notation outside [-10^3, 10^3] and 
    # formats it beautifully as \times 10^n in the axis corners.
    # --------------------------------------------------------
    ax.ticklabel_format(style="sci", scilimits=(-3, 3), axis="both", useMathText=true)

    # Plot the data (Rasterized for lightweight PDF, alpha for density)
    ax.scatter(t, p, color=colors[i], s=1, alpha=0.6)
    
    # Parity Line
    ax.plot([lo, hi], [lo, hi], linestyle="--", color="black", linewidth=2)

    # Apply limits and force a perfectly square aspect ratio
    ax.set_xlim(lo - pad, hi + pad)
    ax.set_ylim(lo - pad, hi + pad)
    ax.set_aspect("equal", adjustable="box")
    ax.grid("on")

    # Labels and Title (PyPlot handles standard $...$ LaTeX natively)
    ax.set_xlabel("True")
    ax.set_ylabel("Predicted")
    ax.set_title("\$ $(labels[i]) \\quad (R^2 = $score) \$")

    # Save PDF with high DPI for the rasterized scatter, bbox_inches="tight" removes white edges
    fig.savefig(joinpath(outdir, "cnn_$(safe_names[i]).pdf"), bbox_inches="tight")
    
    # Close figure to prevent memory leaks in the loop
    close(fig)
end

println("Done. Beautiful, professional parity plots generated.")

# ============================================================
# TABLE OUTPUT
# ============================================================

println("\nScientific Notation Table:\n")

for i in eachindex(labels)

    t = test_true[:, i]
    score = round(r2(t, test_pred[:, i]), digits = 8)

    rmin = @sprintf("%.8e", minimum(t))
    rmax = @sprintf("%.8e", maximum(t))

    println(
        "\$", labels[i], "\$ & ",
        "\\num{$rmin} & ",
        "\\num{$rmax} & ",
        score,
        raw" \\"
    )
end

println("\nDone.")
