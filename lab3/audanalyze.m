function [  ] = audanalyze( input_file, window_type, window_shift, window_size)
%AUDANALYZE This function is to calculate and plot figures for lab3,q2.
signal = audioread(input_file);
R = window_shift;
L = window_size;
figure;
subplot(4,1,1);plot(signal);title('waveform');xlim([0,length(signal)]);
% Use the attribute window type to determine the window
if window_type == 'R'
    window = ones(1,L)';
elseif window_type == 'H'
    window = hamming(L);
end

% short time energy
window_e = window.^2;% effective window for short time energy
stenergy = zeros(1, round((length(signal)-L)/R));
for i = 1:length(stenergy)
    map_i = (i-1)*R+1;% map_i is n hat, beginning of each small piece 
    stenergy(i) = sum((signal(map_i:map_i+L-1).^2).*window_e);
end
subplot(4,1,2);plot(stenergy);title('short-time energy');xlim([0,length(stenergy)]);

% short time magnitude, almost the same with stenergy
stmagnitude = zeros(1, round((length(signal)-L)/R));
for i = 1:length(stmagnitude)
    map_i = (i-1)*R+1;
    stmagnitude(i) = sum(abs(signal(map_i:map_i+L-1)).*window);
end
subplot(4,1,3);plot(stmagnitude);title('short-time magnitude');xlim([0,length(stmagnitude)]);

% short time zero-crossing rate, using the object to calculate
stzeroc = zeros(1, round((length(signal)-L)/R));
Hzerocross = dsp.ZeroCrossingDetector;
for i = 1:length(stzeroc)
    map_i = (i-1)*R+1;
    stzeroc(i) = step(Hzerocross,signal(map_i:map_i+L-1));
end
subplot(4,1,4);plot(stzeroc);title('short-time zero-crossing');xlim([0,length(stzeroc)]);

end

