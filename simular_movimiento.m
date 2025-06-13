function [t, z_dipolo, z_free] = simular_movimiento(zg, Fz)
    % Parámetros físicos
    m = 0.001;           % Masa del dipolo (kg)
    g = 9.81;           % Gravedad (m/s²)
    w = -m * g;         % Peso (negativo porque z crece hacia arriba)
    
    % Tiempo
    dt = 0.01;
    t = 0:dt:7;

    % Estado inicial [z; v]
    z_dipolo = zeros(size(t));
    v = zeros(size(t));
    z_dipolo(1) = 10; % Posición inicial

    % Caída libre para comparación
    z_free = zeros(size(t));
    v_free = zeros(size(t));
    z_free(1) = 10;

    % Función de aceleración total
    a_total = @(z, v) (interp1(zg, Fz, z, 'linear', 'extrap') + w * v) / m;

    for i = 1:length(t)-1
        % RK4 para z_dipolo y v
        z_i = z_dipolo(i);
        v_i = v(i);

        k1_v = a_total(z_i, v_i);
        k1_z = v_i;

        k2_v = a_total(z_i + 0.5*dt*k1_z, v_i + 0.5*dt*k1_v);
        k2_z = v_i + 0.5*dt*k1_v;

        k3_v = a_total(z_i + 0.5*dt*k2_z, v_i + 0.5*dt*k2_v);
        k3_z = v_i + 0.5*dt*k2_v;

        k4_v = a_total(z_i + dt*k3_z, v_i + dt*k3_v);
        k4_z = v_i + dt*k3_v;

        v(i+1) = v_i + dt/6 * (k1_v + 2*k2_v + 2*k3_v + k4_v);
        z_dipolo(i+1) = z_i + dt/6 * (k1_z + 2*k2_z + 2*k3_z + k4_z);

        % Caída libre con Euler (sin campo magnético)
        a_free = -g;
        v_free(i+1) = v_free(i) + a_free * dt;
        z_free(i+1) = z_free(i) + v_free(i+1) * dt;
    end
end