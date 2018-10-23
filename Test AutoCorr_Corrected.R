#created by: shahrear
#(c) Md.Shahrear Zaman
#student.eco86@gmail.com

#Reference: Econometric Analysis . By  William H. Greene

#Read the data
#Declare the variables as X and Y 
r <- nrow(X)
c <- ncol(X)
b = solve(t(X)%*%X)%*%t(X)%*%Y
e = Y - X%*%b
# by setting lag order one 
epsil <-e[1:r-1]
epsil_1<-e[2:r]
# roh = solve(t(epsil_1)%*%epsil_1)%*%t(epsil_1)%*%epsil
r = sum(epsil%*%epsil_1)/sum(epsil^2)
X_0 = X[1:r-1,1:c]

#LAGRANGE MULTIPLIER TEST
LM = nrow(X_0)%*%(t(epsil)%*%X_0%*%solve(t(X_0)%*%X_0)%*%t(X_0)%*%epsil)/t(epsil)%*%epsil

# BOX AND PIERCES TEST AND LJUNGS AND BOX ....(Q-test)
Q1970 = nrow(X_0)%*%sum(r^2)
Q1979 = (r-1)%*%(r-1+2)%*%sum((r^2)/r-1)

# DURBIN-WATSON TEST
DW = sum((epsil - epsil_1)^2)/sum(epsil^2)
