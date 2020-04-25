% The code above is using basic library RandomPermutation below 
 function y=RandomPermutation(A)
 % return random permutation of matrix A
 % RandomPermutation rearrange member of matrix A randomly
 % This function is useful for MonteCarlo Simulation, 
 %
 % example: A = [ 2, 1, 5, 3]
 % RandomPermutation(A) may produce [ 1, 5, 3, 2] or [ 5, 3, 2, 1]
 % 
   [r,c]=size(A);
   b=reshape(A,r*c,1);       % convert to column vector
   x=randperm(r*c);          % make integer permutation��������һ��������ܵ�һ��)����,����;�����е���һ�����ֻ����� of similar array as key
   w=[b,x'];                 % combine matrix and key
   d=sortrows(w,2);          % sort according to key��sortrowsʲô���ã�
   y=reshape(d(:,1),r,c);    % return back the matrix ��d(:,1)��ʾd�ĵ�һ��ȫ����
 end
