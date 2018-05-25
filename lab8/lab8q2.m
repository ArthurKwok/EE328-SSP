% (a)
xin = -1:0.001:1;
xin_quant = fxquant(xin, 4, 'round', 'sat');
plot(xin, xin_quant);grid;title('bit=4, round, sat');
xin_quant = fxquant(xin, 4, 'trunc', 'sat');
plot(xin, xin_quant);grid;title('bit=4, trunc, sat');

% (b)
signal = audioread('s5.wav')';
signal = signal(1300:18800);
signal_quant = zeros(3,length(signal));
bit = [10, 8, 4];
% quantization period
figure;
subplot(4,1,1);plot(signal);title('original signal');
for i = 1:3
    signal_quant(i,:) = fxquant(signal, bit(i), 'round', 'sat');
    subplot(4,1,i+1);plot(signal_quant(i,:));title(sprintf('quantized signal with %d bits', bit(i)));
end
% compute error
signal_error = zeros(3,length(signal));
for i = 1:3
    signal_error(i,:) = signal_quant(i,:) - signal;
    error = signal_error(i,:);
    figure;
    striplot(error(1:8000), 8000, 2000);title(sprintf('error sequence , bit = %d', bit(i)));
    %subplot(3,1,i);plot(error(1:8000));title(sprintf('error sequency , bit = %d', bit(i)));
end
striplot(signal_error(1:8000), 8000, 2000);

%  (c)
figure;
hold on;pspect(signal, 8000, 1024, 128);
for i = 1:3
    signal_error(i,:) = signal_quant(i,:) - signal;
    error = signal_error(i,:);
	pspect(error, 8000, 1024, 128);title('error signal power spectra');
end
hold off;


