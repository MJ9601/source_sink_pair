function [u, v] = Fvelocity_src_sink(strength, xs, ys, X, Y)

u = strength ./ (2 * pi) .* (X - xs) ./ ((X - xs).^2 + (Y - ys).^2);
v = strength ./ (2 * pi) .* (Y - ys) ./ ((X - xs).^2 + (Y - ys).^2);