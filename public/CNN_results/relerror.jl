using CairoMakie
using NPZ
using Statistics
using Printf
using PlotUtils
using LaTeXStrings

# ============================================================
# Helper: Convert "e" notation to standard LaTeX 10^n notation
# ============================================================
function sci_to_tex(s::String)
    if occursin("e", s)
        base, exp_str = split(s, "e")
        exp_int = parse(Int, exp_str) # Cleans up "-04" to "-4"
        return string(base, raw" \times 10^{", exp_int, "}")
    end
    return s
end

# ============================================================
# Global Theme Settings 
# ============================================================
# Adjusted for Histogram: Removed `aspect = 1` as data scales aren't equal.
# Retained LaTeX tick formatting for uniform look with 10^n notation.
set_theme!(
    fontsize = 12,
    Axis = (
        titlesize = 12,
        labelsize = 12,
        xticklabelsize = 10,
        yticklabelsize = 10,
        xtickformat = xs -> [latexstring(sci_to_tex(@sprintf("%g", x))) for x in xs],
        ytickformat = ys -> [latexstring(sci_to_tex(@sprintf("%g", y))) for y in ys]
    )
)

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
# Labels
# ============================================================

labels = [
    raw"\Omega_{m,i}",
    raw"\Omega_{\Lambda,i}",
    raw"\Omega_{k,i}",
    raw"\Omega_{Q,i}",
    raw"h_i",
    raw"\Omega_{m,f}",
    raw"\Omega_{\Lambda,f}",
    raw"\Omega_{k,f}",
    raw"\Omega_{Q,f}",
    raw"h_f"
]

safe_names = [
    "Omega_m_i","Omega_Lambda_i","Omega_k_i","Omega_Q_i","h_i",
    "Omega_m_f","Omega_Lambda_f","Omega_k_f","Omega_Q_f","h_f"
]

tol_colors = PlotUtils.palette(:tol_bright)

colors = repeat(
    [
        tol_colors[1],
        tol_colors[2],
        tol_colors[3],
        tol_colors[5],
        tol_colors[4]
    ],
    2
)

# ============================================================
# Output Directory
# ============================================================

outdir = "residual_hists"
mkpath(outdir)

println("Generating Raw Relative Error Histogram PDFs...")

# ============================================================
# MAIN LOOP
# ============================================================

for i in eachindex(labels)

    t = test_true[:, i]
    p = test_pred[:, i]
    
    # 1. RAW CALCULATION: "Risky" division by true value, no epsilon.
    res = (t .- p) ./ t

    # 2. Pure MSE
    mse = mean((t .- p).^2) #MSRE is mean(res.^2) 
    # Apply 10^n formatting. If MSE is NaN due to division by zero, print NaN.
    mse_str = isnan(mse) ? "NaN" : sci_to_tex(@sprintf("%.2e", mse))

    # 3. Filter data just for plotting limits (to avoid Makie crashing on Inf)
    plot_data = res[isfinite.(res)]
    
    if isempty(plot_data)
        @warn "Skipping $(labels[i]) - all relative errors are non-finite (e.g. division by zero)."
        continue
    end

    # Define x-axis limits based strictly on finite outliers
    x_min, x_max = minimum(plot_data), maximum(plot_data)
    x_width = x_max - x_min
    x_pad = (x_width == 0) ? 0.1 : 0.05 * x_width

    # Title
    latex_title = latexstring(labels[i], raw" \quad (\text{MSE} = ", mse_str, ")")

    # Single, clean figure creation
    fig = Figure(size = (280, 280), figure_padding=2)

    ax = Axis(
        fig[1, 1],
        xlabel = L"(\text{True} - \text{Predicted})/\text{True}",
        ylabel = L"\text{Count}",
        title  = latex_title
    )

    # Plot Histogram
    c = colors[i]
    hist!(
        ax,
        plot_data,
        bins = 50,                
        color = (c, 0.5),         
        strokecolor = c,          
        strokewidth = 1
    )

    # Vertical baseline at zero fractional error
    vlines!(
        ax, 
        [0.0], 
        linestyle = :dash, 
        color = :black,
        linewidth = 2
    )

    # Lock limits based on risky x-values, autoscale y
    limits!(ax, x_min - x_pad, x_max + x_pad, nothing, nothing)

    save(joinpath(outdir, "cnn_rel_err_hist_$(safe_names[i]).pdf"), fig)
end

println("Done. Raw hybrid histogram plots generated.")
