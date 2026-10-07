import pandas as pd
import os

# File name (must be in the same folder as the script)
input_filename = "P3_ReMax_R1.xlsx"
output_filename = "P3_ReMax_R1Avg.xlsx"

# Load the Excel file
df = pd.read_excel(input_filename)

# Set the group size
group_size = 4

# Compute the average for each group of 5 rows
averaged_df = df.groupby(df.index // group_size).mean()

# Save to a new Excel file
with pd.ExcelWriter(output_filename, engine='openpyxl') as writer:
    df.to_excel(writer, index=False, sheet_name='Original Data')
    averaged_df.to_excel(writer, index=False, sheet_name='Averaged Data')

print(f"Averaged file saved as: {output_filename}")

# File name (must be in the same folder as the script)
input_filename = "P3_ReMax_R2.xlsx"
output_filename = "P3_ReMax_R2Avg.xlsx"

# Load the Excel file
df = pd.read_excel(input_filename)

# Set the group size
group_size = 4

# Compute the average for each group of 5 rows
averaged_df = df.groupby(df.index // group_size).mean()

# Save to a new Excel file
with pd.ExcelWriter(output_filename, engine='openpyxl') as writer:
    df.to_excel(writer, index=False, sheet_name='Original Data')
    averaged_df.to_excel(writer, index=False, sheet_name='Averaged Data')

print(f"Averaged file saved as: {output_filename}")
# File name (must be in the same folder as the script)
input_filename = "P3_ReMax_R3.xlsx"
output_filename = "P3_ReMax_R3Avg.xlsx"

# Load the Excel file
df = pd.read_excel(input_filename)

# Set the group size
group_size = 4

# Compute the average for each group of 5 rows
averaged_df = df.groupby(df.index // group_size).mean()

# Save to a new Excel file
with pd.ExcelWriter(output_filename, engine='openpyxl') as writer:
    df.to_excel(writer, index=False, sheet_name='Original Data')
    averaged_df.to_excel(writer, index=False, sheet_name='Averaged Data')

print(f"Averaged file saved as: {output_filename}")
