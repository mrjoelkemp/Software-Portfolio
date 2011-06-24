%Author: Joel Kemp
%Purpose: Computes the bullseye (accuracy) score for the system.
%Returns: The scalar bullseye score.
%Preconditions:
%   1. The sortedDistanceMatrix contains the row-sorted elements
%   of the distance matrix. This gives us the closest images for
%   every image along the y-dimension of the matrix.
%Notes:
%   1. We do not have annotations for each image to predetermine
%   its visually correct class. However, based on the ordering of
%   the dataset, each group of 20 images corresponds to a
%   visually correct grouping of the images in that set. 
%       -In the distance matrix, distanceMatrix(1:20, 1:20)
%       represents the comparisons of each image with the other
%       images in the same grouping. To skip between groupings,
%       we skip 20 rows and 20 columns in the distance matrix.
%   2. The bullseye scores computation: 
%       Every shape in the database is compared to all other shapes, 
%       and the number of shapes from the same class among the 40 most 
%       similar shapes is reported. The bull’s eye retrieval rate is the 
%       ratio of the total number of shapes from the same class to the 
%       highest possible number (which is 20 × 1400). Thus, the best 
%       possible rate is 100%.
function B = getBullseyeScore(distanceMatrix, sortedDistanceMatrix)

%Initialize the return value since we use it in the computation
B = 0;

%The number of images
numImages = numel(distanceMatrix(:,1));

%For each image
for k = 1:numImages
    %The number of matches for the current image
    matches = 0;
    
    %Grab the 40 closest distances
    %Note: Column 1 consists of all zeros (self-matching), 
    %   but that is still considered a match!
    dists = sortedDistanceMatrix(k, 1:40);
    
    %Find the image indices (within the distance matrix) for those 40
    %closest images.
    inds = zeros(1, 40);
    for j = 1:40
        %Cache the current sorted distance
        currentSD = dists(1, j);
        %Get the index for the current sorted distance in the
        %original (unsorted) distance matrix
        %Note: We want to find the first occurrence of the index!
        inds(1, j) = find(distanceMatrix(k,:) == currentSD, 1, 'first');
    end
    
    %Compute the image group for the current image
    %Since each group is of 20 images, we can compute the group
    %number as the integer division of the current image index
    %and 20. 
    %Example: k = 4; curImageGroup = 4/20 = 0.
    %Example: k = 23; curImageGroup = 23/20 = 1;
    %Example: k = 43; curImageGroup = 43/20 = 2;
    curImageGroup = idivide(int16(k), 20);
    
    %For each image index retrieved
    for i = 1:numel(inds)
        %Cache the current close image index
        curIndex = inds(i);
        %Compute the group membership for the current index
        curIndexGroup = idivide(int16(curIndex), 20);
        %If the image index is within the bounds of the correct group
        % for the current image
        if(curImageGroup == curIndexGroup)
            %Increment the match count
            matches = matches + 1;
        end
    end
    %Sum up the match count for each image
    B = B + matches;
end

%Bullseye = total sum of matches / total number of matches
B = B / (20*1400);