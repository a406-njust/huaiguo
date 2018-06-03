function [tmpl,alphaf]=init(image,x,y,w,h)
%% �õ���������
global prob ;
if(w<0 || h<0)
    close;
end
roi=[x,y,w,h];
[tmplFirst,size_x,size_y,numFeature]=GetFeature(image,x,y,w,h,1);

%% creatGaussianPeak��д
res=zeros(size_y,size_x);   %size_xΪ22��size_yΪ14
syh=(size_y)/2;
sxh=(size_x)/2;
output_sigma=sqrt(size_x*size_y)/4*0.125;  %����4λpaddingֵ��0.125Ϊout_sigma_factor����Ϊ��ֵ
mult=-0.5/(output_sigma*output_sigma);
%��ʼ��res���и�ֵ
for ii=1:size_y
    for jj = 1:size_x
        ih=ii-syh-1;
        jh=jj-sxh-1;
        res(ii,jj)=exp(mult*(ih*ih+jh*jh));
    end
end
%��res����������ͬʱ����
new_res=zeros(16,32);
for ii=2:15
    for jj=6:27
        new_res(ii,jj)=res(ii-1,jj-5);
    end
end
prob(:,:,1)=real(fft2(new_res));    %prob����creatGaussianPeak�Ľ��
prob(:,:,2)=imag(fft2(new_res));

%% ����alpha ѵ������
alphaf=zeros(16,32);
[tmpl,alphaf]=train_dl(0,tmplFirst,0,prob,1.0);
end