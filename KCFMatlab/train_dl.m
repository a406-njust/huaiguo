function [ tmpl_pre,alpha_pre ] = train_dl( tmpl_pre,tmpl_now,alpha_pre,prob,train_interp_factor )
%% gaussianCorrelation
[M,N] = size(tmpl_now);
size_patch = [14 22 31];
cl = N/size_patch(1);
sigma = 0.6;
x1=tmpl_now;
x2=tmpl_now;

c = zeros(16, 32);

for ii = 1:size_patch(3)
    x1aux = x1(ii,:);
    x1aux = reshape(x1aux, cl, size_patch(1));
    x1aux = x1aux.';
    
    x2aux = x2(ii,:);
    x2aux = reshape(x2aux, cl, size_patch(1));
    x2aux = x2aux.';
    
    caux = fft2(x1aux, 16, 32).*conj(fft2(x2aux, 16, 32));
    caux = ifft2(caux, 16, 32);
    
    caux = rearrange(caux);
    
    c = c+real(caux);
end
d = (sum(sum(x1.*x1)) + sum(sum(x2.*x2)) - 2*c) / (16*32*size_patch(3));

for ii = 1:16
    for jj = 1:32
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
alphaf=pres;

%% 更新参数
tmpl_pre = (1 - train_interp_factor) * tmpl_pre + (train_interp_factor) * tmpl_now;
alpha_pre = (1 - train_interp_factor) * alpha_pre + (train_interp_factor) * alphaf;
end

