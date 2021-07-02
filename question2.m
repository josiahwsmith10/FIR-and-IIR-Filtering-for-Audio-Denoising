function [b,a] = question2(z_i,pi,b0)
syms z
numz = 1;
denz = 1;
for i = 1:length(z_i)
    numz = numz*(z-z_i(i));
end
numz = expand(numz);
for j = 1:length(pi)
    denz = denz*(z-pi(j));
end
denz = expand(denz);
disp("G(z) = ");
pretty(b0*numz/denz)
b = sym2poly(b0*numz);
a = sym2poly(denz);
end