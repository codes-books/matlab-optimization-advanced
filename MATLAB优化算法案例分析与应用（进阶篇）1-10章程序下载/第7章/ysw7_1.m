% 求一维信号分形维数
clc        % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
data = csvread('lod78.csv');
samplerate = 365; % 采样率
freqsol = 400;    % 频率分辨率
timesol = 800;    % 时间分辨率
df = dbox(data,samplerate);   % 分形维数
disp(['分形维数为:   ',num2str(df)])
%%
clc        % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
data = csvread('lod78.csv');
data = awgn(data,10,'measured'); % Add white Gaussian noise.
samplerate = 365; % 采样率
freqsol = 400;    % 频率分辨率
timesol = 800;    % 时间分辨率
df = dbox(data,samplerate);   % 分形维数
disp(['分形维数为:   ',num2str(df)])
