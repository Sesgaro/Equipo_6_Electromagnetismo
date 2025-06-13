function main()
    % Parámetros iniciales
    [xg, yg, zg, const_BS, x, y, z, dx, dy, dz] = inicializar_espiras();
    
    % Calcular campo magnético
    [Bx, By, Bz] = calcular_campo_BiotSavart(xg, yg, zg, x, y, z, dx, dy, dz, const_BS);

    % Visualización de espiras y campo
    visualizar_espiras(x, y, z, dx, dy, dz);
    visualizar_campo_magnetico(xg, zg, Bx, Bz);

    % Calcular gradiente dBz/dz
    dBz_dz = calcular_gradiente_Bz(zg, Bz, xg, yg);

    % Calcular fuerza magnética
    Fz = calcular_fuerza_magnetica(dBz_dz);

    % Simular caída del dipolo
    [t, z_dipolo, z_free] = simular_movimiento(zg, Fz);

    % Visualizar trayectoria
    visualizar_trayectoria(t, z_dipolo, z_free);
    pause(2);
    % Animación de la trayectoria
    animar_con_fondo(z_dipolo, 'campo_magnetico.png', './animacion.avi', zg);
end