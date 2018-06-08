% normalizeAndTruncate
function [map,sizeX,sizeY,numFeatures ]= NormalizeandTruncate(map, sizeX,sizeY,numFeatures)

NUM_SECTOR = 9;
alfa=0.2000000;
FLT_EPSILON = 1.192092896e-07;
partOfNorm = zeros(1, sizeX*sizeY);

p = NUM_SECTOR;
xp = NUM_SECTOR*3;
pp = NUM_SECTOR*12;

for i = 1 : sizeX*sizeY
    valOfNorm = 0;
    pos = (i-1)*numFeatures;
    for j = 1 : p
        valOfNorm = valOfNorm + map(pos+j)^2;
    end
    partOfNorm(i) = valOfNorm;
end

sizeX = sizeX-2;
sizeY = sizeY-2;

newData = zeros(1, sizeX*sizeY*pp);
% Normalization
for i = 1:sizeY
    for j = 1:sizeX
        valOfNorm = sqrt(partOfNorm(i*(sizeX+2)+j+1)+partOfNorm(i*(sizeX+2)+j+1+1)+partOfNorm((i+1)*(sizeX+2)+j+1)+partOfNorm((i+1)*(sizeX+2)+j+1+1))+FLT_EPSILON;
        pos1 = i*(sizeX+2)*xp+j*xp;
        pos2 = (i-1)*sizeX*pp+(j-1)*pp;
        for ii = 1:p
            newData(pos2+ii) = map(pos1+ii)/valOfNorm;
        end
        for ii=1:2*p
            newData(pos2+ii+p*4) = map(pos1+ii+p)/valOfNorm;
        end
        valOfNorm = sqrt(partOfNorm(i*(sizeX+2)+j+1)+partOfNorm(i*(sizeX+2)+j+1+1)+partOfNorm((i-1)*(sizeX+2)+j+1)+partOfNorm((i-1)*(sizeX+2)+j+1+1))+FLT_EPSILON;
        for jj = 1:p
            newData(pos2+jj+p) = map(pos1+jj)/valOfNorm;
        end
        for ii=1:2*p
            newData(pos2+ii+p*6) = map(pos1+ii+p)/valOfNorm;
        end
        valOfNorm = sqrt(partOfNorm(i*(sizeX+2)+j+1)+partOfNorm(i*(sizeX+2)+j)+partOfNorm((i+1)*(sizeX+2)+j+1)+partOfNorm((i+1)*(sizeX+2)+j))+FLT_EPSILON;
        for jj = 1:p
            newData(pos2+jj+p*2) = map(pos1+jj)/valOfNorm;
        end
        for ii=1:2*p
            newData(pos2+ii+p*8) = map(pos1+ii+p)/valOfNorm;
        end
        valOfNorm = sqrt(partOfNorm(i*(sizeX+2)+j+1)+partOfNorm(i*(sizeX+2)+j)+partOfNorm((i-1)*(sizeX+2)+j+1)+partOfNorm((i-1)*(sizeX+2)+j))+FLT_EPSILON;
        for jj = 1:p
            newData(pos2+jj+p*3) = map(pos1+jj)/valOfNorm;
        end
        for ii=1:2*p
            newData(pos2+ii+p*10) = map(pos1+ii+p)/valOfNorm;
        end
    end
end
% truncation
for i = 1:sizeX*sizeY*pp
    if newData(i) > alfa
        newData(i) = alfa;
    end
end

numFeatures = pp;
% sizeX = sizeX;
% sizeY = sizeY;

map = newData;
end
        
        
        
        
        
        