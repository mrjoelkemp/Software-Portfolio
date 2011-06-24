%Purpose: Normalizes/Equalizes the dimensions of all of the
%   images in the dataset in a 2-pass process. The first pass finds
%   the maximum image dimensions (width and height) in the set, and the
%   second pass resizes each image to those extrema.
%Returns: The normalized set of images.
%Notes: 
%   1. The downside to this method is that it doesn't neglect the
%   background pixels. There are some images that have a lot of
%   background pixels.
function images = normalizeImages(images)
%Get the number of images in the set
N = numel(images(:,1));

%Pass 1: Find the extreme dimensions
largestW = 0;
largestH = 0;

%Compute the average dimensions about the dataset
sumW = 0;
sumH = 0;
%For all the images
for k = 1:N
    %Cache the current image
    curImage = images{k};
    %Width is the number of columns in the image
    curWidth = numel(curImage(1,:));
    %Height is the number of rows in the image
    curHeight = numel(curImage(:,1));
%     if(curWidth > largestW)
%         largestW = curWidth;
%     end
%     if(curHeight > largestH)
%         largestH = curHeight; 
%     end
    sumW = sumW + curWidth;
    sumH = sumH + curHeight;
end

avgW = sumW / N;
avgH = sumH / N;

%Pass 2: Resize all images to the extreme dimensions
% for k = 1:N
%     images{k} = imresize(images{k}, [largestW largestH]);   
% end

for k = 1:N
    images{k} = imresize(images{k}, [avgW avgH]);   
end
