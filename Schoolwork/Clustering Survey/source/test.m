%Joel Kemp
%Shape Indexing of Digital Media

%Tell matlab to shush
warning off Images:im2bw:binaryInput
%Set the seed value to an arbitrary constant
% stream0 = RandStream('mt19937ar','Seed',10);
% RandStream.setDefaultStream(stream0);

%Clear the persistent variables
% clear all;

%load images;
% load decomps1400;
% load numdecomps1400;  %Only needed for outputting the decompositions
% load idealkgroups;    %Ideal k's for each group in dataset
%load imageshfavg;      %Images hole-filled and average-scaled
% load imageshfds256;     %Images hole-filled and downscaled to 256x256 
       
 
% Load all of the images in the current directory
curDir = pwd;
images = loadImagesFromDir(curDir, 'gif', false);
% save('imagespure', 'images');
% Fill in image holes!
images = getFilledImages(images);
% %Normalize the image dimensions
images = downscaleImages(images, 256);
% showPrettyOriginals(images, 6);
% showPrettyOriginals(images2);
% save('imageshf', 'images');
% %Normalize the image dimensions
% % images = normalizeImages(images);
% images = downscaleImages(images, 256);
% save('imageshfds256', 'images');

% [images rinds] = getRandomKImages(images, 5);
% d = morphSegment2(images{1}, 4);
% e = morphSegment2(images{2}, 8);
% D = cell(2, 1);
% D{1} = d;
% D{2} = e;
% nummorph = cellfun(@numel, D, 'UniformOutput', true);
% showPrettyDecompositions(images, D, nummorph);

%Cache the number of images
numImages = numel(images);
numGroups = 70;
% %The number of images per group in the dataset
imagesPerGroup = numImages / numGroups;

% load idealkall;
morphdecomp = cell(numImages,1);
waterdecomp = cell(numImages,1);
kmeansdecomp = cell(numImages,1);
morphRdecomp = cell(numImages,1);
gmmdecomp = cell(numImages,1);

