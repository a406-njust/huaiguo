%% getFeature
% 仿真版本1.0
% 2018.05.04
function [FeaturesMap,sizeX,sizeY,numFeatures ]=GetFeature(image,x,y,w,h,scale_adjust)
global scale;
padding = 4.00;
template_size = 90;
cell_size = 4;
inithann=1;
hogfeatures=1;
roi.x=x;
roi.y=y;
roi.width=w;
roi.height=h;
% Main
cx = roi.x+roi.width/2;
cy = roi.y+roi.height/2;
% f=fopen('image.txt','w');
% for i=1:960
%     for j=1:540
%         fprintf(f,'%d,',image(i,j));
%     end
%     fprintf(f,'\n');
% end
% imshow(image);
% fclose(f);
if inithann == 1
    padded_w = roi.width*padding;
    padded_h = roi.height*padding;
    
    if template_size > 1
        if padded_w >= padded_h
            scale = padded_w/template_size;
        else
            scale = padded_h/template_size;
        end
        
        tmpl_sz.width = padded_w / scale;
        tmpl_sz.height = padded_h / scale;
  
    else
        tmpl_sz.width = padded_w;
        tmpl_sz.height = padded_h;
        scale = 1;
    end
    
    if hogfeatures == 1
         tmpl_sz.width = floor(tmpl_sz.width/(2*cell_size))*2*cell_size + cell_size*2;
         tmpl_sz.height = floor(tmpl_sz.height/(2*cell_size))*2*cell_size + cell_size*2;
    else
        tmpl_sz.width = (tmpl_sz.width / 2) * 2;
        tmpl_sz.height = (tmpl_sz.height / 2) * 2;
    end
            
    extracted_roi.width = scale_adjust * scale * tmpl_sz.width;
    extracted_roi.height = scale_adjust * scale * tmpl_sz.height;
    
    extracted_roi.x = cx - extracted_roi.width / 2;
    extracted_roi.y = cy - extracted_roi.height / 2;
    
    z = subwindow(image, extracted_roi.x, extracted_roi.y, extracted_roi.width, extracted_roi.height);
    z=double(z);%转换成double型   revise
    [ww hh ]=size(z);
    if  hh~= tmpl_sz.width || ww ~= tmpl_sz.height
        z = resize(z,tmpl_sz.width,tmpl_sz.height);   %%修改之后，之前是resize
    end
    z=uint8(z);
%     imshow(z);
    [FeaturesMap,sizeX,sizeY,numFeatures ]=hog(z);
end
end
            