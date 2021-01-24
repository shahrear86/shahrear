% For the dedication, who gave and secrefice their life in the space far from the soil of the earth 
% to discover and to face the challenges of the galaxies
% Md. Shahrear Zaman
% shahrear.zaman1971@gmail.com
% student.eco86@gmail.com
% date : 17/01/2021 % Building up the two dimentional equation system
%        22:22 
%        19/01/2021 % Building up the three dimentional equation system 
%        14:44
clear all
load hight.txt
load distances.txt
load theta.txt
load acceleration.txt
load time.txt

Y = hight ;        % Hights during the flight (k) 
x = distances;     % distances on the one horizontal line(i) during the flight
t = time;          % Time interval during the flight 
theta = theta;     % angles between the horizontal line and the vertical line during the projections
v0= 28  ;          % primary velocity of the projection
m = 230 ;          % mass
a = acceleration ; % accelerations to the vertical during the projections
g = 9.8 ;          % acceleration due to the gravity

% for the two dimentional system :
X =[((t.*(x.*tan(theta)))./(t-m*g)) , (-1)*((t.*(x.^2).*((g - a)./(2*(v0^2)*((cos(theta)).^2))))./(t -m*g))] ;

beta = inv(X'*X)*(X'*Y);
Yhat = X*beta ;
error = Y - Yhat;

figure();plot(Yhat);
grid on;
ylabel('Hight');
xlabel('Observations');
title('');

**********************************************************
% for the three dimentional system :
load acceleration2.txt
load distances2.txt
load theta2.txt

theta1 = theta.*0.2;           % change the angles 20 percent between the horizontal line and the vertical line during the projections
theta2 = theta2;               % angles between the two horizontal lines during the projections
acceleration_z = acceleration; % accelerations to the vertical line during the projections
acceleration_y = acceleration2;% accelerations to the horizontal line during the projections
y = distances2;                % distances on the another horizontal line(j) during the flight

x1 =((sin(theta1).*(( y ./ (cos(theta1)+ sin(theta2))) + ( x ./ (cos(theta1)+ cos(theta2)))))./((t - (m*g))./t));
x2 = (-1)*(((g - acceleration_z) .* ( 1./(v0)^2).*((( y ./ (cos(theta1)+ sin(theta2))) + ( x ./ (cos(theta1)+ cos(theta2)))).^2))./((t - (m*g))./t));
x3 =((m.*acceleration_y.*y)./(t-(m*g)));

X1 = [x1 ,x2 , x3];

beta1 = inv(X1'*X1)*(X1'*Y);
Yhat1 = X1*beta1;
error1 = Y - Yhat1;

figure(); plot(Yhat1);
grid on;
ylabel('Hight');
xlabel('Observations');
title('');

% comment: Three dimentional equation system shows less error

**********************************************************
% Forecast :
% date 13/07/2020
% time 07:18P.M. 
% date 13/09/2020
% time 05:19P.M. 
% date 19/01/2021 
% time 22:32
% date 20/01/2021
% time 03:42
% Forecast from the three dimentional equation system

k = columns(X1);

[count, value] = runlength (Y);
N = sum(count);

prob = count/N;
tprob = sum(prob);

[T  c] = size(Y) ;

PP = [ ];
for i =1:T
      PP1 = (rows(Y(find(Y == Y(i))))/rows(Y))
      PP =[PP PP1]
end
% Population and the sample mean
mu  = sum(PP*Y);
s   = sum(Y)/N;
% Population and the sample variences
sigma2 = sum(((Y-mu).^2)'*PP');
sigma_hat2 = sum((Y- mean(Y)).^2)/(T - k);

% Iterate 1000 times to get 1000 t-values with different volatilities.
% We can use randn(1), randg(1) etc. to get the volatility. There are a lot of procedures.
% In this case I have used randn(1) to get a random number which is normally distributed 
% and intensified the value ten times more.
      
t = [ ];
for itr = 1 : 1000
   tvelu =  (((sum(Y)+10*randn(1)) /rows(Y)) - mu) / sqrt(sigma2/T);
   betaols = inv(X1'*X1)*X1'*Y;
   t = [t  [tvelu]];
   err = Y*t - (X1*betaols);
end

Yhat2 = X1*betaols;
errprc = prctile(err',[10,20,30,40,50,60,70,80,90,100]); 
 
forecast = [[ones(9,1)*Y(1:T-6)'],[Yhat2(T-6:T)'+ errprc(1:9,T-6:T)]]' ;

figure (); plot(forecast);
grid on;
ylabel('Hight');
xlabel('Observations');
title('');





