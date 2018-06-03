function [tmpl,alphaf]=init(image,x,y,w,h)
%% 得到特征矩阵
global prob ;
if(w<0 || h<0)
    close;
end
roi=[x,y,w,h];
[tmplFirst,size_x,size_y,numFeature]=GetFeature(image,x,y,w,h,1);

%% creatGaussianPeak拆开写
res=zeros(size_y,size_x);   %size_x为22，size_y为14
syh=(size_y)/2;
sxh=(size_x)/2;
output_sigma=sqrt(size_x*size_y)/4*0.125;  %这里4位padding值，0.125为out_sigma_factor，都为定值
mult=-0.5/(output_sigma*output_sigma);
%开始对res进行赋值
for ii=1:size_y
    for jj = 1:size_x
        ih=ii-syh-1;
        jh=jj-sxh-1;
        res(ii,jj)=exp(mult*(ih*ih+jh*jh));
    end
end
%在res的上下左右同时补零
new_res=zeros(16,32);
for ii=2:15
    for jj=6:27
        new_res(ii,jj)=res(ii-1,jj-5);
    end
end
prob(:,:,1)=real(fft2(new_res));    %prob等于creatGaussianPeak的结果
prob(:,:,2)=imag(fft2(new_res));

%% 建立alpha 训练参数
alphaf=zeros(16,32);
[tmpl,alphaf]=train_dl(0,tmplFirst,0,prob,1.0);
end