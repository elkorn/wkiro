function f = kernel_triangle(z)
%TRIANGLE The triangular kernel.
a = sqrt(6);
z = abs(z);
f = (z<=a) .* (1 - z/a) / a;