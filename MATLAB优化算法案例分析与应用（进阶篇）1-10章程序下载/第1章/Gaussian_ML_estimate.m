function [m_hat,S_hat]=Gaussian_ML_estimate(X)
% ʵ�������Ȼ����
% ����:
%   X:      ������
% ���:
%   m_hat:  ��ֵ����.
%   S_hat:  Э�������.
[l,N]=size(X);  					% ����ά��
m_hat=(1/N)*sum(X')';  			% ƽ��ֵ
S_hat=zeros(l);        			% ��ʼ��
for k=1:N
    S_hat=S_hat+(X(:,k)-m_hat)*(X(:,k)-m_hat)';  		% �����Ȼ����
end
S_hat=(1/N)*S_hat;      						% ȡƽ��
