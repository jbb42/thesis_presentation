using PGFPlotsX
using NPZ
using PlotUtils
using Colors

# ============================================================
# Colorblind-Friendly Palette (Paul Tol's Bright)
# ============================================================
tol_colors = PlotUtils.palette(:tol_bright)

# Helper to safely format Julia colors for TikZ without the '#' hex crash
function to_tikz_rgb(c::Colorant)
    r = round(Int, red(c) * 255)
    g = round(Int, green(c) * 255)
    b = round(Int, blue(c) * 255)
    return "{rgb,255:red,$r;green,$g;blue,$b}"
end

# Extract 3 distinct accessible colors for our 3 models
model_colors = [
    to_tikz_rgb(tol_colors[1]), # Tol Bright Blue
    to_tikz_rgb(tol_colors[2]), # Tol Bright Red
    to_tikz_rgb(tol_colors[3])  # Tol Bright Green
]

# ============================================================
# Plotting (Single Pane)
# ============================================================
files = ["run_artifacts/results64.npz", "run_artifacts/results128.npz", "run_artifacts/results64ss.npz"]
labels = ["CNN1", "CNN2", "CNN3"]

# Initialize a single Axis
@pgf ax = Axis(
    {
        width = "0.7\\textwidth", 
        height = "6.7cm",
        ymode = "log",      
        xlabel = "Epoch",
        ylabel = "Loss",
        grid = "major",
        ymin = 1e-3, 
        ymax = 1.0,
	xmin = 1,      # Added strict left limit
        xmax = 103,    # Added strict right limit
        # Push the legend completely outside the plot area so it doesn't block the data
        "legend pos" = "north east", 
        "legend cell align" = "left",
	title = "Loss vs epochs"
    }
)

for i in 1:3
    data = npzread(files[i])
    loss = data["loss"]
    val_loss = data["val_loss"]
    
    # Train Loss (Solid line)
    push!(ax, @pgf Plot({"dashed", color=model_colors[i] }, Table(1:length(loss), loss)))
    push!(ax, LegendEntry("$(labels[i]) Train"))
    
    # Validation Loss (Dashed line)
    push!(ax, @pgf Plot({color=model_colors[i]}, Table(1:length(val_loss), val_loss)))
    push!(ax, LegendEntry("$(labels[i]) Val"))
end

# Save to file
outdir = "plots_tikz"
mkpath(outdir)
pgfsave(joinpath(outdir, "loss_comparison_single.pdf"), ax)
pgfsave(joinpath(outdir, "loss_comparison_single.tex"), ax, include_preamble=false)

println("Success. Single-pane TikZ files saved using accessible palette.")
