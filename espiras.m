num_espiras = 5;         % Número de espiras
pts_espira = 80;         % Puntos por espira
radio = 1.5;             % Radio de cada anillo
altura_total = 6;        % Altura total del solenoide
corriente = 300;         % Corriente
mu_0 = 4*pi*1e-7;        % Permeabilidad del vacío
const_BS = mu_0 * corriente / (4*pi); % Constante Biot-Savart
grosor = 0.2;            % Grosor del alambre

% Malla campo magnetico
espacioAmpleado = 2.5; 
lx = 50; ly = 50; lz = 60;  
xg = linspace(-espacioAmpleado*radio, espacioAmpleado*radio, lx);
yg = linspace(-espacioAmpleado*radio, espacioAmpleado*radio, ly);
zg = linspace(-0.5*altura_total, 1.5*altura_total, lz);


% Inicialización de trayectorias
x = []; y = []; z = [];
dx = []; dy = []; dz = [];

altura_espira = altura_total / (num_espiras - 1);

% Crear anillos separados verticalmente
for n = 0:num_espiras-1
    t = linspace(0, 2*pi, pts_espira);
    x_espira = radio * cos(t);
    y_espira = radio * sin(t);
    z_espira = ones(1, pts_espira) * (n * altura_espira);

    x = [x, x_espira];
    y = [y, y_espira];
    z = [z, z_espira];

    dt = mean(diff(t));
    dx = [dx, -radio * sin(t) * dt];
    dy = [dy,  radio * cos(t) * dt];
    dz = [dz, zeros(1, pts_espira)];  % No hay componente vertical
end

% Inicialización del campo magnético
Bx = zeros(lx, ly, lz);
By = zeros(lx, ly, lz);
Bz = zeros(lx, ly, lz);

% Cálculo del campo magnético por Biot-Savart
for i = 1:lx
    for j = 1:ly
        for k = 1:lz
            for n = 1:length(x)
                rx = xg(i) - x(n);
                ry = yg(j) - y(n);
                rz = zg(k) - z(n);
                r_norm = sqrt(rx^2 + ry^2 + rz^2);
                r3 = (r_norm + grosor)^3;

                dBx = const_BS * (dy(n)*rz - dz(n)*ry) / r3;
                dBy = const_BS * (dz(n)*rx - dx(n)*rz) / r3;
                dBz = const_BS * (dx(n)*ry - dy(n)*rx) / r3;

                Bx(i,j,k) = Bx(i,j,k) + dBx;
                By(i,j,k) = By(i,j,k) + dBy;
                Bz(i,j,k) = Bz(i,j,k) + dBz;
            end
        end
    end
end

% Visualización de los anillos (espiras)
figure(1);
quiver3(x, y, z, dx, dy, dz, 'r');
grid on;
view(3);
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Espiras');

% Visualización del campo magnético en plano XZ
[Xm, Zm] = meshgrid(xg, zg);
centro_y = round(ly/2);
Bx_XZ = squeeze(Bx(:,centro_y,:));
Bz_XZ = squeeze(Bz(:,centro_y,:));

figure(2);
hold on;
pcolor(Xm, Zm, sqrt(Bx_XZ.^2 + Bz_XZ.^2)'.^(1/3));
shading interp;
colormap jet;
colorbar;
streamslice(Xm, Zm, Bx_XZ', Bz_XZ', 3);
xlabel('X'); ylabel('Z');
title('Campo magnético');
