function hann1 = reshape_dl(hann2d,new_rows,new_cols)
%��hann2d reshape��һά�ź�
%   �˴���ʾ��ϸ˵��
[rows,cols]=size(hann2d);
hann1=zeros(new_rows,new_cols);
for i=1:rows
    for j=1:cols
        hann1(1,j+(cols*(i-1)))=hann2d(i,j);
    end
end

end

