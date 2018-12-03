created by: shaharear
(c) Md. Shahrear Zaman
student.eco86@gmail.com
# This function was rejected as an incorrect solution from the statistics department of uni kiel..... :) 
# please check whatever this function is correct or not before you will start to use 
identitymatrix = function(n,m){
    I = matrix(0,nrow = n, ncol = m)
    for (i in 1:n) {
       for (j in 1:m) {
          if(i==j) I[i,j]=1
       }
    }
 return(I) 
}

