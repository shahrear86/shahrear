% created by : Md. Shahrear Zaman
%(c) Md. Shahrear Zaman
% shahrear.zaman1971@gmail.com
% student.eco86@gmail.com
% date 18/03/2020
% This code will help you to understand that, under central limit theorem(CLT), the sum of a large number
%of random variables will have an approximately normal distribution

clear all

a= 30;
b= 1;


for i = 1 : a
    for k = 1 : b
          x = randn(1,i,k);
          z =    sqrt(k)*(sum(x)/k);
    end
end


 [r c1 r1] = size(z);
  N1 = r1;
  mu = sum(z)/N1;
  sigma2 = (sum((z - (sum(z)/N1)).^2)/(N1-1));
  zsort = sort(z);
  zsort1 = zsort(1:b);
  f = ( (1 / sqrt(2*pi*(sigma2))) * exp(-(1/2)*(((zsort1 - mu).^2)/sigma2)));
figure (); plot (zsort1,f);
grid on;
ylabel('Probability')
%xlabel('For the observations 50 and  sample 1000')
%xlabel('For the observations 50 and  sample 10')
%xlabel('For the observations 15 and  sample 5')
%xlabel('For the observations 5000 and  sample 5')
xlabel('For the observations 30 and  sample 2')
legend ({"Probability density function"})
title('An Experiment of the Central Limit Theorem');