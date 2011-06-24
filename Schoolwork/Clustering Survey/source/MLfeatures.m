%Author: Joel Kemp
%Machine Learning Linear Regression Project Spring 2011
%File: MLTest.m
%Purpose: Splits the dataset into training and testing sets, generates 
%   the feature vectors for each set, computes the similarity matrix for
%   the training set of vectors of each image group, stores all of the 
%   generated data into MAT files, computes the isolated feature distances 
%   to be the training data used for Linear Regression modeling of feature 
%   distances.

%Turn off the warning about ensuring binary input for methods.
warning off Images:im2bw:binaryInput

%Set the seed value to an arbitrary constant so that the generated random
%numbers are the same for each execution of the program
RandStream.setDefaultStream(RandStream('mt19937ar','Seed',10));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setup and Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load the image data from a MAT file.
%Images hole-filled and downscaled to 256x256 
load imageshfds256;     

%Constants for the MPEG CE Shape Database
numGroups = 70;
numImagesPerGroup = 20;

%The number of features in our feature vectors
numFeatures = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute Feature Distances
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%NOTE:
%   We use indices local to the current group. Instead of computing where
%   we are in the dataset (aside from when we need the actual image for
%   feature generation), we just use local indices (1 to 20) for feature
%   storage and other computations.

%Holds the indices of the computed datasets
%We define them here for scoping purposes
trainingIndices = [];
testingIndices = [];
%For each group of images (apples, bats, etc)
for i = 1:numGroups
    fprintf('Processing Group %i\n', i);
    
    %Grab the set of morph decompositions for that group
    filename = strcat('decomps', num2str(i));
    %Load the information from the matrix file into the var decomps
    load(filename, 'decomps');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate numImagesPerGroup/2 non-repeating numbers corresponding to the
    % indices of the training set images in the group.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Get a random permutation of numbers 1 to 20
    R = randperm(numImagesPerGroup);
    %Grab only the first 10 numbers to be indices of the training set
    trainingIndices = R(1:10);
    %The rest of the permutations are the indices of the testing set
    testingIndices = R(11:20);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute the feature vectors for each image in the group
    % Get the features for both the training and testing sets
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Get the training image indices within the dataset to get the images
    curGroup = (i-1) * numImagesPerGroup;
    
    %Holds all of the generated features, we'll separate them afterward
    allFeatures = cell(numImagesPerGroup, 1);
    for j = 1:numImagesPerGroup
        %Compute the index of the image within the dataset
        imgInd = curGroup + j;
        %Set of decompositions for the image
        L = decomps{j};
        %The actual image in the dataset
        img = images{imgInd};
        %Compute and store the set of feature vectors for the training image.
        allFeatures{j} = getFeatureVectors(L, img);
    end
    
    %Holds the features for the training and testing indices
    trainingFeatures = cell(numImagesPerGroup/2, 1);
    testingFeatures = cell(numImagesPerGroup/2, 1);
    
    %Separate the features into their respective sets
    for j = 1:(numImagesPerGroup/2) %The size of the training and testing sets
        %Grab the features for the current training index and store
        trainingFeatures{j} = allFeatures{trainingIndices(j)};
        %Grab the features fot the current testing index and store
        testingFeatures{j} = allFeatures{testingIndices(j)};
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Store the generated data so that we can access the indices of the
    % training and testing sets corresponding to the features.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Store the training set indices for the current group
    filename = strcat('trainInd', num2str(i));
    save(filename, 'trainingIndices');
    
    %Store the testing set indices for the current group
    filename = strcat('testInd', num2str(i));
    save(filename, 'testingIndices');
    
    %Store the generated training set features for the training set
    filename = strcat('trainFeatures', num2str(i));
    save(filename, 'trainingFeatures');
    
    %Store the generated testing set features
    filename = strcat('testFeatures', num2str(i));
    save(filename, 'testingFeatures');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate all possible combinations of 
    % indices for the training set
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Generate all unique training image comparisons
    combs = nchoose2(trainingIndices);
       
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute the isolated, summed feature 
    % distances/differences for each combination of images 
    % in the training set
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Holds the next available storage position within fdists
    counter = 1;

    %Holds the complete list of isolated, summed feature differences for all
    %shapes of all images in the current group.
    %Note: We don't actually know how many shapes each image has, so we'll
    %declare an arbitrarily large list and clean it up at the end
    trainingData = zeros(2000, numFeatures);

    %For each combination of training image indices (index1, index2)
    for j = 1:numel(combs(:,1))
        %Holds the summed feature deltas for two images
        deltas = zeros(1, numFeatures);
        
        %Locate where the features are for the image indexed in the left
        %column of the current combination
        loc1 = find(combs(j,1) == trainingIndices);
        loc2 = find(combs(j,2) == trainingIndices);
        
        %Grab the respective features
        m1 = trainingFeatures{loc1};
        m2 = trainingFeatures{loc2};
        
        %Get the unweighted similarity feature pairing of the two images
        [SM ~] = getSimilarityMatrix(m1, m2);
        
        %For each row in the similarity matrix
        for k = 1:numel(SM(:,1))
            %Get the left and right feature vectors
            lfv = SM{k, 1};
            rfv = SM{k, 2};
            
            %ds is the absolute element-wise difference vector
            ds = lfv - rfv;
            %Note: 
            %   Squaring the elements makes them smaller values if less than 1
            %   and larger values if greater than 1. In turn, making the
            %   distance between similar shapes smaller and the distance 
            %   between dissimilar shapes larger.
            %   This is a nice effect!
            ds = ds .* ds;
            
            %Add the shape differences to the deltas vector
            %deltas = deltas + ds;
            %Don't sum the distances, just store them as is
            %Store the summed, isolated deltas as a row in the training data list
            trainingData(counter, :) = ds;
            %Increment the position of the next storage location
            counter = counter + 1;
        end
        % At this point, deltas contains the summed, isolated feature 
        % differences for images m1 and m2
        
%         %Store the summed, isolated deltas as a row in the training data list
%         trainingData(counter, :) = deltas;
%         %Increment the position of the next storage location
%         counter = counter + 1;
    end
    %Remove unused indices
    trainingData(counter:end,:) = [];
    
    %Store the training data so far
    filename = strcat('trainingShapeData', num2str(i));
    save(filename, 'trainingData');
end