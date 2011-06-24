%Author: Joel Kemp
%Purpose: Outputs the original images with the respective weighted 
%   distances sorted in ascending order from all other images in the 
%   training set in a presentable fashion.
%Precondition: mode is either 'ascend' or 'descend'
%Notes:
%   1. The isSorted paramter controls whether the output is sorted
%   based on ascending weighted distances.
function showPrettyWeightedDistances(numImages, images, distanceMatrix, isSorted, mode)
position = 0;
numRows = numImages;
numCols = numRows;

figure
%For every image in the set
for m1 = 1:numRows
    %Plot the original image
    position = position + 1;
    h = subplot(numRows, numCols, position);
    imshow(~images{m1});
    title('Original');

    %Get row of distances from other images for current image.
    dists = distanceMatrix(m1,:);

    %Create a map where keys are image indices and values are phi values 
    ks = 1:numImages;
    M = containers.Map(ks, dists);
    vals = cell2mat(values(M));

    %If the output should be in sorted ascending orde
    if (isSorted)   
        %Sort the (keys) phi indices in ascending order
        dists = sort(vals, mode);
    end

    %For each image
    for k = 1:numCols
        %Get phi value for that image pair
        phi = dists(k);
        %We want to find the unsorted key for the current
        % phi value. When we sort by value, the keys do not
        % retain the same correspondence. Hence, we need to look
        % to the unsorted value list to find the proper image
        % key.
        m2 = find(vals == phi);
        
        %Avoid showing yourself to prevent redundancy
        if phi ~= 0          
            %Increment position counter
            position = position + 1;            
            %Create the subplot
            h = subplot(numRows, numCols, position);
            %Show the image
            imshow(~images{m2(1,1)});
            %The title should be the Phi(m1, m2)
            title(phi);
        end
    end
end