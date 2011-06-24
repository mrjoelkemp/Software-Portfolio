function DL = morphSegment3(I)

DL = getDecompositions(I);



%Purpose: Computes the decomposition of image I with a threshold value t to remove
%   generated decompositions with an area smaller than the threshold.
%Precondition: Threshold is the minimum number of pixels for a decomp.
%Returns: A cell matrix of all thresholded decompositions of I.
%Notes: This function is implemented in two phases. Phase 1 involves generating all
%   possible decompositions. 
function DL = getDecompositions(I)
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
%     I1 = imerode(I, strel('disk', radius, 8));
%     imshow(I1);
    %Open the original image 
    I1 = imopen(I, strel('disk', radius, 8));
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
%     imshow(I);

    %Find the initial radius to open I
%      radius = getInitialEigenOpenRadius(I);
    %Find the maximal initial radius
%      radius = getMaximalEigenOpenRadius(I, radius);
%     I1 = imclose(I, strel('disk', radius, 8));
%     imshow(I1);

    %Get the new area of the original
    area = getLargestArea(I);
end %end While

% %Remove decompositions that are smaller than the threshold
% %Get the areas of all the decomps
% areas = cellfun(@getLargestArea, DL, 'UniformOutput', true);
% %Remove the elements at those indices
% DL(areas < t) = [];

%Clean up the cell matrix since we made it arbitrarily large
DL(all(cellfun(@isempty, DL), 2),:) = [];


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