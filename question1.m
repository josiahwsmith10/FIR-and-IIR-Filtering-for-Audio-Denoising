function [poleG,zeroG] = question1(num,den,str)
syms z
poleG = roots(den);
zeroG = zeros(length(den)-1,1); 
zeroG(1:length(num)-1,1) = roots(num);
disp("Zeros:")
disp(zeroG');
pause(1)
disp("Poles:");
disp(poleG');
pause(1)
denz = 1;
numz = 1;
for i = 1:length(zeroG)
    numz = numz * ( 1 - zeroG(i)*z^-1);
end
for j = 1:length(poleG)
    denz = denz * ( 1 - poleG(j)*z^-1);
end
disp("Factored G(z)")
pretty(numz);
if den ~= 1
    disp("----------------------------------------------------------------------------------------------------")
    pretty(denz);
end
s = tf('s');
Gs = tf(num,den);
figure
pzplot(Gs*s^(length(den)-length(num)));
title("Zero-Pole Plot of " + str)
end