% 求一维信号分形维数
clc        % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
data = csvread('lod78.csv');
plot(data(:,500:1500))
hold on
plot(data(:,500:1500),'s')
axis tight
xlabel('t');ylabel('赋值')
