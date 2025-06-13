function [Bx, By, Bz] = calcular_campo_BiotSavart(xg, yg, zg, x, y, z, dx, dy, dz, const_BS)
    [lx, ly, lz] = deal(length(xg), length(yg), length(zg));
    Bx = zeros(lx, ly, lz);
    By = zeros(lx, ly, lz);
    Bz = zeros(lx, ly, lz);

    for i = 1:lx
        for j = 1:ly
            for k = 1:lz
                for n = 1:length(x)
                    rx = xg(i) - x(n);
                    ry = yg(j) - y(n);
                    rz = zg(k) - z(n);
                    r_norm = sqrt(rx^2 + ry^2 + rz^2);
                    if r_norm == 0, r_norm = 1e-6; end
                    r3 = r_norm^3;

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
end