function ycrcb_im =  rgb2ycrcb(r,g,b)
% RGB颜色空间向YCrCb彩色空间转化
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
elseif nargin==1,
  g = r(:,2); b = r(:,3); r = r(:,1);
else
  if ~isequal(size(r),size(g),size(b)), 
    error(message('RGB三通道数据维数不相同'));
  end
end

y1 = 65.481*r + 128.553*g + 24.966*b + 16;
y = y1 /256;
cr1 = -37.797*r - 74.203*g + 112*b + 128;
cr = cr1/256;
cb1 = 112*r - 93.786*g -18.214*b +128;
cb = cb1/256;
ycrcb_im = cat(3,(y),(cr),(cb));
