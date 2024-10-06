% Animation d'un système a Np coprs.

clc;
clear variables;
close all;
format long;

% Définir les paramètres
ht = 0.001;
Nt =10000;

% Nombre de particules
Np = 2;

% Constante gravitationnelle
G = 0.1;

% Masses des particules
Masse = ones(Np, 1);
Masse(1) = 50;

% Positions des particules
x = zeros(Nt, Np);
y = zeros(Nt, Np);

% Vitesses
vx = zeros(Nt, Np);
vy = zeros(Nt, Np);

% Accélérations
ax = zeros(Nt, Np);
ay = zeros(Nt, Np);

% Attribution des conditions initiales 
x(1,1) = 0; x(1,2) = -1;
y(1,1) = 0; y(1,2) = -1;

vx(1,1) = 0; vx(1,2) = 1;
vy(1,1) = 0; vy(1,2) = 0;

% Calcul des accélérations, puis des vitesses, puis des positions
% et du centre de masse pour les Np particules à tous les instants.
for iter = 2:Nt
  diffx = x(iter-1, :)-x(iter-1, :)';
  diffy = y(iter-1, :)-y(iter-1, :)';

  diff2 = diffx.^2+diffy.^2+0.001;
  diff3 = diff2.*sqrt(diff2);

  Fx = G*(Masse.*diffx)./diff3;
  Fy = G*(Masse.*diffy)./diff3;

  Fx(1:Np+1:end) = 0;
  Fy(1:Np+1:end) = 0;

  ax(iter, :) = sum(Fx, 2);
  ay(iter, :) = sum(Fy, 2);
  
  vx(iter, :) = vx(iter-1, :)+ht*ax(iter, :);
  vy(iter, :) = vy(iter-1, :)+ht*ay(iter, :);
  
  x(iter, :) = x(iter-1, :)+ht*vx(iter, :);
  y(iter, :) = y(iter-1, :)+ht*vy(iter, :);
end

% Centre de masse
Mt = sum(Masse);
cmx = sum(Masse'.*x, 2)/Mt;
cmy = sum(Masse'.*y, 2)/Mt;

% Animation des résultats.
figure_handle = figure;
set(figure_handle, 'Position', [50,80,1100,600]);
hold on;
title("Simulation d'un système à "+num2str(Np)+" corps");
xlabel('Position x');
ylabel('Position y');
xlim([min(x, [], "all")-0.2 max(x, [], "all")+0.2]);
ylim([min(y, [], "all")-0.2 max(y, [], "all")+0.2]);

body_handles = gobjects(Np, 1);
trajectory_handles = gobjects(Np, 1);

for i = 1:Np
  clrs = rand(1, 3);
  body_handles(i) = plot(x(1, i), y(1, i), 'o', 'Color', clrs, 'MarkerFaceColor', clrs);
  trajectory_handles(i) = plot(x(1, i), y(1, i), '-', 'Color', clrs, 'LineWidth', 2);
end

cm_handle = plot(cmx(1), cmy(1), '.', 'Color', 'k', 'MarkerFaceColor', 'k');
cm_trajectory_handle = plot(cmx(1), cmy(1), '--', 'Color', 'k', 'LineWidth', 1);

for i = 2:Nt
  for j = 1:Np
    set(body_handles(j), 'XData', x(i, j), 'YData', y(i, j));
    set(trajectory_handles(j), 'XData', x(1:i, j), 'YData', y(1:i, j));
  end
  set(cm_handle, 'XData', cmx(i), 'YData', cmy(i));
  set(cm_trajectory_handle, 'XData', cmx(1:i), 'YData', cmy(1:i));

  drawnow limitrate;
end
