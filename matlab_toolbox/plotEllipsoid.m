 function [x_ellipsoid, y_ellipsoid, z_ellipsoid] = plotEllipsoid(cov)

% In this file, I plot ellipsoid from a covariance matrix. 

%% test

% cov = [3, 1, 1; 1, 2, 0.5; 1, 0.5, 1.5];
% cov = [1, 0, 0; 0, 0, 1; 0, 0, 0];

%% extract eigenvectors and eigenvalues from a covariance matrix

[eigen_vectors, eigen_values, V] = svd(cov); % extract eignevalues and eigenvectors from a covariance matrix

% scaling factor based on eigenvalues
scaling_factors = sqrt(diag(eigen_values));

%% generate points on a unit sphere

[u, v] = meshgrid(linspace(0, 2 * pi, 100), linspace(0, pi, 100));
x_unit_sphere = sin(v) .* cos(u);
y_unit_sphere = sin(v) .* sin(u);
z_unit_sphere = cos(v);

%% Scale the unit sphere along its principal axes

x_ellipsoid = scaling_factors(1) * x_unit_sphere;
y_ellipsoid = scaling_factors(2) * y_unit_sphere;
z_ellipsoid = scaling_factors(3) * z_unit_sphere;


% Rotate the ellipsoid using the eigenvectors
ellipsoid_points = eigen_vectors * [x_ellipsoid(:)'; y_ellipsoid(:)'; z_ellipsoid(:)'];

% Reshape the points
x_ellipsoid = reshape(ellipsoid_points(1, :), size(x_unit_sphere));
y_ellipsoid = reshape(ellipsoid_points(2, :), size(y_unit_sphere));
z_ellipsoid = reshape(ellipsoid_points(3, :), size(z_unit_sphere));


end