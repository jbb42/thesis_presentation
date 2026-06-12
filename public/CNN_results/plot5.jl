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
# By passing the specific grid position (e.g., fig[1, 1] or fig[1, 2]),
# this automatically attaches the 10^n modifiers to the correct subplot!
function apply_scientific_scale!(grid_pos, x_data, y_data)
    max_val = max(maximum(abs.(x_data)), maximum(abs.(y_data)))
    exponent = max_val > 0 ? floor(Int, log10(max_val)) : 0

    if exponent <= -3 || exponent >= 4
        factor = 10.0^exponent
        scale_text = latexstring(raw"\times 10^{", exponent, "}")
        
        # padding = (left, right, bottom, top) pushes the text slightly away from the axis spine
        Label(grid_pos, scale_text, fontsize = 10, 
              halign = :left, valign = :top, 
              tellwidth = false, tellheight = false, padding = (0, 0, 0, 25))
              
        Label(grid_pos, scale_text, fontsize = 10, 
              halign = :right, valign = :bottom, 
              tellwidth = false, tellheight = false, padding = (0, 0, 30, 0))
              
        return x_data ./ factor, y_data ./ factor
    end
    
    return x_data, y_data
end

# ============================================================
# Load data
# ============================================================

data = npzread("./run_artifacts/results64.npz")

test_true = data["test_true"]
test_pred = data["test_pred"]

order = [1, 2, 3, 4, 9, 5, 6, 7, 8, 10]

test_true = test_true[:, order]
test_pred = test_pred[:, order]

# scale h
for col in [5, 10]
    test_true[:, col] .*= 306.5926758 / 1.0227e-1
    test_pred[:, col] .*= 306.5926758 / 1.0227e-1
end

# ============================================================
# Parameter Groupings
# ============================================================

# We group the initial and final column indices together for the loop
parameter_groups = [
    (1, 6,  raw"\Omega_{m,i}",       raw"\Omega_{m,f}",       "Omega_m"),
    (2, 7,  raw"\Omega_{\Lambda,i}", raw"\Omega_{\Lambda,f}", "Omega_Lambda"),
    (3, 8,  raw"\Omega_{k,i}",       raw"\Omega_{k,f}",       "Omega_k"),
    (4, 9,  raw"\Omega_{Q,i}",       raw"\Omega_{Q,f}",       "Omega_Q"),
    (5, 10, raw"h_i",                raw"h_f",                "h")
]

# Using specific colors from your Tol palette to distinguish Initial vs Final
tol_colors = PlotUtils.palette(:tol_bright)
color_initial = tol_colors[1] # Blue-ish
color_final   = tol_colors[2] # Red-ish

# ============================================================
# Metrics
# ============================================================

r2(y, ŷ) = 1 - sum((y .- ŷ).^2) / sum((y .- mean(y)).^2)

# ============================================================
# MAIN LOOP: Side-by-Side Subplots
# ============================================================

outdir = "parity_plots_side_by_side"
mkpath(outdir)
println("Generating Side-by-Side CairoMakie PDFs...")

for (idx_i, idx_f, label_i, label_f, safe_name) in parameter_groups

    # Create a wider figure to hold 2 square panels comfortably
    fig = Figure(size = (600, 280), figure_padding = 25)

    # --------------------------------------------------------
    # LEFT PANEL: Initial Parameter (z = 90)
    # --------------------------------------------------------
    t_i = test_true[:, idx_i]
    p_i = test_pred[:, idx_i]
    score_i = round(r2(t_i, p_i), digits = 3)
    
    title_i = latexstring(label_i, raw" \quad (R^2 = ", score_i, ")")
    
    # fig[1, 1] puts this in the first row, first column
    ax_i = Axis(fig[1, 1], xlabel = L"\text{True}", ylabel = L"\text{Predicted}", title = title_i,
                xticklabelrotation = pi/4, xticklabelalign = (:right, :center), xticks = LinearTicks(5))
    
    t_i_scaled, p_i_scaled = apply_scientific_scale!(fig[1, 1], t_i, p_i)
    
    lo_i = min(minimum(t_i_scaled), minimum(p_i_scaled))
    hi_i = max(maximum(t_i_scaled), maximum(p_i_scaled))
    pad_i = 0.05 * (hi_i - lo_i)
    
    scatter!(ax_i, t_i_scaled, p_i_scaled, color = color_initial, markersize = 2, alpha = 0.6, rasterize = 5)
    lines!(ax_i, [lo_i, hi_i], [lo_i, hi_i], linestyle = :dash, color = :black, linewidth = 2)
    limits!(ax_i, lo_i - pad_i, hi_i + pad_i, lo_i - pad_i, hi_i + pad_i)

    # --------------------------------------------------------
    # RIGHT PANEL: Final Parameter (z = 0)
    # --------------------------------------------------------
    t_f = test_true[:, idx_f]
    p_f = test_pred[:, idx_f]
    score_f = round(r2(t_f, p_f), digits = 3)
    
    title_f = latexstring(label_f, raw" \quad (R^2 = ", score_f, ")")
    
    # fig[1, 2] puts this in the first row, second column
    ax_f = Axis(fig[1, 2], xlabel = L"\text{True}", ylabel = L"\text{Predicted}", title = title_f,
                xticklabelrotation = pi/4, xticklabelalign = (:right, :center), xticks = LinearTicks(5))
    
    t_f_scaled, p_f_scaled = apply_scientific_scale!(fig[1, 2], t_f, p_f)
    
    lo_f = min(minimum(t_f_scaled), minimum(p_f_scaled))
    hi_f = max(maximum(t_f_scaled), maximum(p_f_scaled))
    pad_f = 0.05 * (hi_f - lo_f)
    
    scatter!(ax_f, t_f_scaled, p_f_scaled, color = color_final, markersize = 2, alpha = 0.6, rasterize = 5)
    lines!(ax_f, [lo_f, hi_f], [lo_f, hi_f], linestyle = :dash, color = :black, linewidth = 2)
    limits!(ax_f, lo_f - pad_f, hi_f + pad_f, lo_f - pad_f, hi_f + pad_f)

    # --------------------------------------------------------
    # SAVE FIGURE
    # --------------------------------------------------------
    # Adds a small gap between the two plots so the rotated text doesn't hit the right panel's y-axis
    colgap!(fig.layout, 30) 
    
    save(joinpath(outdir, "cnn_parity_$(safe_name).pdf"), fig)
end

println("Done. Side-by-side plots successfully generated.")
