function z = resize( img,w,h )
%RESIZE 使用线性插值来resize矩阵，将矩阵img变为w*h
    src=img;
    [row,col]=size(img);
    scale_x=w/col;
    scale_y=h/row;
    m=scale_y;              %放大或缩小的高度
    n=scale_x;              %放大或缩小的宽度
%     img=imread('D:\VS2015\CX\追踪\quick1\0001.jpg');
%     img=img(:,:,1);
%     imshow(img);
    %[h w]=size(img);
    imgn=zeros(h,w);
    rot=[m 0 0;0 n 0;0 0 1];                                   %变换矩阵

    for i=1:h
        for j=1:w
            pix=[i j 1]/rot;   

            float_Y=pix(1)-floor(pix(1)); 
            float_X=pix(2)-floor(pix(2));

            if pix(1) < 1     %边界处理
                pix(1) = 1;
            end

            if pix(1) > row
                pix(1) = row;
            end

            if pix(2) < 1
                pix(2) =1;
            end

            if pix(2) > col
                pix(2) =col;
            end

            pix_up_left=[floor(pix(1)) floor(pix(2))];    %四个相邻的点
            pix_up_right=[floor(pix(1)) ceil(pix(2))];
            pix_down_left=[ceil(pix(1)) floor(pix(2))];
            pix_down_right=[ceil(pix(1)) ceil(pix(2))];     

            value_up_left=(1-float_X)*(1-float_Y); %计算临近四个点的权重
            value_up_right=float_X*(1-float_Y);
            value_down_left=(1-float_X)*float_Y;
            value_down_right=float_X*float_Y;
            imgn(i,j)=value_up_left*img(pix_up_left(1),pix_up_left(2))+ value_up_right*img(pix_up_right(1),pix_up_right(2))+ value_down_left*img(pix_down_left(1),pix_down_left(2))+ value_down_right*img(pix_down_right(1),pix_down_right(2));           
            
            imgn(i,j) =  floor(imgn(i,j)); %revise.否则结果会四舍五入
        end
    end
z=imgn;
  
end

