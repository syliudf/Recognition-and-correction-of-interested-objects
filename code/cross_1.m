function [ x_out,y_out ] = cross_1(d1p1,d1p2,d2p1,d2p2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here,d2x1,d2y1,d2x2,d2y2
d1x1=d1p1(1);
d1y1=d1p1(2);
d1x2=d1p2(1);
d1y2=d1p2(2);
d2x1=d2p1(1);
d2y1=d2p1(2);
d2x2=d2p2(1);
d2y2=d2p2(2);

k1=(d1y2-d1y1)/(d1x2-d1x1);
b1=d1y1-k1*d1x1;
k2=(d2y2-d2y1)/(d2x2-d2x1);
b2=d2y1-k2*d2x1;

%[x_out y_out]=solve('y_out=k1*x_out+b1','y_out=k2*x_out+b2');
    if(k1~=Inf && k2 ~= Inf)
    
          y_out= -1*(b1*k2 - b2*k1)/(k1 - k2);
          x_out= -1*(b1 - b2)/(k1 - k2);
    end
    if(k1==Inf)
        x_out=d1x1;
        y_out=k2*d1x1+b2;
    end
    if(k2==Inf)
        x_out=d2x1;
        y_out=k1*d2x1+b1;
    end
            
        
end

%function [ x_out,y_out ] = cross(d1x1,d1y1,d1x2,d1y2,d2x1,d2y1,d2x2,d2y2 )