clc
clear
close all



[X, Y] = meshgrid(-6:.1:6, -6:.1:6);
N = length(X);


u_inf = 1.0;        % freestream speed
% compute the freestream velocity field
u_freestream = u_inf * ones(N);
v_freestream = zeros(N);

% compute the stream-function
psi_freestream = u_inf * Y;


% source
strength_source = 10;            % strength of the source
x_source =  -1;
y_source = 0.0;   % location of the source

% compute the velocity field
[u_source, v_source] = Fvelocity_src_sink(strength_source, x_source, y_source, X, Y);

% compute the stream-function
psi_source = Fget_stream(strength_source, x_source, y_source, X, Y);


% sink
strength_sink = -10;            % strength of the source
x_sink = 1;
y_sink = 0.0;   % location of the source

% compute the velocity field
[u_sink, v_sink] = Fvelocity_src_sink(strength_sink, x_sink, y_sink, X, Y);

% compute the stream-function
psi_sink = Fget_stream(strength_sink, x_sink, y_sink, X, Y);


u = u_freestream  + u_sink + u_source ;
v = v_freestream   + v_sink + v_source ;
psi = psi_freestream  + psi_sink + psi_source;


figure (1)

hold on



plot([x_sink, x_source], [y_sink, y_source], 'o','MarkerSize',10,...
    'MarkerEdgeColor','black',...
    'MarkerFaceColor',[0 0 0])

cp = 1.0 - (u.^2 + v.^2) ./ u_inf.^2;

contourf(X,Y,cp, '--', 'ShowText','on')
% caxis([0 100])
% colormap(hsv)
cb = contourcbar;
cb.YLabel.String = 'Pressure';
title('Pressure contour')


[M, c] = contour(X, Y, psi, [0 0],'k-' );

c.LineWidth = 2;

streamslice(X, Y, u, v)


axis tight