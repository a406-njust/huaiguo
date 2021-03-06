function rect = updata( image,x,y,w,h)
global scale prob tmpl alphaf;
scale_step=0.9;
scale_weight=0.9;%调整的weight的比例大小;
[rows,cols]=size(image);
if (x + w <= 0) 
    x = -w + 1;
end
if (y + h <= 0)
    y = -h + 1;
end
if (x >= cols - 1) 
    x = cols - 2;
end
if (y >= rows - 1) 
    y = rows - 2;
end
cx = x + w / 2.0;
cy = y + h / 2.0;

%% detect 返回peak_value 跟位置偏差
FeatureMap=GetFeature(image,x,y,w,h,1,0);
[res,peak_value] = Detect(tmpl,FeatureMap,alphaf);

%测试不同的尺度情况下的
if (scale_step ~= 1)
    FeatureMap2=GetFeature(image, x,y,w,h, 1.0 / scale_step,0);
    [new_res,new_peak_value]= Detect(tmpl,FeatureMap2,alphaf);
    if (scale_weight * new_peak_value > peak_value) 
        res = new_res;
        peak_value = new_peak_value;
        scale = scale/scale_step;  %在getFeatures中定义
        w = w/scale_step;
        h = h/scale_step;
    end
    FeatureMap3=GetFeature(image, x,y,w,h, 1.0 / scale_step,0);
    [new_res,new_peak_value] = Detect(tmpl,FeatureMap3,alphaf );
    if (scale_weight * new_peak_value > peak_value) 
        res = new_res;
        peak_value = new_peak_value;
        scale = scale*scale_step;
        w = w*scale_step;
        h = h*scale_step;
    end
end
%% Adjust by cell size and _scale
x = cx - w / 2.0 + ( (res(1)-1) * 4 * scale);   %res(1):res.x
y = cy - h / 2.0 + ( (res(2)-1) * 4 * scale);   %res(2):rex.y

if (x >= cols - 1)
    x = cols - 1;
end
if (y >= rows - 1)
    y = rows - 1;
end
if (x + w <= 0)
    x = -w + 2;
end
if (y + h <= 0)
    y = -h + 2;
end
if (w < 0 || h <0)
    close;
end

%% 重新得到特征，再次训练
xx = GetFeature(image, x,y,w,h, 1,0);
train_dl(xx,0.012);
rect=[x,y,w,h];

end

