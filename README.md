# EE514_Group7
Tutorial: [![GENETIC ALGORITHM TUTORIAL](https://www.mathworks.com/responsive_image/165/120/0/0/0/cache/matlabcentral/mlc-downloads/downloads/submissions/35623/versions/5/screenshot.jpg)](https://www.youtube.com/watch?v=dQw4w9WgXcQ)

##To Run: 
Open TestGA.m and run the script. It should work natively, but may get stuck writing the function the first time. To Fix, pause the simulation wait a second and continue it. It should just work after that. 

Lines 5-17 of TestGA should hold all the changeable variables accessible to the user.

Set a custom simulink model by changing line 5 to be a string of the name of the model excluding the extension.

Set t to be the total simulation time.

Set simFunct to be a string containing the name of what you want the generated file to be excluding the extension.

Set costFunction to be the name of the cost function you want to use without extension.

Generations is the total number of generations to be simulated.

Population is the population to be simulated in each generation.

initDepth is the initial depth of the population before evolving

opts is an array containing strings of variable names and conditions after each string. It is recommended to leabe it how it is, albeit MaxSize sets the maximum depth of the generated trees. Crossover number sets the number of trees generated via crossover each generation. Elitism number sets the number of trees that will be carried over due to elitism. Replication number is how many trees will randomly be carried over. The remaining trees not generated via elitism, replication, and crossover will be generated via mutation.

##Trouble shooting: 

If simulink model is not found: Add the folder simLink folder to your path in MATLAB by right clicking on it. 

If simFunct is not recognized: Create a folder called genFiles and add it to your path in MATLAB.

##FILES
The LQR folder holds our LQR simulation function.

The testGA file is the wrapper for our genetic algorithm.

The simLink folder holds our simulink models.

The genFiles folder is where the algorithm puts the generated function.

The bestTest.mat holds the conditions for our best generated function.

Other files are helper or testing functions.