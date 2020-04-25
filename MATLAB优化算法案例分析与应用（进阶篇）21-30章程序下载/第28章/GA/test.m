function flag=test(lenchrom,bound,code)
% lenchrom   input : 染色体长度
% bound      input : 变量的取值范围
% code       output: 染色体的编码值
t=code; %先解码
C = 140;  % 信号周期
L = 10;   % 总损失时间
t4 = C-L - t(1)-t(2)-t(3);
flag=1;
if (t(1)<bound(1,1))||(t(2)<bound(2,1))||(t(3)<bound(3,1))||(t(1)>bound(1,2))||(t(2)>bound(2,2))||(t(3)>bound(3,2))||t4<22||t4>33
    flag=0;
end     