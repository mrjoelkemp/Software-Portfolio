%Author: Joel Kemp
%Purpose: Uses code to compute the GMM segmentation of the passed image
%with K initial clusters. 
%Returns: A Kx1 cell matrix of clusters.
function DL = MLGaussianMM(img, K)

%Initialize the output matrix
DL = cell(K, 1);

%Get the foreground point locations
[xs ys] = find(img == 1);
%Join the columns
X = [xs ys];

%Compute the Gaussian Mixture Model regression on the passed image data
%Transpose to make emgm happy
tic;
idx = emgm(X', K);
toc;

%For each cluster
for k = 1:K
    %Initialize an empty image of the same dimensions as img
    d = img - img;
    
    %Grab all of the indices for the current cluster
    rowNumbers = find(idx == k);
    
    %Grab the pixel locations for the current cluster
    members = X(rowNumbers, :);
    
    %For each of the pixels for the current cluster
    for j = 1:numel(members(:,1))
        %Turn that pixel on in the empty decomposition d
        p = [members(j,1) members(j,2)];
        d(p(1), p(2)) = 1; 
    end
%     imshow(d);
    DL{k} = d;
end