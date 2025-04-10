%% Kurt Emmanuel Snell
%  22 March 2025
%  CHEMENG 4H03
%  Assignment 4
%  Problem 1

%% Reset workspace
clc, clear, close all;



%% Load in data and divide into cell cultures and sensitivity results

% Get raw data
csv = "energy_dataset.xlsx";
all  = readtable(csv, 'NumHeaderLines', 1);

% Get last two columns for predicted and actual price
pre = table2array(all(:, 'Var26'));
act = table2array(all(:, 'Var27'));



%% Calculate R2
R2 = 1 - ( sum( (act - pre).^2 ) / sum( (act - mean(act)).^2 ) );



