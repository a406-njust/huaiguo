function x=imfilter_dl(image,kernal)
    [row,col]=size(image);
    img=zeros(row+2,col+2);
    k=zeros(row,col);
    img(1,1)=0;
    img(1,col+2)=0;
    img(row+2,1)=0;
    img(row+2,col+2)=0;
    for ii=1:(row+2)
        for jj=1:(col+2)
            if(ii>1&&jj>1&&ii<(row+2)&&jj<(col+2))
                img(ii,jj)=image(ii-1,jj-1);
            end
            if(ii==1)
                if(jj>1&&jj<(col+2))
                    img(ii,jj)=image(ii,jj-1);
                end
            end
            if(ii==(row+2))
                if(jj>1&&jj<(col+2))
                    img(ii,jj)=image(row,jj-1);
                end
            end
            if(jj==1)
                if(ii>1&&ii<(row+2))
                    img(ii,jj)=image(ii-1,jj);
                end
            end
            if(jj==(col+2))
                if(ii>1&&ii<(row+2))
                    img(ii,jj)=image(ii-1,col);
                end
            end
        end
    end
    [row_k,col_k]=size(kernal);
    if(row_k>1)
        for ii=2:(row+1)
            for jj=2:(col+1)
                k(ii-1,jj-1)=img(ii-1,jj)*kernal(1)+img(ii,jj)*kernal(2)+img(ii+1,jj)*kernal(3);
            end
        end
    end
    if(col_k>1)
        for ii=2:(row+1)
            for jj=2:(col+1)
                k(ii-1,jj-1)=img(ii,jj-1)*kernal(1)+img(ii,jj)*kernal(2)+img(ii,jj+1)*kernal(3);
            end
        end
    end
    x=k;
end