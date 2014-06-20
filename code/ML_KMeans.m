% This is a script for running the Expectation-Maximization algorithm.
% We will use this algorithm for image segmentation ,
%for different values of K.

format long;
clear all;
clc;

start = tic;

%Initialize the K vector.
K = [1, 2, 4, 8, 16];

%Load the image.
testImage = imread('../images/im' , 'jpg');

%Display the original image.
figure;
image(testImage);
title('Original Image');

%get image properties.
[height , width , D] = size(testImage);

%Get the image as a N X D matrix.
X = imageToData(testImage);


%Apply the EM algorithm for all k's.
for i = 1 : size(K , 2)
    
    %Call the EM algorithm for the current k.
    [newX, M, R] = KMeans(K(1 , i), X, 0.0001, 30);
    
    %Compute the reconstruction error.
    error = ComputeError(X , newX);
    
    %Display the new clustered image.
    figure;
    image(dataToImage(newX , height , width));
    title( sprintf('Clustered image with k = %d.\nReconstruction Error = %d' , K(1 , i)  , error) );
    
end

toc(start);
