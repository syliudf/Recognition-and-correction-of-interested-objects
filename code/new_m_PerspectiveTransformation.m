%函数功能：中心投影变换。输入源图，源图中的任意四边形的4个点的坐标（左上，右上，左下，右下），以及输出图像的大小（高，宽）
function Imgback = m_PerspectiveTransformation(imgIn,pointLT,pointRT,pointLB,pointRB,outHeitht,outWidth)
    [imgInHeight,imgInWidth,imgInDimension] = size(imgIn);
    %为了中心投影变换，需要将4个点转化为三个向量，具体看参考文献
    vector10 = pointLB - pointLT;
    vector01 = pointRT - pointLT;
    vector11 = pointRB - pointLT;
    %把vector11表示成vector10和vector01的线性组合，以使三个向量共面
    A = [vector10' , vector01'];
    B = vector11' ;
    S = A\B;
    a0 = S(1);
    a1 = S(2);
    
    
    %输出矩形
    Imgback = uint8(zeros(outHeitht,outWidth,imgInDimension));
    
    
    %利用循环操作来对每个像素点赋值
    for heightLoop = 1:outHeitht
        for widthLoop = 1:outWidth
            %以下算法为参考文献中的公式表示
            x0 = heightLoop/outHeitht;
            x1 = widthLoop/outWidth;
            FenMu = a0+a1-1+(1-a1)*x0+(1-a0)*x1;            %分母
            y0 = a0*x0/FenMu;
            y1 = a1*x1/FenMu;
            
            %根据得到的参数找到对应的源图像中的坐标位置，并赋值
            coordInOri = y0*vector10 + y1*vector01 + pointLT;
            heightC = round(coordInOri(1));
            widthC = round(coordInOri(2));
                if (heightC > imgInHeight || heightC <= 0 || widthC >imgInWidth || widthC <=0 )
                    disp(['m_PerspectiveTransformation超出范围' num2str(heightC) num2str(widthC)]);
                    pause();
                    return;
                end
            for dimentionLoop = 1:imgInDimension
                %使用最近邻域插值，使用高级插值方法效果会更好
                Imgback(heightLoop,widthLoop,dimentionLoop) = imgIn(heightC,widthC,dimentionLoop);
            end
        end
    end
    
    
%     figure; imshow(Imgback); title('投影变换的结果');