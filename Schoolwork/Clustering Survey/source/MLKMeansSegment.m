%Author: Joel Kemp
%Purpose: Computes the kmeans segmentation of the passed image with a
%user-supplied number of ideal clusters.
%Returns: A Kx1 matrix of decompositions
function DL = MLKMeansSegment(img, K)

%Initialize the output matrix
DL = cell(K, 1);

%Get the foreground point locations
[xs ys] = find(img == 1);
%Join the columns
X = [xs ys];

%Perform K-meanssegmentation on the image with K clusters
[idx, ~] = kmeans(X, K);

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