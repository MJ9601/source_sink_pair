clc
clear
close all


NameFiles = {'naca_63_015.txt'};

% due to high amount of DATA this part used to read data from the file
fileID = fopen(NameFiles{1},'r');
formatSpec = '%f %f';
sizeA = [2 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
A = A'; %used to oriente reading data

xposition =A(:, 1);
yposition = A(:, 2);
scale_ = 10;


figure (1)
hold on
plot(scale_ * xposition - 5, scale_ * yposition, 'k:', 'linewidth',2) % plot

[X, Y] = meshgrid(-6:.1:6, -6:.1:6);
N = length(X);


u_inf = 1.0;        % freestream speed
% compute the freestream velocity field
u_freestream = u_inf * ones(N);
v_freestream = zeros(N);

% compute the stream-function
psi_freestream = u_inf * Y;


% source
strength_source = 2.90;            % strength of the source
x_source =  - scale_ + 5;
y_source = 0.0;   % location of the source

% compute the velocity field
[u_source, v_source] = Fvelocity_src_sink(strength_source, x_source, y_source, X, Y);

% compute the stream-function
psi_source = Fget_stream(strength_source, x_source, y_source, X, Y);


% sink
strength_sink = -0.19;            % strength of the source
x_sink = 1 * scale_ - 5;
y_sink = 0.0;   % location of the source

% compute the velocity field
[u_sink, v_sink] = Fvelocity_src_sink(strength_sink, x_sink, y_sink, X, Y);

% compute the stream-function
psi_sink = Fget_stream(strength_sink, x_sink, y_sink, X, Y);


u = u_freestream  + u_sink + u_source ;
v = v_freestream   + v_sink + v_source ;
psi = psi_freestream  + psi_sink + psi_source;

% compute the velocity field on the mesh grid
for j = 8:2: 16
    for i= 1: 25
        x_doublet = scale_ * xposition(i) - 5;
        y_doublet = 0.0;

        kappa = scale_ * yposition(i)/ j/max(yposition);
        [u_doublet, v_doublet] = Fvelocity_doublet(kappa, x_doublet, y_doublet, X, Y);

        % compute the stream-function on the mesh grid
        psi_doublet = Fget_stream_doublet(kappa, x_doublet, y_doublet, X, Y);



        % superposition of the doublet on the freestream flow
        u = u + u_doublet ;
        v = v + v_doublet;
        psi = psi + psi_doublet;

        plot(x_doublet, y_doublet, 'o','MarkerSize',10,...
        'MarkerEdgeColor','red',...
        'MarkerFaceColor','red')
        hold on
        
    end
    [M, c] = contour(X, Y, psi, [0 0],'--' );
c.LineWidth = 2;
    
end

u = u_freestream  + u_sink + u_source ;
v = v_freestream   + v_sink + v_source ;
psi = psi_freestream  + psi_sink + psi_source;



for i= 1: 25
        x_doublet = scale_ * xposition(i) - 5;
        y_doublet = 0.0;

        kappa = scale_ * yposition(i)/ 12/max(yposition);
        [u_doublet, v_doublet] = Fvelocity_doublet(kappa, x_doublet, y_doublet, X, Y);

        % compute the stream-function on the mesh grid
        psi_doublet = Fget_stream_doublet(kappa, x_doublet, y_doublet, X, Y);



        % superposition of the doublet on the freestream flow
        u = u + u_doublet ;
        v = v + v_doublet;
        psi = psi + psi_doublet;

        plot(x_doublet, y_doublet, 'o','MarkerSize',10,...
        'MarkerEdgeColor','red',...
        'MarkerFaceColor','red')
        hold on
        
end
    [M, c] = contour(X, Y, psi, [0 0],'r-' );
c.LineWidth = 2;





figure (1)
streamslice(X, Y, u, v)
axis tight
plot(x_doublet, y_doublet, 'o','MarkerSize',10,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor','red')
plot([x_sink, x_source], [y_sink, y_source], 'o','MarkerSize',10,...
    'MarkerEdgeColor','black',...
    'MarkerFaceColor',[0 0 0])

title('')

figure (2)

    [M, c] = contour(X, Y, psi, [0 0],'r-' );
c.LineWidth = 2;
hold on

streamslice(X, Y, u, v)
axis tight

plot([x_sink, x_source], [y_sink, y_source], 'o','MarkerSize',10,...
    'MarkerEdgeColor','black',...
    'MarkerFaceColor',[0 0 0])

plot(scale_ * xposition - 5, scale_ * yposition, 'k--', 'linewidth',2) % plot
title('Stream lines')



figure (3)

hold on



plot([x_sink, x_source], [y_sink, y_source], 'o','MarkerSize',10,...
    'MarkerEdgeColor','black',...
    'MarkerFaceColor',[0 0 0])

cp = 1.0 - (u.^2 + v.^2) ./ u_inf.^2;

contourf(X,Y,cp, '--', 'ShowText','on')
cb = contourcbar;
cb.YLabel.String = 'Pressure';
title('Pressure contour')

[M, c] = contour(X, Y, psi, [0 0],'k-' );

c.LineWidth = 2;

streamslice(X, Y, u, v)
axis tight







