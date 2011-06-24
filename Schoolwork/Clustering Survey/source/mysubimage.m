%Purpose: This function displays images tightly in the figure;
%   row by row starting from the first image to last image.
%Notes:
%   1. r and c are the number of rows and columns respectively.
% gaps are the gaps between columns and rows respectively.
% Default: gaps [] = [0.0015 0.0015]

function mysubimage (images, numRows, numCols, gaps)

%If the gaps list is empty
if (isempty(gaps))
    %Gaps are 2 percent by default
    gaps = [0.02 0.02];
end;

%Get the number of images
numImages = numel(images);
%Compute the width and height for the new subplot
width = (1.0 - numCols*gaps(1)) / numCols;
height = (1.0 - numRows*gaps(2)) / numRows;
%Subplot position within figure
position = 1;

figure
for i= 1:numRows
    %Set the bottom right position of the subplot
    bottom = 1.0 - height - (i-1)*(height + gaps(2)) - gaps(2);
    
    for j=1:numCols
        %Set the top-left position of the subplot
        left = (j-1)*(width + gaps(1));
        %Construct the new position property of the subplot
        pst = [left bottom width height];
        %Set the new position property
        subplot('position', pst);
        %Turn off the subplot axis
        axis off;
        %While we still have images to show
        if(position <= numImages)
            imshow(~images{position});
            position = position + 1;
        end
    end;
end;