% Rocco Fasula-Rieke
% Propagation of uncertainty

% k = spring constant
% w = natural resonance frequency
% m = mass of the sphere
% delta_k = uncertainty of spring constant
% delta_m = uncertainty of the mass
% delta_w = uncertainty of nat. res. freq.
% x = partial derivative of w in respect to k
% y = partial derivative of w in respect to m

k = 436.3;
m = 0.00420;
w = sqrt(k/m);

delta_k = 0.1;
delta_m = 0.01;

x = 1/(2*(sqrt(k/m)));
y = -1/(2*(m^2)*sqrt(k/m));

delta_w = sqrt((x*delta_k)^2 + (y*delta_m)^2);
fprintf('The Propagtion of Uncertainty for the Natural Resonance Frequency is %.3f', delta_w)