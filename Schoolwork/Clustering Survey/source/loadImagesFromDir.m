%Author: Joel Kemp
%Purpose: Load all images from the passed directory into an array.
%Precondition: 
%       negative is a boolean determining if the images
%           should be negated.
%       fileExt is the 3-4 character file extension of the images
%           to load.
%Returns: The cell array containing all of the images.
function images = loadImagesFromDir(dirName, fileExt, negative)

%Change the current directory to the passed location
cd(dirName);
% gifFiles = dir('*.gif');
dirPath = ['*.' fileExt];
files = dir(dirPath);
%Working copy of the filenames
gifFiles = files;
numImages = numel(gifFiles);
%Convert the filenames to lowercase to avoid mis-sorting.
newFileNames = cell(numImages,1);
for k = 1:numImages
    gifFiles(k).name = lower(gifFiles(k).name); 
    
    %Look for the dash in the filename
    index = strfind(gifFiles(k).name, '-');
    %Look for the . indicating the file extension
    indexPeriod = strfind(gifFiles(k).name, '.');
    %Get the name of the object (apple, bat, etc)
    fileName = gifFiles(k).name(1:index-1);
    fileNumber = gifFiles(k).name(index+1:indexPeriod-1);
    fileExt = gifFiles(k).name(indexPeriod+1:end);
    %If the number after the dash is single digit
        numChars = numel(fileNumber);
        if(numChars == 1)
        	%Add a leading zero to fix sorting issues
            newFileNumber = strcat('0', fileNumber);
            %Append the dash
            newFileName = strcat(fileName, '-');
            %Append the new filenumber
            newFileName = strcat(newFileName, newFileNumber);
            %Append the file extension
            newFileName = strcat(newFileName, fileExt);
            %Save the revised filename
            gifFiles(k).name = newFileName;
        end
end
%Sort the files by filename (to retain directory ordering)
[A, order] = sort({gifFiles.name});
%Sort the original list of filenames according to our
%filename modifications and sorting.
files = files(order);

%Array to hold the original images from the dataset.
images = cell(numImages,1);

%Load all of the images in the current folder
for k = 1:numImages
    filename = files(k).name;
    m = imread(filename, fileExt);
    %Store the image data in the images array
    if(negative)
        images{k} = ~im2bw(m, 0);
    else
        images{k} = im2bw(m, 0);
    end
end