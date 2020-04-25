function D = myfractal(I)
% 求图形分形维数的程序---差分盒维数计算
% I：输入二维图像
% D: 返回分形维数
[M,N]=size(I);
TotalGary=0;
Rmax=sqrt((M-1)^2+(N-1)^2); %求最大距离
Nr=zeros(1,floor(Rmax));
for k=1:floor(Rmax)
    for i=1:M
        for j=1:N
            for m=1:M
                for n=1:N
                    if k==1
                        TotalGary=TotalGary+double(abs(I(i,j)-I(m,n)));
                    end
                    if k<=sqrt((i-m)^2+(j-n)^2)&sqrt((i-m)^2+(j-n)^2)<(k+1) 
                        Nr(k)=Nr(k)+1;
                    end
                end;
            end;
        end;
    end;
end;
k=[1:floor(Rmax)];
E=2.*TotalGary.*ones(1,floor(Rmax))./Nr(1,floor(Rmax));
[P ,s]=polyfit(log(k),log(E),1); 
D=3-P(1);  
