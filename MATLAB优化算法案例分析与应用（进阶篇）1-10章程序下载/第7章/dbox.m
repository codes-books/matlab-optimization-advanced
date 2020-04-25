function df=dbox(s,Fs)
% df: 网格维数，
% s: 一维信号
% Fs: 采样频率
d=length(s);
da1=0;
da2=0;
if d/2==0
    s=[s,s(d)];  % 补成奇数个,方便第二个for循环
    d=d+1;      
end
for i=1:(d-1)
    a=abs(s(i)-s(i+1))*Fs; % 以1/Fs为边的正方形去覆盖两采样点连成的直线，所得正方形网格数
    da1=da1+a;
end
for j=1:2:(d-2)
    % 以2/Fs以1/Fs为边的正方形去覆盖临近三个采样点连成的折线区域，所得正方形网格数
    b=(max(s(j),max(s(j+1),s(j+2)))-min(s(j),min(s(j+1),s(j+2))))*Fs/2;
    da2=da2+b;
end
df=(log(da1)-log(da2))/log(2);    % 盒维数，公式见“低信噪比下基于短时分形维数的语音端点检测”
