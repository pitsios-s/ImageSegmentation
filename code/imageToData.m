function [ X ] = imageToData( imageData )
% This function is responsible for exporting
% an height * width * D image , to a
% N * D data matrix , where N = height * width.

%get image properties.
[height , width , D] = size(imageData);

N = height * width;

X = zeros( N , D );

for w = 1 : width
    for h = 1 : height
      n = h + (w - 1) * height;
      
      X(n , 1) = imageData(h , w , 1);
      X(n , 2) = imageData(h , w , 2);
      X(n , 3) = imageData(h , w , 3);
    end
end

end