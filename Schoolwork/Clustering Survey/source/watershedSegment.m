%Purpose: Performs watershed segmentation on the passed image and returns a
%cell matrix of clusters (connected components) of image I.
%Returns: A Kx1 cell matrix consisting of clusters of image I.
function DL = watershedSegment(I)
%This states that an image should not have more than 100 decomps.
DL = cell(100,1);

%Invert the image to get a more useful representation for watershed and apply
% a distance transform on that negated image.
DNI = bwdist(I, 'chessboard');

%Negate the distance transform result to get back the object and to get 
% a catchment basin for each potential cluster.
D = ~DNI;
%Perform watershed segmentation on the preprocessed image
L = watershed(D);

%Make the watershed line pixels into background pixels
I(L == 0) = 0;

%Current index of the return cell matrix
count = 1;

%Isolate the connected components 
cc = bwconncomp(I);
numComps = cc.NumObjects;
%For each connected component
for k = 1:numComps
    %Get an image of the component
    cimage = ismember(labelmatrix(cc), k);
    %Store the image as a decomposition
    DL{count} = cimage;
    count = count + 1;
end

%Clean up the cell matrix since we made it arbitrarily large
DL(all(cellfun(@isempty, DL), 2),:) = [];

% figure;
% set(gcf, 'Name', [method ' DT segmentation']);
% subplot(141);
% imshow(m);
% title('Original');
% subplot(142)
% imshow(DNI);
% title('DNI');
% subplot(143);
% imshow(D);
% title('D');
% subplot(144);
% imshow(I);
% title('I Segmented');