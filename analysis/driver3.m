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

badata = readmatrix("barcelona_avg.csv");
bidata = readmatrix("bilbao_avg.csv");
mdata = readmatrix("madrid_avg.csv");
sdata = readmatrix("seville_avg.csv");
vdata = readmatrix("valencia_avg.csv");

fillmissing(badata,"previous");
badata(isnan(badata)) = 0;


%% Trying stuff
% x = bidata(:,4:9); 
% y = bidata(:,23); 
% 
% x = (x-mean(x,"omitmissing"))./std(x,"omitmissing");
% y = (y-mean(y,"omitmissing"))./std(y,"omitmissing");
% 
% A = 6;
% G = 4;
% [T, P, R2] = nipalspca(x,A);
% Q2 = pcacrossval(x,A,G);

% some plots
% loading_plot(P(:,1:2),[1,2],["Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Cloud Cover"])
% score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),["Temperature",'Pressure',"Humidity","Wind Speed","Wind Angle","Cloud Cover"])

% loading_plot(P(:,1:2),[1,2],["Biomass","Coal","Gas","Hard Coal","Oil","Hydro","Hydro River","Hydro Reservoir","Nuclear","Other","Renewable Other","Solar","Waste","Wind"])
% score_loading_plot(T(:,1),T(:,2),P(:,1),P(:,2),["Biomass","Coal","Gas","Hard Coal","Oil","Hydro","Hydro River","Hydro Reservoir","Nuclear","Other","Renewable Other","Solar","Waste","Wind"])
% % 
% [T, U, W_star, W, C, P, R2] = nipalspls(x,y,A);
% Q2 = plscrossval(x,y,A,G);

x = [badata(:,4:9);bidata(:,4:9);mdata(:,4:9);sdata(:,4:9);vdata(:,4:9)];
y = bidata(:,29);

x = (x-mean(x,"omitmissing"))./std(x,"omitmissing");
y = (y-mean(y,"omitmissing"))./std(y,"omitmissing");

ba = length(badata);
bi = length(bidata);
m = length(mdata);
s = length(sdata);
v = length(vdata);

A = 6;
G = 7;
[T, P, R2] = nipalspca(x,A);
Q2 = pcacrossval(x,A,G);
hold on
plot(T(1:ba,1),T(1:ba,2),'ko')
plot(T(ba+1:ba+bi,1),T(ba+1:ba+bi,2),'go')
plot(T(ba+bi+1:ba+bi+m,1),T(ba+bi+1:ba+bi+m,2),'co')
plot(T(ba+bi+m+1:ba+bi+m+s,1),T(ba+bi+m+1:ba+bi+m+s,2),'bo')
plot(T(ba+bi+m+s+1:ba+bi+m+s+v,1),T(ba+bi+m+s+1:ba+bi+m+s+v,2),'yo')

box on;
grid on;

xlabel('First Score t_1');
ylabel('Second Score t_2');

legend("Barcelona","Bilbao","Madrid","Seville","Valencia")


% Plot the T2 elipses
t1 = T(:,1);
t2 = T(:,2);
N = length(t1);
a = (std(t1))^2;
b = (std(t2))^2;

% calculate T2 limits
A = 2;
Flim95 = finv(0.95,A,(N-A));
Flim99 = finv(0.99,A,(N-A));
T2lim95 = ((N-1)*(N+1)*A*Flim95)/(N*(N-A));
T2lim99 = ((N-1)*(N+1)*A*Flim99)/(N*(N-A));

% (t1/s1)^2 + (t2/s2)^2 = T2lim
% t1 is x and t2 is y
% parametric eqn for an elipse (RHS needs to be 1): (x,y) =
% (a*cos(theta),b*sin(theta)) for 0 <= theta <= 2*pi
% eqn becomes t1^2/(T2lim*s1^2) + t2^2/(T2lim*s2^2) = 1

% calculate elipse distances
theta = linspace(0,2*pi,50);
x95 = sqrt(a*T2lim95)*cos(theta);
y95 = sqrt(b*T2lim95)*sin(theta);
x99 = sqrt(a*T2lim99)*cos(theta);
y99 = sqrt(b*T2lim99)*sin(theta);

% plot elipse
plot(x95, y95, '--r')
hold on
plot(x99, y99, '-r')

if max(x99) > max(abs(t1))
    plot([-max(x99)*1.25 max(x99)*1.25], [0 0],'k-','LineWidth',2)
    xlim = [-max(x99)*1.25 max(x99)*1.25];
else
    plot([-max(abs(t1))*1.25 max(abs(t1))*1.25], [0 0],'k-','LineWidth',2)
    xlim = [-max(abs(t1))*1.25 max(abs(t1))*1.25];
end

if max(y99) > max(abs(t2))
    plot([0 0], [-max(y99)*1.25 max(y99)*1.25], 'k-','LineWidth',2)
    ylim = [-max(y99)*1.25 max(y99)*1.25];
else
    plot([0 0], [-max(abs(t2))*1.25 max(abs(t2))*1.25], 'k-','LineWidth',2)
    ylim = [-max(abs(t2))*1.25 max(abs(t2))*1.25];
end

axis([xlim ylim])


hold off;

