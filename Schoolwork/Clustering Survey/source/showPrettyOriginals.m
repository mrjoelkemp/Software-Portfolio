%Author: Joel Kemp
%Purpose: Modifies the default behavior of subplot to create more
%   publication-quality plots of images contained in the passed
%   image cell array. The number of columns within the plot are also
%   passed to the function.
%Notes: We want each subplot to take up the maximum (minus a space between 
%   subplots) percentage of the figure window.
function showPrettyOriginals(images, numColumns)
numImages = numel(images);
%numColumns = 6; 

%Space between the subplot is 5% of the figure window
% spaceBetween = 0.05;
% spaceBetween = 0;

%Compute the number of rows
numRows = ceil(numImages / numColumns);

%Resize all of the images to the same size
% for i = 1:numel(images)
%     images{i} = imresize(images{i}, [256 256]);
% end

%Plot all of the images
mysubimage(images, numRows, numColumns, [.01 .01]);

% %Pre-compute the desired subplot widths and heights
% subplotWidth = (1.0/numColumns) - spaceBetween;
% subplotHeight = (1.0/numRows) - spaceBetween;
% 
% %Subplot Position in the numRows x numColumns plot matrix
% position = 1;
% 
% figure
% %For each image in the list of images
% for k = 1:numImages
%     %Create a new subplot
%     h = subplot(numRows, numColumns, position);
%     %Increase the position counter for the next subplot
%     position = position + 1;
%     
%     %Get the position property of the subplot
%     p = get(h, 'pos');
%     %Set the width of the new plot
%     p(width) = subplotWidth;
%     %Set the height of the subplot
%     p(height) = subplotHeight;
%     
%     %Plot the current image in the list
%     imshow(images{k});
% end