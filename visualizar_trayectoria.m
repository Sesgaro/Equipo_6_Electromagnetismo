function visualizar_trayectoria(t, z_dipolo, z_free)
    figure;
    plot(t, z_dipolo, 'r-', 'DisplayName', 'Caida sobre un anillo');
    hold on;
    plot(t, z_free, 'b--', 'DisplayName', 'Caida Libre');
    xlabel('Tiempo (s)');
    ylabel('Posicion (m)');
    title('Trayectoria del dipolo');
    grid on;
    ylim([-1 11]); 
    legend('show');
end