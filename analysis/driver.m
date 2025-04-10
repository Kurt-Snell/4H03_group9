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

%% Weather PCA on all variables
% xw = wdata;
% 
% % center and scale
% xw = (xw-mean(xw))./std(xw);
% A = 6;
% [Tall, Pall, R2all] = nipalspca(xw,A);
% 
% % some plots
% loading_plot(Pall(:,1:3),[1,2,3],['Year','Month','Day',"Hour",'City',"Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Rain 1h",'Rain 3h',"Snow 3h","Cloud Cover"])
% score_loading_plot(Tall(:,1),Tall(:,2),Pall(:,1),Pall(:,2),['Year','Month','Day',"Hour",'City',"Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Rain 1h",'Rain 3h',"Snow 3h","Cloud Cover"])
% score_loading_plot(Tall(:,1),Tall(:,3),Pall(:,1),Pall(:,3),['Year','Month','Day',"Hour",'City',"Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Rain 1h",'Rain 3h',"Snow 3h","Cloud Cover"])
% score_loading_plot(Tall(:,2),Tall(:,3),Pall(:,2),Pall(:,3),['Year','Month','Day',"Hour",'City',"Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Rain 1h",'Rain 3h',"Snow 3h","Cloud Cover"])

%% Weather PCA on less variables
% xw = [wdata(:,2) wdata(:,4) wdata(:,6) wdata(:,8:11) wdata(:,14)];
% 
% % center and scale
% xw = (xw-mean(xw))./std(xw);
% A = 4;
% [T, P, R2less] = nipalspca(xw,A);
% 
% % some plots
% loading_plot(P(:,1:2),[1,2],["Month","Hour","Temperature","Humidity","Wind Speed","Wind Angle","Rain 1h","Cloud Cover"])
% score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),["Month","Hour","Temperature","Humidity","Wind Speed","Wind Angle","Rain 1h","Cloud Cover"])
% 

%% Weather PCA by city (all variables)
% xw = wdata;
% x_v = xw(xw(:,5) == 1,:); % valencia
% x_m = xw(xw(:,5) == 2,:); % madrid
% x_bi = xw(xw(:,5) == 3,:); % bilbao
% x_ba = xw(xw(:,5) == 4,:); % barcelona
% x_s = xw(xw(:,5) == 5,:); % seville
% 
% x_v(:,5) = [];
% x_m(:,5) = [];
% x_bi(:,5) = [];
% x_ba(:,5) = [];
% x_s(:,5) = [];
% 
% x_v = (x_v-mean(x_v))./std(x_v);
% x_m = (x_m-mean(x_m))./std(x_m);
% x_bi = (x_bi-mean(x_bi))./std(x_bi);
% x_ba = (x_ba-mean(x_ba))./std(x_ba);
% x_s = (x_s-mean(x_s))./std(x_s);
% 
% A = 4;
% [Tv, Pv, R2v] = nipalspca(x_v,A);
% [Tm, Pm, R2m] = nipalspca(x_m,A);
% [Tbi, Pbi, R2bi] = nipalspca(x_bi,A);
% [Tba, Pba, R2ba] = nipalspca(x_ba,A);
% [Ts, Ps, R2s] = nipalspca(x_s,A);
% 
% % plot city PCA results
% T = Tv; % change city in T and P in these lines
% P = Pv;
% loading_plot(P(:,1:2),[1,2],['Year','Month','Day',"Hour","Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Rain 1h",'Rain 3h',"Snow 3h","Cloud Cover"])
% score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),['Year','Month','Day',"Hour","Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Rain 1h",'Rain 3h',"Snow 3h","Cloud Cover"])


%% energy PCA (all variables)
% xe = [edata(:,1:18) edata(:,22) edata(:,24)]; % not using forecast data
% xe = (xe-mean(xe,"omitmissing"))./std(xe,"omitmissing");
% A = 20;
% G = 4;
% [Tepca, Pepca, R2] = nipalspca(xe,A);
% Q2 = pcacrossval(xe,A,G);
% T = Tepca;
% P = Pepca;
% score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),["Year","Month","Day","Hour","BiomassGen","FBCGen","FossilGasGen","FossilHardCoalGen","FossilOilGen","HydroPSCGen","HydroRoRGen","HydroWRGen","NuclearGen","OtherGen","RenewOtherGen","SolarGen","WasteGen","WindOnSGen","TotalLoad","Price"])
% loading_plot(P(:,1),1,["Year","Month","Day","Hour","BiomassGen","FBCGen","FossilGasGen","FossilHardCoalGen","FossilOilGen","HydroPSCGen","HydroRoRGen","HydroWRGen","NuclearGen","OtherGen","RenewOtherGen","SolarGen","WasteGen","WindOnSGen","TotalLoad","Price"])
% loading_plot(P(:,2),2,["Year","Month","Day","Hour","BiomassGen","FBCGen","FossilGasGen","FossilHardCoalGen","FossilOilGen","HydroPSCGen","HydroRoRGen","HydroWRGen","NuclearGen","OtherGen","RenewOtherGen","SolarGen","WasteGen","WindOnSGen","TotalLoad","Price"])
% 
% hold on
% plot(1:20,R2)
% plot(1:20,Q2)
% xlabel("Number of Components")
% ylabel("R^2/Q^2")
% legend("R^2","Q^2")

