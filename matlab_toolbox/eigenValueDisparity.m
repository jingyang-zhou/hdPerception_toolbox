function [distance, difference] = eigenValueDisparity(cov1, cov2)
% compute the difference in eigen-values between two covariance matrices

%% 

[U1, S1, V1] = svd(cov1);
[U2, S2, V2] = svd(cov2);

s1 = diag(S1);
s2 = diag(S2);

%% normalize eigenvalues

vol1 = sqrt(prod(s1(s1 > 0)));
vol2 = sqrt(prod(s2(s2 > 0)));

s1 = s1 ./vol1;
s2 = s2 ./vol2;

%% compute distance

difference = s1 - s2;
distance = sqrt(sum((s1 - s2).^2)); % norm of the difference vector


end