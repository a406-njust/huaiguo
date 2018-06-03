clear all;
clc;
x=269;
y=402;
w=12;
h=8;
global scale prob;
peak_value=0;
new_peak_value=0;
scale_weight=0.9;    %调整的weight的比例大小;
template_size =90;   %模板大小;
interp_factor = 0.012;
figure;
for ii = 1:266
    if ii<10
        filepath=['D:\VS2015\CX\追踪\quick1\000',num2str(ii),'.jpg'];
        image=imread(filepath);
        image=image(:,:,1);
    end
    if ii>=10&&ii<100
        filepath=['D:\VS2015\CX\追踪\quick1\00',num2str(ii),'.jpg'];
        image=imread(filepath);
        image=image(:,:,1);
    end
    if ii>=100
        filepath=['D:\VS2015\CX\追踪\quick1\0',num2str(ii),'.jpg'];
        image=imread(filepath);
        image=image(:,:,1);
    end
    if ii ==1
       [tmpl,alphaf]=init(image,x,y,w,h);
       imshow(image);
       rectangle('Position',[x,y,w,h],'EdgeColor','r');
       drawnow;
    else
%         if ii==49
%             pause;
%         end
        [tmpl,alphaf,rect]=updata(image,x,y,w,h,tmpl,alphaf);
        x=rect(1);
        y=rect(2);
        w=rect(3);
        h=rect(4);
        imshow(image);
        %        fid=fopen('result.txt','a');
        %        fprintf(fid,'%d \n',ii);
        %        fprintf(fid,'%d %d \n',x,y);
        rectangle('Position',[x,y,w,h],'EdgeColor','r');
        drawnow;
    end
end
% fclose(fid);
