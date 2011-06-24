%Purpose: Enhances the decomposition in DL by assigning non-DL pixels to
%the closest decomposition (based on centroid distance).
%Returns: The enhanced set of decompositions
function NDL = reconstructDecompositions(DL, I)
%Number of decompositions
N = numel(DL(:,1));
%Holds the list of centroids for each decomposition.
%centroids = cell(N, 1);
centroids = zeros(N, 2);
NDL = cell(N, 1);
%For every decomposition
for k = 1:N
    %Remove the pixels of the decomp from the original
    %We only want to deal with the unclassified pixels
    %I = I - DL{k};
    %The centroid is the absolute position of the cluster's center in the
    %original image.
    cobj = regionprops(DL{k}, 'Centroid');
%     imshow(DL{k});
    centroids(k, :) = cobj.Centroid;
end
%Get the foreground point locations
[xs ys] = find(I == 1);
%Join the columns
X = [xs ys];
%Perform KMeans to segment the foreground at the starting locations
%identified by the clusters.
[idx, ~] = kmeans(X, N, 'start', centroids);
for k = 1:N
   %Grab all kmeans indices for the current cluster
   %This identifies the rows in X that belong to the current cluster.
   rowNumbers = find(idx == k); 
   %Grab the pixel locations for the current cluster, identified by the idx
   members = X(rowNumbers, :);
   %Cache the current decomposition
   d = DL{k};
   d = d - d;
   for j = 1:numel(members(:,1))
       p = [members(j,1) members(j,2)];
       d(p(1), p(2)) = 1; 
   end
   %Turn the pixel members on
%    d(members(:,1), members(:,2)) = 1;
   %Store the final decomposition
   NDL{k} = d;
end
% %Holds the distances between a point and each centroid
% dists = ones(N,1);
% %Grab all of the foreground pixel indices
% [xs ys] = find(I == 1);
% %For every foreground pixel
% for k = 1:numel(xs)
%     %Cache the point
%     p = [xs(k) ys(k)];
%     %For every decomposition
%     for n = 1:N
%         %Compute the distance between the point and centroid
%         dists(n) = sum(abs(p - centroids{n}));
%     end
% 
%     %Find the smallest distance and the index of that centroid
%     [~, ind]= min(dists);
% 
%     %Add the point to the decomposition identified by the centroid
%     d = DL{ind};
%     d(p(2), p(1)) = 1;
%     DL{ind} = d;
% end