%(c)Md.Shahrear Zaman
%shahrear.zaman1971@gmail.com
%student.eco86@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reference: Principles of Econometrics ( Third Edition)        
%%%%%%%% by R. Carter Hill , William E. Griffiths, Guay C. Lim 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reference: Advanced Econometrics                              
%%%%%%%% by Takeshi Amemiya                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%28/09/2020,Time: 11:24 P.M.,29/09/2020,Time: 01:08 P.M.,
%01/09/2020,Time: 10:42P.M.
clear all
% Read the data
% Time series or cross section data or mixed
load goldprice.txt %for example
%load testexo.txt
%load Years.txt
Y = goldprice;
%year = Years                             
[T  c] = size(Y) ;
% Let's consider we have done already the standard stationary test
% Let's consider we have done already the standard lag selection test 
X=[ones(T,1) lagadjust(1,Y)'];
betaols = inv(X'*X)*(X'*Y);
Yhat = X*betaols;
e = (Y - Yhat);
%Let us consider from 1 to 8 lags
Eexo = [lagadjust(1,e)' lagadjust(2,e)'  lagadjust(3,e)' lagadjust(4,e)' ...
        lagadjust(5,e)' lagadjust(6,e)' lagadjust(7,e)' lagadjust(8,e)' ]

e_betaols = inv(Eexo'*Eexo)*Eexo'*Y;

figure (); plot (e_betaols);

e = (Y - Yhat);
estd=sqrt(((e - mean(e)).^2)/(size(e,1)-1));
EexoStd = [lagadjust(1,estd)' lagadjust(2,estd)'  lagadjust(3,estd)' lagadjust(4,estd)' ...
        lagadjust(5,estd)' lagadjust(6,estd)' lagadjust(7,estd)' lagadjust(8,estd)' ]

e_betaolsStd = inv(EexoStd'*EexoStd)*EexoStd'*Y;

%Graph: for the impact of endogenous dependent variable, on the ... 
%change of one standard deviation of the error, where the change of ...
%the error, follows the lag order.

figure (); plot (e_betaolsStd); 

%Test-1 
shock = 1  % setup the shock
l = 25     % Time length
lagc = 1   % Lag for Co-efficient
yy1 =[]
for i = 0 : l 
     y1 = (e_betaolsStd(lagc)^(i))*(shock.*ones(size(Y,1),1));
     yy1 =[yy1 y1]
end

figure (); plot (yy1(1,:));

%Test-2
shock = 1  % setup the shock
l = 25     % Time length
lagc = 1   % Lag for Co-efficient
yy2 =[]
for i = 0 : l 
     y2 = (e_betaolsStd(lagc)^(i))*(shock.*ones(size(Y,1),1)).*estd;
     yy2 =[yy2 y2]
end

figure (); plot (yy2(1,:));

%Test-3
shock = 1  % setup the shock
l = 25     % Time length
%lagc = 1  % Lag for Co-efficient
cn = 1  % Coefficient no.  
yy3 =[]
for i = 0 : l 
     y3 = (betaols(cn)^(i))*(shock.*ones(size(Y,1),1));
     yy3 =[yy3 y3]
end

figure (); plot (yy3(1,:));

%e_c = Eexo.*e_betaols';
%figure (); plot (e_c(40,:));
%figure (); plot (e_c(39,:));
%figure (); plot (e_c(38,:));
%figure (); plot (e_c(37,:));
%figure (); plot (e_c(36,:));
%figure (); plot (e_c(10,:));

%plot(mean(e_c))

%e_cStd = EexoStd.*e_betaolsStd';
%figure (); plot (e_cStd(40,:));
%figure (); plot (e_cStd(39,:));
%figure (); plot (e_cStd(38,:));
%figure (); plot (e_cStd(37,:));
%figure (); plot (e_cStd(36,:));
%figure (); plot (e_cStd(10,:));
%
%plot(mean(e_cStd))
%
%Y = flip(Broadmoney);
%X=flip([ones(T,1) lagadjust(1,Y)']);

%(X - mean(X))
%(Y - mean(Y))
%sum((X - mean(X))'*(X - mean(X)))

%beta =  ((X - mean(X))'*(Y - mean(Y)))./sum((X - mean(X)).^2)'
%beta =  (sum((X - mean(X)).*(Y - mean(Y)))./sum((X - mean(X)).^2))'
%alpha = mean(Y) - mean(X)*beta
char([35,32,97,117,116,104,111,114,58,32,109,100,46,115,104,97,104,114,101 ... 
,97,114,32,122,97,109,97,110],10)
