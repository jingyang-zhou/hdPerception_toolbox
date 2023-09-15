function distance = ellipsoidalVolumeDisparity(cov1, cov2)

%% useful function

positive_terms = @(x) x(x > 0);

%%

[U1, S1, V1] = svd(cov1);
[U2, S2, V2] = svd(cov2);

s1 = positive_terms(diag(S1));
s2 = positive_terms(diag(S2));

%% compute difference in volumes

vol1 = sqrt(prod(s1));
vol2 = sqrt(prod(s2));

distance = abs(vol1 - vol2);



end