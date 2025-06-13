function animar_con_fondo(zm, imagen, nombre_video, zg)
    x_range = [-0.1, 0.1];  % Pequeño rango en x
    z_range = [min(zg), max(zg)];
    writerObj = VideoWriter(nombre_video, 'Motion JPEG AVI');
    writerObj.FrameRate = 30;
    open(writerObj);
    img = imread(imagen);
    figure; clf;
    imagesc(x_range, z_range, flipud(img));
    axis xy;
    hold on;
    xlabel('x (m)'); ylabel('z (m)');
    title('Trayectoria sobre campo magnético');
    h = plot(0, zm(1), 'ro', 'MarkerSize', 10);  % Punto inicial
    for i = 1:length(zm)
        set(h, 'YData', zm(i));  % Actualizar posición
        drawnow;
        frame = getframe(gcf);
        writeVideo(writerObj, frame);
    end
    close(writerObj);
end