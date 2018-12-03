identitymatrix = function(n,m){
    I = matrix(0,nrow = n, ncol = m)
    for (i in 1:n) {# i is the number of the row
       for (j in 1:m) {# j is the number of the column
          if(i==j) I[i,j]=1 # each element of the diagonal (i=j) is 1
       }
    }
 return(I) 
}

# Save your script and type submit() in the console after you have written the function