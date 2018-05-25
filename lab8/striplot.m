function hp = striplot(x, fs, n, ntick, xmax)
%STRIPLOT    plot long signal in horizontal strips     
%-------      ( good for multi-line speech wfms )
%
%  Usage:  HP = striplot(X, FS, N)
%
%             plots waveform X with N pts/line. ALL traces 
%               are auto-scaled to the max signal value
%
%        FS :  sampling rate (Hertz); used only for labeling
%        HP :  the graphics handle for the plot.
%
%    striplot(X, FS, N, NTICK)
%                    puts markers every NTICK samples
%    striplot(X, FS, N, NT, XMAX)
%                  uses XMAX as the value for scaling
%
%   NOTE: the x-axis is always labeled with (time) indices.
%         the y-axis labels are NOT AMPLITUDE, rather they
%         are the INDEX OFFSET to the start of each row.
%
%   see also STRIPS in Sig Proc Toolbox version 3 and higher

%---------------------------------------------------------------
% copyright 1994, by C.S. Burrus, J.H. McClellan, A.V. Oppenheim,
% T.W. Parks, R.W. Schafer, & H.W. Schussler.  For use with the book
% "Computer-Based Exercises for Signal Processing Using MATLAB"
% (Prentice-Hall, 1994).
%---------------------------------------------------------------

x = x(:);
x = x/max(abs(x));	%% <-- normalize sample amplitude

if nargin < 5
  xmax = max(abs(x));      %% <-- default scaling
end
if nargin < 4
  ntick = 0;
end
if nargin < 3
  n = 400;        %% default:  50 msec @ 8 kHz
end

lenx = length(x);
nrows = ceil(lenx/n);
if lenx < n*nrows
   x(n*nrows) = 0;        %% <--- need to zero pad
   lenx = n*nrows;
end

del_t = 1/fs;

yscale = -n*del_t;
zeroy = yscale*[1;1]*[0:(nrows-1)];
half = 0.50;
offsets = (half*yscale)*[1;1]*ones(1,nrows);
sepy = [(zeroy-offsets) (zeroy(:,nrows)+(half*yscale)*[1;1])];

if ntick > 0 
   nnt   = [0:ntick:(lenx-1)];
   xtick = del_t*[1;1]*rem(nnt,n);
   ytick = yscale*( [1;1]*(fix(nnt/n)) + half*[1;-1]*ones(size(nnt)));
else
   xtick = 0; ytick = 0;
end

if xmax < 1		%% to prevent overlap of plots
  xmax = 1;
end
scale = half/xmax;
x = reshape( x, n, nrows );
for i = 1:nrows
   x(:,i) = -yscale*scale*x(:,i) + yscale*(i-1);
end

ends = del_t*[0;n-1];

h = plot( del_t*[0:(n-1)], x, '-k',  ends, sepy, ':k',...
      ends, zeroy, '--k', xtick, ytick, ':k' );
axis( [ ends'  [(nrows-0.5) -0.5]*yscale ] );
if( nargout>0 )
  hp = h;
end