function [M]=massCalculation(fit,min_flag)
% ����ÿ�������������

Fmax=max(fit); Fmin=min(fit);  % �����С 
Fmean=mean(fit);   % ƽ��
[i N]=size(fit);

if Fmax==Fmin
   M=ones(N,1);
else
    
   if min_flag==1  % ��Сֵ���
      best=Fmin;worst=Fmax;
   else            % ����ֵ���
      best=Fmax;worst=Fmin;
   end
  
   M=(fit-worst)./(best-worst);  % M���

end

M=M./sum(M); 