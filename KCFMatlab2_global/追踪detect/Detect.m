function [pos,peak_value]=Detect(z1,x1,alpha1) 
%% GaussianCorrelation
global sizeX sizeY new_sizeX new_sizeY numFeatures;
x2 = z1;
alphaf1 = alpha1(:,:,1);
alphaf2 = alpha1(:,:,2);
[M,N] = size(x1);
size_patch = [sizeY sizeX numFeatures];
cl = N/size_patch(1);
sigma = 0.6;
c = zeros(new_sizeY, new_sizeX);

for ii = 1:size_patch(3)
    x1aux = x1(ii,:);
    x1aux = reshape(x1aux, cl, size_patch(1));
    x1aux = x1aux.';
    
    x2aux = x2(ii,:);
    x2aux = reshape(x2aux, cl, size_patch(1));
    x2aux = x2aux.';
    
    caux = fft2(x1aux, new_sizeY, new_sizeX).*conj(fft2(x2aux, new_sizeY, new_sizeX));
    caux = ifft2(caux, new_sizeY, new_sizeX);
    
    caux = rearrange(caux);
    
    c = c+real(caux);
end
d = (sum(sum(x1.*x1)) + sum(sum(x2.*x2)) - 2*c) / (new_sizeY*new_sizeX*size_patch(3));

for ii = 1:new_sizeY
    for jj = 1:new_sizeX
        k(ii,jj) = exp(-d(ii,jj)/(sigma*sigma));
    end
end
%新加：complexMultiplication
b1=real(fft2(k,new_sizeY, new_sizeX));  %k做FFT之后的实部
b2=imag(fft2(k,new_sizeY, new_sizeX));  %k做FFT之后的虚部
pres1=b1.*alphaf1-b2.*alphaf2;  %两实部点乘减去两虚部点乘
pres2=alphaf1.*b2-alphaf2.*b1;  %alpha的实部乘k的虚部减去。。。。
pres=zeros(new_sizeY,new_sizeX);
for ii=1:new_sizeY               %拼接实部和虚部
    for jj=1:new_sizeX
        pres(ii,jj)=pres1(ii,jj)+pres2(ii,jj)*i;
    end
end

res = real(ifft2(pres, new_sizeY, new_sizeX));

PV = max(max(res));
[posy_tmp, posx_tmp] = find(res == max(max(res)));

[rows, cols] = size(res);

if posx_tmp > 1 && posx_tmp <  (cols-1)
    posx = posx_tmp + subPixelPeak(res(posy_tmp, posx_tmp-1), PV, res(posy_tmp, posx_tmp+1));
end
if posy_tmp> 1 && posy_tmp < (rows-1)
    posy = posy_tmp + subPixelPeak(res(posy_tmp-1, posx_tmp), PV, res(posy_tmp+1, posx_tmp));
end
posx = posx - cols/2;
posy = posy - rows/2;
pos=[posx,posy];
peak_value=PV;
end
