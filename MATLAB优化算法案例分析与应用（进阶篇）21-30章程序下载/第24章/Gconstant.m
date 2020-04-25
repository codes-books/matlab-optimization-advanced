function G=Gconstant(iteration,max_it)
% 万有引力常数计算
% 初始化值可以自己制定
alfa=20;G0=100;
G=G0*exp(-alfa*iteration/max_it); 
  
  
