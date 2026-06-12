using CairoMakie
using NPZ
using Statistics
using Printf
using PlotUtils
using LaTeXStrings

# ============================================================
# Global Theme Settings
# ============================================================
set_theme!(
    fontsize = 12,
    Axis = (
        titlesize = 12,
        labelsize = 12,
        xticklabelsize = 10,
        yticklabelsize = 10,
        aspect = 1, 
        xtickformat = xs -> [latexstring(@sprintf("%g", x)) for x in xs],
        ytickformat = ys -> [latexstring(@sprintf("%g", y)) for y in ys]
    )
)

# ============================================================
# Helper Function: Layout-Aware Matplotlib Emulator
# ============================================================
function apply_scientific_scale!(fig, row, col, x_data, y_data)
    max_val = max(maximum(abs.(x_data)), maximum(abs.(y_data)))
    exponent = max_val > 0 ? floor(Int, log10(max_val)) : 0

    if exponent <= -3 || exponent >= 4
        factor = 10.0^exponent
        scale_text = latexstring(raw"\times 10^{", exponent, "}")
        
        # Top() targets the margin ABOVE the axis. halign=:left puts it in the top-left corner.
        Label(fig[row, col, Top()], scale_text, fontsize = 10, 
              halign = :left, valign = :bottom, 
              padding = (0, 0, 0, 0)) # A tiny 2px bump up so it clears the line
              
        # Bottom() targets the margin BELOW the axis. halign=:right puts it in the bottom-right.
        Label(fig[row, col, Bottom()], scale_text, fontsize = 10, 
              halign = :right, valign = :top, 
              padding = (0, 0, 0, 0)) # A tiny 2px bump down
              
        return x_data ./ factor, y_data ./ factor
    end
    
    return x_data, y_data
end

# ============================================================
# Load data
# ============================================================

data = npzread("./run_artifacts/results64ss.npz")

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

tol_colors = PlotUtils.palette(:tol_bright)
colors = repeat([tol_colors[1], tol_colors[2], tol_colors[3], tol_colors[5], tol_colors[4]], 2)

# ============================================================
# Metrics
# ============================================================

r2(y, ŷ) = 1 - sum((y .- ŷ).^2) / sum((y .- mean(y)).^2)

# ============================================================
# MAIN LOOP
# ============================================================

outdir = "parity_plots_individual_ss"
mkpath(outdir)
println("Generating High-Fidelity CairoMakie PDFs...")

for i in eachindex(labels)

    t_raw = test_true[:, i]
    p_raw = test_pred[:, i]
    score = round(r2(t_raw, p_raw), digits = 3)

    # 1. Setup Figure and Axis
    fig = Figure(size = (300, 270), figure_padding = 5)
    latex_title = latexstring(labels[i], raw" \quad (R^2 = ", score, ")")
    
    ax = Axis(fig[1, 1], xlabel = L"\text{True}", ylabel = L"\text{Predicted}", title = latex_title,
    xticks = LinearTicks(5), yticks = LinearTicks(5))

    # 2. Apply our custom Matplotlib-style scaling (returns clean scaled data)
    t, p = apply_scientific_scale!(fig, 1, 1, t_raw, p_raw)

    # 3. Calculate plotting limits on the scaled data
    lo = min(minimum(t), minimum(p))
    hi = max(maximum(t), maximum(p))
    pad = 0.05 * (hi - lo)
    
    # 4. Plot
    scatter!(ax, t, p, color = colors[i], markersize = 2, alpha = 0.6, rasterize = 5)
    lines!(ax, [lo, hi], [lo, hi], linestyle = :dash, color = :black, linewidth = 2)
    limits!(ax, lo - pad, hi + pad, lo - pad, hi + pad)
    
    save(joinpath(outdir, "cnn_$(safe_names[i]).pdf"), fig)
end

println("Done. CairoMakie superiority maintained.")

# ============================================================
# TABLE OUTPUT
# ============================================================
println("\nScientific Notation Table:\n")

for i in eachindex(labels)
    t = test_true[:, i]
    score = round(r2(t, test_pred[:, i]), digits = 8)
    rmin, rmax = @sprintf("%.8e", minimum(t)), @sprintf("%.8e", maximum(t))

    println("\$", labels[i], "\$ & \\num{$rmin} & \\num{$rmax} & $score \\\\")
end
println("\nDone.")
