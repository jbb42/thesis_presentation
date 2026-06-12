# First, ensure you have the required packages:
# using Pkg; Pkg.add(["CSV", "DataFrames", "Plots", "StatsPlots", "PGFPlotsX"])

using CSV
using DataFrames
using Plots
using StatsPlots

# Activate the PGFPlotsX backend for TikZ generation
pgfplotsx()

# 1. Load the aggregated data
println("Loading data...")
df = CSV.read("aggregated_simulation_results.csv", DataFrame)

# 2. Calculate the "Backreaction Shifts"
println("Calculating shifts...")
df.Delta_Om = df.Simulated_Om_mean .- df.Expected_Om
df.Delta_OL = df.Simulated_OL_mean .- df.Expected_OL
df.Delta_Ok = df.Simulated_Ok_mean .- df.Expected_Ok
df.Delta_OQ = df.Simulated_OQ_mean .- df.Expected_OQ  # Expected_OQ is 0
df.Delta_h  = (df.Simulated_H_mean .* 306.5926758 ./ 1.0227e-1) .- df.Expected_h

# Extract the columns into a Matrix (StatsPlots requires a matrix, not a NamedTuple)
data_matrix = Matrix(df[!, [:Delta_Om, :Delta_OL, :Delta_Ok, :Delta_OQ, :Delta_h]])

# Define LaTeX labels as a 1x5 Matrix of raw strings (standard for Plots.jl labels)
# We use raw"..." so we don't have to double-escape every backslash
lbls = [raw"$\Delta\Omega_m$" raw"$\Delta\Omega_\Lambda$" raw"$\Delta\Omega_k$" raw"$\Delta\Omega_Q$" raw"$\Delta h$"]

# 3. Create the Corner Plot
println("Generating corner plot...")

# StatsPlots provides a built-in cornerplot recipe
p = cornerplot(
    data_matrix,
    label = lbls,
    compact = true,
    plot_title = "Simsilun deviations from FLRW values",
    plot_titlefontsize = 12,
    size = (1200, 1200)
)

# Save the plot. Because we are using the pgfplotsx backend, 
# saving as .tikz or .tex generates native LaTeX/PGF code.
output_filename = "backreaction_corner_plot.tikz"
savefig(p, output_filename)

output_filename = "backreaction_corner_plot.pdf"
savefig(p, output_filename)

println("Done! Plot saved as $output_filename")
