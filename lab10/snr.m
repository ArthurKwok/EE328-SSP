function [ s_n_r, e ] = snr( xh, x )
%SNR function for computing snr
% [s_n_r,e]=snr(xh,x)
% xh=quantized signal
% x=unquantized signal
% e=quantization error signal (optional)
% s_n_r=snr in dB
s_n_r = 10*log10(sum(x.^2)/sum((xh-x).^2));
e = x-xh;
end

