using CairoMakie
using NPZ
using Statistics
using LaTeXStrings

# ============================================================
# 1. Data Loading
# ============================================================
# Adjust path as necessary
data_path = "./run_artifacts/results64.npz"
if !isfile(data_path)
    error("File not found: $data_path")
end

data = npzread(data_path)

test_true  = data["test_true"]
test_pred  = data["test_pred"]

# Define LaTeX labels for titles
labels = [L"\Omega_{m,i}", L"\Omega_{\Lambda,i}", L"\Omega_{k,i}", L"\Omega_{Q,i}", L"\Omega_{m,f}", 
          L"\Omega_{\Lambda,f}", L"\Omega_{k,f}", L"\Omega_{Q,f}", L"H_i", L"H_f"]

# Define "safe" names for filenames
safe_names = ["Omega_m_i", "Omega_Lambda_i", "Omega_k_i", "Omega_Q_i", "Omega_m_f", 
              "Omega_Lambda_f", "Omega_k_f", "Omega_Q_f", "H_i", "H_f"]

colors = [:red, :blue, :green, :orange, :purple, :red, :blue, :green, :orange, :purple]

# Helper function for R²
calc_r2(true_val, pred_val) = 1 - sum((true_val .- pred_val).^2) / sum((true_val .- mean(true_val)).^2)

# Create output directory
output_dir = "parity_plots_individual"
mkpath(output_dir)

# ============================================================
# 2. Individual Plot Generation
# ============================================================
println("Starting plot generation...")

for i in 1:10
    # Create a small square figure with very tight padding
    fig = Figure(size = (450, 450), figure_padding = 5) 
    
    t = test_true[:, i]
    p = test_pred[:, i]
    r2_val = round(calc_r2(t, p), digits=3)
    
    # Construct title using the correct %$ interpolation for LaTeXStrings
    # \text{} keeps the R² part in a standard font
    title_str = L"%$(labels[i]) \text{ (R² = %$r2_val)}"

    ax = Axis(fig[1, 1], 
              title = title_str,
              xlabel = "True", 
              ylabel = "Predicted",
              xticklabelrotation = π/4,
              titlesize = 20,
              xlabelsize = 16,
              ylabelsize = 16)
    
    # RASTERIZE ONLY THE SCATTER POINTS
    # Keeps the file size tiny but the axes and text perfectly sharp
    scatter!(ax, t, p, 
             markersize = 4, 
             color = (colors[i], 0.6), 
             rasterize = 2)
    
    # Identity line (Vector)
    limits = [min(minimum(t), minimum(p)), max(maximum(t), maximum(p))]
    lines!(ax, limits, limits, 
           color = :black, 
           linestyle = :dash, 
           linewidth = 1.5)
    
    # Adjust axis limits slightly so points aren't touching the edge
    padding = (limits[2] - limits[1]) * 0.05
    limits!(ax, limits[1] - padding, limits[2] + padding, 
                limits[1] - padding, limits[2] + padding)

    # Save to the directory
    save_path = joinpath(output_dir, "$(safe_names[i])_parity.pdf")
    save(save_path, fig)
    
    println("Saved: $save_path")
end

using Printf

println("\nScientific Notation for Horizontal Table:")
for i in 1:10
    t = test_true[:, i]
    r2 = round(calc_r2(t, test_pred[:, i]), digits=8)
    
    # Format range using scientific notation
    # %.2e creates e.g., 1.30e-02
    r_min = @sprintf("%.8e", minimum(t))
    r_max = @sprintf("%.8e", maximum(t))
    
    # Format for LaTeX siunitx: \num{1.30e-2}
    println("$(labels[i]) & \\num{$r_min} & \\num{$r_max} & $r2 \\\\")
end


println("Done! All plots saved in '$output_dir'.")
