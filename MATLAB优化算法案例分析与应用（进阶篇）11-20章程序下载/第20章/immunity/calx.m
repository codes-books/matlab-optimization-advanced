%实现个体的解码的计算
function [objx]=calx(pop)
% global N length  % 默认染色体的二进制长度length=10
N=12; length=10;
for j=1:N  %译码！
   temp(:,j)=decodechrom(pop,1+(j-1)*length,length);      %将newpop每行(个体）每列（每段基因）转化成十进制数
   x(:,j)=temp(:,j)/(2^length-1)*(max(j)-min(j))+min(j);     % popsize×N 将二值域中的数转化为变量域的数       
end
objx = x;         % 实现个体的解码的计算