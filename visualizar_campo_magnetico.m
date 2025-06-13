function visualizar_campo_magnetico(xg, zg, Bx, Bz)
    [Xm, Zm] = meshgrid(xg, zg);
    centro_y = round(size(Bx, 2)/2);
    Bx_XZ = squeeze(Bx(:,centro_y,:));
    Bz_XZ = squeeze(Bz(:,centro_y,:));

    figure;
    hold on;
    pcolor(Xm, Zm, sqrt(Bx_XZ.^2 + Bz_XZ.^2)'.^(1/3));
    shading interp; colormap jet; colorbar;
    streamslice(Xm, Zm, Bx_XZ', Bz_XZ', 3);
    xlabel('X'); ylabel('Z');
    title('Campo magnético');


    figure;
    hold on;
    pcolor(Xm, Zm, sqrt(Bx_XZ.^2 + Bz_XZ.^2)'.^(1/3));
    shading interp;
    colormap jet;
    colorbar;
    streamslice(Xm, Zm, Bx_XZ', Bz_XZ', 3);
    % Ocultar elementos no deseados
    axis off; % Oculta los ejes
    delete(findobj(gcf, 'Type', 'ColorBar')); % Elimina la barra de color
    set(get(gca, 'Title'), 'Visible', 'off'); % Oculta el título
    set(get(gca, 'XLabel'), 'Visible', 'off'); % Oculta la etiqueta del eje X
    set(get(gca, 'YLabel'), 'Visible', 'off'); % Oculta la etiqueta del eje Y

    % Guardar solo el plot del campo magnético
    exportgraphics(gcf, 'campo_magnetico.png', 'Resolution', 1080);

end