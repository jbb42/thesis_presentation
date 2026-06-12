using CairoMakie
using NPZ
using Statistics
using LaTeXStrings

# Load data
# Note: Ensure results64.npz is in the current directory
data = npzread("./run_artifacts/results64.npz")

train_true = data["train_true"]
train_pred = data["train_pred"]
val_true   = data["val_true"]
val_pred   = data["val_pred"]
test_true  = data["test_true"]
test_pred  = data["test_pred"]
loss       = data["loss"]
val_loss   = data["val_loss"]
mae        = data["mae"]
val_mae    = data["val_mae"]

# 1. Ensure LaTeXStrings is used. 
# Note: Wrap your labels in L"..." properly
labels = [L"\Omega_{m,i}", L"\Omega_{\Lambda,i}", L"\Omega_{k,i}", L"\Omega_{Q,i}", L"\Omega_{m,f}", 
          L"\Omega_{\Lambda,f}", L"\Omega_{k,f}", L"\Omega_{Q,f}", L"H_i", L"H_f"]

colors = [:red, :blue, :green, :orange, :purple, :red, :blue, :green, :orange, :purple]

# Helper function for R²
calc_r2(true_val, pred_val) = 1 - sum((true_val .- pred_val).^2) / sum((true_val .- mean(true_val)).^2)

# ============================================================
# 2. Parity plots (TEST SET)
# ============================================================
# Use 'size' instead of 'resolution' (resolution is deprecated in newer Makie)
fig2 = Figure(size = (900, 1800)) 

for i in 1:10
    row = Int(ceil(i / 2))
    col = i % 2 == 0 ? 2 : 1
    
    t = test_true[:, i]
    p = test_pred[:, i]
    r2_val = round(calc_r2(t, p), digits=3)
    
    # Use string interpolation directly inside the LaTeX string macro
    # The %$ syntax allows you to insert Julia variables into the L"..." string
    title_str = L"%$(labels[i]) \text{ (R² = %$r2_val)}"

    ax = Axis(fig2[row, col], 
              title = title_str, # Pass it directly to the axis
              xlabel = "True", 
              ylabel = "Predicted",
              xticklabelrotation = π/4,
              xticksize = 5,
              yticksize = 5)
    
    scatter!(ax, t, p, markersize = 4, color = (colors[i], 0.6), rasterize = 2)
    
    limits = [min(minimum(t), minimum(p)), max(maximum(t), maximum(p))]
    lines!(ax, limits, limits, color = :black, linestyle = :dash, linewidth = 1)
end

# FIX: Adjust the spacing between subplots
rowgap!(fig2.layout, 40)
colgap!(fig2.layout, 40)

display(fig2)
save("parity_plots.pdf", fig2)
