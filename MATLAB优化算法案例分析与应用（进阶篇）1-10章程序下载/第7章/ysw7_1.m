% ��һά�źŷ���ά��
clc        % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
data = csvread('lod78.csv');
samplerate = 365; % ������
freqsol = 400;    % Ƶ�ʷֱ���
timesol = 800;    % ʱ��ֱ���
df = dbox(data,samplerate);   % ����ά��
disp(['����ά��Ϊ:   ',num2str(df)])
%%
clc        % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
data = csvread('lod78.csv');
data = awgn(data,10,'measured'); % Add white Gaussian noise.
samplerate = 365; % ������
freqsol = 400;    % Ƶ�ʷֱ���
timesol = 800;    % ʱ��ֱ���
df = dbox(data,samplerate);   % ����ά��
disp(['����ά��Ϊ:   ',num2str(df)])
