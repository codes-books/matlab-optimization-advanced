function flag=test(lenchrom,bound,code)
% lenchrom   input : Ⱦɫ�峤��
% bound      input : ������ȡֵ��Χ
% code       output: Ⱦɫ��ı���ֵ
t=code; %�Ƚ���
C = 140;  % �ź�����
L = 10;   % ����ʧʱ��
t4 = C-L - t(1)-t(2)-t(3);
flag=1;
if (t(1)<bound(1,1))||(t(2)<bound(2,1))||(t(3)<bound(3,1))||(t(1)>bound(1,2))||(t(2)>bound(2,2))||(t(3)>bound(3,2))||t4<22||t4>33
    flag=0;
end     