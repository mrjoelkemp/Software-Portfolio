% Author: Joel Kemp
% Purpose: Segment an image using morphology and eigenanalysis.
% Returns: A list of the decompositions from structural elements.
% Notes:
%   1. RemoveSmallDecomps variable dictates if we should remove
%   the decompositions whose area is smaller than the threshold
%   of the original image.

function L = morphSegment(I0)
persistent it;  %Outputs the iteration number
if(isempty(it))
    it = 0;
else 
    it = it + 1
end

if(it == 380)
  fprintf('%s', 'Hoooold up!'); 
end

%Matrix of cells to hold the decomposed images
L = cell(25,1);

%Get the area of the image
I0area = getLargestArea(I0);

%Constant to represent 5 percent of parent's area.
threshold = .05;
%Area threshold -- using floor because we need a number of pixels that will
%be the threshold.
tarea = floor(I0area * threshold);

I0copy = I0;%Copy so we don't lose the contents of the original image
area = 1;   %Area of the image subtraction result.
count = 1;  %Counter for indexing in cell array

while (area > 0)
    %Get the radius that can open I0
    radius = getEigenOpenRadius(I0copy);
    %Open the original image
    I1 = getDiskOpenedImage(I0copy, radius);
    
    %Check if the opening results in numerous components
    CC = bwconncomp(I1);
    numComps = CC.NumObjects;
    %If we have more than one connected component
    if numComps > 1
        %For each component
        for j = 1:CC.NumObjects
            %Extract the component information
            cimage = ismember(labelmatrix(CC), j);
            
            %Store the component as a decomp
            L{count} = cimage;
            count = count + 1;
        end %end for
    %Otherwise, we only have one component in the image
    else
        %Get the area of the component
        carea = regionprops(I1, 'Area');
        %If the area of the component is larger than the
        %area threshold.
        if(carea.Area >= tarea)
            %Store the decomposition
            L{count} = I1;
            %Increment the count
            count = count + 1;
        end %end if
    end %end if

    %Compute the image subtraction of original - (unseparated) decomposition
    I0copy = I0copy - I1;
    %imshow(I0copy);
    
    %Remove small objects with areas smaller than area threshold
    I0copy = bwareaopen(I0copy, tarea);
    %imshow(I0copy);
    
    %Compute the area of the subtraction
    Iarea = regionprops(I0copy, 'Area');
    
    %If the area struct is empty, then the area doesn't exist (is zero)
    if(isempty(Iarea))
        area = 0;
    %Otherwise
    else
        %Get the area
        area = getLargestArea(I0copy); 
    end
end

%Get the number of non-empty cells
cols = sum(~cellfun('isempty', L));
%Remove empty columns
L(cols+1:end) = [];

%Purpose: Computes the largest area of an image (which may have more than one
%connected component).
%Returns: The largest area out of all of the connected components.
function A = getLargestArea(I0)
%Used for component thresholding
I0AreaObj = regionprops(I0, 'Area');
numObjs = numel(I0AreaObj);
for k = 1:numObjs
    if(I0AreaObj(k,1).Area > largestArea)
        A = I0AreaObj(k,1).Area;        
    end
end

%Author: Joel Kemp
%Purpose: Performs an eigenanalysis on the passed image to compute an 
%    initial radius for performing morphological opening.
%Returns: The initial radius that yields at least 1 connected
%    component.
function R = getEigenOpenRadius(I0)
%Get the length of the major axis that spans the object
lengthMajor = regionprops(I0, 'MajorAxisLength');
%Initialize the radius to the length of the major axis
radius = lengthMajor.MajorAxisLength;
%The number of connected components found in the image
numObjects = 0;
%If we haven't found any components, then our radius is too large
while (numObjects <= 0)
   %Change the size of the radius
   radius = floor(radius / 2);
   %Reopen the image
   I1 = getDiskOpenedImage(I0, radius);
   %Compute the number of connected components
   CC = bwconncomp(I1);
   numObjects = CC.NumObjects;
end

R = radius;

%Author: Joel Kemp
%Purpose: Opens an image m with a disk constructed from radius r.
%Preconditions: m = image; r = radius.
%Returns: The resulting opened image.
function I = getDiskOpenedImage(m, r)
%Create a structural element of the found radius
%The constant 8 is the approximation of the structural element.
disk = strel('disk', r, 8);
%Open the original image
I = imopen(m, disk);