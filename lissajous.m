% made by gunnar on march 21 2026

%
data = readmatrix("../water_45hz.txt");
top = data(:,1);
bot = data(:,2);

figure
plot(top,bot)
grid on
title('Lissajous Figure for Water at 45 Hz')
xlabel('Speaker Accelerameter')
ylabel('Mass Acceleratometer')