% (a)
signal = audioread('s5.wav');
signal_8 = fxquant(signal, 8, 'round', 'sat');
signal_9 = fxquant(signal, 9, 'round', 'sat');
snr8 = snr(signal_8, signal);
snr9 = snr(signal_9, signal);

% (b)
clear;clc
mu = 500;
signal = audioread('s5.wav');
hold on;
for i = 10:-1:6
    SNRplot(signal, mu, i);
end
hold off;
xlabel('1/sigmax');ylabel('SNR in dB');title(sprintf('mu=%d',mu));
legend('10bit','10bit','9bit','9bit','8bit','8bit','7bit','7bit','6bit','6bit');

