%Purpose: Outputs a matrrix where the first column contains the
%   list of original images and the other columns contain the
%   decompositions for each original image.
%Returns: The matrix of originals and decompositions.
%Notes: 
%   numDecompositionsList: Each original image could result 
%       in any number of decompositions, we require that a 
%       count of the number of decompositions be passed in for 
%       the set of original images. 
function IM = getImageDecompositionMatrix(originals, decompositions,...
    numDecompsList)

numRows = numel(originals);
numCols = max(numDecompsList);
numImages = numRows;

position = 1;
nextOriginalPosition = 1;

%Prepare output matrix
IM = cell(numRows, numCols);

for k = 1:numImages
    IM{position} = originals{k};
    numDecomps = numDecompsList(k);
    decompList = decompositions{k};
    
    for j = 1:numDecomps
        position = position + 1;
        IM{position} = decompList{j};
    end
    
    nextOriginalPosition = nextOriginalPosition + numCols;
    position = nextOriginalPosition;
end
    