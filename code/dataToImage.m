function [ newImage ] = dataToImage(X , height , width)
% This function is responsible for exporting
% an N * D data matrix , to an
% height * width * D image.

[N , D] = size(X);

newImage = zeros(height , width , D , 'uint8');

for n = 1 : N
    
    w = fix(n/height);
    
    if mod(n , height) ~= 0
        w = w + 1;
    end
    
    h = n - (w - 1) * height;
            
    newImage(h , w , :) = X(n , :);
    
end

end