function hann = createHanningMats(sizeX,sizeY,numFeatures)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
hann1t=zeros(1,sizeY);
hann2t=zeros(sizeX,1);
for  i= 1: sizeY
    hann1t(i) = 0.5 * (1 - cos(2 * 3.14159265358979323846 * (i -1)/ (sizeY - 1)));
end
for  i = 1: sizeX
    hann2t(i) = 0.5 * (1 - cos(2 * 3.14159265358979323846 * (i-1) / (sizeX - 1)));
end
hann2d=hann2t*hann1t;
hann1d=reshape_dl(hann2d,1,sizeX*sizeY);
hann=zeros(numFeatures,sizeX*sizeY);
for i=1:numFeatures
    hann(i,:)=hann1d;
end
end

