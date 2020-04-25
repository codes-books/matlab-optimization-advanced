% ÐÙÑÀÀûËã·¨
clc,clear,close all
warning off
feature jit off
A=[1 1 7 4
0 6 3 0
8 7 1 8
2 8 0 3
8 2 4 1];
[Matching,Cost] = Hungarian(A)
