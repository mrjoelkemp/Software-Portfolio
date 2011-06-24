%Author: Joel Kemp
%Purpose: Outputs the original images with their decompositions
%   next to them in a presentable fashion.
%Notes:
%   1. Number of columns in the plot is the max number of
%   decompositions for a single original image.
%   2. Number of rows is the number of original images.
function showPrettyDecompositions(originals, decompositions, numDecompsList)

%Set the number of rows
numRows = numel(originals);
% numRows = 6;

%Set the number of columns
%We need enough columns to hold the max number of decompositions
%in addition to the column of original images!
%numColumns = max(numDecompsList) + 1;
%Add 1 for Original, add another for the colored sum image
numColumns = max(numDecompsList) + 2;   %New

%Set the number of images
numImages = numRows;

%Subplot Position in the numRows x numColumns plot matrix
position = 1;
%The new position for the next original image
nextOriginalPosition = 1;

%Create a new figure that will contain the subplots
figure;
    
%Generates different colors to be used with the plotting of the decomps
plotColors = ['y.' ; 'm.'; 'c.'; 'r.'; 'g.'; 'b.'; 'w.'; 'k.'];
plotColorsSymbols = [];
curSymbol = '.';
for p = 1:numel(plotColors);
    plotColorsSymbols = [plotColorsSymbols; strcat(plotColors(p), curSymbol)];
end

%For each image/row in the list of images
for k = 1:numImages
    %Plot the original image
    %Create a new subplot
    subplot(numRows, numColumns, position);

    %Plot the current image in the list
    imshow(~originals{k});
    %Set the title
    title('Original');
    position = position + 1;
    
    %Get the number of decomps for the current original image.
    numDecomps = numDecompsList(k);
    %Cache the list of decompositions for the current original.
    decompList = decompositions{k};
    
    %Plot the colored sum image
    %Color sum image is the sum of all decomps with a different color added
    %to each cluster in the plot.
    CSI = originals{k};
    subplot(numRows, numColumns, position);
    imshow(~CSI);
    hold on;
   
    %Index within the color symbol list. 
    %If |decompList{d}| > |plotColorsSymbols|, we cycle to the beginning
    count = 1;
    for d = 1:numDecomps
        curDecomp = decompList{d};
        if(d > numel(plotColors))
            count = 1;
        end
        [xs ys] = find(curDecomp == 1);
        %plot(xs, ys, plotColorsSymbols(count));
        plot(ys, xs, plotColors(count));
        count = count + 1;

    end;
    hold off;
    title('Summed');
    
    %Plot the decompositions for the current image
    for j = 1:numDecomps
        %Increase the position counter for the next subplot
        position = position + 1;
        %Create a new subplot
        subplot(numRows, numColumns, position);
        %Plot the current decomposition
        imshow(~decompList{j});
    end

    %Set the new position to be at the index for the next
    %original image. Previous starting position + the number of
    %columns
    nextOriginalPosition = nextOriginalPosition + numColumns;
    
    %At this point in the program, either we displayed enough
    %images to fill the columns, or we didn't have enough images.
    %In either case, we know that we've finished showing the
    %decompositions, so just move to the next original index!
    position = nextOriginalPosition;
end