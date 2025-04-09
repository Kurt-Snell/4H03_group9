%% Kurt Emmanuel Snell
%  snellk1@mcmaster.ca, 1kurtsnell@gmail.com
%  Created: 25 March 2025
%  Updated: 9 April 2025
%  Center and scale CSV data

% Reset workspace
clc, clear, close all;

% Comma-separated value file name
file = "test.csv";

% Get raw data and remove unusable data
tabl = readtable(file);
for vt = ["string", "cell", "char"]
    cols = tabl.Properties.VariableNames(vartype(vt));
    tabl = removevars(tabl, cols);
end

% Split file into headers and data
headers = tabl.Properties.VariableNames;
data = table2array(tabl);

% Center and scale
data = (data - mean(data)) ./ std(data);

% Save as csv
be = split(file, ".");
base = be(1);
ext  = be(2);
writecell([headers; num2cell(data)], sprintf("%s_cs.%s", base, ext));
fclose('all');
