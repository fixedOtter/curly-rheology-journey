% made by gunbar on march 4, 2026

% adds parent directory to path, since that's where the data is
addpath('./data_mod/');

% list of materials
materials = ["air", "gly", "water"];

% list of frequencies
freq = zeros(1,8);
freq(1:3) = 5:5:15;
freq(4:8) = 30:15:90;

% init matrix for accelerometer ratios
ratio_mat = zeros(length(materials), length(freq));

% do whats done below
for i = 1:length(materials)
    for j = 1:length(freq)
        % lil logic to read each file
        M = readmatrix(strcat(materials(i), '_', num2str(freq(j)), 'hz.txt'));

        % splitting the data from the file
        top=M(:,1);
        bot=M(:,2);

        % pass the signals to the FFT function
        [AT,AB,ratio]=two_fft_gungun(top,bot,freq(j));

        % store the ratio in the matrix
        ratio_mat(i,j) = ratio;
    end
end

% fprintf(ratio_mat);
% fprintf(ratio_mat,'%f\t',T');
fprintf([repmat('%f\t', 1, size(ratio_mat, 2)) '\n'], ratio_mat');

% plot
figure
hold on
plot(freq,ratio_mat(1,:), 'b-o')
plot(freq,ratio_mat(2,:), 'g-o')
plot(freq,ratio_mat(3,:), 'r-o')

% labels on the plots
xlabel('Frequency in Hz','fontsize', 16)
ylabel('Acceleration Ratio Between Driven and Response','fontsize', 16)
legend('Air','Glycerin','Water')
title('Acceleration Ratio vs Frequency for Different Materials','fontsize',18)