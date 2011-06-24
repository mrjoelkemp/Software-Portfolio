% Author: Joel Kemp
% Purpose: Generates the feature vectors for each image in the array L.
% Parameters: L = list of decompositions.
%             m = original image (union of decompositions).
% Returns: A list of feature vectors, one for each image in L.
% Notes:
%     Feature Vector Format:
%     [size, centroid, compactness, eccentricity]
% 
%     Size(Area): the scale-invariant number of pixels in the decomposition. 
%     Centroid: The translation and rotation invariant location of the centroid.
%     Compactness: The scale-invariant ratio of the size/area to the boundary.
%     Eccentricity: The ratio of eigenvectors  v1 / v2
function FVS = getFeatureVectors(L, m)
%Persistence to see how far we are
% persistent it;  %Outputs the iteration number
% if(isempty(it))
%     it = 0;
% else 
%     it = it + 1
% end

%Array to hold the feature vector list
FVS = cell(numel(L), 1);

%For each image in L
for k = 1: numel(L)
    %Cache the current image
    I = L{k};
    
    %Get the scale-invariant area of the decomposition
    area = getScaleInvariantArea(I, m);
    %Get the invariant centroid location
    centroid = getInvariantCentroid(I, m);
    compactness = getCompactnessRatio(I);
    eccentricity = getEccentricity(I);
    
    %Get the geometrical compactness
    geoCompactness = getGeometricalCompactnessRatio(I);

    FV = [area centroid compactness eccentricity geoCompactness];
    FVS{k} = FV;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Feature Generation Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Author: Joel Kemp
% Purpose: Compute the scale invariant area of a decomposition I in relation
%     to the original image m.
% Returns: The scalar scale-invariant area.
% Notes: 
%     We make the area of I scale-invariant by dividing its area
%     by the area of the original image m. This achieves a sort of 
%     area normalization in case image resolutions differ throughout
%     the system.
function SA = getScaleInvariantArea(I, m)

%Get the area objects of the two images
IAreaObj = regionprops(I, 'Area');
MAreaObj = regionprops(m, 'Area');

%Get the raw areas
IArea = IAreaObj.Area;
MArea = MAreaObj.Area;

%We make the area scale invariant by dividing this
% by the area of the original image.
SA = IArea / MArea;


% Author: Joel Kemp
% Purpose: Computes the scale, rotation, and translation invariant centroid location
%     of the decomposition I in relation to the original image m.
% Returns: The centroid location [x y].
% Preconditions: m is the original image
%                I is a single decomposition  
% Notes:
%     1. We make the centroid location translation invariant by only keeping
%     the distance between I's centroid and M's centroid.
%     2. We make the centroid location scale invariant by dividing each element 
%     by sqrt(Area(m)).  Why that?
%         -Alternative: Don't divide by the above function, just return the raw
%             centroid location. To achieve scale invariance, we can use the 
%             ratio of the centroid distances.
function C = getInvariantCentroid(I, m)

%Get the area of the image m
AreaObj = regionprops(m, 'Area');
area = AreaObj.Area;

%Get the centroids
ICentroidObj = regionprops(I, 'Centroid');
MCentroidObj = regionprops(m, 'Centroid');

%Get the raw centroid locations
ICentroid = ICentroidObj.Centroid;
MCentroid = MCentroidObj.Centroid;

%Return the positive normalized Euclidean distance as a tuple
centDiff = pdist2(ICentroid, MCentroid);
%centDiff = abs(ICentroid - MCentroid);
C = centDiff ./ sqrt(area);

% Author: Joel Kemp
% Purpose: Computes the elliptical eccentricity about the decomposition I.
% Returns: The scalar eccentricity (aspect ratio).
% Notes:
%     Eccentricity = sqrt(V1 / V2) where V1, V2 are eigenvectors 
%         of the region I.
%     We created this function thinking that we would have to do the manual
%     computation of the ration... Turns out, regionprops does it for us!
function E = getEccentricity(I)

ecc = regionprops(I, 'Eccentricity');
E = ecc.Eccentricity;


% Author: Joel Kemp
% Purpose: Computes the compactness ratio of the passed decomposition I.
% Returns: The scalar compactness ratio.
% Notes:
%     1. Compactness ratio = B/sqrt(Area(I))
%         -where B is the number of boundary pixels.
function CR = getCompactnessRatio(I)
%Make sure I is a BW image.
if (~isa(I, 'logical'))
    I = im2bw(I);
end

AreaObj = regionprops(I, 'Area');
%Get the raw area
area = AreaObj.Area;
%Get the boundary pixels; only account for the whole object, not the holes.
bpix = bwboundaries(I, 'noholes');
bpixList = bpix{1};
%The number of boundary pixels
B = numel(bpixList(:,1));
%Return the compactness
CR = B / sqrt(area);

%Author: Joel Kemp
%Purpose: Computes the geometrical compactness ration of the
%   passed decomposition I.
%Returns: The scalar geometrical compactness ratio.
%Notes: GCR = W / sqrt(Area(I))
%       -where W is the sum of binary zero (background) pixels
%       for each boundary pixel in I.
function GCR = getGeometricalCompactnessRatio(I)
%Get the area of the decomposition
AreaObj = regionprops(I, 'Area');
%Get the raw area
area = AreaObj.Area;
%Pad the matrix I by adding a border of zeros 
%Note: We do this to prevent handling border cases in the counting of
%   background pixels.
I = padarray(I, [2 2]);
%Get the boundary pixels; only account for the whole object, not the holes.
bpix = bwboundaries(I, 'noholes');
%Get the list of boundary pixels
bpixList = bpix{1};
%The number of boundary pixels
B = numel(bpixList(:,1));
%The sum of the boundary background pixel counts
W = 0;

%For each boundary point
for k=1:B
    %Get the count of neighboring background pixels
    W = W + getBackgroundNeighborCount(I, bpixList(k,:));
end
GCR = W / sqrt(area);

%Purpose: computes the number of background neighbors for the
%   passed boundary pixel.
%Returns: The scalar count of background neighbors for the passed
%   boundary pixel.
%Note: We use an 8 pixel neighborhood analysis.
%Precondition: We assume that the matrix I has been padded with
%   zeros around the borders, preventing any segmentation faults.
function C = getBackgroundNeighborCount(I, boundaryPix)
%Take the inverse of the image -- Background pixels will become
%foreground pixels.
Iinv = ~I;

%Grab the individual coordinates
x = boundaryPix(1, 1);
y = boundaryPix(1, 2);

%Grab the individual pixel values -- helps with debugging.
top = Iinv(x, y-1);
topL = Iinv(x-1, y-1);
topR = Iinv(x+1, y-1);
left = Iinv(x-1, y);
right = Iinv(x+1, y);
bottom = Iinv(x, y+1);
bottomL = Iinv(x-1, y+1);
bottomR = Iinv(x+1, y+1);

%Sum all the foreground pixels in the neighborhood to get the
%count of background neighbors for the given boundary pixel.
C = top + topL + topR + left + right + bottom + bottomL + bottomR;
