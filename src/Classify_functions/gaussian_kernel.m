function [ mapped_observations ] = gaussian_kernel( x, sigma )
%gaussian_kernel Performs feature mapping using Gaussian similarity.
%   x is matrix of input vectors, where each row is one observation
%   and column corresponds to the feature

[obs, ~] = size(x);

% for each row in x calculate exp(-norm(x-xi)^2 / 2*sigma^2)
% for all i = 1:observations

replicate_rows = kron(x, ones(obs, 1));% replicates each row obs times
replicate_x = repmat(x, obs, 1);

difference = replicate_x - replicate_rows;
squared_diff = difference .^ 2; % norm = sum(xi^2)
norm = sum(squared_diff')';
fraction = norm ./ (2 * sigma * sigma);
fraction = -fraction;
new_features = exp(fraction);

mapped_observations = reshape(new_features, obs, obs);

end

