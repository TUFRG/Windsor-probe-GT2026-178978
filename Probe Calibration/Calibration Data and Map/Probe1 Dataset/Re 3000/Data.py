import csv
import pandas as pd


input_file = "Probe1_RE3000_R1.txt"
output_file = "Probe1_RE3000_R1.xlsx"

# Read file
df = pd.read_csv(input_file, delimiter='\t', header=None)

# Keep columns A–G (0–6) and Q–T (16–19)
df = df.iloc[:, list(range(0, 7)) + list(range(16, 20))]

# Final column names (adjust if needed)
new_headers = [
    "P1 (Top)",
    "P2 (Left)",
    "P3 (Bottom)",
    "P4 (Right)",
    "P5 (Center)",
    "Pstatic (P)",
    "Ptot_ref (P0)",
    "Beta T",
    "Alpha T",
    "Density",
    "Flow Velocity"
]

df.columns = new_headers[:len(df.columns)]

# Save
df.to_excel(output_file, index=False)


print("Excel file created.")

input_file = "Probe1_RE3000_R2.txt"
output_file = "Probe1_RE3000_R2.xlsx"

# Read file
df = pd.read_csv(input_file, delimiter='\t', header=None)

# Keep columns A–G (0–6) and Q–T (16–19)
df = df.iloc[:, list(range(0, 7)) + list(range(16, 20))]

# Final column names (adjust if needed)
new_headers = [
    "P1 (Top)",
    "P2 (Left)",
    "P3 (Bottom)",
    "P4 (Right)",
    "P5 (Center)",
    "Pstatic (P)",
    "Ptot_ref (P0)",
    "Beta T",
    "Alpha T",
    "Density",
    "Flow Velocity"
]

df.columns = new_headers[:len(df.columns)]

# Save
df.to_excel(output_file, index=False)

print("Excel file created.")



input_file = "Probe1_RE3000_R3.txt"
output_file = "Probe1_RE3000_R3.xlsx"

# Read file
df = pd.read_csv(input_file, delimiter='\t', header=None)

# Keep columns A–G (0–6) and Q–T (16–19)
df = df.iloc[:, list(range(0, 7)) + list(range(16, 20))]

# Final column names (adjust if needed)
new_headers = [
    "P1 (Top)",
    "P2 (Left)",
    "P3 (Bottom)",
    "P4 (Right)",
    "P5 (Center)",
    "Pstatic (P)",
    "Ptot_ref (P0)",
    "Beta T",
    "Alpha T",
    "Density",
    "Flow Velocity"
]

df.columns = new_headers[:len(df.columns)]

# Save
df.to_excel(output_file, index=False)

print("Excel file created.")

