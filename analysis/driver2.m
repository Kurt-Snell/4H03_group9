clear variables;
clc;
close all;

%% Data load and cleanup
wdata = readmatrix("weather_features_processed.csv");
edata = readmatrix("energy_dataset_p.csv");
Ne = length(edata);
Nw = length(wdata);

fillmissing(wdata,"previous");
fillmissing(edata,"previous");
edata(isnan(edata)) = 0;

badata = readmatrix("barcelona.csv");
bidata = readmatrix("bilbao.csv");
mdata = readmatrix("madrid.csv");
sdata = readmatrix("seville.csv");
vdata = readmatrix("valencia.csv");

fillmissing(badata,"previous");
badata(isnan(badata)) = 0;

%% Wind energy production
% x = vdata(:,12:25); 
% y = vdata(:,31); 
% 
% x = (x-mean(x,"omitmissing"))./std(x,"omitmissing");
% y = (y-mean(y,"omitmissing"))./std(y,"omitmissing");
% 
% A = 6;
% G = 4;
% [T, P, R2] = nipalspca(x,A);
% Q2 = pcacrossval(x,A,G);
% 
% % some plots
% loading_plot(P(:,1:2),[1,2],["Biomass","Coal","Gas","Hard Coal","Oil","Hydro","Hydro River","Hydro Reservoir","Nuclear","Other","Renewable Other","Solar","Waste","Wind"])
% score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),["Biomass","Coal","Gas","Hard Coal","Oil","Hydro","Hydro River","Hydro Reservoir","Nuclear","Other","Renewable Other","Solar","Waste","Wind"])

% x = badata(:,12:25);
% y = badata(:,31); 
% 
% x = (x-mean(x,"omitmissing"))./std(x,"omitmissing");
% y = (y-mean(y,"omitmissing"))./std(y,"omitmissing");
% 
% A = 5;
% G = 4;
% [T, U, W_star, W, C, P, R2] = nipalspls(x,y,A);
% Q2 = plscrossval(x,y,A,G);

% % scatter plot
% figure()
% hold on
% plot(W_star(:,1),W_star(:,2),'ko')
% plot(C(:,1),C(:,2),'rs')
% xlabel('w*_{1}');
% ylabel('w*_{2}');
% legend("W*","C")
% 
% % loadings plot
% figure()
% bar(["Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Rain 1h","Cloud Cover"],[W_star(:,1)';W_star(:,2)'])
% legend("Component 1","Component 2")
% ylabel("Loadings for Components 1 and 2")
% grid on
% 
% % SPE plot
% y_hat = T*C';
% E = y - y_hat;
% N = length(y);
% SPE = zeros(N,1);
% for i=1:N
%     SPE(i) = E(i,:)*E(i,:)';
% end
% 
% m = mean(SPE);
% v = var(SPE);
% dof = 2*m^2/v;
% chival95 = v/(2*m)*chi2inv(0.95,dof);
% chival99 = v/(2*m)*chi2inv(0.99,dof);
% 
% figure()
% hold on
% plot(1:N,SPE)
% plot(1:N,chival95*ones(N,1),'--r')
% plot(1:N,chival99*ones(N,1),'-r')
% legend("SPE","95 CI","99 CI")
% xlabel("Observation")
% ylabel("Standard Prediction Error")
% xlim([0,length(y)])