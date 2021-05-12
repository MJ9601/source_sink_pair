function [psi] = Fget_stream(strength, xs, ys, X, Y)

psi = strength / (2 * pi) * atan2((Y - ys), (X - xs));
