import pandas as pd
import numpy as np
import corner
import matplotlib.pyplot as plt

# ==========================================
# Force Matplotlib to use LaTeX styling
# ==========================================
plt.rcParams.update({
    "text.usetex": True,                   # Use your system's LaTeX engine
    "font.family": "serif",                # Match LaTeX serif text
    "font.serif": ["Computer Modern"],     # Use the classic LaTeX font
    "axes.labelsize": 12,
    "font.size": 12,
    "legend.fontsize": 12,
    "xtick.labelsize": 10,
    "ytick.labelsize": 10,
})

# Sizing in inches for 5 parameters. 7x7 is reasonable.
my_fig = plt.figure(figsize=(5, 5))

# 1. Load the aggregated data (assumed to be in the same directory)
print("Loading data...")
try:
    df = pd.read_csv('aggregated_simulation_results.csv')
except FileNotFoundError:
    print("Error: 'aggregated_simulation_results.csv' not found.")
    # Exiting or using mock data here for testing. Assuming the user has the file.
    import sys
    sys.exit(1)

# 2. Calculate the "Backreaction Shifts" (Delta = Simulated - Expected)
print("Calculating shifts...")
df['Delta_Om'] = df['Simulated_Om_mean'] - df['Expected_Om']
df['Delta_OL'] = df['Simulated_OL_mean'] - df['Expected_OL']
df['Delta_Ok'] = df['Simulated_Ok_mean'] - df['Expected_Ok']
df['Delta_OQ'] = df['Simulated_OQ_mean'] - df['Expected_OQ']  # Expected_OQ is 0
df['Delta_h']  = df['Simulated_H_mean']*306.5926758/1.0227e-1 - df['Expected_h']

# Extract just the shift columns for the corner plot
shifts_df = df[['Delta_Om', 'Delta_OL', 'Delta_Ok', 'Delta_OQ', 'Delta_h']]

# 3. Create the Corner Plot
print("Generating corner plot...")

# Labels using raw strings for LaTeX math
labels = [
    r"$\Delta\Omega_m$", 
    r"$\Delta\Omega_\Lambda$", 
    r"$\Delta\Omega_k$", 
    r"$\Delta\Omega_Q$", 
    r"$\Delta h$"
]

# FIX ISSUE 2: Increase label padding to prevent y-label overlap using label_kwargs
label_kwargs = {"labelpad": 25} # Adds spacing between labels and tickmarks

fig = corner.corner(
    shifts_df, 
    labels=labels,
    label_kwargs=label_kwargs, # Apply the padding
    show_titles=True,
    title_kwargs={"fontsize": 12},
    quantiles=[0.16, 0.5, 0.84],
    plot_contours=True,
    plot_density=True,
    fill_contours=True,
    color='midnightblue',
    fig=my_fig
)
fig.subplots_adjust(left=-0.50, bottom=-0.50)
# FIX ISSUE 1: Remove redundant x labels below, as titles are active.
# Get the dimensionality (5)
ndim = shifts_df.shape[1]
# corner creates an ndim x ndim grid, reshape fig.axes for easy indexing
axes = np.array(fig.axes).reshape((ndim, ndim))

# Iterate through the bottom row of axes
for j in range(ndim):
    ax = axes[-1, j]
    ax.set_xlabel('') # Clear the x-label from the axis, relying on titles

# Add a main title to the figure
# Adjusted y position and used figure-relative positioning for consistency
fig.suptitle(
    r"Simsilun deviations from FLRW values",
    fontsize=16,
    x=0.35,
    y=1.02
)

# Save the plot. Using tight bbox ensures the suptitle and 
# padded labels are included in the PDF.
output_filename = "backreaction_corner_plot_64.pdf"
fig.savefig(output_filename, bbox_inches='tight')

print(f"Done! Plot saved as {output_filename}")
