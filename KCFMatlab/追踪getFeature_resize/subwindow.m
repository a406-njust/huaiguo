function z = subwindow( image,x,y,w,h )
%SUBWINDOW 提取image的局部，使用replication-padding
    xs = floor(x) + (2:(w+1)) ;
	ys = floor(y) + (2:(h+1)) ;
    xs(xs < 1) = 1;
	ys(ys < 1) = 1;
	xs(xs > size(image,2)) = size(image,2);
	ys(ys > size(image,1)) = size(image,1);
    z = image(ys, xs, :);


end

