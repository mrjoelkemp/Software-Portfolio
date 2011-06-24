%Author: Joel Kemp
%Purpose: Evaluates the data points about the generated
%   polynomial specified by the weight vector.
%Preconditions: |weights| > 0
%Returns: An Nx1 vector consisting of the data points evaluated
%   on the polynomial determined by the passed weights.
function Y = fitDataToPolynomial(data, weights)
%Get the count of datapoints
N = numel(data(:,1));
%Prepare output vector
Y = zeros(N, 1);

%Determine the original degree of the polynomial
%Note: We subtract 1 because we want our computation to begin with 
%   weights(2) because weights(1) corresponds to
%   weight w0 -- which is not included in the summation.
D = numel(weights) - 1;
%Cache the first weight
w0 = weights(1);
%Remove w0 from the list of weights to exclude it from the
%summation.
weights(1) = [];

%For every data point in the data matrix
for c = 1:N
    %Cache the current data point
    x = data(c,1);
    %Vector of the data point raised to each power from 1 to D
    X =  x.^(1:D);
    %Tranpose the exponential data matrix to make multiplication easier
    XT = X.';
    %Evaluate the data point for each coefficient 
    y = weights .* XT;
    %Compute the y value for the current data point
    Y(c,1) = w0 + sum(y);
end