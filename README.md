# Windsor-probe-GT2026-178978

This repository contains openly available design and calibration files for the Windsor Probe—an L-shaped adaptation of the Oxford Probe head. The probe is an additively manufactured stainless steel five-hole probe featuring a 3mm probe head diameter, developed by Aman Thomson during his Masters degree with the Turbomachinery and Unsteady Flows Research Group, at the University of Windsor.



Probe calibration was performed using LabVIEW, with post-processing and data analysis conducted in Python, Excel, and MATLAB.



## Citing

Please cite the following paper, which details the design and calibration of the probe:

Thomson, A., Fontanin, L., and Defoe, J., “The Windsor Probe: An Additively Manufactured L-Shaped 5-Hole Probe Based on Oxford Probe Heads,” Proceedings of the ASME Turbo Expo, GT2026-178978, Milan, Italy, June 15–19, 2026.



## Contents

The repository is organized into two main folders: one containing the probe design and manufacturing files and the other containing the calibration files.



### Design and Manufacturing

This section is organized into the following folders:



* **BOM (Bill of Materials)**

Contains a complete list of components used in the design, manufacturing, and calibration of the probe, including items required for the calibration facility.

* **Drawings**

&#x09;Includes detailed technical drawings for all probe components, as well as newly manufactured parts used to retrofit the existing calibration facility.

* **Probe Assembly (CAT Parts and STL)**

&#x09;Provides individual CAD files for each probe component and the full assembly. This folder also includes high-resolution microscopic images of the assembled probe for inspection and reference.

&#x09;CAT Parts were designed in CATIA V5 6R-2021 and require the same or later version to open 



### Probe Calibration



This section is organized into the following folders:



* **Calibration Data and Map**

&#x09;Contains the raw data collected during the calibration process across multiple runs, covering Reynolds numbers ranging from 1000 to 4300 (based on probe diameter) and provides visual calibration maps along with the datasets used to generate them. Maps are available for all Reynolds numbers at which calibration was performed..

* **Calibration Facility**

&#x09;Includes CAD and assembly files for the calibration facility used to test the probe. The facility was designed using CATIA V5–6R2021.

* **Calibration Program (5 Hole Probe Calibration 2025)**

&#x09;Contains the LabVIEW VI and associated subVIs used during calibration. Developed and executed in LabVIEW 2023.

* **Processing Scripts**

&#x09;Includes sample Excel files (with formulas for calibration coefficient calculations), the experimental data structure, and scripts used for: Averaging repeated measurements, generating calibration maps and estimating measurement uncertainty

&#x09;Data averaging was performed using Python, while calibration map generation and uncertainty analysis were carried out in MATLAB.

