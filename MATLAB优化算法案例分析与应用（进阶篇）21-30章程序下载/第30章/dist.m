%�����i�������������λ�ã���������
function D=dist(Xi,X)
col=size(X,2);
D=zeros(1,col);
for j=1:col
    D(j)=norm(Xi-X(:,j));
end