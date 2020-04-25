function ycrcb_im =  rgb2ycrcb(r,g,b)
% RGB��ɫ�ռ���YCrCb��ɫ�ռ�ת��
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
elseif nargin==1,
  g = r(:,2); b = r(:,3); r = r(:,1);
else
  if ~isequal(size(r),size(g),size(b)), 
    error(message('RGB��ͨ������ά������ͬ'));
  end
end

y1 = 65.481*r + 128.553*g + 24.966*b + 16;
y = y1 /256;
cr1 = -37.797*r - 74.203*g + 112*b + 128;
cr = cr1/256;
cb1 = 112*r - 93.786*g -18.214*b +128;
cb = cb1/256;
ycrcb_im = cat(3,(y),(cr),(cb));
