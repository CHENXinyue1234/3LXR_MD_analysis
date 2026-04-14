\# 3LXR Molecular Dynamics and AlphaFold Analysis

\## Overview

This project investigates the effect of temperature on the structural stability of the 3LXR complex using molecular dynamics (MD) simulations.

Simulations were carried out at three temperatures:
\- 280 K
\- 300 K
\- 320 K

The results were analyzed in terms of structural stability, interface properties, and comparison with an AlphaFold-Multimer model.



\## Repository structure

\### 1_Molecular_Dynamics/

Contains all MD simulation files organized by temperature.

Each temperature folder includes:
\- `input_*`: GROMACS parameter files (.mdp)
\- `output_*`: analysis outputs (.xvg) and the final structure extracted at 18 ns (.pdb)
\- `script_*.txt`: command history used to run the simulation on the server

The `pdb/` folder contains:
\- `initial_pdb/`: cleaned starting structure for MD
\- `output_pdb/`: cleaned representative structures extracted at 18 ns, , used as input for downstream analyses (PROCHECK, PISA, PyMOL, DSSP)



\### 2_AlphaFold/

Contains files related to AlphaFold-Multimer prediction:
\- `3lxr_sequences.fasta`: input sequences
\- `AF_predict_3LXR.pdb`: predicted complex structure



\### 3_plots/

Contains all figures used in the Results section:

1. RMSD
2. RMSF
3. Radius of gyration
4. Interface area
5. Hydrogen bonds
6. Secondary structure
7. AlphaFold RMSD comparison
8. AlphaFold interface comparison



\## Methods summary

The MD simulations were performed using GROMACS 2024.3 with the CHARMM36 force field and TIP3P water model.

Workflow:

1. Structure preparation
2. Solvation and ion addition
3. Energy minimisation
4. NVT equilibration
5. NPT equilibration
6. 20 ns production MD simulation
7. Trajectory analysis (RMSD, RMSF, Rg)
8. Extraction of representative structures 


Additional analyses were performed as follows:

1. Structural quality was assessed using PROCHECK (https://www.ebi.ac.uk/thornton-srv/databases/pdbsum/Generate.html)

2. Interface properties (interface area and binding free energy) were calculated using PDBePISA (https://www.ebi.ac.uk/msd-srv/prot_int/)
3. Hydrogen bonds were analysed in PyMOL (v2.5.8)
4. Secondary structure was analysed using DSSP (https://pdb-redo.eu/dssp)

5. AlphaFold-Multimer prediction was performed using ColabFold based on the input sequences  `3lxr_sequences.fasta`(https://colab.research.google.com/github/sokrypton/ColabFold/blob/main/AlphaFold2.ipynb).

