%Author: Joel Kemp
%Machine Learning Linear Regression Project Spring 2011
%File: MLregression.m
%Purpose: Uses the (summed shape or shape) isolated feature training data to 
%   construct a regression model of 5 (corresponding to the number of features) 
%   variables to compute a set of weights that can be used in the weighted feature
%   distance computation of the testing set.

%Constants for the MPEG CE Shape Database
numGroups = 70;
numImagesPerGroup = 20;

%The number of features in our feature vectors
numFeatures = 5;

%Holds all of the training data across all groups
%Since the training data captures the feature of all shapes of all training
%images, we need an arbitrarily large matrix to hold the data
trainingDataAll = zeros(20000, numFeatures);

%The next storage position for trainingDataAll
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load each group's shape training data into trainingDataAll
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load trainingDataAll;
% %For each group
% for i = 1:numGroups
%     %Load the group's shape training data
%     filename = strcat('trainingShapeData', num2str(i));
%     %Load the information from the matrix file into the var decomps
%     load(filename, 'trainingData');
%     
%     %Store the training data into the trainingDataAll list
%     for j = 1:numel(trainingData(:,1))
%         %Store the row
%         trainingDataAll(counter,:) = trainingData(j,:);
%         %Increment the next storage position
%         counter = counter + 1;
%     end
%     
% end
% %Clean up the arbitrarily large matrix
% trainingDataAll(counter:end,:) = [];
% 
% %Save the massive list of training data
% filename = 'trainingDataAll';
% save(filename, 'trainingDataAll');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load each group's image (not shape) training data into trainingDataAll
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %For each group
% for i = 1:numGroups
%     %Load the group's shape training data
%     filename = strcat('trainingData', num2str(i));
%     %Load the information from the matrix file into the var decomps
%     load(filename, 'trainingData');
%     
%     %Store the training data into the trainingDataAll list
%     for j = 1:numel(trainingData(:,1))
%         %Store the row
%         trainingDataAll(counter,:) = trainingData(j,:);
%         %Increment the next storage position
%         counter = counter + 1;
%     end
%     
% end
% %Clean up the arbitrarily large matrix
% trainingDataAll(counter:end,:) = [];
% 
% %Save the massive list of training data
% filename = 'trainingImageDataAll';
% save(filename, 'trainingDataAll');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the Regression Weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

targets = ones(numel(trainingDataAll(:,1)),1);
%Compute the optimal weights for the passed dataset. We are implicitly
%modeling this data with a degree-5 polynomial based on the number of
%columns in the training data matrix.
W = regressionWeights(trainingDataAll, targets);
%Save the regression weights for shape training data
filename = 'trainingShapeDataWeights';
save(filename, 'W');

