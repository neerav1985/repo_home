>>>from numpy import * 
>>> # Define a matrix X that has 3 column vectors as the observations variables
>>> X = array([[1, 2, 3],   [2, 4, 5],   [1, 2, 5], [10,2,3], [25,23,1]])
>>> X
array([[ 1,  2,  3],
       [ 2,  4,  5],
       [ 1,  2,  5],
       [10,  2,  3],
       [25, 23,  1]])
>>> # Calculate covariance matrix
>>> cov = dot(X.T, X)
>>> cov
array([[731, 607,  73],
       [607, 557,  65],
       [ 73,  65,  69]])
>>> # Calculate eigenvalues and eigenvectors(in rows) of covariance matrix
>>> eigval, eigvec = linalg.eig(cov) 
>>> eigval
array([ 1265.18870211,    30.74169774,    61.06960014])
>>> eigvec
array([[ 0.75303936,  0.65186942, -0.08943145],
       [ 0.6529166 , -0.7571372 , -0.02105173],
       [ 0.08143485,  0.0425385 ,  0.99577048]])
>>> # By definition eigenvectors transform a matrix to return a diagonal matrix of eigen values
>>> # cov = eigvec.T * diag(eigvalues) * eigvec  = P * D * P.T
>>> Here P is a 3*3 matrix with its columns as eigenvectors
>>> # Because eigvec * eigvec.T = I, above is equivalent to
>>> # eigvec * cov * eigvec.T = diag(eigvalues) 
>>> # All 3 eigenvalues are non-zero, so we will use all 3 eigenvectors as principal components
>>> new_eigvec
array([[ 0.75303936,  0.65186942, -0.08943145],
       [ 0.6529166 , -0.7571372 , -0.02105173],
       [ 0.08143485,  0.0425385 ,  0.99577048]])
>>> # Calculating transformed variables
>>> X_trans = dot(X,new_eigvec)
>>> X_trans
array([[  2.30317712,  -0.73478949,   2.85577652],
       [  4.52491939,  -1.51211749,   4.71578257],
       [  2.46604683,  -0.6497125 ,   4.84731748],
       [  9.08053138,   5.13203525,   2.05089349],
       [ 33.92450066,  -1.07488172,  -1.72420547]])
>>> # Note that the diagonal elements of below cov matrix matches the eigenvalues from above
>>> new_cov = dot(X_trans.T, X_trans)
>>> new_cov
array([[  1.26518870e+03,   2.77111667e-13,  -2.84217094e-14],
       [  2.77111667e-13,   3.07416977e+01,   3.73034936e-14],
       [ -2.84217094e-14,   3.73034936e-14,   6.10696001e+01]])
>>> # Or other way of looking at it
>>> dot(dot(new_eigvec.T, dot(A.T, A)),new_eigvec)
array([[  1.26518870e+03,   2.50466314e-13,  -5.68434189e-14],
       [  2.71241363e-13,   3.07416977e+01,   3.73034936e-14],
       [ -4.70734562e-14,   3.15303339e-14,   6.10696001e+01]])
