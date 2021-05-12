function [u, v] = Fvelocity_doublet(strength, xd, yd, X, Y)

u = (- strength / (2 * pi) *((X - xd).^2 - (Y - yd).^2) ./((X - xd).^2 + (Y - yd).^2).^2);
 
v = (- strength / (2 * pi) *2 * (X - xd) .* (Y - yd) ./((X - xd).^2 + (Y - yd).^2).^2);