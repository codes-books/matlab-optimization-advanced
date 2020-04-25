function [h,s,v] = rgb2hsv(r,g,b)
%RGB2HSV Convert red-green-blue colors to hue-saturation-value.
% ɫ��(H)�ͱ��Ͷ�(S)������(V)
switch nargin
  case 1,  % ����һ��������һ��RGBͼ��
     validateattributes(r, {'uint8', 'uint16', 'double', 'single'}, {'real'}, mfilename, 'RGB', 1);
     
     if isa(r, 'uint8'),     % ͼ����������uint8
        r = double(r) / 255; 
     elseif isa(r, 'uint16')  % �Ƿ�Ϊuint16
        r = double(r) / 65535;
     end
  case 3,  % ����ΪRGB��ͨ������
     validateattributes(r, {'uint8', 'uint16', 'double', 'single'}, {'real'}, mfilename, 'R', 1);
     validateattributes(g, {'uint8', 'uint16', 'double', 'single'}, {'real'}, mfilename, 'G', 2);
     validateattributes(b, {'uint8', 'uint16', 'double', 'single'}, {'real'}, mfilename, 'B', 3);

     if isa(r, 'uint8'), 
        r = double(r) / 255; 
     elseif isa(r, 'uint16')
        r = double(r) / 65535;
     end
     
     if isa(g, 'uint8'), 
        g = double(g) / 255; 
     elseif isa(g, 'uint16')
        g = double(g) / 65535;
     end
     
     if isa(b, 'uint8'), 
        b = double(b) / 255; 
     elseif isa(b, 'uint16')
        b = double(b) / 65535;
     end
     
  otherwise,
      error(message('�����������'));
end
  
threeD = (ndims(r)==3); % �ж�r�Ƿ�����ͨ��������

if threeD, %����ǵģ��ֳɣңǣ���ͨ������
  g = r(:,:,2); b = r(:,:,3); r = r(:,:,1);
  siz = size(r);
  r = r(:); g = g(:); b = b(:); % ����һ��
elseif nargin==1,
  g = r(:,2); b = r(:,3); r = r(:,1);
  siz = size(r);
else
  if ~isequal(size(r),size(g),size(b)), 
    error(message('RGB��ͨ������ά������ͬ'));
  end
  siz = size(r);
  r = r(:); g = g(:); b = b(:);
end
% ɫ��(H)�ͱ��Ͷ�(S)������(V)
v = max(max(r,g),b);           % ���ֵ
h = zeros(size(v), 'like', r); % ɫ��
s = (v - min(min(r,g),b));     % ���Ͷ�
% ��ʽ
z = ~s;
s(~s) = 1;
k = find(r == v);  % rͨ��
h(k) = (g(k) - b(k))./s(k);
k = find(g == v);  % gͨ��
h(k) = 2 + (b(k) - r(k))./s(k);
k = find(b == v);  % bͨ��
h(k) = 4 + (r(k) - g(k))./s(k);
h = h/6;
k = find(h < 0);
h(k) = h(k) + 1;
h(z) = 0;

tmp = s./v;
tmp(z) = 0;
k = find(v);
s(k) = tmp(k);
s(~v) = 0;

if nargout<=1,  % ���С�ڵ���1������
  if (threeD || nargin==3),
    h = reshape(h,siz);  % ��Ϊ��ά����
    s = reshape(s,siz);
    v = reshape(v,siz);
    h=cat(3,h,s,v);
  else
    h=[h s v];
  end
else
  h = reshape(h,siz);
  s = reshape(s,siz);
  v = reshape(v,siz);
end
