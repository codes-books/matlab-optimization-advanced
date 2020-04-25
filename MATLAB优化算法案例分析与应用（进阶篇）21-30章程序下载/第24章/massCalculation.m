function [M]=massCalculation(fit,min_flag)
% 计算每个智能体的质量

Fmax=max(fit); Fmin=min(fit);  % 最大最小 
Fmean=mean(fit);   % 平均
[i N]=size(fit);

if Fmax==Fmin
   M=ones(N,1);
else
    
   if min_flag==1  % 极小值求解
      best=Fmin;worst=Fmax;
   else            % 极大值求解
      best=Fmax;worst=Fmin;
   end
  
   M=(fit-worst)./(best-worst);  % M求解

end

M=M./sum(M); 