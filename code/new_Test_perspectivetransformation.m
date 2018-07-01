 function  new_Test_perspectivetransformation( imgSrc,pic_x, pic_y,v1,v2,v3,v4,wid,len )
 %   imgSrc = imread('5.jpg');
%    figure; imshow(imgSrc); title('源图');
    
    u1=[0,0];u2=[0,pic_x];u3=[pic_y,0];u4=[pic_y,pic_x];%原图四点坐标
   % v1=[375 200];v2=[ 692 670];v3=[702 206 ];v4=[ 367 637];%感兴趣四点的坐标
     aa1=sqrt(dot(v1,v1));aa2=sqrt(dot(v2,v2));aa3=sqrt(dot(v3,v3));aa4=sqrt(dot(v4,v4));
    bb1=sqrt(dot(v1-u2,v1-u2));bb2=sqrt(dot(v2-u2,v2-u2));bb3=sqrt(dot(v3-u2,v3-u2));bb4=sqrt(dot(v4-u2,v4-u2));
    if(aa1==min(min(min(aa1,aa2),aa3),aa4))
        pointLT=v1;
        ans = iscro(v1,v2,v3,v4);
        if(ans==1)
            pointRB=v2;
            if(bb3<bb4)
                pointRT=v3;pointLB=v4;
            else
                 pointRT=v4;pointLB=v3;
            end
        else
            ans = iscro(v1,v3,v2,v4);
            if(ans==1)
                pointRB=v3;
                if(bb2<bb4)
                pointRT=v2;pointLB=v4;
                else
                 pointRT=v4;pointLB=v2;
                end
            else
                pointRB=v4;
                if(bb2<bb3)
                pointRT=v2;pointLB=v3;
                else
                 pointRT=v3;pointLB=v2;
                end
            end
        end
    elseif(aa2==min(min(min(aa1,aa2),aa3),aa4))
         pointLT=v2;
        ans = iscro(v2,v1,v3,v4);
        if(ans==1)
            pointRB=v1;
            if(bb3<bb4)
                pointRT=v3;pointLB=v4;
            else
                 pointRT=v4;pointLB=v3;
            end
        else
            ans = iscro(v2,v3,v1,v4);
            if(ans==1)
                pointRB=v3;
                if(bb1<bb4)
                pointRT=v1;pointLB=v4;
                else
                 pointRT=v4;pointLB=v1;
                end
            else
                pointRB=v4;
                if(bb1<bb3)
                pointRT=v1;pointLB=v3;
                else
                 pointRT=v3;pointLB=v1;
                end
            end
        end
    elseif(aa3==min(min(min(aa1,aa2),aa3),aa4))
         pointLT=v3;
        ans = iscro(v3,v1,v2,v4);
        if(ans==1)
            pointRB=v1;
            if(bb2<bb4)
                pointRT=v2;pointLB=v4;
            else
                 pointRT=v4;pointLB=v2;
            end
        else
            ans = iscro(v3,v2,v1,v4);
            if(ans==1)
                pointRB=v2;
                if(bb1<bb4)
                pointRT=v1;pointLB=v4;
                else
                 pointRT=v4;pointLB=v1;
                end
            else
                pointRB=v4;
                if(bb1<bb2)
                pointRT=v1;pointLB=v2;
                else
                 pointRT=v2;pointLB=v1;
                end
            end
        end
    else(aa4==min(min(min(aa1,aa2),aa3),aa4))
         pointLT=v4;
        ans = iscro(v4,v1,v2,v3);
        if(ans==1)
            pointRB=v1;
            if(bb2<bb3)
                pointRT=v2;pointLB=v3;
            else
                 pointRT=v3;pointLB=v2;
            end
        else
            ans = iscro(v4,v2,v1,v3);
            if(ans==1)
                pointRB=v2;
                if(bb1<bb3)
                pointRT=v1;pointLB=v3;
                else
                 pointRT=v3;pointLB=v1;
                end
            else
                pointRB=v3;
                if(bb1<bb2)
                pointRT=v1;pointLB=v2;
                else
                 pointRT=v2;pointLB=v1;
                end
            end
        end
    end
     %通过判断是否相交来确定点的顺序  
    imgBack = m_PerspectiveTransformation(imgSrc,pointLT,pointRT,pointLB,pointRB,wid,len);
    figure; imshow(imgBack); title('矩形图');
    [m n]=size(imgSrc)
