clear;
close all;




%% Section 1.4: Part 1

scale = 0.001; % Define the scale factor for the objects

N = 8; % This is the number of rays we want to graph

angles = linspace(-pi/20,pi/20, N); % Create a vector of all the ray angles we want to test

y = zeros(size(angles)); theta_y = zeros(size(angles));

x_1 = 0; x_2 = 10; % Starting x-coordinates for the two objects

d = 0.2; % defining the distance we are observing the rays traveling (in meters)

M_d1 = [1, d, 0, 0; % Creating the 3D ray-transfer matrix
        0, 1, 0, 0;
        0, 0, 1, d;
        0, 0, 0, 1];

rays_in_obj1 = [x_1 * scale * ones(size(angles)); % Make the 4 x N matrix for the first objects
                  angles;
                     y;
                  theta_y];

rays_in_obj2 = [x_2 * scale * ones(size(angles)); % Make the 4 x N matrix for the Second objects
                    angles;
                      y;
                    theta_y];

rays_out_obj1 = M_d1 * rays_in_obj1; % Calculating the resultant 
rays_out_obj2 = M_d1 * rays_in_obj2;

ray_z1 = [zeros(1, size(rays_in_obj1, 2)); d*ones(1, size(rays_in_obj1, 2))];
ray_z2 = [zeros(1, size(rays_in_obj2, 2)); d*ones(1, size(rays_in_obj2, 2))];

figure; hold on;

% sz_obj1 = size(object_1, 2);
% sz_obj2 = size(object_2, 2);
% Plot the rays for object 1
plot(ray_z1, [rays_in_obj1(1, :); rays_out_obj1(1, :)], 'Color', 'blue');
% Plot the rays for object 2
plot(ray_z2, [rays_in_obj2(1, :); rays_out_obj2(1, :)], 'Color', 'red');



%% Section 1.4: Part 2

figure; hold on

% Re-plot the rays from figure 1 so we can compare them in one figure like
% on the assignment

% Plot the rays for object 1
plot(ray_z1, [rays_in_obj1(1, :); rays_out_obj1(1, :)], 'Color', 'blue');
% Plot the rays for object 2
plot(ray_z2, [rays_in_obj2(1, :); rays_out_obj2(1, :)], 'Color', 'red');

d_2 = 0.5; 

f = 150 * scale; % Define lens focal length

r_lens = 20 * scale;

M_d2 = [1, d_2, 0, 0; % creating the 3D ray-transfer matrix for the second part
        0, 1, 0, 0;
        0, 0, 1, d_2;
        0, 0, 0, 1];

M_f = [   1,    0,    0,    0; % Creating the focal point transfer matrix
       (-1/f),  1,    0,    0;
          0,    0     1,    0;
          0,    0, (-1/f),  1];

M = M_d1 * M_d2 * M_f; % Calculating the entire transfer matrix

rays_in_obj1_new = rays_out_obj1(:, abs(rays_out_obj1(1,:)) <= r_lens); % filtering out the rays that didn't hit the lens using logical indexing
rays_in_obj2_new = rays_out_obj2(:, abs(rays_out_obj2(1,:)) <= r_lens);


rays_out_obj1_new = M * rays_in_obj1_new; % Basically same process as part one now
rays_out_obj2_new = M * rays_in_obj2_new;

ray_z1_new = [ray_z1(2, 1:size(rays_in_obj1_new, 2)); d_2 * ones(1, size(rays_in_obj1_new, 2))];
ray_z2_new = [ray_z2(2, 1:size(rays_in_obj2_new, 2)); d_2 * ones(1, size(rays_in_obj2_new, 2))];



% Plot the rays for the new object 1
plot(ray_z1_new, [rays_in_obj1_new(1, :); rays_out_obj1_new(1, :)], 'Color', 'blue');
% Plot the rays for the new object 2
plot(ray_z2_new, [rays_in_obj2_new(1, :); rays_out_obj2_new(1, :)], 'Color', 'red');



