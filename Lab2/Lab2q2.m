% question 2
clear;clc;
[data,fs] = audioread('C_01_01.wav');
noise = zeros(6,length(data));
score = zeros(6,1);
%when dB set as [-5, 5], the score is almost the same,
%so I extended the dB range to get a clearer result.
db = [-50, -30, -10, 10, 30, 50];

for i = 1:6
    %generate the awgn noise signal with a certain SNR
    noise(i,:) = awgn(data,db(i),'measured');
    %write 6 audio files with correct filname 1-6
    audio_order = 'noisedsignal_%d.wav';
    A = i;
    audio_name = sprintf(audio_order,A);
    audiowrite(audio_name,noise(i,:),fs);
end

for i = 1:6
    %read 6 audio files with correct filname 1-6
    audio_order = 'noisedsignal_%d.wav';
    A = i;
    audio_name = sprintf(audio_order,A);
    %use the PESQ to compare the original signal and the noised signal
    score(i,1) = pesq('C_01_01.wav',audio_name);
end

stem(db,score);xlabel('SNR in dB');ylabel('PESQ score');axis([-55,55,-0.5,4.5]);