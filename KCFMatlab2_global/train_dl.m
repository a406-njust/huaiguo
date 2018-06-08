function train_dl(tmpl_now,train_interp_factor )
%% gaussianCorrelation
global sizeX sizeY numFeatures new_sizeX new_sizeY tmpl alphaf prob;
[M,N] = size(tmpl_now);
size_patch = [sizeY sizeX numFeatures];
cl = N/size_patch(1);
sigma = 0.6;
x1=tmpl_now;
x2=tmpl_now;

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
d = (sum(sum(x1.*x1)) + sum(sum(x2.*x2)) - 2*c) / (new_sizeX*new_sizeY*size_patch(3));

for ii = 1:new_sizeY
    for jj = 1:new_sizeX
        k(ii,jj) = exp(-d(ii,jj)/(sigma*sigma));
    end
end

%% 求出alpha
pb1=real(fft2(k)+0.0001);
pb2=imag(fft2(k)+0.0001);
mid=(pb1.*(pb1)+ pb2.*(pb2));
divisor=1./mid;
pres1=(prob(:,:,1).*(pb1) + prob(:,:,2).*(pb2));
pres1=pres1.*(divisor);
pres2=(prob(:,:,2).*(pb1) + prob(:,:,1).*(pb2));
pres2=pres2.*(divisor);
pres(:,:,1)=pres1;
pres(:,:,2)=pres2;
alphaf_f=pres;

%% 更新参数
if(isempty(tmpl))
    tmpl=0;
end
if(isempty(alphaf))
    alphaf=0;
end
tmpl = (1 - train_interp_factor) * tmpl + (train_interp_factor) * tmpl_now;
alphaf = (1 - train_interp_factor) * alphaf + (train_interp_factor) * alphaf_f;
end