%% energy PCA (generation variables, no datetime)
% xe = [edata(:,5:18) edata(:,22) edata(:,24)]; % not using forecast data
% xe = (xe-mean(xe,"omitmissing"))./std(xe,"omitmissing");
% A = 20;
% G = 4;
% [Tepca, Pepca, R2] = nipalspca(xe,A);
% Q2 = pcacrossval(xe,A,G);
% T = Tepca;
% P = Pepca;
% score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),["BiomassGen","FBCGen","FossilGasGen","FossilHardCoalGen","FossilOilGen","HydroPSCGen","HydroRoRGen","HydroWRGen","NuclearGen","OtherGen","RenewOtherGen","SolarGen","WasteGen","WindOnSGen","TotalLoad","Price"])
% loading_plot(P(:,1),1,["BiomassGen","FBCGen","FossilGasGen","FossilHardCoalGen","FossilOilGen","HydroPSCGen","HydroRoRGen","HydroWRGen","NuclearGen","OtherGen","RenewOtherGen","SolarGen","WasteGen","WindOnSGen","TotalLoad","Price"]);
% loading_plot(P(:,2),2,["BiomassGen","FBCGen","FossilGasGen","FossilHardCoalGen","FossilOilGen","HydroPSCGen","HydroRoRGen","HydroWRGen","NuclearGen","OtherGen","RenewOtherGen","SolarGen","WasteGen","WindOnSGen","TotalLoad","Price"]);
% 
% figure()
% hold on
% plot(1:20,R2)
% plot(1:20,Q2)
% xlabel("Number of Components")
% ylabel("R^2/Q^2")
% legend("R2","Q2")

%% energy PLS (all data)
% xe = edata(:,1:18); % not using forecast data
% ye = [edata(:,22) edata(:,24)]; % totalLoadActual,priceActual
% xe = (xe-mean(xe,"omitmissing"))./std(xe,"omitmissing"); % omitmissing ignores NaN
% ye = (ye-mean(ye,"omitmissing"))./std(ye,"omitmissing");
% A = 10;
% G = 4;
% [T, U, W_star, W, C, P, R2] = nipalspls(xe,ye,A);
% Q2epls = plscrossval(xe,ye,A,G);

%% energy PLS (generation variables, no datetime)
% xe = edata(:,5:18); % generation variables
% ye = [edata(:,22) edata(:,24)]; % totalLoadActual,priceActual
% xe = (xe-mean(xe,"omitmissing"))./std(xe,"omitmissing"); % omitmissing ignores NaN
% ye = (ye-mean(ye,"omitmissing"))./std(ye,"omitmissing");
% A = 10;
% G = 4;
% [T, U, W_star, W, C, P, R2] = nipalspls(xe,ye,A);
% Q2epls = plscrossval(xe,ye,A,G);
% 
% % R2 plot
% plot(1:10,R2,'k-')
% xlabel("Number of Components")
% ylabel("R2")

%Hotellings T2
% N = Ne;
% A = 6;
% T2 = zeros(N,1);
% for n=1:N
%     Tn2 = 0;
%     for a=1:4
%         sa = std(T(:,a));
%         Tn2 = Tn2 + (T(n,a)/sa)^2;
%     end
%     T2(n) = Tn2;
% end
% 
% T95 = (N-1)*(N+1)*A/(N*(N-A))*finv(0.95,A,N-A);
% T99 = (N-1)*(N+1)*A/(N*(N-A))*finv(0.99,A,N-A);
% 
% figure()
% hold on
% plot(1:length(xe),T2)
% plot(1:N,T95*ones(N,1),'--r')
% plot(1:N,T99*ones(N,1),'-r')
% xlabel("Observation")
% ylabel("Hotelling's T^2")
% legend("T^2","95 CI","99 CI")
% xlim([0,length(xe)])

%% weather/energy PLS barcelona (datetime, weather, generation predict load and price)
% x = [badata(:,1:25)]; %datetime, weather, generation
% y = [badata(:,29) badata(:,31)]; % totalLoadActual,priceActual
% x(25083,:) = []; 
% y(25083,:) = []; % drop outlier
% x = (x-mean(x,"omitmissing"))./std(x,"omitmissing"); % omitmissing ignores NaN
% y = (y-mean(y,"omitmissing"))./std(y,"omitmissing");
% A = 10;
% G = 4;
% [T, U, W_star, W, C, P, R2] = nipalspls(x,y,A);
% Q2 = plscrossval(x,y,A,G);

%% weather/energy PCA barcelona (weather, energy load, energy price)
% x = [badata(:,5:11) badata(:,29) badata(:,31)];
% x = (x-mean(x,"omitmissing"))./std(x,"omitmissing");
% A = 11;
% G = 4;
% [T, P, R2] = nipalspca(x,A);
% Q2 = pcacrossval(x,A,G);
% score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),["Temperature","Pressure","Humidity","Wind Speed","Wind Angle","Rain 1h","Cloud Cover","Energy Load","Energy Price"])
% loading_plot(P(:,1),1,["Temperature","Pressure","Humidity","Wind Speed","Wind Angle","Rain 1h","Cloud Cover","Energy Load","Energy Price"]);
% loading_plot(P(:,2),2,["Temperature","Pressure","Humidity","Wind Speed","Wind Angle","Rain 1h","Cloud Cover","Energy Load","Energy Price"]);

%% weather/energy PLS barcelona (x=weather, y=energy load, energy price)
% x = badata(:,1:11);
% y = [badata(:,29) badata(:,31)];
% x = (x-mean(x,"omitmissing"))./std(x,"omitmissing");
% y = (y-mean(y,"omitmissing"))./std(y,"omitmissing");
% A = 10;
% G = 4;
% [T, U, W_star, W, C, P, R2] = nipalspls(x,y,A);
% Q2 = plscrossval(x,y,A,G);
% 
% %% SPE plot
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