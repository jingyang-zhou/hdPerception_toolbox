% plot ellipses

% In this file, we plot ellipses using a covariance matrix.

function [x1, y1] = plotEllipse(C, areaNormalizeFlag)

% INPUTS ----------------------
% C:  a two-dimensional covariance matrix
% areaNormalizeFlag: whether I want to normalize the area of the ellipse.
%     "1" for making the ellipse area 0, "0" for no normalization

% OUTPUTS ---------------------
%

%% compute SVD of the covariance matrix

[U, S, V] = svd(C);

% normalize the area of the ellipse
switch areaNormalizeFlag
    case 1
        S = S ./sum(diag(S));
    case 0
    otherwise
        warning('areNormalizeFlag value is not recognizable.')
end

%% prep for plotting

n_samples = 100;

s = linspace(-pi, pi, n_samples);
x = sin(s);
y = cos(s);

%% making ellipse

epsilon = [x.*sqrt(S(1, 1)); y.*sqrt(S(2, 2))];

x1 = U(1, :) * epsilon;
y1 = U(2, :) * epsilon;

end






