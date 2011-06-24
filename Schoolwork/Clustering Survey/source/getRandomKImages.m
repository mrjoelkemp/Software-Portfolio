%Purpose: Selects a random choice of k images from the passed dataset.
%Preconditions: k is a non-zero positive integer.
%               images is an Nx1 cell matrix.
%Returns: An Nxk cell matrix of images from the passed images array.
%         The random indices generated.
%Note: We retrieve a random selection of images to prevent
%   overfitting our models to the same selection of images.
function [IMAGES rands] = getRandomKImages(images, k)
%Generate k random integers between 1 and 1400
rands = randi(1400, [k 1]);
%Return the random selection of images.
IMAGES = images(rands);


%TODO: find a way to grab at least 2 images from the same group.
%Otherwise, we have no way to really judge if the known matches
%are coming up as the closer images.