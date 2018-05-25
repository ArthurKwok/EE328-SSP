function [ output ] = myCepstrum( input, cr )
%MYCEPSTRUM computes the complex or real cepstrum of the input signal.
% cr: complex or real. 'C' for complex, 'R for real.

H = fft(input,2048);
if cr == 'C'
    H_log = log(abs(H)) + 1i*unwrap(angle(H));
    
elseif cr =='R'
    H_log = log(abs(H));
end
output = real(ifft(H_log));
output = fftshift(output);

end

