% (a)
signal = [audioread('s1.wav')', audioread('s2.wav')', audioread('s3.wav')', audioread('s4.wav')', audioread('s5.wav')',audioread('s6.wav')']';
min = min(signal);
max = max(signal);
mean = mean(signal);
variance = var(signal);
stem((min:(max-min)/24:max),hist(signal,25),'Linewidth',10,'Marker','none');
stem((min:(max-min)/99:max),hist(signal,100),'Linewidth',2.5,'Marker','none');
title('histogram of large speech file, bin=100');

% (b)
for i= 1:5
    subplot(3,2,i);pspect(signal, 8000, 1024,16*2^i);
end
subplot(3,2,6);autocorr(signal,10);

% (d)
male = [audioread('s2.wav')', audioread('s4.wav')', audioread('s5.wav')', audioread('s6.wav')']';
female = [audioread('s1.wav')', audioread('s3.wav')']';
hold on; pspect(male, 8000, 1024, 256); pspect(female, 8000, 1024,256); hold off;grid;