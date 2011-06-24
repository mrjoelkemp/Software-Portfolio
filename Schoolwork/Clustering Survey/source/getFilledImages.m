%Author: Joel Kemp
%Purpose: Removes holes from all of the images in the passed set.
function images = getFilledImages(images)

numImages = numel(images);

% Fill in image holes!
for k = 1: numImages
    curImage = images{k};
    filledIm = regionprops(curImage, 'FilledImage');
    images{k} = filledIm.FilledImage;
end