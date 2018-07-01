%�������ܣ�����ͶӰ�任������Դͼ��Դͼ�е������ı��ε�4��������꣨���ϣ����ϣ����£����£����Լ����ͼ��Ĵ�С���ߣ���
function Imgback = m_PerspectiveTransformation(imgIn,pointLT,pointRT,pointLB,pointRB,outHeitht,outWidth)
    [imgInHeight,imgInWidth,imgInDimension] = size(imgIn);
    %Ϊ������ͶӰ�任����Ҫ��4����ת��Ϊ�������������忴�ο�����
    vector10 = pointLB - pointLT;
    vector01 = pointRT - pointLT;
    vector11 = pointRB - pointLT;
    %��vector11��ʾ��vector10��vector01��������ϣ���ʹ������������
    A = [vector10' , vector01'];
    B = vector11' ;
    S = A\B;
    a0 = S(1);
    a1 = S(2);
    
    
    %�������
    Imgback = uint8(zeros(outHeitht,outWidth,imgInDimension));
    
    
    %����ѭ����������ÿ�����ص㸳ֵ
    for heightLoop = 1:outHeitht
        for widthLoop = 1:outWidth
            %�����㷨Ϊ�ο������еĹ�ʽ��ʾ
            x0 = heightLoop/outHeitht;
            x1 = widthLoop/outWidth;
            FenMu = a0+a1-1+(1-a1)*x0+(1-a0)*x1;            %��ĸ
            y0 = a0*x0/FenMu;
            y1 = a1*x1/FenMu;
            
            %���ݵõ��Ĳ����ҵ���Ӧ��Դͼ���е�����λ�ã�����ֵ
            coordInOri = y0*vector10 + y1*vector01 + pointLT;
            heightC = round(coordInOri(1));
            widthC = round(coordInOri(2));
                if (heightC > imgInHeight || heightC <= 0 || widthC >imgInWidth || widthC <=0 )
                    disp(['m_PerspectiveTransformation������Χ' num2str(heightC) num2str(widthC)]);
                    pause();
                    return;
                end
            for dimentionLoop = 1:imgInDimension
                %ʹ����������ֵ��ʹ�ø߼���ֵ����Ч�������
                Imgback(heightLoop,widthLoop,dimentionLoop) = imgIn(heightC,widthC,dimentionLoop);
            end
        end
    end
    
    
%     figure; imshow(Imgback); title('ͶӰ�任�Ľ��');