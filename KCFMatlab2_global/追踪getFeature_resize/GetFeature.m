%% getFeature
% 仿真版本1.0
% 2018.05.04
function FeaturesMap=GetFeature(image,x,y,w,h,scale_adjust,inithann)
global scale tmpl_sz_width tmpl_sz_height ;
padding = 6.00;
template_size = 95;
cell_size = 4;
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
        
        tmpl_sz_width = padded_w / scale;
        tmpl_sz_height = padded_h / scale;
  
    else
        tmpl_sz_width = padded_w;
        tmpl_sz_height = padded_h;
        scale = 1;
    end
    
    if hogfeatures == 1
         tmpl_sz_width = floor(tmpl_sz_width/(2*cell_size))*2*cell_size + cell_size*2;
         tmpl_sz_height = floor(tmpl_sz_height/(2*cell_size))*2*cell_size + cell_size*2;
    else
        tmpl_sz_width = (tmpl_sz_width / 2) * 2;
        tmpl_sz_height = (tmpl_sz_height / 2) * 2;
    end
end         
    extracted_roi.width = scale_adjust * scale * tmpl_sz_width;
    extracted_roi.height = scale_adjust * scale * tmpl_sz_height;
    
    extracted_roi.x = cx - extracted_roi.width / 2;
    extracted_roi.y = cy - extracted_roi.height / 2;
    
    z = subwindow(image, extracted_roi.x, extracted_roi.y, extracted_roi.width, extracted_roi.height);
    z=double(z);%转换成double型   revise
    [ww hh ]=size(z);
    if  hh~= tmpl_sz_width || ww ~= tmpl_sz_height
        z = resize(z,tmpl_sz_width,tmpl_sz_height);   %%修改之后，之前是resize
    end
    z=uint8(z);
%     imshow(z);
    FeaturesMap=hog(z);

end
            