clear;clc
signal = audioread('C_01_01.wav')';
noise_3 = awgn(signal,-3,'measured');
compete = audioread('C_01_02.wav');
compete = [compete'  zeros(1,length(signal)-length(compete))];
compete_3 = compete*1.873;% reamplitude to make snr = -3db
sound(noise_3,16000);
sound(signal+compete_3,16000);

noise_6 = awgn(signal,-6,'measured');
compete_6 = compete*2.645;% reamplitude to make snr = -6db
sound(noise_6,16000);
sound(signal+compete_6,16000);