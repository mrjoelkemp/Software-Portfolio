%Purpose: Downscales all of the images in the passed cell matrix to be of
%dimensions dxd.
%Precondition: 0 < d < 512
%Returns: The downscaled cell matrix of images.
%Notes: The purpose of this downscaling is to reduce the space requirement
%for keeping all of the images in memory. 
function images = downscaleImages(images, d)
%Get the number of images in the set
N = numel(images(:,1));

%For all the images
for k = 1:N   
    images{k} = imresize(images{k}, [d d]);  
end