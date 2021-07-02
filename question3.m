function question3(num,den,str)
w = 0:0.001:2*pi;
numw = 0;
denw = 0;
for i = 1:length(num)
    numw = numw + num(i).*exp(1j*w*(i-1));
end
for i = 1:length(den)
    denw = denw + den(i).*exp(1j*w*(i-1));
end

figure
subplot(211)
Hw = numw./denw;
plot(w/pi,abs(Hw))
xlabel('Frequency *pi')
title("Magnitude Response of " + str)

subplot(212)
plot(w/pi,angle(Hw))
xlabel('Frequency *pi')
title("Phase Response of " + str)
end