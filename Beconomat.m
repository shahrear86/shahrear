%created by : Md. Shahrear Zaman
%(c) Md. Shahrear Zaman
%shahrear.zaman1971@gmail.com
%student.eco86@gmail.com
%date 07/02/2020
%08:28 P.M.

clear all
x1 = randn(1,100); 
x2 = randn(1,30);
y1 =10.*gamma(x1);
y2 = gamma(x2);

[r1 c1] = size(y1);
N = c1
v = N
m_bar = sum(y1)/N
[r2 c2] = size(y2);
T = r2
y_bar = sum(y2)/T
m_star = (v/(v+T))*m_bar + (T/(v+T))*y_bar


v_1= v*N + T;
m_tilde = (v*y_bar + m_bar)/T;
mu_1 = normrnd(m_bar, 1/sqrt(T));
b_tilde = 0.5*sum((y1-m_star).^2) + r2;
tau = gamrnd(m_tilde, b_tilde);

num = zeros(100,2);
if (r2>c2)
num(r1-c1,1) = mu;
num(r1-c1,2) = tau;
end

itr = c2
for i = 1 : itr
      b_tilde1 = 0.5*(y1-m_star).^2 + r2;
      tau = tau.*b_tilde1 + randn(v,1);
       b = v*N  + mu_1*tau + v*y_bar + m_bar;
end
      
 %mu_0 =  0:0.1:1
mu_0 =  1:1:15
s2_0 = 200
v_0 = 30
 
s2 = sum((y2-y_bar).^2)/(T-1)
s21_0 =  (( v_0*s2_0) + sum((y1-m_bar).^2) +  ( (v_0*v)/(v_0+v).*(mu_0 - m_bar ).^2 ) )/(v_0+v) % instead of n and n0 , I have used v and v_0
mu = m_star + mu_0.*sqrt((s21_0/(v+T)))

pdf_mu =  (1 / sqrt((2*pi*s2)/(v+T))) * exp( (-(mu - m_star).^2)/((2*s2)/(v+T))) 

y_1 = sort(y1)
f1 = ( (1 / sqrt(2*pi*(s2))) * exp(-(1/2)*((( y_1- y_bar).^2)/s2)));
figure (); plot (y_1,f1);

y_2 = sort(y2)
f2 = ( (1 / sqrt(2*pi*(s2))) * exp(-(1/2)*((( y_2- y_bar).^2)/s2)));
figure (); plot (y_2,f2);

figure (); plot (mu,pdf_mu);
grid on;




