function [tmpl,alphaf]=init(image,x,y,w,h)
%% �õ���������
global prob sizeX sizeY new_sizeX new_sizeY;
if(w<0 || h<0)
    close;
end
roi=[x,y,w,h];
tmplFirst=GetFeature(image,x,y,w,h,1,1);

%% creatGaussianPeak��д
res=zeros(sizeY,sizeX);   %size_xΪ22��size_yΪ14
syh=(sizeY)/2;
sxh=(sizeX)/2;
output_sigma=sqrt(sizeX*sizeY)/4*0.125;  %����4λpaddingֵ��0.125Ϊout_sigma_factor����Ϊ��ֵ
mult=-0.5/(output_sigma*output_sigma);
%��ʼ��res���и�ֵ
for ii=1:sizeY
    for jj = 1:sizeX
        ih=ii-syh-1;
        jh=jj-sxh-1;
        res(ii,jj)=exp(mult*(ih*ih+jh*jh));
    end
end
%��res����������ͬʱ����
new_res=zeros(new_sizeY,new_sizeX);
r=(new_sizeY-sizeY)/2;
c=(new_sizeX-sizeX)/2;
for ii=(r+1):(new_sizeY-r)
    for jj=(c+1):(new_sizeX-c)
        new_res(ii,jj)=res(ii-r,jj-c);
    end
end
prob(:,:,1)=real(fft2(new_res));    %prob����creatGaussianPeak�Ľ��
prob(:,:,2)=imag(fft2(new_res));

%% ����alpha ѵ������
train_dl(tmplFirst,1.0);
end