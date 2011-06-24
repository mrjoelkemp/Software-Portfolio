%Author: Joel Kemp
%Purpose: Sets the weights for each feature vector in the system.
%Returns: A list of weights for each feature vector.
%Notes: 
%   1. The order of weight definitions is the same as the order
%   in the feature vector.
%   2. Centroid is currently broken into separate x and y feature
%   entries. This means that the weight for the centroid should
%   be broken in half. We might be able to just add up the
%   centroid locations and apply the full weight.
%   3. Weights are randomly assigned by me. They might need to be
%   learned somehow!
function WS = getFeatureWeights()

%Load the weights from the regression experiments

%Weights for shape training data regression
load trainingShapeDataWeights;
%Weights for image (summed shapes) training data regression
% load trainingImageDataWeights;

%Remove w0
W(1) = [];
%Return the regression weights as a row vector
WS = W';

%Test Feature Weights: 23.12% Bullseye
% sizeW = 1;
% centroidW = 1;
% compactnessW = 1;
% eccentricityW = 1;
% geoCompactnessW = 1;

%Old Feature Weights
% sizeW = .25;
% centroidW = .10;
% compactnessW = .25;
% eccentricityW = .10;
% geoCompactnessW = .30;

% sizeW = 30;
% centroidW = 10;
% compactnessW = 30;
% eccentricityW = 10;
% geoCompactnessW = 20;

%Weights should be organized horizontally
% WS = zeros(1, 6);
% WS(1) = sizeW;
% %Centroid is split into two elements
% WS(2) = centroidW/2;
% WS(3) = centroidW/2;
% WS(4) = compactnessW;
% WS(5) = eccentricityW;
% WS(6) = geoCompactnessW;

% %Weights should be organized horizontally
% WS = zeros(1, 5);
% WS(1) = sizeW;
% %Centroid is split into two elements
% WS(2) = centroidW;
% WS(3) = compactnessW;
% WS(4) = eccentricityW;
% WS(5) = geoCompactnessW;

