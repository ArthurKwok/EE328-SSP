function [ signal ] = SNRplot( signal, mu, bit)
%SNRPLOR plot a single line
% signal: input signal array
% mu: factor for mu-law
% bit: quantization bit number

% x-axis: 1/sigma, 13 samples
% y-axis: SNR, 13 samples
factor = 1*2.^(0:-1:-12)';
signal = factor*signal';
signal = signal';
SNR_mu = zeros(1,13);
SNR_uni = zeros(1,13);
standard = std(signal);
% mulaw and quantization
for i = 1:13
    signal_f = signal(:,i);
    signal_compress = mulaw(signal_f, mu);
    signal_q = fxquant(signal_compress, bit, 'round', 'sat');
    signal_expand = mulawinv(signal_q, mu);
    SNR_mu(i) = snr(signal_expand, signal_f);
    SNR_uni(i) = snr(fxquant(signal_f,bit,'round','sat'),signal_f);
end
semilogx(1./standard, SNR_mu);
semilogx(1./standard, SNR_uni,'--');
grid;

