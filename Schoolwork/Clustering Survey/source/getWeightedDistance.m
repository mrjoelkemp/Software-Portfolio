% Author: Joel Kemp
% Purpose: Compute the total distance between the two images from the
%     passed in feature vector pairing list.
% Returns: A scalar absolute distance.
% Notes:
%     1. The DS contains the pairing of similar feature vectors between
%       two images.
%     2. We return the average weighted feature distance to eliminate 
%       the bias towards images with a smaller number of
%       clusters.
function Phi = getWeightedDistance(DS)
%Initialize Phi since we're adding to it.
Phi = 0;

%Get the pre-defined feature vector weights
fweights = getFeatureWeights();

%numel(DS) gives us the total number of elements
%We divide by 2 (columns) to get the number of rows
numrows = numel(DS) / 2;

%For each row in the similarity matrix
for k = 1: numrows
    %Get individual columns as arrays to perform subtraction
    xs = DS{k, 1};      %First set of FVs
    ys = DS{k, 2};      %Second set of FVs
    
    %Compute the absolute differences between the similar feature vectors.
    pairDistances = abs(xs - ys);
    %Compute the Euclidean distance between the feature vectors
%     pairDistances = pdist2(xs, ys);
    
    %Multiply the element-wise difference result by the weights
    wpds = pairDistances .* fweights;
    
    %Compute the sum of the weighted distances
    sumd = sum(wpds);
    
    %Add the computed distance to the overall distance Phi
    Phi = Phi + sumd;
end

%Compute the average weighted distance
% average = Phi / numrows;
% Phi = average;