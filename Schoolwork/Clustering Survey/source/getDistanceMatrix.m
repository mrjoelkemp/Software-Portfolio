%Author: Joel Kemp
%Purpose: Computes the distance matrix comprised of the weighted 
% feature distance about every pair of images.
%   in the passed set of images.
%Returns: The distance matrix numImages x numImages.
%Notes:
%   1. We initialize the matrix to be zeros so that we don't need
%   to compute the distances between an image and itself -- which
%   will be equal to 0.
function DM = getDistanceMatrix(images, SIMS)

%Cache the number of images
numImages = numel(images);
%Initialize the distance matrix dimensions.
DM = zeros(numImages, numImages);

% %Get all unique pair combinations of the numbers/indices from 1 to
% %numImages. We can use this list to bypass the double for loop.
% combs = nchoosek(1:numImages, 2);
% 
% %Get the left column as the set of f1
% f1s = combs(:, 1);
% f2s = combs(:, 2);
% 
% %Get the feature vectors for each set of indices
% f1List = features(f1s);
% f2List = features(f2s);
% 
% %Get the similarity matrices for all combinations of features
% fprintf('%s', 'Get Similarity Matrix');
% tic;
% SIMS = cellfun(@getSimilarityMatrix, f1List, f2List, 'UniformOutput', false);
% toc;

%Get the weighted feature distance for each similarity matrix
fprintf('%s', 'Get Weighted Distance');
tic;
phis = cellfun(@getWeightedDistance, SIMS, 'UniformOutput', true);
toc;

%Get the number of pair combinations
% numCombs = numel(combs(:, 1));

%The total number of non-repeating image combinations
%Found by 1400 choose 2
numCombs = 979300;

%For each combination
for c = 1:numCombs
    %Get current combination row
    p = combs(c,:);
    %Get current weighted distance
    phi = phis(c);
    %Store the weighted distances in both the normal and reverse
    %feature pairings. We do this so the display output looks
    %full and shows all possible matches for each image.
    DM(p(1), p(2)) = phi;
    DM(p(2), p(1)) = phi;
end