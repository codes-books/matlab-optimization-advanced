% ��һά�źŷ���ά��
clc        % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
data = csvread('lod78.csv');
plot(data(:,500:1500))
hold on
plot(data(:,500:1500),'s')
axis tight
xlabel('t');ylabel('��ֵ')
