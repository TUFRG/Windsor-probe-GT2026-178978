import pandas as pd

file1 = "Probe1_RE3000_R1avg.xlsx"
file2 = "Probe1_RE3000_R2avg.xlsx"
file3 = "Probe1_RE3000_R3avg.xlsx"

output_file = "Mean data.xlsx"

df1 = pd.read_excel(file1)
df2 = pd.read_excel(file2)
df3 = pd.read_excel(file3)

# Check same shape
if df1.shape != df2.shape or df1.shape != df3.shape:
    raise ValueError("All files must have the same dimensions")

# Compute mean (numeric-safe version recommended)
mean_df = (df1 + df2 + df3) / 3

# Write all sheets into one Excel file
with pd.ExcelWriter(output_file, engine="openpyxl") as writer:
    mean_df.to_excel(writer, sheet_name="Mean", index=False)
    df1.to_excel(writer, sheet_name="R1", index=False)
    df2.to_excel(writer, sheet_name="R2", index=False)
    df3.to_excel(writer, sheet_name="R3", index=False)

print("Mean data file created with all sheets.")