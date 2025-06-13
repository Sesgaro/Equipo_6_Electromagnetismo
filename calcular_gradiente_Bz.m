function dBz_dz = calcular_gradiente_Bz(zg, Bz, xg, yg)
    centro_x = round(length(xg)/2);
    centro_y = round(length(yg)/2);
    Bz_centro = squeeze(Bz(centro_x, centro_y, :));

    delta = 0.005;
    Bz_forward = interp1(zg, Bz_centro, zg + delta, 'linear', 'extrap');
    Bz_backward = interp1(zg, Bz_centro, zg - delta, 'linear', 'extrap');
    dBz_dz = (Bz_forward - Bz_backward) / (2 * delta);

    figure;
    plot(zg, dBz_dz, 'r');
    xlabel('z (m)'); ylabel('dBz/dz (T/m)');
    title('Gradiente del campo magnético');
    grid on;
end