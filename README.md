# curly-rheology-journey
Light Matlab code library to analyze some oscillatory rheology measurements from a  custom-built mass-spring rheometer.

## who made this
Originally written by Abraham Preciado Rodriguez, with the help of Dr Angel Martinez.
later modified by gunnar.

## how to use this code
Clone the repository, either open the code in Matlab, or in VSCode with the Matlab extension.
Make sure to change the directory the data files are stored in.
This is done by modifying this line of getaccelratios.m
```matlab
% adds parent directory to path, since that's where the data is
addpath('./data_mod/');
```
In this case, the data files are in data_mod.

## how is the data expected
We're using an arduino on a baud rate of 115200, which corresponds to a sample rate of 1000.
The data files being written have a format of just two values per line, comma separated.
We also have a list of data files following a pretty easy to understand format from this point in the getaccelratios.m file:
```matlab
% lil logic to read each file
M = readmatrix(strcat(materials(i), '_', num2str(freq(j)), 'hz.txt'));
```
There's also a "materials" array and a "freq" array initialized before the for loop.
You could modify these arrays, and keep with the naming scheme to plot different fluids, moving at different frequencies.
I did it this way, because it seemed cleaner than writing lines for each frequency, and material. (You might also want to try different materials or frequencies than other groups.)