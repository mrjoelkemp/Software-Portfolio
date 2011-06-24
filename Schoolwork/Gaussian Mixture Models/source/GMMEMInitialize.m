%Author: Joel Kemp
%File: GMMEMInitialize.m
%Purpose: Performs Kmeans segmentation on the passed data matrix X with an 
%   initial number of clusters, m. The function then computes an initial set
%   of parameters (mean, covariance, and mixture coefficient) for each cluster.
%Returns: A list of the generated model parameters.
function [means, covariances, mixtureCoeffs] = GMMEMInitialize(X, m)
N = numel(X(:,1));
%Run k means on the dataset with m clusters
[idx, ~] = kmeans(X, m);

%Holds the statistics for each cluster
means = zeros(m, 2);            %Means
covariances = cell(m, 1);      %Covariances 2x2 matrices

%TODO: Double check the dimensions!!!!!
% covariances = zeros(m, m);      %Covariance disgonal (variance)
% covariances = zeros(2, 2);      %Covariance disgonal (variance)
mixtureCoeffs = zeros(m, 1);    %Mixture Coefficients

%Intialize the mixture model with the kmeans data
%For each cluster
for k = 1:m
      
    %Grab all of the indices for the current cluster
    rowNumbers = find(idx == k);
    
    %Grab the pixel locations for the current cluster
    members = X(rowNumbers, :);
    
    %Compute the mean of the members
    means(k,:) = mean(members);
   
    %Compute the covariance of the members
    covariances{k, 1} = cov(members, 1);
    %Grab the diagonal (variance) to make dimensions agree for pdf
%     covariance = cov(members,1);
%     covariances(k, :) = diag(covariance);
    
    %Compute the mixture coefficient for the current cluster
    %Note: mc = #points in current cluster / total points in dataset
    NK = numel(members(:,1));
    mixtureCoeffs(k, 1) = NK / N;
end