% Author: Joel Kemp
% Purpose: Computes the distances between the combinations of feature vectors
%     and get a list of paired (similar) features.
% Returns: SM: A cell matrix of paired features from both images.   
%          Phi: The weighted feature distance between the two images.
% Parameters: m1 = Image 1's feature vectors as a cell array
%             m2 = Image 2's feature vectors as a cell array
% Notes:
%   1. We first do a weighted analysis of shapes to find the similar pairs
%   of shapes between the two images. We compute similarity from m1->m2 and
%   then m2->m1 to make the computation symmetric.
%   2. After the shapes have been paired off, we remove duplicate entries
%   from the pairing matrix. 
%   3. After the previous steps, we have a unique similarity matrix between
%   the images m1 and m2. We can then compute a weighted analysis of the
%   features in each row to get an overall weighted distance between the
%   two images. 
%   4. Computing the total weighted distance while comparing the shapes is
%   problematic because some of the pairs will be redundant and eliminated
%   during step 2.
function [SM Phi] = getSimilarityMatrix(m1, m2)
% %Outputs the iteration number
% persistent sit; 
% if(isempty(sit)) sit = 1
% else sit = sit + 1
% end

%Find pairs from m1's perspective
Pairsm1 = getFeaturePairs(m1, m2);
%Find pairs from m2's perspective
Pairsm2 = getFeaturePairs(m2, m1);

%Remove duplicates from m2
um2 = removeReversePairings(Pairsm1, Pairsm2);
%Remove duplicates from m1 with the cleaned m2
um1 = removeReversePairings(um2, Pairsm1);

%Concatenate the two outputs
SM = [um1; um2];

%Compute the weighted feature distance between each row in the similarity
%matrix generated above.
Phi = 0;
for k = 1:numel(SM(:,1))
    %For the current row, get the left fv
    x = [SM{k, 1}];
    %Get the right fv
    y = [SM{k, 2}];
    %Compute the distance between the two fvs
    d = weightedFeatureDistance(x, y, getFeatureWeights());
    %Add this to the total distance
    Phi = Phi + d;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Joel Kemp
% Purpose: Computes the pairs for the mapping of image m1 onto m2. 
% Returns: DS - The pairs of elements from m1 and m2.
%          
% Note: The pairs are from the perspective of m1. For each shape S within
%   m1, we find an S' in m2 with the smallest absolute feature difference. 
function DS = getFeaturePairs(m1, m2)

%Number of features in each image
m1size = numel(m1);
m2size = numel(m2);

%Distance matrix between elements of m1 and m2
largestSize = max(m1size, m2size);

%Initialize the pair list - as large as the numel in m1.
%Each row refers to a feature vector in m1
%Col 1 = m1's FV  Col 2 = m2I  i.e. m1k's matching FV from m2
DS = cell(m1size, 2);

%Dists is largestSize x largestSize
dists = zeros(largestSize);  %Initialize dimensions
dists(dists == 0) = 10000;   %Initialize matrix values since we'll be looking for the min

%Get the pre-defined feature vector weights
fweights = getFeatureWeights();

%Compare each shape of m1 to each shape of m2. Store the resulting
%distances in a matrix consisting of the distance of each shape comparison.

%For each (shape) feature vector in m1
for k = 1:m1size
    %Cache the current feature vector as numeric values
    x = [m1{k}];
    
    %For each (shape) feature vector in m2 
    for j = 1:m2size
        %Cache the current features from m2 as numeric
        y = [m2{j}];
        
        %Store the sum in the distance matrix
        dists(k,j) = weightedFeatureDistance(x, y, fweights);
    end
    
    %Find the minimum distance and index from dists for the
    %current feature
    curFeatureDistRow = dists(k, :);
    %Get the index of the smallest distance 
    %I corresponds to m1's matching feature index in m2
    [dist I] = min(curFeatureDistRow);

    %Save the feature pair [m1k, m2I]
    DS{k, 1} = x;       %m1k
    DS{k, 2} = m2{I};   %m2I
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Purpose: Computes the weighted feature vector distance between feature
%vectors fv1 and fv2.
%Preconditions: W is a weight vector where |W| = #system features
%Returns: The weighted distance scalar.
function D = weightedFeatureDistance(fv1, fv2, W)
%Compute the element-wise euclidean distance 
%Note: We keep the elements separate to keep the vector. If we pass the
%entire vectors to Pdist2, then it returns the distance between all
%elements as a single scalar -- eliminating the ability to use the weights.
fdistances = ones(1, numel(fv1));
for k = 1:numel(fv1)
    fdistances(1, k) = pdist2(fv1(k), fv2(k));
end
D = sum(fdistances .* W);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Joel Kemp
%Purpose: For each (i, j) pairing in m1p, remove the (j, i) duplicate
%   pairs in m2p.
%Returns: A list of m2p pairs with the reverse duplicates removed.
function ND = removeReversePairings(m1p, m2p)

%Get the list of reverse m1 pairings by flipping the columns from
%the left to the right.
rm1p = fliplr(m1p);

%Temporary copy of m2p
m2pcopy = m2p;
%Indicates elements of m2copy to be deleted
%Note: We can't directly delete duplicates because it causes the
%cells to shift upward and mess up further deletion.
m2d = zeros(numel(m2p(:, 1)), 1);

%For every row in m1p
for i = 1: numel(m1p(:, 1))
    %Join the cell columns for the current row
    rm1pm = [rm1p{i, 1} rm1p{i, 2}];
    
    for j = 1: numel(m2p(:, 1))
        %Join the cell columns for the current row
        m2pm = [m2p{j,1} m2p{j, 2}];
        %Get the list of matching elements
        ms = rm1pm == m2pm;
        %If the number of matching elements is equal to the
        %number of columns in the current row, then we have a
        %match.
        if (sum(ms) == numel(m2pm)) 
            %Mark the element for deletion
            m2d(j, 1) = 1;
        end
    end
end

%Delete the marked items
indices = m2d(:,1) == 1;
m2pcopy(indices, :) = [];

%Return the new m2p
ND = m2pcopy;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%