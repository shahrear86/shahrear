#created by: shahrear
#(c) Md.Shahrear Zaman
#student.eco86@gmail.com

#Reference: Time Series Analysis . By  James D. Hamilton
#           Econometric Analysis . By  William H. Greene
          

#Read the data
#Declare the variables as X and Y 
r <- nrow(X)
c <- ncol(X)

b = solve(t(X)%*%X)%*%t(X)%*%Y
e = Y - X%*%b

sigma2  = (1/(r - c))%*%sum(e^2)  

# by setting lag order one 
epsil <-e[1:r-1]
epsil_1<-e[2:r]

roh = solve(t(epsil_1)%*%epsil_1)%*%t(epsil_1)%*%epsil

# Let's consider the number of the rows-> 8

M1<-cbind(matrix(0:8),matrix(0:8-1),matrix(0:8-2),matrix(0:8-3),matrix(0:8-4),matrix(0:8-5),matrix(0:8-6),matrix(0:8-7),matrix(0:8-8))
M1[upper.tri(M1)]=0
M2 <- t(M1)
Omega <- M1 + M2
V1 <- 1/(1-roh^2)
V1 = matrix(V1,8,8)
V  <- V1*Omega
sigma2 = matrix(sigma2,8,8)
Eete = sigma^2*V







