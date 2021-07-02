function [y_new,y_new1,y_new2] = question4(y,Fs,r1,r2)
L = length(y);
yf = fftshift(fft(y))/L;
f = -Fs/2:Fs/L:Fs/2-Fs/L;

%% A: Plot magnitude and phase respose of audio file
figure
subplot(211);
plot(f,abs(yf));
ylabel('Magnitude Response')
xlabel('Hz')
% plot phase
subplot(212);
plot(f,unwrap(angle(yf))); 
ylabel('Phase Response')
xlabel('Hz')

%% B: Determine Spectral location associated with noise
[~,noi_loc] = findpeaks(abs(yf( (length(yf)+1)/2 : length(yf) ) ),f( (length(yf)+1)/2 : length(yf) ),'MinPeakHeight',0.01);

disp("Frequencies of Noise (Hz):")
disp(noi_loc);
disp("Discrete Normalized Frequencies of Noise:")
disp(noi_loc/Fs);

%% C: Make an FIR filter with zeros at noise frequencies
syms z
numz = 1;
%noi_loc = mean(noi_loc);
for i = 1:length(noi_loc)
   numz = numz .* (z^2-2*cos(2*pi*noi_loc(i)/Fs)*z+1);
end
numHz = sym2poly(numz);

question3(numHz,1,"FIR Filter");
question1(numHz,1,"FIR Filter");

y_new = filter(numHz,1,y);

%% D: Make an IIR filter with r1
denz = 1;
for i = 1:length(noi_loc)
   denz = denz .* (z^2-2*r1*cos(2*pi*noi_loc(i)/Fs)*z+r1^2);
end
denHz1 = sym2poly(denz);

question3(numHz,denHz1,"IIR Filter with r = 0.4");
question1(numHz,denHz1,"IIR Filter with r = 0.4");

y_new1 = filter(numHz,denHz1,y);

%% E: Make an IIR filter with r2
denz = 1;
for i = 1:length(noi_loc)
   denz = denz .* (z^2-2*r2*cos(2*pi*noi_loc(i)/Fs)*z+r2^2);
end
denHz2 = sym2poly(denz);

question3(numHz,denHz2,"IIR Filter with r = 0.95");
question1(numHz,denHz2,"IIR Filter with r = 0.95");

y_new2 = filter(numHz,denHz2,y);

%% Save the new audio files
audiowrite("FIRaudio.wav",y_new/max(y_new(:))*0.5,Fs)
audiowrite("IIR1audio.wav",y_new1/max(y_new1(:))*0.5,Fs)
audiowrite("IIR2audio.wav",y_new2/max(y_new2(:))*0.5,Fs)
end