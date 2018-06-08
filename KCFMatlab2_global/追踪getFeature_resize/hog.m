function FeaturesMap = hog( z )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global sizeX sizeY numFeatures new_sizeX new_sizeY;
[map,sizeX,sizeY,numFeatures ]=getFeatureMap(z);
[map,sizeX,sizeY,numFeatures ]= NormalizeandTruncate(map, sizeX,sizeY,numFeatures);
[map,sizeX,sizeY,numFeatures ]= PCAFeatureMaps(map, sizeX,sizeY);
FeaturesMap=reshape(map,[numFeatures,sizeX*sizeY]);   %size_patch[0]=sizeX  size_patch[1]=sizeY  size_patch[2]=numFeatures
hann=createHanningMats(sizeX,sizeY,numFeatures);  %%���Ӧ��ִֻ��һ��
FeaturesMap=hann.*FeaturesMap;

%% �ҵ���sizeX,sizeY�����2�Ĵη���
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

