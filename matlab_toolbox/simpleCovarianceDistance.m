% This file calculates some simple distance metrics between two covariance
% matrices

function dist = simpleCovarianceDistance(cov1, cov2, metricKnob)

% INPUTS -------------------
% cov1 : the first covariance matrix
% cov2: the second covariance matrix, same dimensionality as the first one
% metricKnob: "euclidean", "sqrt", "log"

% OUTPU --------------------
% dist: distance metric

%% compute distance metric

switch lower(metricKnob)
    case "euclidean"
        term1 = cov1;
        term2 = cov2;

    case "sqrt"
        u1, s1, v1 = svd(cov1);
        u2, s2, v2 = svd(cov2);

        term1 = u1 * s1.^0.5 * v1;
        term2 = u2 * s2.^0.5 * v2;

    case "log"
        u1, s1, v1 = svd(cov1);
        u2, s2, v2 = svd(cov2);

        term1 = u1 * log(s1 + 1e-10) * v1;
        term2 = u2 * log(s2 + 1e-10) * v2;

    otherwise
        warning("Un-identified metricKnob")
end

dist = norm(term1(:) - term2(:));



end