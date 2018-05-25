% Record your voice for 2 seconds.
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 2);
disp('End of Recording.');

aa = getaudiodata(recObj);%save audio file(take 3 times for a, i, u)
audiowrite('aa.wav', aa, 8000);%write audio file into system(take 3 times)

aa = audioread('aa.wav');
[aa_spec, w] = DTFT(aa, length(aa));
plot(w*8000/(2*pi), 10*log(abs(aa_spec)));title('spectrum of vowel /a:/ (dB)');axis([0 4000 -10 80]);

ii = audioread('i.wav');
[ii_spec, w] = DTFT(ii, length(ii));
plot(w*8000/(2*pi), 10*log(abs(ii_spec)));title('spectrum of vowel /i/ (dB)');axis([0 4000 -10 80]);

u = audioread('u.wav');
[u_spec, w] = DTFT(u, length(u));
plot(w*8000/(2*pi), 10*log(abs(u_spec)));title('spectrum of vowel /u/ (dB)');axis([0 4000 -10 80]);

% take the envelope of the spectrum, only YUPPER is used
[YUPPER,YLOWER] = envelope(abs(u_spec),50,'peak');
w = w*8000/(2*pi);
subplot(2,1,1);plot(w, 10*log(abs(YUPPER)));title('envelope of spectrum of vowel /u/ (dB)');axis([0 4000 -10 80]);


frequency = 50:50:4000;%take frequency samples
t = 1:16000;%generate time series

%calculate the index of the referencing frequency
frequency_YUPPER = round(length(w)/8000*frequency+(length(w)/2));
YUPPER = abs(YUPPER);

%synthesis the waveform by multiplexing pure tones with respecting
%amplitude
u_synth = zeros(1,16000);
for i = 1:length(frequency)
    u_synth = u_synth + cos(2*pi*frequency(i)/8000*t) * YUPPER(frequency_YUPPER(i));
end

%normalize the waveform amplitude
m = max(u_synth);
u_synth = u_synth/m;
[u_syn_spe, w] = DTFT(u_synth, length(u_synth));
subplot(2,1,2);plot(w*8000/(2*pi), 10*log(abs(u_syn_spe)));title('spectrum of synthesised vowel /u/ (dB)');axis([0 4000 -10 80]);
soundsc(u_synth);

