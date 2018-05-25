% (a)
x = -1:0.001:1;
y = zeros(6,length(x));
mu = [1, 20, 50, 100, 255, 500];
figure;hold on;
for i = 1:6
    y(i,:) = mulaw(x, mu(i));
    plot(x,y(i,:));
end

% (b)
clear;clc
signal = audioread('s5.wav');
signal = signal(1300:18800); 
y = mulaw(signal, 255);
subplot(2,1,1);plot(signal);title('original signal');grid;
subplot(2,1,2);plot(y);title('quantized signal, mu=255');grid;
histogram(y,50);xlim([-1,1]);title('histogram of mulaw-signal');grid;

%(c)
clear;clc
signal = audioread('s5.wav');
signal = signal(1300:18800);
y = mulaw(signal, 255);
v = mulawinv(y,255);
subplot(3,1,1);plot(signal);title('orignial signal');grid;
subplot(3,1,2);plot(v);title('inversed mulaw signal');grid;
subplot(3,1,3);plot(signal-v);title('difference');grid;

%(d)
clear;clc
signal = audioread('s5.wav');
signal = signal(1300:18800);
bit = [4,6,8,10];
yh = zeros(4,length(signal));
e = zeros(4,length(signal));
for i = 1:4
    yh(i,:) = fxquant(mulaw(signal,255),bit(i),'round','sat');
    e(i,:) = mulawinv(yh(i,:),255)-signal;
    error = e(i,:);
    subplot(2,2,i);histogram(error(1:8000),50);title(sprintf('bit = %d',bit(i)));grid;
end
figure;hold on;
for i = 1:4
    error = e(i,:);
    pspect(error(1:8000), 8000, 1024, 60);
end
title('error power spectrum'); legend('bit=4', 'bit=6', 'bit=8', 'bit=10');grid;
