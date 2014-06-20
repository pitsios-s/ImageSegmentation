function error = ComputeError( X , Xnew )
% Computes the reconstruction error , 
% between the initial image and the new one.

error = ( norm(X - Xnew) ^ 2 ) / size(X , 1);

end