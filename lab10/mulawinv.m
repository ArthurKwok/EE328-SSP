function x=mulawinv(y,mu)
%
% function for inverse mu-law (expansion) for signal in the range [-1 1]
%
% Inputs:
%	y=: mu-law encoded input signal (usually quantized)
%	mu: mulaw compression parameter
%
% Output:
%	x: expanded output vector

% load mu-law encoded (and usually quantized) input signal
    y=y(:);
    
% determine the sign of each sample of the input signal
    sign=ones(length(y),1);
    sign(find(y<0))=-1;
    
% inverse mu-law decode of signal
    x=(exp(abs(y)*log(1+mu))-1)/mu.*sign;
end