function S = mySoftmax(Y) 

K = size(Y , 2);

M = max(Y, [], 2); 

Y = Y - repmat(M, 1, K); 

Y = exp(Y); 

S = Y./repmat(sum(Y,2),1,K); 