idealkall = [7 5 5 6 9];
% idealkall = [2];
% load uselessdata;
% img = images{1};
% %Get the foreground point locations
% [xs ys] = find(img == 1);
% %Join the columns
% X = [xs ys];
% label = emgm(X', 7);
% spread(X',label);

for k = 1:numImages
%     %Morphological Segmentation w/ no reconstruction
%     d = morphSegment2(images{k}, idealkall(k));
%     %Make sure the loaded decomps matrix consists of all cells
%     if(isa(d, 'logical'))
%         morphdecomp{k, 1} = {d};
%     else
%         morphdecomp{k, 1} = d;
%     end
   
%    
%     w = watershedSegment(images{k});
%     %Make sure the loaded decomps matrix consists of all cells
%     if(isa(w, 'logical'))
%         waterdecomp{k, 1} = {w};
%     else
%         waterdecomp{k, 1} = w;
%     end
   
%     %Pure kmeans with user-supplied k
%     kd = MLKMeansSegment(images{k}, idealkall(k));
%     if(isa(kd, 'logical'))
%         kmeansdecomp{k, 1} = {kd};
%     else
%         kmeansdecomp{k, 1} = kd;
%     end
    
    %Gaussian Mixture Models with user-supplied k
    kd = MLGaussianMM(images{k}, idealkall(k));
    if(isa(kd, 'logical'))
        gmmdecomp{k, 1} = {kd};
    else
        gmmdecomp{k, 1} = kd;
    end
%     %Morphological Segmentation with reconst
%     dr = reconstructDecompositions(morphdecomp{k,1}, images{k});
%     morphRdecomp{k,1} = dr;  
end

% nummorph = cellfun(@numel, morphdecomp, 'UniformOutput', true);
% numwater = cellfun(@numel, waterdecomp, 'UniformOutput', true);
% nummorphr = cellfun(@numel, morphRdecomp, 'UniformOutput', true);
% numkmeans = cellfun(@numel, kmeansdecomp, 'UniformOutput', true);
numgmm = cellfun(@numel, gmmdecomp, 'UniformOutput', true);

showPrettyDecompositions(images, gmmdecomp, numgmm);
% showPrettyDecompositions(images, kmeansdecomp, numkmeans);
showPrettyDecompositions(images, morphdecomp, nummorph);
% showPrettyDecompositions(images, morphRdecomp, nummorphr);
% showPrettyDecompositions(images, waterdecomp, numwater);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Watershed Decomposition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% try
%     fprintf('%s\n', 'Watershed Decomposing all Images...');
%     tic;
%     %We are trying to save memory be processing chunks of the dataset, saving
%     %the results of each chunk in a separate MAT file.
%     %Intitialize the cell array to hold the decomps for the group
%     watershedDecomps = cell(imagesPerGroup, 1);
%     %For every group in the dataset
%     for j = 1:numGroups
%         %The current group number
%         %We are in the first group only when j = 0
%         curGroup = (j-1)*imagesPerGroup;
%         %For each image in the group
%         for k = 1:imagesPerGroup
%             %The actual image number in the entire dataset
%             imgInd = curGroup + k;
%             tic;
%             %Compute the set of cluster
%             %Store the set of found cluster in the group's set
%             d = watershedSegment(images{imgInd});
%           
%             %Make sure the loaded decomps matrix consists of all cells
%             if(isa(d, 'logical'))
%                 watershedDecomps{k, 1} = {d};
%             else
%                 watershedDecomps{k, 1} = d;
%             end
%             fprintf('Image %i | ', imgInd);
%             toc;
%         end
%         %At this point, we have the decomps for the group of images
%         %Save the current group of decompositions so we can load them up later
%         filename = strcat('watershedDecomps', num2str(j));
%         save(filename, 'watershedDecomps');
%     end
% catch exc
%     %If there's an error, play a sound!
%     [y,fs] = wavread('ping');
%     player = audioplayer(y, fs);
%     play(player);
%     throw(exc);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Morphological Decomposition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load idealkall;                     %Ideal k's for each image
% idealtall = zeros(numImages, 1);    %Ideal threshold for each image
% try
%     clear it;   %Clear persistent variable showing the iteration #
%     fprintf('%s\n', 'Decomposing all Images...');
%     tic;
%     %We are trying to save memory be processing chunks of the dataset, saving
%     %the results of each chunk in a separate MAT file.
%     %Intitialize the cell array to hold the decomps for the group
%     decomps = cell(imagesPerGroup, 1);
%     %For every group in the dataset
%     for j = 1:numGroups
%         %The current group number
%         %We are in the first group only when j = 0
%         curGroup = (j-1)*imagesPerGroup;
%         %For each image in the group
%         for k = 1:imagesPerGroup
%             %The actual image number in the entire dataset
%             imgInd = curGroup + k;
%             %Get the ideal k for the current image
%             ik = idealkall(imgInd);
% 
%             tic;
%             %Compute the set of decompositions
%             %Store the set of found decomps in the group's set
%             [d rk t]= morphSegment2(images{imgInd}, ik);
%           
%             %Make sure the loaded decomps matrix consists of all cells
%             if(isa(d, 'logical'))
%                 decomps{k, 1} = {d};
%             else
%                 decomps{k, 1} = d;
%             end
%            
%             fprintf('%i | %s %i | ', imgInd, 'Original Ideal K:', ik);
%             fprintf('%s %i | ', 'Revised Ideal K:', rk);
%             toc;
%             %Store the new idealk
%             idealkall(imgInd) = rk;
%             %Store the ideal threshold
%             idealtall(imgInd) = t;
%             
%             
%         end
%         %At this point, we have the decomps for the group of images
%         %Save the current group of decompositions so we can load them up later
%         filename = strcat('decomps', num2str(j));
%         save(filename, 'decomps');
%         
%         %TESTING
% %         numDecompsList = cellfun(@numel, decomps, 'UniformOutput', true);
% %         showPrettyDecompositions(images(1,20), decomps, numDecompsList);
%     end
%     %Save the revised ideakall to file.
%     save('idealkall', 'idealkall');
%     %Save the ideal thresholds
%     save('idealtall', 'idealtall');
%     %Remove from memory
%     clear 'idealkall', 'idealtall';
%     toc;
%     
% 
% catch exc
%     %If there's an error, play a sound!
%     [y,fs] = wavread('ping');
%     player = audioplayer(y, fs);
%     play(player);
%     throw(exc);
% end
% %Get the numbers of decompositions for all of the images
% numDecompsList = cellfun(@numel, decomps, 'UniformOutput', true);
% showPrettyDecompositions(images, decomps, numDecompsList);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Feature Vector Generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('%s\n', 'Generating all feature sets...');
% tic;
% features = cell(imagesPerGroup, 1);
% for j = 1:numGroups
%     curGroup = (j-1)*imagesPerGroup;
%     %Load the decomps for the current group
%     filename = strcat('watershedDecomps', num2str(j));
%     load(filename, 'watershedDecomps');
%     
%     %For each image decomposition set in the current group
%     for k = 1:imagesPerGroup
%        %Get the index of the set of decompositions.
%        imgInd = curGroup + k;
%        tic;
%        %Generate the feature vector for the current set of decomps
%        features{k, 1} = getFeatureVectors(watershedDecomps{k, 1}, images{imgInd});
%        fprintf('Image %i | ', imgInd);
%        toc;
%     end
%     %Remove the loaded decompositions for the current group
%     clear 'watershedDecomps';
%     %Generate the filename for the current features set
%     filename = strcat('watershedFeatures', num2str(j));
%     save(filename, 'features');
% end
% toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Similarity and Distance Matrix Generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We don't need the images to be in memory for these computations.
% clear 'images', 'features';

%Load up all of the feature vector sets so that we can compute the
%similarity matrix for every image (feature vector set) pairing.
% featuresSet = cell(numImages, 1);
% fprintf('%s\n', 'Loading all feature sets...');
% tic;
% for j = 1:numGroups
%     %Allows us to jump groups of size imagesPerGroup
%     curGroup = (j-1)*imagesPerGroup;
%     %Load the feature vector sets for the current group
%     filename = strcat('features', num2str(j));
%     load(filename, 'features');
%     for k = 1:imagesPerGroup
%         %The actual image number in the entire dataset
%         imgInd = curGroup + k; 
%         %Store each of the feature vectors as rows in the featuresSet
%         %matrix. We know the index of the image (feature set) in the
%         %dataset and in the featuresSet matrix from imgInd.
%         featuresSet{imgInd, 1} = features{k, 1};
%     end
%     %Clear the space since we don't need it anymore
%     clear 'features';
% end
% toc;
% 
% fprintf('%s\n', 'Generating All Combinations');
% % combs = nchoosekr_rec(1:numImages, 2);
% combs = nchoose2(1:numImages);
% numCombs = numel(combs(:,1));
% 
% fprintf('%s\n', 'Generating All Similarity Matrices and Distances');
% %We need to hold the similarity matrices for every possible image combo
% % similarityMatrices = cell(numCombs, 1);
% distanceMatrix = zeros(numImages);
% %For every possible combination of images
% for j = 1:numCombs
%     %Get the feature vectors for each set of combination indices
%     f1List = featuresSet{combs(j, 1)};
%     f2List = featuresSet{combs(j, 2)};
%    
%     tic;
%     %Get the similarity matrix and feature distance for the feature combo
%     [sm phi] = getSimilarityMatrix(f1List, f2List);
%     
%     %Get current combination row
%     p = combs(j,:);
%     distanceMatrix(p(1), p(2)) = phi;
%     distanceMatrix(p(2), p(1)) = phi;
%     fprintf('%i | phi(%i,%i) = %f | ', j, p(1), p(2), phi);
%     toc;
% end
% % save('similarityall', 'similarityMatrices');
% save('watershedDistanceall', 'distanceMatrix');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Bullseye Score Computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load distanceall;
% load watershedDistanceall;
% clear 'images';
% %Get the sorted distance matrix
% sortedDistanceMatrix = distanceMatrix;
% tic;
% for k=1:numImages
%      %Sort the row
%      sortedDistanceMatrix(k, :) = sort(sortedDistanceMatrix(k, :));
% end
% toc;
% tic;
% bullseye = getBullseyeScore(distanceMatrix, sortedDistanceMatrix);
% fprintf('Bullseye Score = %f% | ', bullseye*100);
% toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Plot originals %%%%%%%%
% showPrettyOriginals(images, numImages);
% showPrettyOriginals(images(1:40), 40);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%  Plot decompositions  %%%%%%%%
% showPrettyDecompositions(images, decomps, numDecompsList);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Plot the training set weighted distances %%%
%  showPrettyWeightedDistances(numImages, images, distanceMatrix, true, 'ascend');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Bullseye Score Computation %%%%%%%%%%%%%%%%%

%Get the sorted distance matrix
% sortedDistanceMatrix = distanceMatrix;
% for k=1:numImages
%     %Sort the row
%     sortedDistanceMatrix(k, :) = sort(sortedDistanceMatrix(k, :));
% end

% bullseye = getBullseyeScore(distanceMatrix, sortedDistanceMatrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%