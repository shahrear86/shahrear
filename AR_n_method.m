%AR - n method
%created by shahrear
%student.eco86@gmail.com
%(c) Md. Shahrear Zaman
%The model and method are structured by : Md. Shahrear Zaman
clear all 
pkg load io
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
%% value of the left hand side variable depends on it's future value and other variable's same period and on the future value.
%% as we have the data and I have considered that we already have planned and hence we know what the future value will be...(for example: Government already have planned, what's it's expenditure
%% will be in next year....For other's some variables we can also take an expectation.     
%% past error depends on the future error ( we already have the data ); possible in case have expectation on future and hence... 
%Prediction full:
%by using ols
betaFull = inv(X'*X)*(X'*Y)
y_hatFull=X*betaFull
error = Y - y_hatFull
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
back=8   % 8-years less value 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=length(Y);

for i=0:back
Yint=Y(1:T-back+i,1);
eval(['Yint' num2str(i) ' = Yint'])
Xint=X(1:T-back+i,:);
eval(['Xint' num2str(i) ' = Xint'])
betaint = inv(Xint'*Xint)*(Xint'*Yint)
eval(['betaint' num2str(i) ' = betaint'])
y_hatint=Xint*betaint
eval(['y_hatint' num2str(i) ' = y_hatint'])
errorint=Yint - y_hatint
eval(['errorint' num2str(i) ' = errorint'])
errorintLag=(lag(errorint,1));
eval(['errorintLag' num2str(i) ' = errorintLag'])
errorintLag1= errorintLag(:,2);
eval(['errorintLag1' num2str(i) ' = errorintLag1'])
errorint1 = errorintLag(:,1);
eval(['errorint1' num2str(i) ' = errorint1'])
eta_hat_int = inv(errorintLag1'*errorintLag1)*errorintLag1'*errorint1;
eval(['eta_hat_int' num2str(i) ' = eta_hat_int'])
error_min = errorint1 - eta_hat_int*errorintLag1;
E = eval(['error_min' num2str(i) ' = error_min'])
predict_yint_step = X(length(X)-back:length(X),:)*betaint + eta_hat_int*E(length(E)-back:length(E),:)
eval(['predict_yint_step' num2str(i) ' = predict_yint_step'])
end


                      