function   fitness=evaluateF(X,F_index);
% ������Ӧ��ֵ
[N,dim]=size(X);
for i=1:N 
    % L �� 'i' ����Ⱥ������һ��δ֪����ĸ���
    L=X(i,:); 
    % �� 'i' ����Ⱥ����Ӧ�ȼ������
    fitness(i)=test_functions(L,F_index,dim);
end