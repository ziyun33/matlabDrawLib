function [img_out, y] = imgfft(img)
%% 输入：二维图像，输出：[fft后图像, 每个频率的平均值]

I = im2gray(img);
I1=im2double(I);

%归一化
I2 = Normalize(I1);

%将图像长、宽化为奇数
[M,N]=size(I2);
I3 = I2(1:2*ceil(M/2)-1,1:2*ceil(N/2)-1);

img_fft = fft2(I3); % 对图像进行傅里叶变换
img_fftshift = fftshift(img_fft); % 将低频分量置于中心
img_out = log(abs(img_fftshift)+1); % 取对数

y = fft_count(img_out); % 不同频率计数

end

function output = Normalize(input)
    [M, N] = size(input);
    if M==1 || N==1
        output = (input - min(input))/(max(input) - min(input));
    else
        output = (input - min(min(input)))/(max(max(input)) - min(min(input)));
    end
end

function y = fft_count(img)
[M,N]=size(img);
sum_t=zeros(1,round((M+1)/2));
sum_m=zeros(1,round((M+1)/2));
c=zeros(1,round((M+1)/2));
for k=0:(M+1)/2-1
for i=1:M
   for j=1:N
       distance=round(sqrt((i-(M+1)/2)^2+(j-(N+1)/2)^2));
       if distance==k
          sum_t(1,k+1)=sum_t(1,k+1)+img(i,j);
          c(1,k+1)=c(1,k+1)+1;
       end
   end
end
if c(1,k+1)>0
 sum_m(1,k+1)=sum_t(1,k+1)/c(1,k+1);
end
end
y = sum_m;
end