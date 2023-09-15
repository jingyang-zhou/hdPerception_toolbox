% summarizing discriminability across representations, illustration.

% In this file, first I would generate two sets of representations, each
% consists of 3 discriminability ellipses (2-dimensional).

% Then I will (1) create summary statistics for discriminabilities in each
% representations, and (2) refer to how to compare across representations.

figLoc = '/Users/jyzhou/Library/CloudStorage/GoogleDrive-jyz205@nyu.edu/My Drive/gd_Projects/receptiveFieldDiscrimination/additionalFigures/';

%% create two representations

% Each representation consists of "n_references" number of ellipses sitting
% in the 3-dimensional space.

n_representations = 2;
n_references = 4;

rep{1} = [];
rep{2} = [];


for j = 1 : n_representations
    for k = 1 : n_references
        % make two-dimensional ellipses in 3 dimensional space:

        % generate random vectors and turn them into eigenvectors:
        eigen_vec = orth(rand(3, 3));
        eigen_val = diag([0.05 + [rand(1, 2) * 0.05], 0]);

        rep{j}.cov(k, :, :) = eigen_vec * eigen_val * eigen_vec';

        % make different means for the representation of each reference
        % image:
        rep{j}.mean(k, :) = rand(1, 3);
    end
end

%% visualize the ellipsoidal representations

figure (1), clf
for j = 1 : 2 % 2 representations
    subplot(1, 2, j),
    for k = 1 : n_references

        [x, y, z] = plotEllipsoid(squeeze(rep{j}.cov(k, :, :)));
        m = rep{j}.mean(k, :);

        surf(x + m(1), y + m(2), z + m(3), 'FaceAlpha', 0.5, 'EdgeColor', 'none'); hold on
    end
    xlim([-0.3, 1.2]), ylim([-0.3, 1.2]), zlim([-0.3, 1.2])
    xlabel('x'), ylabel('y'), zlabel('z')
    set(gca, 'fontsize', 16)
end

%printnice(1, 0, figLoc, 'comparison_illustration')

%% compute summary metrics

metric = {};

pairwise_idx = nchoosek(1 : n_references, 2);

% for each representation, we compare the within-representation difference
% between the ellipses. 

for j = 1 : n_representations
    for k = 1 : length(pairwise_idx)

        term1 = squeeze(rep{j}.cov(pairwise_idx(k, 1), :, :));
        term2 = squeeze(rep{j}.cov(pairwise_idx(k, 2), :, :));

        term11 = reshape(term1, 1, []);
        term22 = reshape(term2, 1, []);

        metric{j}.euclidean(k) = simpleCovarianceDistance(term11, term22, 'euclidean');
        metric{j}.sqrt(k) = simpleCovarianceDistance(term11, term22, 'sqrt');
        metric{j}.log(k) = simpleCovarianceDistance(term11, term22, 'log');

        % compute grassman distance, this metric gives us the difference
        % between subspaces
        %[u1, s1, v1] = svd(term1);
        %[u2, s2, v2] = svd(term2);
        %metric{j}.grassman(k) = grassmanDistance(u1, u2);
        metric{j}.grassman(k) = grassmanDistance(orth(term1), orth(term2));

        % compute differences among eigenvalues. 
        metric{j}.eigValDisparity(k) = eigenValueDisparity(term1, term2);

        % compute differences among the volumes of the ellipses
        metric{j}.volumeDisparity(k) = ellipsoidalVolumeDisparity(term1, term2);

    end
end

%% display distance measures

fprintf('\n')
fprintf(sprintf('Euclidean distance: %d, %d', median(metric{1}.euclidean), median(metric{2}.euclidean)))
fprintf('\n')
fprintf(sprintf('Sqrt distance: %d, %d', median(metric{1}.sqrt), median(metric{2}.sqrt)))
fprintf('\n')
fprintf(sprintf('Log distance: %d, %d', median(metric{1}.log), median(metric{2}.log)))
fprintf('\n')
fprintf(sprintf('Grassman distance: %d, %d', median(metric{1}.grassman), median(metric{2}.grassman)))
fprintf('\n')
fprintf(sprintf('Eigenvalue disparity: %d, %d', median(metric{1}.eigValDisparity), median(metric{2}.eigValDisparity)))
fprintf('\n')
fprintf(sprintf('Volume disparity: %d, %d', median(metric{1}.volumeDisparity), median(metric{2}.volumeDisparity)))
fprintf('\n')

