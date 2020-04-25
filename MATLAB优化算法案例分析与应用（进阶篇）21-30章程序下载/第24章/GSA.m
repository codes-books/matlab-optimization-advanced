% �������������㷨
function [Fbest,Lbest,BestChart,MeanChart]=GSA(F_index,N,max_it,ElitistCheck,min_flag,Rpower)
%V:   �ٶ�
%a:   ���ٶ�
%M:   ����.  Ma=Mp=Mi=M;
%dim: �����δ֪��ά��
%N:   �������Ӹ���
%X:   ��Ⱥ����λ��. dim-by-N matrix.
%R:   ��Ⱥ֮��ľ���
%[low-up]: ȡֵ��Χ
%Rnorm:  ����
%Rpower: Power of R 
Rnorm=2;  % 2�׷�������ŷ�Ͼ���
% ��ȡ�����Ŀ�귽�̵�δ֪�������Լ�ȡֵ��Χ
[low,up,dim]=test_functions_range(F_index); 
% ����ĳ�ʼ������
X=initialization(dim,N,up,low); 
% ��Ӧ��ֵ�����ʼ��
BestChart=[];
MeanChart=[];
V=zeros(N,dim); % �ٶȳ�ʼ��
for iteration=1:max_it  % ������ʼ
%     iteration
    
    % ���x�����Ƿ���ȡֵ��Χ��
    X=space_bound(X,up,low); 
    % ������Ӧ��ֵ
    fitness=evaluateF(X,F_index); 
    
    if min_flag==1
        [best best_X]=min(fitness); %minimization.
    else
        [best best_X]=max(fitness); %maximization.
    end        
    
    if iteration==1
       Fbest=best;Lbest=X(best_X,:);
    end
    if min_flag==1
      if best<Fbest  % ��Сֵ���
       Fbest=best;Lbest=X(best_X,:);
      end
    else 
      if best>Fbest  % ����ֵ���
       Fbest=best;Lbest=X(best_X,:);
      end
    end
      
BestChart=[BestChart Fbest];          % ������Ӧ��ֵ
MeanChart=[MeanChart mean(fitness)];  % ƽ����Ӧ��ֵ

% M����
[M]=massCalculation(fitness,min_flag); 
%����������������
G=Gconstant(iteration,max_it); 
%���ٶ�a����
a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it);

% �������
[X,V]=move(X,a,V);

end % ������ֹ

