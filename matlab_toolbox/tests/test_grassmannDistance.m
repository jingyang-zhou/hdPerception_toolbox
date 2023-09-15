% grassman distance_test

% There are multiple ways to find the orthogonal bases for a subspace,
% which way works, and which way is better?

%% simple example 1

simp = [];
% two sub-spaces that are aligned
simp.cov{1} = [2, 0, 0; 0, 1, 0; 0, 0, 0];
simp.cov{2} = [2, 0, 0; 0, 3, 0; 0, 0, 0];
simp.cov{3} = [1, 0, 0; 0, 0, 0; 0, 0, 2];

% The first two matrices should share the same subspace, and both of which
% are orthogonal to the third matrix. 

%% computing distances using svd eigenvectors as bases

[b1, b2] = mk_orth_basis(simp.cov{1}, simp.cov{2}, 'svd');
distance = grassmanDistance(b1, b2)

[b1, b2] = mk_orth_basis(simp.cov{1}, simp.cov{3}, 'svd');
distance = grassmanDistance(b1, b2)

[b1, b2] = mk_orth_basis(simp.cov{2}, simp.cov{3}, 'svd');
distance = grassmanDistance(b1, b2)

%% c

[b1, b2] = mk_orth_basis(simp.cov{1}, simp.cov{2}, 'orth');
distance = grassmanDistance(b1, b2)

[b1, b2] = mk_orth_basis(simp.cov{1}, simp.cov{3}, 'orth');
distance = grassmanDistance(b1, b2)

[b1, b2] = mk_orth_basis(simp.cov{2}, simp.cov{3}, 'orth');
distance = grassmanDistance(b1, b2)

%% now check if in general, the two methods provide the same grassmann distance

arb = [];
for k = 1 : 2
    eigen_vec = orth(rand(3, 3));
    eigen_val = diag([0.05 + [rand(1, 2) * 0.05], 0]);
    arb.cov{k} = eigen_vec * eigen_val * eigen_vec';
end

% compute grassmann distance
[b1, b2] = mk_orth_basis(arb.cov{1}, arb.cov{2}, 'orth');
distance = grassmanDistance(b1, b2)

[b3, b4] = mk_orth_basis(arb.cov{1}, arb.cov{2}, 'svd');
distance = grassmanDistance(b3, b4)


%% orthogonal basis 1: qr, function "orth" and eigenvectors from svd

function [basis1, basis2] = mk_orth_basis(cov1, cov2, method)

count = @(x) sum(abs(x)>1e-6);

switch lower(method)
    case "qr"
        [basis1, R1] = qr(cov1);
        [basis2, R2] = qr(cov2);

        % this is not ideal, "basis_i" does not give an orthogonal basis
        % for the subspace
    case "orth"
        basis1 = orth(cov1);
        basis2 = orth(cov2);

        % this can also work

    case "svd"
        [U1, S1, basis1] = svd(cov1);
        [U2, S2, basis2] = svd(cov2);
        %S1,S2
        
        term1 = count(diag(S1));
        term2 = count(diag(S2));

        basis1 = basis1(:, 1 : term1);
        basis2 = basis2(:, 1 : term2);

    otherwise
        warning("method for making orthogonal basis is not recognizable.")
end
end

%% orthogonal basis 2: function "orth"

%% orthogonal basis 3: eigenvectors from svd

%% compute grassmann distance