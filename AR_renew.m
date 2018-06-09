%created by shahrear
%student.eco86@gmail.com
%(c) Md. Shahrear Zaman
clear all 
XY = xlsread('C:\Users\shahrear\Desktop\function\test 1.xlsx','A2:AU40');
%Read the file
%XY = xlsread('.....................');
Year =XY(:,1); 
BOT  =XY(:,17);
BNC  =XY(:,18);
GNC  =XY(:,19);
NM   =XY(:,20);
BM   =XY(:,21);
EXRJ =XY(:,22);
EXRUS=XY(:,23);
EXRUK=XY(:,24);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%taking the log
BOT    =(XY(:,17));
BNCL   =log(XY(:,18));
GNCL   =log(XY(:,19));
NML    =log(XY(:,20));
BML    =log(XY(:,21));
EXRJL  =log(XY(:,22));
EXRUSL =log(XY(:,23));
EXRUKL =log(XY(:,24));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Adjusting the lag value (1-lag)
%Use the function lag
BOTL1    = lag(BOT,1);
BNCLL1   = lag(BNCL,1);
GNCLL1   = lag(GNCL,1);
NMLL1    = lag(NML,1);
BMLL1    = lag(BML,1);
EXRJLL1  = lag(EXRJL,1);
EXRUSLL1 = lag(EXRUSL,1);
EXRUKLL1 = lag(EXRUKL,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Set up the variables
Y = EXRUSLL1(:,1);
X = [EXRUSLL1(:,2) BOTL1(:,1) BOTL1(:,2) BNCLL1(:,1) BNCLL1(:,2) GNCLL1(:,1) GNCLL1(:,2) NMLL1(:,1) NMLL1(:,2) BMLL1(:,1) BMLL1(:,2) EXRJLL1(:,1) EXRJLL1(:,2)  EXRUKLL1(:,1) EXRUKLL1(:,2)]
%Prediction full:
%by using ols
betaFull = inv(X'*X)*(X'*Y)
y_hatFull=X*betaFull
error = Y - y_hatFull
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(Y)
plot(y_hat)
plot(error)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
back=8   % 8-years less value 
%back=16
lap =2   % 2-steps forward
n=back/(lap*lap) % formula for making a loop to roll through the steps 
%and to find out the value of ols, pridiction and error for each window

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=length(Y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Yint=Y(1:T-back,1);
Xint=X(1:T-back,:);
betaint = inv(Xint'*Xint)*(Xint'*Yint)
y_hatint=Xint*betaint
errorint=Yint - y_hatint
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=0:n
   Yr=Y(1+2^(i)*lap:T-back+2^(i)*lap,1);
   Xr=X(1+2^(i)*lap:T-back+2^(i)*lap,:);
   beta = inv(Xr'*Xr)*(Xr'*Yr)
   eval(['beta' num2str(i) ' = beta'])
   y_hat=Xr*beta
   eval(['y_hat' num2str(i) ' = y_hat'])
   errorR=Yr - y_hat;
   eval(['errorR' num2str(i) ' = errorR'])
end  
%********************************************************
%********************************************************
errorintLag=(lag(errorint,1));
errorintLag1= errorintLag(:,2);
errorint1 = errorintLag(:,1);

% errorint = eta*(errorint+1) + epsilon 
% betaint is from first 30 years data
% past error depends on the future error ( we already have the data ); possible in case have expectation on future and hence... 
eta_hat_int = inv(errorintLag1'*errorintLag1)*errorintLag1'*errorint1;
error_min = errorint1 - eta_hat_int*errorintLag1;
predict_yint_1step = X(length(Xint)+1,:)*betaint + eta_hat_int*error_min(length(error_min));
original_y = Y(31,1)
%original_y =  4.0765
%predict_yint_1step =  4.1973
%.........................................continued




 











