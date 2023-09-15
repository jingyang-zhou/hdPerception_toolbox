% grassman distance

function distance = grassmanDistance(orthBasis1, orthBasis2)

% Grassman distance is a measure of difference between two sub-spaces. 
% Here, I use Grassman distance to compare the subspaces spanned by two
% sets of eigenvectors, one for each discrimination ellipsoid. I use this
% as a measure of how different the directions of two ellipsoids differ. 

% function distance = grassmanDistance(subspace1, subspace2, weightFlag)

% INPUTS :
% orthBasis1: an (p x n) matrix, n is the number of orthogonal vectors, and
%            p is the dimensionality of each vector. I assume the n vectors
%            are orthogonal to each other, because they are the
%            eigenvectors of a discrimination ellipsoid. 
% orthBasis2: same dimensionality as subspace1, a matrix that represents the
%            eigenvectors of the second discrimination ellipsoid. 


%% compute grassman distance

% % compute svd:
% 
[U, S, V] = svd(orthBasis1' * orthBasis2);

cos_thetas = diag(S)';
%diag(S)

thetas = acos(cos_thetas);

distance = sqrt(sum(thetas.^2));
% distance = acos(norm(orthBasis1' * orthBasis2));


end








% end