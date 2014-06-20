function [clusteredX , gamma , m , sigma , p] = Expectation_Maximization(K , X , maxIters , tol)
% Applies the expectation maximization algorithm
% to the image given as parameter.
%   initialImage = The image to be clustered.
%   k = the number of clusters we want.
%   clusteredX = the new clustered data.
%   maxIters = The maximum number of iterations we allow.
%   tol = The tolerance we will use for checking convergence.


%Get matrix properties.
[N , D] = size(X);

%The probabilities γ(Ζnk).
gamma = zeros(N , K);




%STEP 1 : INITIALIZE PARAMETERS OF EM.

% Initialize the p , 1 X K vector.
% p keeps the prior probality of cluster k.
p(1 , 1:K) = 1/K;

% Initialize the m , K X D vector.
% m_k is the centroid of cluster k.
% Initialize m , using random points from our input data.
m = X( randi(N , 1 , K) , : );

%Initialize the covariance matrix K X D.
sigma = repmat(0.1 * var(X) , K , 1);

%Compute the initial maximum likelihood.
likelihood = MaxLikelihood(X , m , K , sigma , p);
fprintf('Initial Likelihood = %d\n' , likelihood);




%Loop until convergence , or if maximum iterations are reached.
for count = 1 : maxIters
    
    %STEP 2 : EXPECTATION STEP.
    fprintf('E-step start\n');
    
    s = zeros(N,K);
    for k = 1 : K
        
        for d = 1 : D
            s(:,k) = s(:,k) + repmat(log(sqrt(2*pi*sigma(k,d))) , N , 1)  + (((X(:,d) - repmat(m(k,d) , N , 1)).^2 ) ./ (2*sigma(k,d))) ;
        end
        
        s(:,k) = log(p(1,k)) - s(:,k);
        
    end

    gamma = mySoftmax(s);
    
    fprintf('E-step end\n');
    
    
    
    
    %STEP 3 : MAXIMIZATION STEP.
    fprintf('M-step start\n');
    
    sums = sum(gamma);
    
    for k = 1 : K
        
        for d = 1 : D
            
            m(k,d) = (gamma(: , k)' * X(: , d)) / sums(1,k);
            
            sigma(k,d) = ( gamma(1:N , k)' * (X(1:N,d) - repmat(m(k,d) , N , 1)).^2 )/sums(1,k);
                        
        end
            
    end
    
    p = sums / N;
    sigma(sigma < 1e-06) = 1e-06;
    
    fprintf('M-step end\n');
    
    
    
    
    %STEP 4 : CHECK FOR CONVERGENCE.
    likelihoodNew = MaxLikelihood(X , m , K , sigma , p);

    if(likelihoodNew < likelihood)
        fprintf('ERROR!!!!!!!!!\n');
        break;
    else
        if (likelihoodNew - likelihood) < tol
            fprintf('Convergence!\n');
            break;
        else
            fprintf('LIKELIHOOD DIFFERENCE= %d\n' , likelihoodNew - likelihood);
            likelihood = likelihoodNew;
        end
    end

end




%FINALLY , ASSIGN EACH DATA TO IT'S CLOSEST CLUSTER.
[~ , maxK] = max(gamma , [] , 2);
clusteredX = m(maxK( : , 1) , :);

end