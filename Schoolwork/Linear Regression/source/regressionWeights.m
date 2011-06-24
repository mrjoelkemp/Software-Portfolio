%Author: Joel Kemp
%Purpose: Trains linear regression parameters/weights based on
%   training data, target values, and polynomial degree d.
%Preconditions:
%   1. data is a nonempty Nx1 numeric vector
%   2. targets is a nonempty Nx1 numeric vector
%   4. d > 0
%Returns: A set of optimal weights for the degree d polynomial.
function W = regressionWeights(data, targets, d)
%Get the number of rows in the first column to represent the
%total number of data points in the data matrix
N = numel(data(:,1));

%Create an NxD matrix from the data
X = zeros(N,d);

%For each measurement in the data matrix
for c = 1:N
    %Get the current data point
    x = data(c);
    %For each number from 1 to the degree d
    for j = 1:d
        %Generate x^i
        xi = x.^j;
        %Store the generated value
        X(c, j) = xi;
    end
end

%Add a column of ones to the left of the array so that we can
%generate a w0 for polynomial evaluation.
X = [ones(N,1) X];

%Get the transpose of X
XT = X.';

%Compute the weight vector.
%Note: The \ operator is a faster way to evaluate the expression:
%   inv(XT * X) * (XT * targets)
W = (XT * X) \ (XT * targets);