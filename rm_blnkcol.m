%% Kurt Emmanuel Snell
%  snellk1@mcmaster.ca, 1kurtsnell@gmail.com
%  Created: 25 March 2025
%  Updated: 25 March 2025
%  Remove empty columns from csv dataset

% Reset workspace
clc, clear, close all;

% Get raw data
tabl = readtable("weather_features_Valencia.csv");
headers = tabl.Properties.VariableNames;
csv = table2array(readtable("weather_features_Valencia.csv", 'NumHeaderLines', 1));

% Remove columns of all zeros
c = 1;
while c < width(csv)
    if sum(csv(:,c), "omitmissing") == 0
        csv(:,c) = [];
        headers(c) = [];
    else
        c = c + 1;
    end
end

% Save as csv
writecell([headers; num2cell(csv)], "wfp_Valencia.csv")
fclose('all');



