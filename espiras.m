nl = 5;
N = 50;
R = 1.5;
sz = 1;
I = 300;
no = 4*pi*1e-7;
ka = no*I/(4*pi);
rw = 0.2;

nx = 50;
ny = 50;
nz = 50;
x = linspace(-5, 5, nx);
y = linspace(-5, 5, ny);
z = linspace(-5, 5, nz);
[X, Y, Z] = meshgrid(x, y, z);

Bx = zeros(nx, ny, nz);
By = zeros(nx, ny, nz);
Bz = zeros(nx, ny, nz);

theta = linspace(0, 2*pi, N);

figure(1);
hold on;
for k = 0:(nl-1)
    r = R * ones(size(theta));
    x_ring = r .* cos(theta);
    y_ring = r .* sin(theta);
    z_ring = ((k - (nl-1)/2) * sz) * ones(size(theta));

    dx_dtheta = gradient(x_ring, theta);
    dy_dtheta = gradient(y_ring, theta);
    magnitud = sqrt(dx_dtheta.^2 + dy_dtheta.^2);
    tangente_x = dx_dtheta ./ magnitud;
    tangente_y = dy_dtheta ./ magnitud;
    normal_x = -tangente_y;
    normal_y = tangente_x;
    factor_quiebre = 0.2;
    x_quiebre = x_ring + factor_quiebre * normal_x;
    y_quiebre = y_ring + factor_quiebre * normal_y;

    plot3(x_quiebre, y_quiebre, z_ring, 'r-', 'LineWidth', 2);
    
    for i = 1:2:N
        quiver3(x_quiebre(i), y_quiebre(i), z_ring(i), tangente_x(i), tangente_y(i), 0, 'b-');
    end

    for i = 1:N-1
        dlx = x_quiebre(i+1) - x_quiebre(i);
        dly = y_quiebre(i+1) - y_quiebre(i);
        x_mid = (x_quiebre(i) + x_quiebre(i+1))/2;
        y_mid = (y_quiebre(i) + y_quiebre(i+1))/2;
        z_mid = z_ring(i);
        
        rx = X - x_mid;
        ry = Y - y_mid;
        rz = Z - z_mid;
        r_magnitud = sqrt(rx.^2 + ry.^2 + rz.^2);
        r_cubed = r_magnitud.^3 + eps;

        cross_x = dly.*rz;
        cross_y = -dlx.*rz;
        cross_z = dlx.*ry - dly.*rx;

        Bx = Bx + ka * cross_x ./ r_cubed;
        By = By + ka * cross_y ./ r_cubed;
        Bz = Bz + ka * cross_z ./ r_cubed;
    end
end

[sx, sy, sz_stream] = meshgrid(linspace(-1,1,4), linspace(-1,1,4), linspace(-1,1,4));
streamline(X, Y, Z, Bx, By, Bz, sx, sy, sz_stream);
title('Espiras');
xlabel('x');
ylabel('y');
zlabel('z');
axis equal;
grid on;
view(3);
hold off;

figure(2);
hold on;
y_index = round(ny/2);
B_magnitude = sqrt(Bx(:,y_index,:).^2 + By(:,y_index,:).^2 + Bz(:,y_index,:).^2);
B_magnitude = squeeze(B_magnitude);
contourf(x, z, B_magnitude', 20, 'LineColor', 'none');
colormap('jet');
colorbar;
max_B = max(B_magnitude(:));
clim([0, max_B * 0.8]);
title('Campo magnetico');
xlabel('x');
ylabel('z');
axis equal;
hold off;
