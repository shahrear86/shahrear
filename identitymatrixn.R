created by: shaharear
(c) Md. Shahrear Zaman
student.eco86@gmail.com

identitymatrix = function(n,m){
    I = matrix(0,nrow = n, ncol = m)
    for (i in 1:n) {
       for (j in 1:m) {
          if(i==j) I[i,j]=1
       }
    }
 return(I) 
}

# Save your script and type submit() in the console after you have written the function
