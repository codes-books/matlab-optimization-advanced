function [h,s,v] = rgb2hsv(r,g,b)
%RGB2HSV Convert red-green-blue colors to hue-saturation-value.
% 色度(H)和饱和度(S)、亮度(V)
switch nargin
  case 1,  % 输入一个量，即一副RGB图像
     validateattributes(r, {'uint8', 'uint16', 'double', 'single'}, {'real'}, mfilename, 'RGB', 1);
     
     if isa(r, 'uint8'),     % 图像数据类型uint8
        r = double(r) / 255; 
     elseif isa(r, 'uint16')  % 是否为uint16
        r = double(r) / 65535;
     end
  case 3,  % 输入为RGB三通道数据
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
      error(message('输入变量错误'));
end
  
threeD = (ndims(r)==3); % 判断r是否是三通道的数据

if threeD, %如果是的，分成ＲＧＢ三通道数据
  g = r(:,:,2); b = r(:,:,3); r = r(:,:,1);
  siz = size(r);
  r = r(:); g = g(:); b = b(:); % 化成一列
elseif nargin==1,
  g = r(:,2); b = r(:,3); r = r(:,1);
  siz = size(r);
else
  if ~isequal(size(r),size(g),size(b)), 
    error(message('RGB三通道数据维数不相同'));
  end
  siz = size(r);
  r = r(:); g = g(:); b = b(:);
end
% 色度(H)和饱和度(S)、亮度(V)
v = max(max(r,g),b);           % 最大值
h = zeros(size(v), 'like', r); % 色度
s = (v - min(min(r,g),b));     % 饱和度
% 公式
z = ~s;
s(~s) = 1;
k = find(r == v);  % r通道
h(k) = (g(k) - b(k))./s(k);
k = find(g == v);  % g通道
h(k) = 2 + (b(k) - r(k))./s(k);
k = find(b == v);  % b通道
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

if nargout<=1,  % 输出小于等于1个变量
  if (threeD || nargin==3),
    h = reshape(h,siz);  % 变为二维矩阵
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
