clc;clear;close all
[FileName,PathName] = uigetfile({'*.wav'},'Load Wav File');
[x,fs] = wavread([PathName '/' FileName]);
handlesx = x;
handlesfs = fs;
time = 0:1/fs:(length(handlesx)-1)/fs;
figure,plot(time,handlesx(:,1));
figure,plot(time,handlesx(:,2));
title('Original Signal');
figure,specgram(handlesx(:,1), 1024, handlesfs);
figure,specgram(handlesx(:,2), 1024, handlesfs);
title('Spectrogram of Original Signal');
%% play
handlesFSQ=1; % -1:3
fs = handlesfs*(1 + handlesFSQ);
sound(handlesx, fs);
%% formants
h = spectrum.welch;
hs = psd(h,handlesx,'fs',handlesfs);
figure;plot(hs);
title('¹¦ÂÊÆ×ÃÜ¶È')


