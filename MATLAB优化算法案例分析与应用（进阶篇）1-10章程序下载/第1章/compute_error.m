function [clas_error]=compute_error(y,y_est)
% �������ø�ʽ
%   [clas_error]=compute_error(y,t_est)
% ����������
%����:
%   y:      N-dimensional vector �����ǩ
%   y_est:  N-dimensional vector ���շ������������
%���:
%   clas_error: �������.
 
[q,N]=size(y);   			% N = ��������
c=max(y);      			% ȷ��������
clas_error=0;   			% ��ʼ��
for i=1:N
    if(y(i)~=y_est(i))
        clas_error=clas_error+1;
    end
end
%���
clas_error=clas_error/N;
