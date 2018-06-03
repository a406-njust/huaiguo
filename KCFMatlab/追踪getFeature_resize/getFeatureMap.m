function [map,sizeX,sizeY,numFeatures ]= getFeatureMap(image)
k=4;
numChannels = 1;
NUM_SECTOR = 9;
kernel = [-1, 0, 1];

kernel_dx = kernel;
kernel_dy = kernel.';

boundary_x = zeros(1, NUM_SECTOR+1);
boundary_y = zeros(1, NUM_SECTOR+1);

[height, width] = size(image);

dx = zeros(height, width);
dy = zeros(height, width);

sizeX = width/k;
sizeY = height/k;
px = 3*NUM_SECTOR;
p = px;
stringSize = sizeX*p;

% allocFeatureMapObject
numFeatures = p;
map = zeros(1, sizeX*sizeY*p);

% cvFilter2D
dx=imfilter_dl(image,kernel_dx);
dy=imfilter_dl(image,kernel_dy);
% dx = imfilter (image, kernel_dx, 'replicate');
% dy = imfilter (image, kernel_dy, 'replicate');

for i = 1:( NUM_SECTOR+1)
    arg_vector = double((i-1)*(3.1415926535897932384626433832795)/double(NUM_SECTOR));
    boundary_x(i) = cos(arg_vector);
    boundary_y(i) = double(sin(arg_vector));
end

r = zeros(1, width*height);
alfa = zeros(1, width*height*2);

for j = 2 : (height-1)
    for i = 2 : (width-1)
        c = 0;
        x = dx(j, i+c);
        y = dy(j, i+c);
        
        r((j-1)*width+i) = sqrt(x^2+y^2);
        
        max = boundary_x(1)*x + boundary_y(1)*y;
        maxi = 0;
        
        for kk = 1:NUM_SECTOR
            dotProd = boundary_x(kk)*x+boundary_y(kk)*y;
            if dotProd > max
                max = dotProd;
                maxi = kk-1;
            else
                if -dotProd > max
                    max = -dotProd;
                    maxi = kk-1+NUM_SECTOR;
                end
            end
        end
        
        alfa((j-1)*width*2+(i-1)*2+1) = rem(maxi, NUM_SECTOR);
        alfa((j-1)*width*2+(i-1)*2+2) = maxi;
    end
end

nearest = [-1 -1 1 1];
w = [0.625 0.375 0.875 0.125 0.875 0.125 0.625 0.375];

for i = 1:sizeY
    for j = 1:sizeX
        for ii = 1:k
            for jj = 1:k
                if ((i-1)*k+ii > 1) && ((i-1)*k+ii < height) && ((j-1)*k+jj > 1) && ((j-1)*k+jj < width)
                    d = (k*(i-1)+ii-1)*width+((j-1)*k+jj);
%                     if ((i+nearest(ii)-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1)==9738
%                         bbb=1;
%                     end
                    map((i-1)*stringSize+(j-1)*numFeatures+alfa((d-1)*2+1)+1) =  map((i-1)*stringSize+(j-1)*numFeatures+alfa((d-1)*2+1)+1) + r(d)*w((ii-1)*2+1)*w((jj-1)*2+1);
                    map((i-1)*stringSize+(j-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1) =  map((i-1)*stringSize+(j-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1) + r(d)*w((ii-1)*2+1)*w((jj-1)*2+1);
                    if i+nearest(ii) >= 1 && i +nearest(ii) <= sizeY
                        map((i+nearest(ii)-1)*stringSize+(j-1)*numFeatures+alfa((d-1)*2+1)+1) =  map((i+nearest(ii)-1)*stringSize+(j-1)*numFeatures+alfa((d-1)*2+1)+1) + r(d)*w((ii-1)*2+2)*w((jj-1)*2+1);
                        map((i+nearest(ii)-1)*stringSize+(j-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1) =  map((i+nearest(ii)-1)*stringSize+(j-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1)+ r(d)*w((ii-1)*2+2)*w((jj-1)*2+1);
                    end
                    if j +nearest(jj) >= 1 && j+nearest(jj) <= sizeX
                        map((i-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+1)+1) =  map((i-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+1)+1) + r(d)*w((ii-1)*2+1)*w((jj-1)*2+2);
                        map((i-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1) =  map((i-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1) + r(d)*w((ii-1)*2+1)*w((jj-1)*2+2);
                    end
                    if i+nearest(ii) >= 1 && i+nearest(ii) <= sizeY &&j+nearest(jj) >= 1 && j+nearest(jj) <= sizeX 
                        map((i+nearest(ii)-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+1)+1) =  map((i+nearest(ii)-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+1)+1) + r(d)*w((ii-1)*2+2)*w((jj-1)*2+2);
                        map((i+nearest(ii)-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1) =  map((i+nearest(ii)-1)*stringSize+(j+nearest(jj)-1)*numFeatures+alfa((d-1)*2+2)+NUM_SECTOR+1)+ r(d)*w((ii-1)*2+2)*w((jj-1)*2+2);
                    end
                end
            end
        end
    end
end
end


% 
