function p = kirsch_algorithm(a)
% kirsch模板  方向算子 边缘检测
b=[-5 3 3;-5 0 3;-5 3 3]/1512;
c=[3 3 3;-5 0 3;-5 -5 3]/1512; 
d=[3 3 3;3 0 3;-5 -5 -5]/1512;
e=[3 3 3;3 0 -5; 3 -5 -5]/1512; 
f=[3 3 -5;3 0 -5;3 3 -5]/1512;
g=[3 -5 -5;3 0 -5;3 3 3]/1512; 
h=[-5 -5 -5;3 0 3;3 3 3]/1512;
i=[-5 -5 3;-5 0 3;3 3 3]/1512; 
b=conv2(a,b,'same');b=abs(b);
c=conv2(a,c,'same');c=abs(c); 
d=conv2(a,d,'same');d=abs(d);
e=conv2(a,e,'same');e=abs(e);
f=conv2(a,f,'same');f=abs(f);
g=conv2(a,g,'same');g=abs(g); 
h=conv2(a,h,'same');h=abs(h);
i=conv2(a,i,'same');i=abs(i); 
p=max(b,c);
p=max(d,p);
p=max(e,p);
p=max(f,p);
p=max(g,p);
p=max(h,p);
p=max(i,p); 
p = im2bw(p);