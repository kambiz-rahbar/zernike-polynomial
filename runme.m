clc
clear
close all

%% generate axis resolution
x = -1 : 0.01 : 1;
y = -1 : 0.02 : 1;
[X, Y] = meshgrid(x, y);
[theta, r] = cart2pol(X, Y);

%% generate radial/azimuthal degree
OSA_idx_array = zeros(36, 3);
for radial_degree = 0 : 7
    for azimuthal_degree = -radial_degree : 2 : radial_degree
        OSA_index = 0.5 * (radial_degree * (radial_degree + 2) + azimuthal_degree);
        OSA_idx_array(OSA_index+1, :) = [OSA_index; radial_degree; azimuthal_degree];
    end
end

idx_table = table(OSA_idx_array(:,1), OSA_idx_array(:,2), OSA_idx_array(:,3));
idx_table.Properties.VariableNames = {'OSA index', 'radial degree', 'azimuthal degree'};
disp(idx_table);

%% generate zernike data
OSA_index = 3;

circle_idx = r<=1;

Z = nan(size(circle_idx));
Z(circle_idx) = zernike_fcn(OSA_index, r(circle_idx), theta(circle_idx));

%% plot zernike function
figure(1);
mesh(X,Y,Z);
xlim = [-1,1];
ylim = [-1,1];
zlim = [-1,1];
xlabel('x');
ylabel('y');
zlabel('z');
axis square;
grid minor;
title(['OSA index: ' num2str(OSA_index) '  ( Z_{' num2str(OSA_idx_array(OSA_index+1, 2)) '}^{' num2str(OSA_idx_array(OSA_index+1, 3)) '} )']);
