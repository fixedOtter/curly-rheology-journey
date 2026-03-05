% made by gunbar

matrix = readmatrix("./data_mod/gly_45hz.txt");
ball = matrix(:,1);
speaker = matrix(:,2);

t = 0:length(ball)-1;

figure
plot(t,speaker)
hold on
plot(t,ball)
xlim([25,200])
grid on
title('cool ball and speaker')