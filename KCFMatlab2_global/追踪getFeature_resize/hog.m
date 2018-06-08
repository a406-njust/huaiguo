function FeaturesMap = hog( z )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
global sizeX sizeY numFeatures new_sizeX new_sizeY;
[map,sizeX,sizeY,numFeatures ]=getFeatureMap(z);
[map,sizeX,sizeY,numFeatures ]= NormalizeandTruncate(map, sizeX,sizeY,numFeatures);
[map,sizeX,sizeY,numFeatures ]= PCAFeatureMaps(map, sizeX,sizeY);
FeaturesMap=reshape(map,[numFeatures,sizeX*sizeY]);   %size_patch[0]=sizeX  size_patch[1]=sizeY  size_patch[2]=numFeatures
hann=createHanningMats(sizeX,sizeY,numFeatures);  %%这个应该只执行一次
FeaturesMap=hann.*FeaturesMap;

%% 找到离sizeX,sizeY最近的2的次方数
for i=1:10
    if(sizeX< 2^(i))
        new_sizeX = 2^(i);
        break;
    end
end
for j=1:10
    if(sizeY< 2^(j))
        new_sizeY = 2^(j);
        break;
    end
end
end

