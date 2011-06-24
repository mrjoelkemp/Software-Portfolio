%Author: Joel Kemp
%Purpose: Performs linear regression with a d-th degree polynomial and 
%   computes the mean squared errors with L2-regularization paramater lamba
%   for both the training and testing sets. The training and
%   testing set errors are printed to the console.
%Preconditions:
%   1. d > 0
%   2. lambda >= 0
%   3. trainingFile is a string indicating the filename
%   containing the training data.
%   4. testingFile is a string indicating the filename 
%   containing the testing data.
function LinearRegression(trainingFile, testingFile, d, lambda)
%Supress the warning about matrix inversions
warning('off', 'MATLAB:nearlySingularMatrix');

%Open the training and testing files
train = csvread(trainingFile);
test = csvread(testingFile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate & Evaluate Model on Training Set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Training Data and targets
trainData = train(:, 1);
trainTargets = train(:, 2);

%NOTE: The parameters d and lambda, if passed as program parameters in the
%command window, will come in as strings. We must ensure that
%they are of type double for the system's computations.

%Ensure that the pass parameter is a double.
if(~isa(d, 'double'))
    d = str2double(d);
end
%Ensure that lambda is a double.
if(~isa(lambda, 'double'))
    lambda = str2double(lambda);
end

%Get the weights for the regression polynomial of 
%degree d on the training data.
W = regressionWeights(trainData, trainTargets, d);
%Fit the data points to the polynomial
trainY = fitDataToPolynomial(trainData, W);
%Get the regularized squared error for the d-degree polynomial
trainError = evaluateRegressionModel(trainY, trainTargets, W, lambda);
%Normalize the training error
trainError = trainError / numel(trainY(:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evaluate Training Model on Testing Set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Training Data and targets
testData = test(:, 1);
testTargets = test(:, 2);

%Fit the data points to the polynomial modeled after the training data
testY = fitDataToPolynomial(testData, W);
%Get the regularized squared error for the d-degree polynomial
testError = evaluateRegressionModel(testY, testTargets, W, lambda);
%Normalize the testing error
testError = testError / numel(testY(:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output the Training and Testing Errors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('%f, %f \n', trainError, testError);