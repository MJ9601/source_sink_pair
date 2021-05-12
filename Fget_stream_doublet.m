function [psi] = Fget_stream_doublet(strength, xd, yd, X, Y)

psi = - strength ./ (2 * pi) .* (Y - yd) ./ ((X - xd).^2 + (Y - yd).^2);
    