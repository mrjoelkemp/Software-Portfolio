%Author: Joel Kemp
%Purpose: Trains linear regression parameters/weights based on
%   training data.
%Notes:
%   Notice how we don't pass in a polynomial degree d. The degree is
%   evident from the number of columns (number of features) in the passed
%   data matrix. If we were modeling each column, then we would need a
%   degree.
%Preconditions:
%   1. data is a nonempty Nx1 numeric vector
%Returns: A set of optimal weights for the passed data.
function W = regressionWeights(data, targets)
%Get the number of rows in the first column to represent the
%total number of data points in the data matrix
N = numel(data(:,1));

%Create an NxD matrix from the data
% X = zeros(N,d);
X = data;

%Add a column of ones to the left of the array so that we can
%generate a w0 for polynomial evaluation.
X = [ones(N,1) X];

%Get the transpose of X
XT = X.';

%Compute the weight vector.
%Note: The \ operator is a faster way to evaluate the expression:
%   inv(XT * X) * (XT)
W = (XT * X) \ (XT * targets);