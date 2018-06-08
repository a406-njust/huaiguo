function [map,sizeX,sizeY,numFeatures ]= PCAFeatureMaps(map, sizeX,sizeY)
NUM_SECTOR=9;
p = 108;
pp = NUM_SECTOR*3+4;
yp = 4;
xp = NUM_SECTOR;

nx = 1/sqrt(xp*2);
ny = 1/sqrt(yp);
col=sizeX*sizeY*pp;
newData = zeros(1,col);

for i = 1:sizeY
    for j = 1:sizeX
        pos1 = ((i-1)*sizeX+j-1)*p;
        pos2 = ((i-1)*sizeX+j-1)*pp;
        k = 1;
        for jj = 1:xp*2
            val = 0;
            for ii = 1:yp
                val = val+map(pos1+yp*xp+(ii-1)*xp*2+jj);
            end
            newData(pos2+k) = val*ny;
            k = k+1;
        end
        for jj = 1:xp
            val = 0;
            for ii = 1:yp
                val = val+map(pos1+(ii-1)*xp+jj);
            end
            newData(pos2+k) = val*ny;
            k = k+1;
        end
        for ii = 1:yp
            val = 0;
            for jj = 1:2*xp
                val = val+map(pos1+yp*xp+(ii-1)*xp*2+jj);
            end
            newData(pos2+k) = val*nx;
            k = k+1;
        end
    end
end
numFeatures = pp;
map = newData;
end
                
                
                
                