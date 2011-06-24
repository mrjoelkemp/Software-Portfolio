%Author: Joel Kemp
%File: getMLBullseyeScore.m 
%Purpose: Computes the bullseye score about a distance matrix where the
%MPEG7 dataset has been split into a training and testing set. This reduces
%the actual numbers used in the computation by half.

function B = getMLBullseyeScore(distanceMatrix, sortedDistanceMatrix)

%Initialize the output
B = 0;

%The number of images
numImages = numel(distanceMatrix(:,1));

%Load the indices of all of the training images used.
load testIndicesGlobalAll;

