% Animation d'un système a Np coprs.

clc;
clear variables;
close all;
format long;

% Définir les paramètres
ht = 0.01;
Nt = 1000;

% Nombre de particules
Np = 3;

% Constante gravitationnelle
G = 5;

% Masses des particules
Masse = ones(Np, 1);

% Positions des particules
x = zeros(Nt, Np);
y = zeros(Nt, Np);
z = zeros(Nt, Np);

% Vitesses
vx = zeros(Nt, Np);
vy = zeros(Nt, Np);
vz = zeros(Nt, Np);

% Accélérations
ax = zeros(Nt, Np);
ay = zeros(Nt, Np);
az = zeros(Nt, Np);

% Attribution des conditions initiales 
x(1,:) = -5+10.*rand(1, Np);
y(1,:) = -5+10.*rand(1, Np);
z(1,:) = -5+10.*rand(1, Np);

vx(1,:) = -1+2*rand(1, Np);
vy(1,:) = -1+2*rand(1, Np);
vz(1,:) = -1+2*rand(1, Np);

% Calcul des accélérations, puis des vitesses, puis des positions
% et du centre de masse pour les Np particules à tous les instants.
for iter = 2:Nt
  diffx = x(iter-1, :)-x(iter-1, :)';
  diffy = y(iter-1, :)-y(iter-1, :)';
  diffz = z(iter-1, :)-z(iter-1, :)';
  
  diff2 = diffx.^2+diffy.^2+diffz.^2+0.001;
  diff3 = diff2.*sqrt(diff2);
  
  Fx = G*(Masse.*diffx)./diff3;
  Fy = G*(Masse.*diffy)./diff3;
  Fz = G*(Masse.*diffz)./diff3;
  
  Fx(1:Np+1:end) = 0;
  Fy(1:Np+1:end) = 0;
  Fz(1:Np+1:end) = 0;
  
  ax(iter, :) = sum(Fx, 2);
  ay(iter, :) = sum(Fy, 2);
  az(iter, :) = sum(Fz, 2);
  
  vx(iter, :) = vx(iter-1, :)+ht*ax(iter, :);
  vy(iter, :) = vy(iter-1, :)+ht*ay(iter, :);
  vz(iter, :) = vz(iter-1, :)+ht*az(iter, :);
  
  x(iter, :) = x(iter-1, :)+ht*vx(iter, :);
  y(iter, :) = y(iter-1, :)+ht*vy(iter, :);
  z(iter, :) = z(iter-1, :)+ht*vz(iter, :);
end

% Centre de masse
Mt = sum(Masse);
cmx = sum(Masse'.*x, 2)/Mt;
cmy = sum(Masse'.*y, 2)/Mt;
cmz = sum(Masse'.*z, 2)/Mt;

figure_handle = figure(1);
set(figure_handle, 'Position', [50, 80, 1100, 600]);
hold on;
grid on;
title ("Simulation d'un système à " + num2str(Np) + " corps");
xlabel('Position x');
ylabel('Position y');
zlabel('Position z');
xlim([min(x, [], 'all')-0.2 max(x, [], 'all')+0.2]);
ylim([min(y, [], 'all')-0.2 max(y, [], 'all')+0.2]);
zlim([min(z, [], 'all')-0.2 max(z, [], 'all')+0.2]);
view(3)

body_handles = gobjects(Np, 1);
trajectory_handles = gobjects(Np, 1);

for i = 1:Np
  clrs = rand(1, 3);
  body_handles(i) = plot3(x(1, i), y(1, i), z(1, i), 'o', 'Color', clrs, 'MarkerFaceColor', clrs);
  trajectory_handles(i) = plot3(x(1, i), y(1, i), z(1, i), '-', 'Color', clrs, 'LineWidth', 1.2);
end

cm_handle = plot3(cmx(1), cmy(1), cmz(1), '.', 'Color', 'k', 'MarkerFaceColor', 'k');
cm_trajectory_handle = plot3(cmx(1), cmy(1), cmz(1), '--', 'Color', 'k', 'LineWidth', 1);

for i = 2:Nt
  for j = 1:Np
    set(body_handles(j), 'XData', x(i, j), 'YData', y(i, j), 'ZData', z(i, j));
    set(trajectory_handles(j), 'XData', x(1:i, j), 'YData', y(1:i, j), 'ZData', z(1:i, j));
  end
  set(cm_handle, 'XData', cmx(i), 'YData', cmy(i), 'ZData', cmz(i));
  set(cm_trajectory_handle, 'XData', cmx(1:i), 'YData', cmy(1:i), 'ZData', cmz(1:i));
  
  drawnow limitrate;
end
