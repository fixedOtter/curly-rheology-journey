%% 333W Rheology: Reliable Viscosity Fitting
clear; clc; close all;

%% 1. Constants and Measured Data
m = 0.0042; % kg
k = 436.3;  % N/m
R = 0.0232; % m
rho_vals = [1.225, 1000, 1261]; % Air, Water, Glycerin (kg/m^3)
omega_hz = [5, 10, 15, 30, 45, 60, 75, 90];
omega_rad = omega_hz * 2 * pi; % Convert to rad/s for physics

% Your Measured Data (Extracted from viscomath.m)
Acc_Ratio = [0.3163, 1.0422, 1.0545, 1.5798, 2.6763, 2.3659, 1.5741, 1.1516;
             0.4942, 1.0722, 1.0703, 1.7993, 2.9930, 1.4099, 0.5677, 0.1824;
             1.1311, 1.0581, 1.0565, 1.5372, 3.2063, 2.4812, 0.9146, 0.7464];

Amp_Ratio = [0.3163, 1.0422, 1.0545, 1.5798, 2.6763, 2.3659, 1.5741, 1.1516;
             1.1311, 1.0581, 1.0565, 1.5372, 3.2063, 2.4812, 0.9146, 0.7464;
             0.4942, 1.0722, 1.0703, 1.7993, 2.9930, 1.4099, 0.5677, 0.1824];

AAR_Measured = abs(Acc_Ratio ./ Amp_Ratio);

%% 2. Fitting Loop (Grid Search)
fluids = {'Air', 'Water', 'Glycerin'};
fitted_n = zeros(1, 3);
colors = {'r', 'k', 'b'};

figure('Position', [100, 100, 800, 600]);
hold on;

for f = 1:3
    rho = rho_vals(f);
    target = AAR_Measured(f, :);
    
    % Define a wide search range for viscosity (Pa.s)
    % Air (~1e-5), Water (~1e-3), Glycerin (~1.0)
    n_search = logspace(-6, 1, 1000); 
    SSE = zeros(size(n_search));
    
    for i = 1:length(n_search)
        n = n_search(i);
        
        % A. Viscous Penetration Depth
        delta = sqrt((2 * n) ./ (rho * omega_rad));
        
        % B. Added Mass Effect (Important for Glycerin!)
        m_added = (2/3) * pi * rho * (R^3) * (1 + (9 * delta) / (2 * R));
        m_eff = m + m_added;
        
        % C. Damping and Frequency Ratios
        wn_eff = sqrt(k ./ m_eff);
        r = omega_rad ./ wn_eff;
        c = 6 * pi * n * R * (1 + R ./ delta);
        xi = c ./ (2 * m_eff .* wn_eff);
        
        % D. Model Formula (from Line 252 of Procedure)
        % AR = 1 / sqrt( (1-r^2)^2 + (2*xi*r^2)^2 )
        AR_model = 1 ./ sqrt((1 - r.^2).^2 + (2 * xi .* r.^2).^2);
        
        SSE(i) = sum((AR_model - target).^2);
    end
    
    % Find best n
    [~, best_idx] = min(SSE);
    fitted_n(f) = n_search(best_idx);
    
    % Generate curve for plotting
    n_final = fitted_n(f);
    delta_f = sqrt((2*n_final)./(rho*omega_rad));
    m_eff_f = m + (2/3)*pi*rho*(R^3)*(1+(9*delta_f)/(2*R));
    wn_f = sqrt(k./m_eff_f);
    r_f = omega_rad./wn_f;
    xi_f = (6*pi*n_final*R*(1+R./delta_f))./(2*m_eff_f.*wn_f);
    AR_fit = 1 ./ sqrt((1 - r_f.^2).^2 + (2 * xi_f .* r_f.^2).^2);
    
    % Plotting
    plot(omega_hz, target, [colors{f} 'o'], 'MarkerFaceColor', colors{f}, 'DisplayName', [fluids{f} ' Measured']);
    plot(omega_hz, AR_fit, colors{f}, 'LineWidth', 1.5, 'DisplayName', sprintf('%s Fit (n=%.4f)', fluids{f}, n_final));
end

title('Viscosity Fitting: Base Excitation Model (with Added Mass)');
xlabel('Driving Frequency (Hz)'); ylabel('Acceleration Amplitude Ratio');
legend('Location', 'best'); grid on;
hold off;

fprintf('--- Fitted Viscosity Results ---\n');
fprintf('Air:      %.6f Pa.s\n', fitted_n(1));
fprintf('Water:    %.6f Pa.s\n', fitted_n(2));
fprintf('Glycerin: %.6f Pa.s\n', fitted_n(3));