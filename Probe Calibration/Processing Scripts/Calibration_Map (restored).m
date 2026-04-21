%% MeanPlots_New.m
% Author: Aman Thomson

clear; clc; close all;

%% Load Excel data
file_path = 'Calibration Data.xlsx'; % Ensure the file is in the same folder
data = readtable(file_path);

C_alpha = data.("CAlpha");
C_beta  = data.("CBeta");
alpha   = data.("Alpha");
beta    = data.("Beta");
Cp      = data.("Cp");
Cp0     = data.("CP0");

%% Create interpolation grid
xq = linspace(min(C_beta), max(C_beta), 1000);
yq = linspace(min(C_alpha), max(C_alpha), 1000);
[grid_x, grid_y] = meshgrid(xq, yq);

%% Build interpolants 
F_alpha = scatteredInterpolant(C_beta, C_alpha, alpha, 'natural');
F_beta  = scatteredInterpolant(C_beta, C_alpha, beta, 'natural');
F_cp    = scatteredInterpolant(C_beta, C_alpha, Cp, 'natural');
F_cp0   = scatteredInterpolant(C_beta, C_alpha, Cp0, 'natural');


%% Interpolate onto grid
zi_alpha = F_alpha(grid_x, grid_y);
zi_beta  = F_beta(grid_x, grid_y);
zi_cp    = F_cp(grid_x, grid_y);
zi_cp0   = F_cp0(grid_x, grid_y);

%% Define contour levels
alpha_levels = -50:5:50;
beta_levels  = -50:5:50;
cp_levels    = linspace(min(Cp), max(Cp),20);
cp0_levels   = linspace(min(Cp0), max(Cp0),20);

% %% Plot and save contour maps
function plot_contour(grid_x, grid_y, data, levels, title_str, filename)
    figure('Position', [100, 100, 800, 600]);
    [C, h] = contour(grid_x, grid_y, data, levels, 'k', 'LineWidth', 1);
    clabel(C, h, 'FontSize', 8, 'Color', 'k');
    title(title_str);
    xlabel('C Beta');
    ylabel('C Alpha');
    grid on;
    axis equal tight;
    saveas(gcf, filename);
    end

plot_contour(grid_x, grid_y, zi_alpha, alpha_levels, ...
    'Alpha Contours (5° steps)', 'alpha_black_contours.png');
plot_contour(grid_x, grid_y, zi_beta, beta_levels, ...
    'Beta Contours (5° steps from 0°)', 'beta_black_contours.png');
plot_contour(grid_x, grid_y, zi_cp, cp_levels, ...
    'Cp Contours', 'cp_black_contours.png');
plot_contour(grid_x, grid_y, zi_cp0, cp0_levels, ...
    'Cp0 Contours', 'cp0_black_contours.png');

%% Combined alpha-beta overlay
figure('Position', [100, 100, 800, 600]);
[C1, h1] = contour(grid_x, grid_y, zi_alpha, alpha_levels, 'r', 'LineWidth', 1);
clabel(C1, h1, 'FontSize', 8, 'Color', 'r');
hold on;
[C2, h2] = contour(grid_x, grid_y, zi_beta, beta_levels, 'b', 'LineWidth', 1);
clabel(C2, h2, 'FontSize', 8, 'Color', 'b');
title('Combined Alpha (Red) & Beta (Blue) Contours');
xlabel('C Beta');
ylabel('C Alpha');
grid on;
axis equal tight;
saveas(gcf, 'combined_alpha_beta_5deg_beta0_contours.png')
disp('All plots saved successfully.');

% Export interpolated maps to Excel
% Interpolated = struct();
% 
% Interpolated.Alpha = table(grid_x(:), grid_y(:), zi_alpha(:), ...
%     'VariableNames', {'C_Beta', 'C_Alpha', 'Alpha'});
% Interpolated.Beta  = table(grid_x(:), grid_y(:), zi_beta(:), ...
%     'VariableNames', {'C_Beta', 'C_Alpha', 'Beta'});
% Interpolated.Cp    = table(grid_x(:), grid_y(:), zi_cp(:), ...
%     'VariableNames', {'C_Beta', 'C_Alpha', 'Cp'});
% Interpolated.Cp0   = table(grid_x(:), grid_y(:), zi_cp0(:), ...
%     'VariableNames', {'C_Beta', 'C_Alpha', 'Cp0'});
% 
% output_file = 'Interpolated_Calibration_Maps.xlsx';
% writetable(Interpolated.Alpha, output_file, 'Sheet', 'Alpha');
% writetable(Interpolated.Beta,  output_file, 'Sheet', 'Beta');
% writetable(Interpolated.Cp,    output_file, 'Sheet', 'Cp');
% writetable(Interpolated.Cp0,   output_file, 'Sheet', 'Cp0');
% 
% disp('Interpolated maps exported to separate Excel sheets.');
% %

function [alpha_val, beta_val, Cp_val, Cp0_val] = getAnglesFromC(Calpha_input, Cbeta_input, F_alpha, F_beta, F_Cp, F_Cp0)
% getAnglesFromC: Returns alpha, beta, Cp, and Cp0 values for given C_alpha and C_beta
%
% Inputs:
%   Calpha_input : scalar or vector of C_alpha values
%   Cbeta_input  : scalar or vector of C_beta values
%   F_alpha      : scatteredInterpolant for alpha (from MeanPlots_New)
%   F_beta       : scatteredInterpolant for beta
%   F_Cp         : scatteredInterpolant for Cp
%   F_Cp0        : scatteredInterpolant for Cp0
%
% Outputs:
%   alpha_val    : interpolated alpha angle(s)
%   beta_val     : interpolated beta angle(s)
%   Cp_val       : interpolated Cp value(s)
%   Cp0_val      : interpolated Cp0 value(s)

    % Input size check
    if ~isequal(size(Calpha_input), size(Cbeta_input))
        error('Calpha_input and Cbeta_input must be the same size');
    end

    % Query the interpolants
    alpha_val = F_alpha(Cbeta_input, Calpha_input);
    beta_val  = F_beta(Cbeta_input, Calpha_input);
    Cp_val    = F_Cp(Cbeta_input, Calpha_input);
    Cp0_val   = F_Cp0(Cbeta_input, Calpha_input);
end

% %% Load your input Excel file
inputFile = 'Inputs.xlsx';   % <-- change as needed
data = readtable(inputFile);

% Assume columns are named exactly like this
Calpha_list = data.C_alpha;
Cbeta_list  = data.C_beta;

%% Compute alpha, beta, Cp, and Cp0 values for all rows
[alpha_vals, beta_vals, Cp_vals, Cp0_vals] = getAnglesFromC(Calpha_list, Cbeta_list, F_alpha, F_beta, F_cp, F_cp0);

%% Make a table for output
outputTable = table(alpha_vals, beta_vals, Calpha_list, Cbeta_list,Cp_vals, Cp0_vals, ...
    'VariableNames', {'alpha_deg','beta_deg','C_alpha','C_beta','Cp','Cp0'});

%% Write to a new Excel file
outputFile = 'Output_Angles1000.xlsx';   % <-- change if you want
writetable(outputTable, outputFile);

fprintf('Done! Output written to %s\n', outputFile);
