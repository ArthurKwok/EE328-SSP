%question 1
x1 = 0.5.^(1:128);
x1_c = myCepstrum(x1,'C');
stem(-64:63,x1_c,'Marker','.');title('complex cepstrum of input signal');xlabel('quefrency, nT');axis([-64,63,-1,1]);

%question 2
x2 = [1, zeros(1,99), 0.85];
subplot(3,1,1);stem(x2);title('original signal');xlabel('Time');ylim([-1,1]);
subplot(3,1,2);stem(myCepstrum(x2,'C'));title('complex cepstrum');xlabel('Quefrency');axis([0,2048,-1,1]);
subplot(3,1,3);stem(myCepstrum(x2,'R'));title('real cepstrum');xlabel('Quefrency');axis([0,2048,-1,1]);

%question 3 
speAnal('test_16k.wav', 13000, 400); 