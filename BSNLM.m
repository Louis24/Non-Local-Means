function DenoisedImg=NLmeans(I,ds,Ds,h)

I=double(I);
[m,n]=size(I);
DenoisedImg=zeros(m+2*ds,n+2*ds);
PaddedImg = padarray(I,[ds,ds],'symmetric','both');
h2=h*h;
for i=1:2:m
    for j=1:2:n
        i1=i+ds;
        j1=j+ds;
        W1=PaddedImg(i1-ds:i1+ds,j1-ds:j1+ds);%目标窗口
        wmax=0;
        average=zeros(3);
        sweight=0;
        %边界判定
        rmin = max(i1-Ds,ds+1);
        rmax = min(i1+Ds,m+ds);
        smin = max(j1-Ds,ds+1);
        smax = min(j1+Ds,n+ds);
        for r=rmin:rmax
            for s=smin:smax
                if(r==i1&&s==j1)
                    continue;
                end
                W2=PaddedImg(r-ds:r+ds,s-ds:s+ds);%对比窗口
                Dist2=sum(sum((W1-W2).*(W1-W2)./W2));
                w=exp(-Dist2/h2);
                if(w>wmax)
                    wmax=w;
                end
                sweight=sweight+w;
                average=average+w*W2;
            end
        end
        average=average+wmax*W1;%自身取最大权值 注意这里不能直接取1
        sweight=sweight+wmax;
        DenoisedImg(i1-ds:i1+ds,j1-ds:j1+ds) = DenoisedImg(i1-ds:i1+ds,j1-ds:j1+ds)+(average/sweight);%Zi Normalization
    end
end

 Scale=zeros(m,n);
 Scale(1:2:m-1,1:2:n-1)=1;
 Scale(2:2:m,2:2:n)=4;
 Scale(1:2:m-1,2:2:n)=2;
 Scale(2:2:m,1:2:n-1)=2;
 
 DenoisedImg=DenoisedImg(1+ds:m+ds,1+ds:n+ds);
 DenoisedImg=DenoisedImg./Scale;
 