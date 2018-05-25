function X = fxquant( s, bit, rmode, lmode )
%X = fxquant( S, BIT, RMODE, LMODE )  simulated fixed-point arithmetic
%	fxquant  returns the input signal S reduced to a word-length
%	of BIT bits and limited to the range [-1,1). The type of
%	word-length reduction and limitation may be chosen with
%	RMODE:	'round'		rounding to nearest level
%		'trunc'		2's complement truncation
%		'magn'		magnitude truncation
%	LMODE:	'sat'		saturation limiter
%		'overfl'	2's complement overflow
%		'triangle'	triangle limiter
%		'none'		no limiter

%	(C) 1989,1990 LNT Erlangen, FRG  
%	Version 2: 241090rr

if nargin ~= 4;
	error('usage: fxquant( S, BIT, RMODE, LMODE ).');
end;
if bit <= 0 | abs(rem(bit,1)) > eps;
	error('wordlength must be positive integer.');
end;

Plus1 = 2^(bit-1);

X = s * Plus1;
if     strcmp(rmode, 'round');		X = round(X);
elseif strcmp(rmode, 'trunc');		X = floor(X);
elseif strcmp(rmode, 'ceil');		X = ceil(X);
elseif strcmp(rmode, 'magn');		X = fix(X);
else		error('illegal wordlength reduction spec.');
end;

if     strcmp(lmode, 'sat');
	X = min(Plus1 - 1,X);
	X = max(-Plus1,X);
elseif strcmp(lmode, 'overfl');
	X = X + Plus1 * ( 1 - 2*floor((min(min(X),0))/2/Plus1) );
	X = rem(X,2*Plus1) - Plus1;
elseif strcmp(lmode, 'triang');
	X = X + Plus1 * ( 1 - 2*floor((min(min(X),0))/2/Plus1) );
	X = rem(X,4*Plus1) - Plus1;
	f = find(X > Plus1);
	X(f) = 2*Plus1 - X(f);
	f = find(X == Plus1);
	X(f) = X(f) - 1;
elseif strcmp(lmode, 'none');		%  limiter switched off
else	error('illegal limiter spec.');
end;

X = X / Plus1;
