function visualizar_espiras(x, y, z, dx, dy, dz)
    figure;
    quiver3(x, y, z, dx, dy, dz, 'r');
    grid on; view(3);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title('Espiras');
end