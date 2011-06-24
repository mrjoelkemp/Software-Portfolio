%Author: Joel Kemp
%Purpose: Performs morphological segmentation using non-overlapping maximal
%   disks and searches through a list of possible threshold values to find a 
%   clustering that yields a number of decompositions "very close" to k.
%Preconditions: k > 0
%Returns: DL: A cell matrix of k decompositions for the image I.
%         rk: The (revised) value of k that yielded the returned set of
%         decompositions.
%         thresh: The threshold value that yielded the returned DL and rk.
%Notes: 
%   1. Tackling the uniform thresholding problem will only affect the noise 
%   small-mass decompositions that result from image subtractions (I - I1). 
%
%   2. To truly improve segmentation, we must do better to find the initial radius
%   that leads to an optimal segmentation. If we start with a crude radius, then that
%   resulting decomposition is removed from the original -- further hindering the
%   other decompositions.
%
%   3. One way to improve the initial radius guessing is to use a
%   ballooning technique. This allows us to creep towards the optimal
%   initial radius by comparing the resulting number of decompositions and
%   seeing if we can get to an initial radius that yields k decompositions.
function [DL rk, thresh]= morphSegment2(I, k)

%TODO: Revise the function to take an ideal threshold parameter (if known)

% %Outputs the iteration number
% persistent it; 
% if(isempty(it)) it = 1
% else it = it + 1
% end

%Initialize the outputs just in case they aren't set.
if(k == 1)
    DL = I;
    rk = k;
    thresh = 0.15;
else
    DL = [];
    rk = k;
    thresh = 0.15;
end;

%The upper bound for the count of ideal clusters.
%We allow the system to give up to 30% (arbitrary) more clusters in 
%case the user's defined cluster count could not be attained.
kTol = ceil(.3*k) + k;

%Threshold vector: 15% to 1% of original image's area
%We basically threshold everything but the largest components and become
%more lax as the threshold decreases.
T = 0.15:-0.02:0.01;

%Get the threshold pixel counts with respect to the area
%of the original image
TA = T * getLargestArea(I);

%Look for the clustering that yields 0 < k < kTol clusters.
for j = 1:numel(TA)
    %The current threshold value from the list.
    t = TA(j);
    %Compute the thresholded decompositions
    D = getDecompositions(I, t);
    %Get the number of decompositions
    N = numel(D(:,1));
    
    %If the number of decomps is "around" (larger or equal to) 
    %the optimal number.
    if(N >= k && N <= kTol)
        %Store the decomposition set
        DL = D;
        %Store the N that yielded the found decompositions.
        %This could be different than the initial k
        rk = N;
        %Store the threshold that yielded the results above.
        thresh = T(j);
        %Stop looking for decompositions
        break;
    end
end

%If at the end of our search, we haven't found a decomposition,
% then our initial user-supplied k was too strict. We need to decrease that
% lower bound and try again.

