function likelihood = MaxLikelihood( X , m , K , sigma  , p)
% This function is used in order to compute the
% maximum likelihood using numerical stable way.

[N , D] = size(X);
f = zeros(N,K);

for k = 1 : K
    
    for d = 1 : D
         f(:,k) = f(:,k) + repmat(log(sqrt(2*pi*sigma(k,d))) , N , 1)  + (((X(:,d) - repmat(m(k,d) , N , 1)).^2 ) ./ (2*sigma(k,d))) ;
    end
    
    f(:,k) = log(p(1,k)) - f(:,k);
end

maxF = max(f , [] , 2);

repMax = repmat(maxF , 1 , K);

f = exp(f - repMax);

likelihood = sum(maxF + log(sum(f , 2)));

end