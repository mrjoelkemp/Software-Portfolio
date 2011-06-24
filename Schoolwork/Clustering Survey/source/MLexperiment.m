%Author: Joel Kemp
%Machine Learning Linear Regression Project Spring 2011
%File: MLexperiment.m
%Purpose: Uses the isolated testing set shape feature data to compute the
%weighted feature distance about image comparisons across the entire
%testing set, using the weights found in the regression experiments.

%Constants for the MPEG CE Shape Database
numGroups = 70;
numImagesPerGroup = 20;

%The number of features in our feature vectors
numFeatures = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load all test image group indices into a single matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load testIndicesGlobalAll;

% %Holds the entire list of test indices
% %Each group has 10 testing images, thus 10 * 70 total indices across dataset.
% testIndicesAll = zeros((numImagesPerGroup/2) * numGroups,1);
% counter = 1;
% 
% %For each group
% for i = 1:numGroups
%     %Load the group's image indices
%     filename = strcat('testInd', num2str(i));
%     %Load the information from the matrix file
%     load(filename, 'testingIndices');
%         
%     %Get the training image indices within the dataset to get the images
%     curGroup = (i-1) * numImagesPerGroup;
% 
%     %Convert from local (group) index to global (dataset) index based on
%     %curGroup value to get the *actual* image indices
%     testingIndices = testingIndices + curGroup;
%     
%     numInds = numel(testingIndices);
%     %Where is the last place to store in the matrix.
%     %We subtract 1 to avoid trying to store 11 elements instead of 10
%     stopindex = (counter + numInds) - 1;
%     %Store the indices as a column vector within testIndicesAll
%     testIndicesAll(counter:stopindex,1) = testingIndices;
%     counter = counter + numInds;
%     
% end
% 
% %Save the massive list of global (dataset-wide) testing image indices
% filename = 'testIndicesGlobalAll';
% save(filename, 'testIndicesAll');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load all features into a single matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%We need to load all of the features into a single matrix since we're
%computing comparisons across the entire testing set, not just individual
%groups.
load testFeaturesAll;
% %Holds all of the testing set feature vectors
% testFeaturesAll = cell(20000, 1);
% counter = 1;
% %For each group
% for i = 1:numGroups
%     %Load the group's features
%     filename = strcat('testFeatures', num2str(i));
%     %Load the information from the matrix file
%     load(filename, 'testingFeatures');
%     
%     %Store the training data into the trainingDataAll list
%     for j = 1:numel(testingFeatures(:,1))
%         %Store the row
%         testFeaturesAll(counter,:) = testingFeatures(j,:);
%         %Increment the next storage position
%         counter = counter + 1;
%     end
%     
% end
% %Clean up the arbitrarily large matrix
% testFeaturesAll(all(cellfun(@isempty, testFeaturesAll), 2),:) = [];
% 
% %Save the massive list of training data
% filename = 'testFeaturesAll';
% save(filename, 'testFeaturesAll');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generate the combinations about all feature indices within testFeaturesAll
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
combs = nchoose2(1:numel(testFeaturesAll(:,1)));
%Create an NxN matrix where N is the total number of images whose feature
%vectors will be compared.
%Note: testFeaturesAll contains cell matrices, not the individual shapes as
%rows, so we can just use the number of elements in testFeaturesAll to get
%the number of images in the testing set.
testDistanceMatrix = zeros(numel(testFeaturesAll(:,1)));

%For each combination
for i = 1:numel(combs(:,1))
    fprintf('Processing Comb %i of %i | ', i, numel(combs(:,1)));
    
    tic;
    %Cache the left and right combination image features
    m1 = testFeaturesAll{combs(i,1)};
    m2 = testFeaturesAll{combs(i,2)};
    
    %Compute the weighted feature distance
    [SM phi] = getSimilarityMatrix(m1, m2);
    
    %Store the WFD into a distance matrix
    testDistanceMatrix(combs(i,1), combs(i,2)) = phi;
    %Store the reverse indices to make it symmetric along the diagonal
    testDistanceMatrix(combs(i,2), combs(i,1)) = phi;
    toc;
end

%Save the massive list of weighted feature distances about all images 
%in the testing set.
filename = 'testDistanceMatrix';
save(filename, 'testDistanceMatrix');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Bullseye Score Computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load testDistanceMatrix;
%Get the sorted distance matrix
sortedDistanceMatrix = testDistanceMatrix;
for k=1:numImages
     %Sort the row
     sortedDistanceMatrix(k, :) = sort(sortedDistanceMatrix(k, :));
end
bullseye = getMLBullseyeScore(testDistanceMatrix, sortedDistanceMatrix);
fprintf('Bullseye Score = %f% | ', bullseye*100);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%