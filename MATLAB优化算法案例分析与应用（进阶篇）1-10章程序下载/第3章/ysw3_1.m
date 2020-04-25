%第一层小波分解
clc,clear
load wbarb;
image(X);
colormap(map);
colorbar;
% 小波分解
[cA1,cH1,cV1,cD1] = dwt2(X,'bior3.7');
% 第一层小波逼近系数--cA1
% 水平系数--cH1
% 垂直系数--cV1
% 对角系数--cD1
A1 = upcoef2('a',cA1,'bior3.7',1);
H1 = upcoef2('h',cH1,'bior3.7',1); 
V1 = upcoef2('v',cV1,'bior3.7',1);
D1 = upcoef2('d',cD1,'bior3.7',1);
%显示第一层小波分解图形
colormap(map);
subplot(2,2,1); image(wcodemat(A1,192));
title('第一层小波逼近系数A1')
subplot(2,2,2); image(wcodemat(H1,192));
title('第一层小波水平系数H1')
subplot(2,2,3); image(wcodemat(V1,192));
title('第一层小波垂直系数V1') 
subplot(2,2,4); image(wcodemat(D1,192));
title('第一层小波对角系数D1')


%% 由单层逆小波变换重新产生一副图像
% 逆变换
Xsyn = idwt2(cA1,cH1,cV1,cD1,'bior3.7');
%To perform a level 2 decomposition of the image
[C,S] = wavedec2(X,2,'bior3.7'); 
%To extract the level 2 approximation coefficients from C
cA2 = appcoef2(C,S,'bior3.7',2);
%To extract the first- and second-level detail coefficients from C
cH2 = detcoef2('h',C,S,2);
cV2 = detcoef2('v',C,S,2);
cD2 = detcoef2('d',C,S,2);
cH1 = detcoef2('h',C,S,1);
cV1 = detcoef2('v',C,S,1);
cD1 = detcoef2('d',C,S,1);
%To reconstruct the level 2 approximation from C
A2 = wrcoef2('a',C,S,'bior3.7',2);
%To reconstruct the level 1 and 2 details from C
H1 = wrcoef2('h',C,S,'bior3.7',1);
V1 = wrcoef2('v',C,S,'bior3.7',1);
D1 = wrcoef2('d',C,S,'bior3.7',1);
H2 = wrcoef2('h',C,S,'bior3.7',2);
V2 = wrcoef2('v',C,S,'bior3.7',2);
D2 = wrcoef2('d',C,S,'bior3.7',2);
%To display the results of the level 2 decomposition
colormap(map);
subplot(2,4,1);image(wcodemat(A1,192));
title('第一层小波逼近系数A1')
subplot(2,4,2);image(wcodemat(H1,192));
title('第一层小波水平系数H1')
subplot(2,4,3);image(wcodemat(V1,192));
title('第一层小波垂直系数V1')
subplot(2,4,4);image(wcodemat(D1,192));
title('D第一层小波对角系数D1')
subplot(2,4,5);image(wcodemat(A2,192));
title('第二层小波逼近系数A2')
subplot(2,4,6);image(wcodemat(H2,192));
title('第二层小波水平系数H2')
subplot(2,4,7);image(wcodemat(V2,192));
title('第二层小波垂直系数V2')
subplot(2,4,8);image(wcodemat(D2,192));
title('第二层小波对角系数D2')

%%
%% 重构 the original image from the wavelet decomposition structure
X0 = waverec2(C,S,'bior3.7');
% 压缩图像X
[thr,sorh,keepapp]= ddencmp('cmp','wv',X);
% 降噪 or 压缩 using wavelets.
[Xcomp,CXC,LXC,PERF0,PERFL2] = ... 
wdencmp('gbl',C,S,'bior3.7',2,thr,sorh,keepapp);
% 对比查看压缩前后图像
colormap(map);
subplot(121); image(X); title('原始图像'); 
axis square
subplot(122); image(Xcomp); title('压缩图像'); 
axis square




