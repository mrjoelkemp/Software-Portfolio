%Author: Joel Kemp
%Purpose: For every image/row in the passed image (NxN) matrix, we
%   compute SIFT match distances for that image out of
%   the total dataset of images. 
%Returns: An NxK matrix containing the average SIFT descriptor distances
%   for each image.

%Notes: This allows us to narrow down the initial set of images
%   to use in our shape analysis. We tell the SIFT filtering
%   algorithm to return the closest 80 images for each image in the
%   dataset. We can then do a shape analysis to find the closest
%   40 images out of the filtered set to use in computing our
%   bullseye.
function SM = getSIFTMatches(images)
%Cache the total number of images
numImages = numel(images(:,1));

%Prepare matrix of image pair SIFT scores
SS = zeros(numImages);

%Get all unique pair combinations of the image index pairings
combs = nchoosek(1:numImages, 2);
%Get the left column as the set of image1 indices
i1s = combs(:, 1);
%Get the right column as the set of image2 indices
i2s = combs(:, 2);

%Get the list of images for each combination
i1List = images(i1s);
i2List = images(i2s);

%Get the average SIFT score for each image pairing and store the
%scores in the #combinations x 1 matrix
scores = cellfun(@getSIFTPairScore, i1List, i2List, 'UniformOutput', true);
%Remove (reset) the persistent var and global since we finished work.
clear it;

%Populate the output siftScores matrix
numCombs = numel(combs(:, 1));
for c = 1:numCombs
   %Get the current combination row [ind1, ind2]
   crow = combs(c,:);
   %Get the current SIFT score for that combination
   score = scores(c,1);
   %Store the score in the output matrix as two entries to make
   %the output matrix symmetrical about the diagonal
   SS(crow(1), crow(2)) = score;
   SS(crow(2), crow(1)) = score;
end
SM = SS;    %Debug

%Purpose: Computes the average distance score for SIFT descriptor matches
%between the two passed images I1 and I2.
%Precondition: We assume that ind1 and ind2 are cell arrays.
%Returns: The average SIFT distance score between the two images.
function S = getSIFTPairScore(I1, I2)
persistent it;
if(isempty(it))
    it = 0;
else 
    it = it + 1
end
%Grab the images from the image matrix
[I1 I2] = equalizeImageDimensions(I1, I2);
im1 = im2single(I1);
im2 = im2single(I2);

[fa, da] = vl_sift(im1);
[fb, db] = vl_sift(im2);

[matches, scores] = vl_ubcmatch(da, db);
numScores = numel(scores(1,:));

if(numScores == 0)
    %Return a small distance to indicate that there
    %were no matches. If we don't do this, then we'll get NaN as
    %the result of division by zero.
    S = 2;
else
    %S = sum(scores)/ numel(scores(1,:));
    S = mean(scores);
end

%Purpose: Pads the appropriate dimensions of each image to make
%them both equal in size.
%Returns: The equalized images in the order passed.
function [I1 I2] = equalizeImageDimensions(im1, im2)
I1 = im1;
I2 = im2;
%Get the image dimensions
[h,w] = size(im1);
[h2,w2] = size(im2);
if(h > h2)
    %Resize the first picture to equal the dimensions of the second
    I2 = imresize(I2, [h w]);
elseif(h2 > h)
    I1 = imresize(I1, [h2, w2]);
end