%Prepared by: shahrear
%student.eco86@gmail.com
% © Md. Shahrear Zaman
%March-May 2017

clear all
%Lets the equation y  = beta_x1*x1 + beta_x2*x2 + u
%                  x2 = beta_z3*z + u1
%                  z  = (x2 - u1)/beta_z3


nobs = 100;
%************************
beta_x1 = 1;
beta_x2 = 1;
beta_z = 0.5; 

%************************
mu_x1=0;
mu_x2=3;
mu_u=0;
mu_u1=0;
mu_z = 4;
%***********************
var_x1=3;
var_x2=9;
var_u=7;
var_u1=9;
var_z=3;
%***********************
corr_x1_x2=0;
corr_x1_u=0;
corr_x1_u1=0;
corr_x2_u=0.90;
corr_x2_u1=0;
corr_u_u1=0;
%***********************
corr_z_x1=0;
corr_z_x2=0.70;
corr_z_u=0;
corr_z_u1=0;
%***********************
mu = [mu_x1 mu_x2 mu_u mu_u1 mu_z];
%***********************
cov_x1_x1=var_x1^2;
cov_x2_x2=var_x2^2;
cov_u_u=var_u^2;
cov_u1_u1=var_u1^2;

%***********************
cov_x1_x2=corr_x1_x2*var_x1*var_x2;
%***********************
cov_x1_u=corr_x1_u*var_x1*var_u;
cov_x1_u1=corr_x1_u1*var_x1*var_u1;
%************************
cov_x2_u=corr_x2_u*var_x1*var_u;
cov_x2_u1=corr_x2_u1*var_x1*var_u1;
%************************
cov_u_u1=corr_u_u1*var_u*var_u1;
%************************
cov_z_z=var_z^2;
cov_z_u=corr_z_u*var_z*var_u;
cov_z_u1=corr_z_u1*var_z*var_u1;
cov_z_x1=corr_z_u*var_z*var_x1;
cov_z_x2=corr_z_x2*var_z*var_x2;

%***************************
sigma = [cov_x1_x1  cov_x1_x2  cov_x1_u  cov_x1_u1 cov_z_x1;  
     cov_x1_x2  cov_x2_x2  cov_x2_u  cov_x2_u1 cov_z_x2;
     cov_x1_u  cov_x2_u  cov_u_u  cov_u_u1  cov_z_u;
     cov_x1_u1  cov_x2_u1  cov_u_u1  cov_u1_u1 cov_z_u1;
     cov_z_x1 cov_z_x2 cov_z_u cov_z_u1 cov_z_z];
 

ut = chol(sigma);
m = repmat(mu,nobs,1) + randn(nobs,5)*ut;
%**************************************

x1 = m(:,1);
x2 = m(:,2);
u = m(:,3);
u1 = m(:,4);
z = m(:,5);
%**************************************

Check_Corr_x1_u=corr(x1,u);
Check_Corr_x2_u=corr(x2,u);
Check_Corr_x1_u1=corr(x1,u);
Check_Corr_x2_u1=corr(x1,u);
Check_Corr_u_u1=corr(x1,u);
Check_Corr_x1_x2=corr(x1,x2);
%***************************************
Check_Corr_z_x1=corr(z,x1);
Check_Corr_z_x2=corr(z,x2);
Check_Corr_z_u =corr(z,u);
Check_Corr_z_u1 =corr(z,u1);


%***************************************
y  = beta_x1*x1 + beta_x2*x2 + u;
% x2=beta_z*z + u1;
% z  = (x2 - u1)/beta_z3;
%***************************************
Check_Corr_y_z=corr(y,z);
% Check_Corr_z_u=corr(z,u);




