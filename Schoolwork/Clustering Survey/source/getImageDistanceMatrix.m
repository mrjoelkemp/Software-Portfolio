%Author: Joel Kemp
%Purpose: Return a matrix consisting of the images arranged in
%   ascending order based on the distances in the distance matrix.
%Returns: A matrix consisting of the image orderings that are
%   displayed in the plot. The returned results are not used for
%   anything but computing the bullseye score.
%Notes: This is similar to the output of showPrettyWeightDistances(),
%   but without the actual plotting.
function IM = getImageDistanceMatrix(numImages, images, distanceMatrix)
%Intitialize the return matrix: numImages x numImages
%Matrix has to be cell because of the different image resolutions
IM = cell(numImages);

position = 0;
%For every image in the set
for m1 = 1:numImages
    
    position = position + 1;
    %Store the original image in the return matrix
    IM{position} = images{m1};
    
    %Get row of distances from other images for current image.
    dists = distanceMatrix(m1,:);
    
    %Create a map where keys are phi values and values are image 
    %indices within the set of images  
%     M = containers.Map(dists, 1:numImages);
   
    %Map uses cell arrays but we need numeric to sort
%     kset = cell2mat(keys(M));
    ks = 1:numImages;
    M = containers.Map(ks, dists);
    kset = cell2mat(values(M));
    
    %If the output should be in sorted ascending orde  
    %Sort the (keys) phi indices in ascending order
    dists = sort(kset);
    
    %For each of the sorted keys (|keys| = numImages)
    for k = 1:numImages
        %Get phi value
        phi = dists(k);
        %Get index of image for that key
        %m2 = M(phi);
        m2 = k;
        %Avoid showing yourself to prevent redundancy
        if m1 ~= m2            
            %Increment position counter
            position = position + 1;            
                       
            %Store the image in the return matrix
            IM{position} = images{m2};
        end
    end
end