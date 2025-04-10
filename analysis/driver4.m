clear variables;
clc;
close all

%% Data load and cleanup
wdata = readmatrix("weather_features_processed.csv");
edata = readmatrix("energy_dataset_p.csv");
Ne = length(edata);
Nw = length(wdata);

fillmissing(wdata,"previous");
fillmissing(edata,"previous");
edata(isnan(edata)) = 0;

badata = readmatrix("barcelona_avg_sums.csv");
badata2 = readmatrix("barcelona_avg.csv");
bidata = readmatrix("bilbao_avg.csv");
mdata = readmatrix("madrid_avg_sums.csv");
mdata2 = readmatrix("madrid_avg.csv");
sdata = readmatrix("seville_avg.csv");
vdata = readmatrix("valencia_avg.csv");

%% raw data ANN
% weather = badata(:,4:9);
% fossil_fuels = badata(:,10);
% renewables = badata(:,11);
% load = badata(:,15);
% price = badata(:,17);
% 
% x = [weather fossil_fuels renewables];
% y = [load price];
% 
% net = feedforwardnet(1,"trainlm");
% net = train(net,x',y');
% 
% IW = net.IW{1};
% LW = net.LW{2};
% b1 = net.b{1};
% b2 = net.b{2};

%% PCA ANN
weather = sdata(:,4:9);
fossil_fuels = badata(:,10);
renewables = badata(:,11);
generations = badata2(:,10:23);
load = badata2(:,27);
price = badata2(:,29);

% x = [weather generations];
% y = [load price];
% 
% x = (x-mean(x))./std(x);
% 
% A = 20;
% G = 7;
% [T, P, R2] = nipalspca(x,A);
% Q2 = pcacrossval(x,A,G);
% 
% net = feedforwardnet(1,"trainlm");
% net = train(net,T',y');
% 
% IW = net.IW{1};
% LW = net.LW{2};
% b1 = net.b{1};
% b2 = net.b{2};

%% PCA stuff
x = [weather fossil_fuels renewables load price];
x = (x-mean(x,"omitmissing"))./std(x,"omitmissing");

A = 6;
G = 7;
[T, P, R2] = nipalspca(x,A);
Q2 = pcacrossval(x,A,G);

% p1re = [P(1,1:2);P(6:9,1:2);P(11:14,1:2)];
% p1fos = [P(2:5,1:2);P(10,1:2)];
% 
% hold on 
% grid on
% box on
% bar(["Coal","Gas","Hard Coal","Oil","Other"],p1fos,'r')
% bar(["Biomass","Hydro","Hydro River","Hydro Reservoir","Nuclear","Renewable Other","Solar","Waste","Wind"],p1re,'g')
% ylabel("Loading for Components 1 and 2")

score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),["Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Cloud Cover","Fossil Fuels","Renewables","Load","Price"])
loading_plot(P(:,1:2),[1,2],["Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Cloud Cover","Fossil Fuels","Renewables","Load","Price"])

figure()
grid on
box on
bar(["Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Cloud Cover","Fossil Fuels","Renewables","Load","Price"],P(:,1:2),'r')
ylabel("Loadings for Components 1 and 2")

% p1re = [P(1,1);P(6:9,1);P(11:14,1)];
% p2re = [P(1,2);P(6:9,2);P(11:14,2)];
% p1fos = [P(2:5,1);P(10,1)];
% p2fos = [P(2:5,2);P(10,2)];
% 
% t1 = T(:,1);
% t2 = T(:,2);
% 
% F = figure;
% hold on;
% plot(t1,t2,'ko')
% 
% box on;
% grid on;
% 
% xlabel('First Score t_1');
% ylabel('Second Score t_2');
% 
% 
% % Plot the T2 elipses
% N = length(t1);
% a = (std(t1))^2;
% b = (std(t2))^2;
% 
% % calculate T2 limits
% A = 2;
% Flim95 = finv(0.95,A,(N-A));
% Flim99 = finv(0.99,A,(N-A));
% T2lim95 = ((N-1)*(N+1)*A*Flim95)/(N*(N-A));
% T2lim99 = ((N-1)*(N+1)*A*Flim99)/(N*(N-A));
% 
% % (t1/s1)^2 + (t2/s2)^2 = T2lim
% % t1 is x and t2 is y
% % parametric eqn for an elipse (RHS needs to be 1): (x,y) = (a*cos(theta),b*sin(theta)) for 0 <= theta <= 2*pi
% 
% % eqn becomes t1^2/(T2lim*s1^2) + t2^2/(T2lim*s2^2) = 1
% 
% % calculate elipse distances
% theta = linspace(0,2*pi,50);
% x95 = sqrt(a*T2lim95)*cos(theta);
% y95 = sqrt(b*T2lim95)*sin(theta);
% x99 = sqrt(a*T2lim99)*cos(theta);
% y99 = sqrt(b*T2lim99)*sin(theta);
% 
% % plot elipse
% plot(x95, y95, '--r')
% hold on
% plot(x99, y99, '-r')
% 
% if max(x99) > max(abs(t1))
%     plot([-max(x99)*1.25 max(x99)*1.25], [0 0],'k-','LineWidth',2)
%     xlim = [-max(x99)*1.25 max(x99)*1.25];
% else
%     plot([-max(abs(t1))*1.25 max(abs(t1))*1.25], [0 0],'k-','LineWidth',2)
%     xlim = [-max(abs(t1))*1.25 max(abs(t1))*1.25];
% end
% 
% if max(y99) > max(abs(t2))
%     plot([0 0], [-max(y99)*1.25 max(y99)*1.25], 'k-','LineWidth',2)
%     ylim = [-max(y99)*1.25 max(y99)*1.25];
% else
%     plot([0 0], [-max(abs(t2))*1.25 max(abs(t2))*1.25], 'k-','LineWidth',2)
%     ylim = [-max(abs(t2))*1.25 max(abs(t2))*1.25];
% end
% 
% axis([xlim ylim])
% 
% % LOADINGS
% Datasetre = ["Biomass","Hydro","Hydro River","Hydro Reservoir","Nuclear","Renewable Other","Solar","Waste","Wind"];
% for i = 1:length(p1re)
%     plot(p1re(i)*xlim(2),p2re(i)*ylim(2),'gs','MarkerSize',10,'MarkerFaceColor','g');
%     text(p1re(i)*xlim(2)+0.5,p2re(i)*ylim(2)+0.5, Datasetre(i),'FontSize',12,'Color','green');
% end
% Datasetfos = ["Coal","Gas","Hard Coal","Oil","Other"];
% for i = 1:length(p1fos)
%     plot(p1fos(i)*xlim(2),p2fos(i)*ylim(2),'rs','MarkerSize',10,'MarkerFaceColor','r');
%     text(p1fos(i)*xlim(2)+0.5,p2fos(i)*ylim(2)+0.5, Datasetfos(i),'FontSize',12,'Color','red');
% end





