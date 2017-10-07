function DenoisedImg=NLmeans(I,ds,Ds,h)

I=double(I);
[m,n]=size(I);
DenoisedImg=zeros(m,n);
PaddedImg = padarray(I,[ds,ds],'symmetric','both');
h2=h*h;
for i=1:m
    for j=1:n
        i1=i+ds;
        j1=j+ds;
        W1=PaddedImg(i1-ds:i1+ds,j1-ds:j1+ds);%Ŀ�괰��
        wmax=0;
        average=0;
        sweight=0;
        %�߽��ж�
        rmin = max(i1-Ds,ds+1);
        rmax = min(i1+Ds,m+ds);
        smin = max(j1-Ds,ds+1);
        smax = min(j1+Ds,n+ds);
        for r=rmin:rmax
            for s=smin:smax
                if(r==i1&&s==j1)
                    continue;
                end
                W2=PaddedImg(r-ds:r+ds,s-ds:s+ds);%�Աȴ���
                Dist2=sum(sum((W1-W2).*(W1-W2)./W2));
                w=exp(-Dist2/h2);
                if(w>wmax)
                    wmax=w;
                end
                sweight=sweight+w;
                average=average+w*PaddedImg(r,s);
            end
        end
        average=average+wmax*PaddedImg(i1,j1);%����ȡ���Ȩֵ ע�����ﲻ��ֱ��ȡ1
        sweight=sweight+wmax;
        DenoisedImg(i,j)=average/sweight;%Zi Normalization
    end
end
