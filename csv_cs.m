%% Kurt Emmanuel Snell
%  snellk1@mcmaster.ca, 1kurtsnell@gmail.com
%  Created: 25 March 2025
%  Updated: 25 March 2025
%  Center and scale CSV data

% Reset workspace
clc, clear, close all;

% Get raw data
file = "pie_production.csv";
tabl = readtable(file);
headers = tabl.Properties.VariableNames;
csv = table2array(readtable(file, 'NumHeaderLines', 1));

% Center and scale
csv = (csv - mean(csv)) ./ std(csv);

% Save as csv
writecell([headers; num2cell(csv)], "pie_production_cs.csv")
fclose('all');
