signal1 = audioread('s1.wav');
signal1_adpcm = adpcm_decoder(adpcm_encoder(signal1));
snr1 = snr(signal1_adpcm, signal1');

signal2 = audioread('s2.wav');
signal2_adpcm = adpcm_decoder(adpcm_encoder(signal2));
snr2 = snr(signal2_adpcm, signal2');

signal3 = audioread('s3.wav');
signal3_adpcm = adpcm_decoder(adpcm_encoder(signal3));
snr3 = snr(signal3_adpcm, signal3');

signal4 = audioread('s4.wav');
signal4_adpcm = adpcm_decoder(adpcm_encoder(signal4));
snr4 = snr(signal4_adpcm, signal4');

signal5 = audioread('s5.wav');
signal5_adpcm = adpcm_decoder(adpcm_encoder(signal5));
snr5 = snr(signal5_adpcm, signal5');

signal6 = audioread('s6.wav');
signal6_adpcm = adpcm_decoder(adpcm_encoder(signal6));
snr6 = snr(signal6_adpcm, signal6');

stem([snr1, snr2, snr3, snr4, snr5, snr6]);