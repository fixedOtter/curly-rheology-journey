%% Standard
clear; clc; close all;
%% Variables
m = .0042; % Kilograms
k = 436.3; % Spring Constant
R = .0232; % Meters
n = [1.85e-5 8.9e-4 .954]; % Fluid Viscocity
rho = [0.590 1000 1261]'; % Fluid Density, Kg/m
omega = [5,10,15,30,45,60,75,90]; % Driving Freq
%% Math

%Setup
nat_res_freq = sqrt(k/m);
visc_pentr = sqrt((2*n)'./(rho*omega));
drag_coeff = (-6*pi*n.*R)'.*(1+R./visc_pentr);
Xi_omega = drag_coeff/(2*m*nat_res_freq);
damp_freq = nat_res_freq*sqrt(1-(Xi_omega).^2);
r_omega = omega/nat_res_freq;

%Acceleration Amplitude Ratio

AR = (sqrt(1-(r_omega).^2).^2+(2*Xi_omega.*(r_omega).^2).^2).^(-1);
%% Plotting
figure;
hold on
title('Amplitude Acceleration Ratio vs Driving Frequency')
plot(omega, AR(1,:), '--*r')
plot(omega, AR(2,:), '-ok')
plot(omega, AR(3,:), '-->m')
legend('Air','Water','Glycerin')
grid on; xlabel('Driving Frequency'); ylabel ('Amplitude Acceleration Ratio')
hold off
