clearvars;clc;
I = imread('cheetah.jpg');%Read the foreground image
I = rgb2gray(I);
I = im2double(I);
K=2;
F=makeLMfilters;
tic;
for i=1:48
result = conv2(I,F(1:49,1:49,i),'same');
m = size(result,1);
n = size(result,2);
feature(:,i) = reshape(abs(result),m*n,1);
end
X = feature;

Data = X;

% Initialize centroids
centroids = kMeansInitCentroids(Data, K);
iterations = 20;
for iter = 1:iterations
% Cluster assignment step: Assign each data point to the
% closest centroid. idx(i) corresponds to cˆ(i), the index
% of the centroid assigned to example i
idx = findClosestCentroids(Data, centroids);
% Move centroid step: Compute means based on centroid
% assignments
centroids = computeCentroids(Data, idx, K);
end

temp = reshape(idx,285,384);
imagesc(temp);
idx = reshape(idx,285,384);

sImg = imread('cheetah.jpg');%Foreground Image
tImg = imread('bg.jpg');%Background Image
newImg = transferImg([1,3,4,6,8], idx, sImg, tImg);%Function to transfer the segmented image onto the background image
timetaken = toc;



