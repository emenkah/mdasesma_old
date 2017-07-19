
NB: Plotting is done by python

Trajectory files in data/ should have the format 'H20-pos-000.xyz'
The 3 characters before the dot indicates the temperature of caculation. Eg. H20-pos-050.xyz 

To run and plot data: make plot

## Table of plots


|  Eigen with DZVP |
Temp     |  Inversion Probability   |    Time series
:--------|:---------------:|:---------------:
   50    | <img src="plots_output/Eigen-050inv.png" width="350">|<img src="plots_output/Eigen-050-tim.png" width="350"> 
   100   | <img src="plots_output/Eigen-100inv.png" width="350">|<img src="plots_output/Eigen-100-tim.png" width="350"> 
   150   | <img src="plots_output/Eigen-150inv.png" width="350">|<img src="plots_output/Eigen-150-tim.png" width="350"> 
   300   | <img src="plots_output/Eigen-300inv.png" width="350">|<img src="plots_output/Eigen-300-tim.png" width="350"> 


|  Zundel Cation with DZVP |

	Temp |    Dot Product   | Inversion 1  | Inversion 2 
:--------|:----------------:|:------------:|:------------:
  50     | <img src="plots_output/Zundel-050dot.png" width="300">|<img src="plots_output/Zundel-050inv1.png" width="300">|<img src="plots_output/Zundel-050inv2.png" width="300">  
  100     | <img src="plots_output/Zundel-100dot.png" width="300">|<img src="plots_output/Zundel-100inv1.png" width="300">|<img src="plots_output/Zundel-100inv2.png" width="300">  
  150     | <img src="plots_output/Zundel-150dot.png" width="300">|<img src="plots_output/Zundel-150inv1.png" width="300">|<img src="plots_output/Zundel-150inv2.png" width="300">  
  300     | <img src="plots_output/Zundel-300dot.png" width="300">|<img src="plots_output/Zundel-300inv1.png" width="300">|<img src="plots_output/Zundel-300inv2.png" width="300">  