%While we haven't reached 0 being the ideal cluster value and the number of
%decompositions found through our search is not zero
% while(k ~= 0 && numDecompsFound ~= 0)
while(isempty(DL) && k ~= 0)
    fprintf('%s\n', 'Going deeper!');
    %Decrease the lower ideal-k bound by 1 cluster and try again.
    [DL rk] = morphSegment2(I, k-1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Purpose: Obtains a single image that is the sum of the decompositions
%Returns: The image composed of all the decompositions in the passed cell matrix.
function I = getReconstructedImage(DLlist)
%Intitialize the output to the empty image of the same dimensions as the
%decompositions.
I = DLlist{0} - DLlist{0};

%The number of decomposition in the matrix
N = numel(DLlist(:,1));
for n = 1:N
    I = I + DLlist{n, 1};
end

%Purpose: Find the decomposition set with the most mass/cumulative area
%Returns: The decomposition set with the largest cumulative area
function DL = getLargestMassDecompositionSet(DLlist)
%Get the number of decomposition sets in the matrix
N = numel(DLlist(:,1));
%The largest cumulative area for a resulting set of decompositions
maximalArea = 0;

%Initialize the return matrix in case it isn't set for some reason.
DL = cell(1,1);
% ind = max(sum([DLlist{:,1}]));
% DL = DLlist(ind);
for k = 1:N
    %Grab a set of decompositions
    ds = DLlist{k,1};
    nds = numel(ds);
    areas = zeros(nds, 1);
    for j = 1:nds
        %Get the areas of all the decomps
        areas(j,1) = getLargestArea(ds{j,1});
    end
    %Compute the cumulative area
    cumulArea = sum(areas);
    %Store the largest cumulative area so far
    if(cumulArea > maximalArea)
        maximalArea = cumulArea;
        DL = ds;
    end
end


%Purpose: Computes the decomposition of image I with a threshold value t to remove
%   generated decompositions with an area smaller than the threshold.
%Precondition: Threshold is the minimum number of pixels for a decomp.
%Returns: A cell matrix of all thresholded decompositions of I.
%Notes: This function is implemented in two phases. Phase 1 involves generating all
%   possible decompositions. 
function DL = getDecompositions(I, t)
%Initialize the return cell matrix
%This states that an image should not have more than 100 decomps.
DL = cell(100,1);

%Get the initial area of the image
area = getLargestArea(I);
%Current index of the return cell matrix
count = 1;
%While the image is not empty
while (area > 0)
    %Find the initial radius to open I
    radius = getInitialEigenOpenRadius(I);
    %Find the maximal initial radius
    radius = getMaximalEigenOpenRadius(I, radius);
    %Open the original image 
    I1 = imopen(I, strel('disk', radius, 8));
%     I1 = imopen(I, STRELS{radius});
    %     imshow(I1);
    
    %Get the number of components in the decomposition
    cc = bwconncomp(I1);
    numComps = cc.NumObjects;
    %For each connected component
    for k = 1:numComps
        %Get an image of the component
        cimage = ismember(labelmatrix(cc), k);
        %Store the image as a decomposition
        DL{count} = cimage;
        count = count + 1;
    end
    
    %Subtract the decomposition (and its components) from the original
    I = I - I1;

    %Remove small objects with areas smaller than area threshold
    %Bwareaopen expects threshold as an int 
    I = bwareaopen(I, floor(t));
%     imshow(I);
    %Get the new area of the original
    area = getLargestArea(I);
end %end While

%Remove decompositions that are smaller than the threshold
%Get the areas of all the decomps
areas = cellfun(@getLargestArea, DL, 'UniformOutput', true);
%Remove the elements at those indices
DL(areas < t) = [];

%Clean up the cell matrix since we made it arbitrarily large
DL(all(cellfun(@isempty, DL), 2),:) = [];


%{
%Purpose: Removes elements of the passed cell matrix DL that contain an area smaller
%   than the passed threshold t.
%Precondition: t is the minimum number of pixels for a decomp.
%Returns: A cell matrix containing the thresholded list of elements.
function DL = thresholdDecompositions(DL, t)
%Get the areas of all the decomps
areas = cellfun(@getLargestArea, DL, 'UniformOutput', true);
%Find the indices of the areas smaller than the threshold
% inds = find();
%Remove the elements at those indices
DL(areas < t) = [];
%}

%Purpose: Computes the largest area of an image (which may have more than one
%   connected component).
%Returns: The largest area out of all of the connected components.
function A = getLargestArea(I)
%Get the area of the passed image
IAreaObj = regionprops(I, 'Area');
%If the area structure is empty
if(isempty(IAreaObj))
    %Return an area of zero
    A = 0;
%Otherwise
else
    A = max([IAreaObj(:,1).Area]); 
end

%Purpose: Performs an eigenanalysis on the passed image to compute an 
%    initial radius for performing morphological opening.
%Returns: The initial radius that yields at least 1 connected component.
function radius = getInitialEigenOpenRadius(I)
%Get the length of the major axis that spans the object
lengthMajor = regionprops(I, 'MajorAxisLength');
%Initialize the radius to the length of the major axis
radius = lengthMajor.MajorAxisLength;
%The number of connected components found in the image
numObjects = 0;

%If we haven't found any components, then our radius is too large
while (numObjects == 0)
   %Change the size of the radius
   radius = floor(radius / 2);
   %Reopen the image
   I1 = imopen(I, strel('disk', radius, 8));   
%    I1 = imopen(I, STRELS{radius});
   %Compute the number of connected components
   cc = bwconncomp(I1);
   numObjects = cc.NumObjects;
end

%Purpose: Computes the maximal radius that opens an image I.
%Returns: The maximal scalar radius.
%Notes: The ballooning technique employed in this function utilizes the fact that the
%   passed radius was obtained by halving the major axis length of the ellipse
%   enclosing image I, until I could be morphologically opened. To find an
%   upper bound for our ballooning, we find the previous radius before the
%   passed radius, in turn, the last radius that did not yield an opening.
function radius = getMaximalEigenOpenRadius(I, radius)
%The changing upper bound of the radius -- the old radius that yielded 
%the passed radius parameter. 
upperRadius = radius * 2;
%The changing lower bound of the radius
lowerRadius = radius;
%Initialize the midpoint to be the lower radius. This is a bit trivial,
%since the first computation is guaranteed to yield an opening, but it
%allows us to reach the loop's stopping condition
midpoint = lowerRadius;

%While the upper radius and midpoint haven't settled on the maximal location
while (upperRadius ~= midpoint)
   %Attempt to open the image with the midpoint
%    I1 = getDiskOpenedImage(I, midpoint);
   I1 = imopen(I, strel('disk', midpoint, 8));
   %Compute the number of connected components
   cc = bwconncomp(I1);
   numObjects = cc.NumObjects;
   
   %If we still have an opening result
   if(numObjects == 1)
       %Move the lower bound up to the midpoint
       lowerRadius = midpoint;
   %If we no longer have a result,
   else
       %Move the upper bound to the midpoint
       upperRadius = midpoint;
   end
   
   %Compute the midpoint between the two changing radii
   %If after the computation of the midpoint, the upper bound is equal to
   %the midpoint, then we've hit the boundary and can increase the radius
   %no longer. Hence, we've found the maximal radius.
   midpoint = ceil(mean([lowerRadius upperRadius]));
   
end

%Lower radius contains the maximal radius
radius = lowerRadius;


% %Purpose: Opens an image I with a disk constructed from radius r.
% %Preconditions: m = image; r = radius.
% %Returns: The resulting opened image.
% function I = getDiskOpenedImage(I, r)
% %The constant 8 is the approximation of the structural element.
% %Open the original image
% I = imopen(I, strel('disk', r, 8));


%{
%Purpose: Opens an image I with a square of a passed width.
function I = getSquareOpenedImage(I, width)
I = imopen(I, strel('square', width)); 
%}

%{
%Purpose: Removes unused cell elements from the passed cell matrix
%Returns: A cell matrix with unused elements removed.
function DL = removeUnusedElements(DL)
% %Get the number of non-empty cells
% cols = sum(~cellfun('isempty', DL));
% %Remove empty columns
% DL(cols+1:end) = [];
DL(all(cellfun(@isempty, DL), 2),:) = [];
%}