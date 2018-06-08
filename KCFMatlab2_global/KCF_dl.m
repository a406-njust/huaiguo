clear all;
clc;
x=269;
y=400;
w=15;
h=13;
peak_value=0;
new_peak_value=0;  
template_size =90;   %Ä£°å´óÐ¡;
interp_factor = 0.012;
figure;
for ii = 1:266
    if ii<10
        filepath=['D:\VS2015\CX\×·×Ù\quicka\000',num2str(ii),'.jpg'];
        image=imread(filepath);
        image=image(:,:,1);
    end
    if ii>=10&&ii<100
        filepath=['D:\VS2015\CX\×·×Ù\quicka\00',num2str(ii),'.jpg'];
        image=imread(filepath);
        image=image(:,:,1);
    end
    if ii>=100
        filepath=['D:\VS2015\CX\×·×Ù\quicka\0',num2str(ii),'.jpg'];
        image=imread(filepath);
        image=image(:,:,1);
    end
    if ii ==1
       init(image,x,y,w,h);
       imshow(image,[]);
       rectangle('Position',[x,y,w,h],'EdgeColor','r');
       drawnow;
    else
%         if ii==49
%             pause;
%         end
        rect=updata(image,x,y,w,h);
        x=rect(1);
        y=rect(2);
        w=rect(3);
        h=rect(4);
        imshow(image,[]);
        %        fid=fopen('result.txt','a');
        %        fprintf(fid,'%d \n',ii);
        %        fprintf(fid,'%d %d \n',x,y);
        rectangle('Position',[x,y,w,h],'EdgeColor','r');
        drawnow;
    end
end
% fclose(fid);
