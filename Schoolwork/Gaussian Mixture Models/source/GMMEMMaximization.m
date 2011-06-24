%Author: Joel Kemp
%File: GMMEMMaximization.m
%Purpose: Recomputes the model parameters based on the assignment scores
%   passed in the scores matrix. 
%Returns: The modified model parameters.
function [means, covariances, mixtureCoeffs] = GMMEMMaximization(X, m, scores, means, covariances, mixtureCoeffs)
N = numel(X(:,1));
%For each cluster, compute the new mean and covariance
for k = 1:m
    %%%%%%%%%%%%%%%%
    % Compute New Mean
    %%%%%%%%%%%%%%%%
    clusterScores = scores(:, k);
    %Compute the cluster's scores * datapoints
    nkx = 0;
    for j = 1:N
        curScore = clusterScores(j,1);
        p = X(j,:);
        nkx =  nkx + (curScore * p);
    end
    %Sum up the current cluster's column of scores
    nk = sum(clusterScores); 
    
    %Store the new mean
    means(k, :) = nkx / nk;
    
    %%%%%%%%%%%%%%%%
    % Compute New Covariance
    %%%%%%%%%%%%%%%%
    %Reset sum
    nkx = 0;
    for j = 1:N
        curScore = clusterScores(j,1);
        p = X(j,:);
        %Compute X - mu(x)
        deltaX = (p - means(k,:));
        xxp = deltaX' * deltaX;
        nkx =  nkx + (curScore * xxp);
    end
    
    %Store the new covariance
    %Note: the result of the previous computation is a scalar, however, we
    %have been dealing with 1xm covariance matrices, so we replicate the
    %1x1 scalar result into both columns.
    sk = nkx / nk;
    %Copy sk into a 1x2 matrix
    %Covariance matrices are always 1x2 for each cluster
    covariances{k,:} = sk;
    
    %%%%%%%%%%%%%%%%
    % Compute New Mixture Coefficients
    %%%%%%%%%%%%%%%%
    mixtureCoeffs(k,1) = nk / N;
end