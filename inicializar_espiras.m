function [xg, yg, zg, const_BS, x, y, z, dx, dy, dz] = inicializar_espiras()
    num_espiras = 5;
    pts_espira = 80;
    radio = 1.5;
    altura_total = 6;
    corriente = 1000;
    mu_0 = 4*pi*1e-7;
    const_BS = mu_0 * corriente / (4*pi);

    espacioAmpleado = 2.5;
    lx = 50; ly = 50; lz = 60;
    xg = linspace(-espacioAmpleado*radio, espacioAmpleado*radio, lx);
    yg = linspace(-espacioAmpleado*radio, espacioAmpleado*radio, ly);
    zg = linspace(-0.5*altura_total, 1.5*altura_total, lz);

    x = []; y = []; z = [];
    dx = []; dy = []; dz = [];
    altura_espira = altura_total / (num_espiras - 1);

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
        dz = [dz, zeros(1, pts_espira)];
    end
end