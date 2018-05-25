function [ error,synth ] = lab6q1( input_file, frame_size, frame_shift, order )
%LAB6Q1 use LPC
signal = audioread(input_file);
error = zeros(1,length(signal));
synth = zeros(1,length(signal));
for n_hat = 1:frame_shift:length(signal)-frame_size
    frame = signal(n_hat:n_hat+frame_size-1);
    frame = frame.*hamming(frame_size);% windowing
    %calculate a_k
    a = lpc(frame,order);% p-th order lpc
    a = a(2:end);
    %calulate e(n)
    error_frame = filter([1,a],1,frame);% frame error
    error(n_hat:n_hat+frame_size-1)=error(n_hat:n_hat+frame_size-1)+error_frame';% adding to total error
    synth_frame = filter(1,[1,a],error_frame);
    synth(n_hat:n_hat+frame_size-1)=synth(n_hat:n_hat+frame_size-1)+synth_frame';% adding to total signal 
end

subplot(3,1,1);plot(signal);title('original signal s[n]');
subplot(3,1,2);plot(error);title('error signal e[n]');
subplot(3,1,3);plot(synth);title('resynthesized signal s_{hat}[n]');
end

