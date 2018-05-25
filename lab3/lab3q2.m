[signal, Fs] = audioread('test_16k.wav');
R = 5; % window_shift;
L = [51, 101, 201, 401]; %window_size;
figure;

% short-time energy
figure;
for j = 1:4
    stenergy = zeros(1, round((length(signal)-L(j))/R));
    window = hamming(L(j));
    window_e = window.^2;
    for i = 1:length(stenergy)
        map_i = (i-1)*R+1;
        stenergy(i) = sum((signal(map_i:(map_i+L(j)-1)).^2).*window_e);
    end
    subplot(4,1,j);plot(stenergy);title(sprintf('short-time energy when L=%d', L(j)));xlim([0,length(stenergy)]);
end

% short time magnitude
for j = 1:4
    stmagnitude = zeros(1, round((length(signal)-L(j))/R));
    window = hamming(L(j));
    for i = 1:length(stmagnitude)
        map_i = (i-1)*R+1;
        stmagnitude(i) = sum(abs(signal(map_i:map_i+L(j)-1)).*window);
    end
    subplot(4,1,j);plot(stmagnitude);title(sprintf('short-time magnitude when L=%d',L(j)));xlim([0,length(stmagnitude)]);
end

% short time zero crossing
for j = 1:4
    stzeroc = zeros(1, round((length(signal)-L(j))/R));
    Hzerocross = dsp.ZeroCrossingDetector;
    for i = 1:length(stzeroc)
        map_i = (i-1)*R+1;
        stzeroc(i) = step(Hzerocross,signal(map_i:map_i+L(j)-1));
    end
    subplot(4,1,j);plot(stzeroc);title(sprintf('short-time zero-crossing when L=%d',L(j)));xlim([0,length(stzeroc)]);
    
end
