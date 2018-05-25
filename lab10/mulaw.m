function  y=mulaw(x,mu)
%
% function for mu-law compression for signals with maximum value of 1
%
% Inputs:
%	x: input signal vector
%	mu: compression parameter (mu=255 used for telephony)
%
% Output:
%   y: mu-law encoded signal

% load input signal
    x=x(:);
    
% set sign to +1 for x >= 0; -1 for x < 0
    sign=ones(length(x),1); 
    sign(find(x<0))=-1;
    
% mu-law encode the absolute value of x and multiply by the sign
    y=(1/log(1+mu))*log(1+mu*abs(x)).*sign;
end