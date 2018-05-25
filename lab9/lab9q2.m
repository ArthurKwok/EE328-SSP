% (a)
signal = audioread('s5.wav');
signal = signal';
sigma = zeros(1,length(signal));
alpha = 0.99;
for i = 2:length(sigma)
    sigma(i) = alpha*sigma(i-1)+(1-alpha)*(signal(i))^2;
end
sigma = sigma.^(0.5);
subplot(2,1,1); hold on;
plot(2700:6700,signal(2700:6700));plot(2700:6700,sigma(2700:6700));
legend('speech', 'standard deviation');title('alpha = 0.99');
hold off;
subplot(2,1,2);plot(2700:6700,signal(2700:6700)./sigma(2700:6700));
title('gain equalized speech');

% (b)
signal = audioread('s5.wav');
signal = signal';
sigma = zeros(1,length(signal));
M = 10;
for i = M+1:length(sigma)
    sigma(i) = sum(signal(i-M+1:i).^2);
end
sigma = sigma.^(0.5);
subplot(2,1,1);
plot(2700:6700,signal(2700:6700)./sigma(2700:6700));
title('M=10');
M = 100;
for i = M+1:length(sigma)
    sigma(i) = sum(signal(i-M+1:i).^2);
end
sigma = sigma.^(0.5);
subplot(2,1,2);plot(2700:6700,signal(2700:6700)./sigma(2700:6700));
title('M=100');

