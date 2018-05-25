function [ ] = lab4q2( anal_num, file_name, start_sample, frame_length )
%LAB3Q1 calculate the STFT, and generate figures for lab4q1
[signal, Fs] = audioread(file_name);

% hamming window plot
figure;
for i = 1:anal_num
    L = round((Fs/1000)*frame_length(i));% calculate length
    window = hamming(L);% generate hamming window
    signal_w = signal(start_sample:start_sample+L-1).*window;% timesignal
    signal_w_s = fft(signal_w);% compute STFT
    subplot(anal_num,1,i);stem(abs(signal_w_s(1:round(L/2))),'Marker','none');xlim([0,L]);
    title(sprintf('STFT, hamming window, length = %d msec', frame_length(i)));
end

% rectangular window plot
figure;
for i = 1:anal_num
    L = round((Fs/1000)*frame_length(i));% calculate length
    window = ones(L,1);% generate hamming window
    signal_w = signal(start_sample:start_sample+L-1).*window;% timesignal
    signal_w_s = fft(signal_w);% compute STFT
    subplot(anal_num,1,i);stem(abs(signal_w_s(1:round(L/2))),'Marker','none');
    title(sprintf('STFT, rectangular window, length = %d msec', frame_length(i)));xlim([0,L]);
end

end
