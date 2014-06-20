function [clusteredX, M, R] = KMeans(K, X, tol, maxIters)
%function [M, R] = ml_kmeans(X, M)
% 
% Inputs:  
%          X is N x D data matrix. 
%          K is number of clusters.
%          tol is the tolerance that we will use for convergence.
%          maxIters is the maximum number of iterations that we allow.
%
% Outputs: 
%          clusteredX the new clustered data.
%          M the final values of the centers.
%          R is 1 x N vector integers indicating the assingment of 
%            the data point into clusters.                 


N = size(X, 1); 

% Initialize the m , K X D vector.
% m_k is the centroid of cluster k.
% Initialize m , using random points from our input data.
M = X( randi(N , 1 , K) , : );

% Apply the two steps of kmean until convergence  
Jold = Inf; 
clusteredX = X;
R = zeros(1,N);


for it = 1 : maxIters

    % STEP 1 -- assing data to clusters 
    distances = zeros(N,K);
    
    for k = 1 : K
        distances(:,k) = sum( (X - repmat(M(k,:), N, 1)).^2, 2) ;
    end
    
    [mindist,R] = min(distances, [], 2);
    
    
    
    
    % STEP 2 -- update the mean centers 
    for k = 1 : K 
       
       indk = find(R==k);  
       numk = length(indk); % be careful not to divide by zero 
       
       if numk > 0 
          M(k,:) = sum(X(indk,:), 1)/numk;
       end
       
    end
    
    
    
    
    % STEP 3
    J = sum(mindist);
    
    % print the value of objective function 
    fprintf('Iteration %4d  Cost function %11.6f\n', it, J); 
    
    % Check for convergence 
    if (abs(J-Jold) < tol)
        break;
    end
    
    Jold = J;
    clusteredX = M(R, :);
    
end

end