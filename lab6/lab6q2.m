function [  ] = lab6q2( input_file, frame_start, frame_size, order )
%LAB6Q2 此处显示有关此函数的摘要
%   此处显示详细说明
signal = audioread(input_file);
frame = signal(frame_start:frame_start+frame_size-1);
%calculate a_k
a = lpc(frame,order);% p-th order lpc
a = a(2:end);
%calulate e(n)
error_frame = filter([1,-a],1,frame);% frame error
spec_frame = 10*log(abs(fft(frame,1024)));
spec_frame = spec_frame(1:end/2);
lpc_frame = 10*log(abs(freqz(1,[1,a],1024)));
error_spec = 10*log(abs(fft(error_frame,1024)));
error_spec = error_spec(1:end/2);

subplot(2,2,1);plot(frame);title('original signal s[n]');
subplot(2,2,2);plot(error_frame);title('error signal e[n]');
subplot(2,2,3);hold on ;plot(spec_frame);
plot((1:length(lpc_frame))/2,lpc_frame);hold off;title('spectrum and lpc spectrum (dB)');
subplot(2,2,4);plot(error_spec);title('error signal spectrum (dB)');
end

