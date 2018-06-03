function [FeaturesMap,sizeX,sizeY,numFeatures ] = hog( z )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
[map,sizeX,sizeY,numFeatures ]=getFeatureMap(z);
[map,sizeX,sizeY,numFeatures ]= NormalizeandTruncate(map, sizeX,sizeY,numFeatures);
[map,sizeX,sizeY,numFeatures ]= PCAFeatureMaps(map, sizeX,sizeY);
FeaturesMap=reshape(map,[numFeatures,sizeX*sizeY]);   %size_patch[0]=sizeX  size_patch[1]=sizeY  size_patch[2]=numFeatures
hann=createHanningMats(sizeX,sizeY,numFeatures);
FeaturesMap=hann.*FeaturesMap;

end

