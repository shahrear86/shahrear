Created by: shahrear
(c) Md. Shahrear Zaman
student.eco86@gmail.com
#Reference Book: Econometrics Analysis ; by WILLIAM H. GREENE
# read the data
# data = .................
# X = data[:,..] 
# Y = data[:,..] 
# con = v % if constant exist v>1, if not v = 0 
r<-nrow(X)
c<-ncol(X-con) 
R<-matrix(0,r,c)
q<-matrix(0,r,1)
# For impose the restrictions you can use the code R[k,l]<-1, In some cases the code will not run because of the restriction structure.
# Restriction should be economecially meaningful and consistent with the mathematical structure so that you can find out the inverse of 
# the matrix  
# Here you can impose only the linear restrictions 
# Ev= matrix(runif(m*n),m,n) you can check by yourself 
# Env= matrix(runif(m*n),m,n)  you can check by yourself 
# b = solve(t(Ev)%*%Ev,t(Ev)%*%Env)  you can check by yourself 

b = solve(t(X)%*%X,t(X)%*%Y)
e = Y - X%*%b
sigma2 = sum(e^2)/r

W = { t(R%*%b - q)%*%solve(R%*%solve(t(X)%*%X)%*%t(R))%*%(R%*%b-q) } / sigma2 