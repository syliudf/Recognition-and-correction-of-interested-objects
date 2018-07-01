img1=imread('pos_0583.jpg');
gap=100;
minl=2;
linenum=50;
filter=5;
vn=2;
hn=2;
canny_para=0.3;
thres_theta=25;


img2=rgb2gray(img1);
[y_pix x_pix dim]=size(img1);
img31 = imresize(img1, [y_pix  x_pix] , 'bilinear') ;

x_scale=x_pix/300;
y_scale=y_pix/300;
img3 = imresize(img2, [300  300] , 'bilinear') ;
%imshow (img3);

originalMinValue = double(min(min(img3)));
originalMaxValue = double(max(max(img3)));
originalRange = originalMaxValue - originalMinValue;
desiredMin = 0;
desiredMax = 255;
desiredRange = desiredMax - desiredMin;
dblImageS255 = desiredRange * (double(img3) - originalMinValue) / originalRange + desiredMin;
img4=uint8(dblImageS255);
%imshow(img5)

%figure,imshow(img4);  
  

img5=medfilt2(img4,[filter,filter]);
figure,subplot(221), imshow(img31), title('original image');

BW = edge(img5,'canny',canny_para);
subplot(223), imshow(BW), title('image edge');
% the theta and rho of transformed space
[H,Theta,Rho] = hough(BW);
subplot(224), imshow(H,[],'XData',Theta,'YData',Rho,'InitialMagnification','fit'),...
    title('rho\_theta space and peaks');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
% label the top 4 intersections
P  = houghpeaks(H,linenum,'threshold',ceil(0.3*max(H(:))));
x = Theta(P(:,2)); 
y = Rho(P(:,1));
plot(x,y,'*','color','r');
lines = houghlines(BW,Theta,Rho,P,'FillGap',gap,'MinLength',minl);
subplot(222), imshow(img5),hold on
max_len = 0;

vert_angle=lines(1).theta;
hori_angle=lines(1).theta+90;
if(hori_angle>90)
    hori_angle=hori_angle-180;
end
vert_num=vn;
hori_num=hn;

flag=zeros(1,length(lines));
for k = 1:length(lines)
    
    xy = [lines(k).point1; lines(k).point2];
    angle=lines(k).theta;
    
    if(abs(angle-vert_angle)<thres_theta || abs(angle-vert_angle)>180-thres_theta)
        if(vert_num>0)
            vert_num=vert_num-1;
            plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','r');
            flag(k)=1;
        end
    end
    
    if(abs(angle-hori_angle)<thres_theta || abs(angle-hori_angle)>180-thres_theta)
        if(hori_num>0)
            hori_num=hori_num-1;
            plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','r');
            flag(k)=-1;
        end
    end
   
end
c_num=1;
for k = 1:length(lines)
    for j= k+1:length(lines)
        if(flag(j)*flag(k)==-1)
            j;
            k;
            [c_x(c_num),c_y(c_num)]=cross_1(lines(k).point1 ,lines(k).point2,lines(j).point1, lines(j).point2);
            c_num=c_num+1;
        end
    end
end
plot(c_x,c_y,'bd');

figure,imshow(img1),title('Դͼ'),hold on

nc_x=floor(c_x.*x_scale);
nc_y=floor(c_y.*y_scale);
plot(nc_x,nc_y,'bd');
min_x=min(nc_x);
max_x=max(nc_x);
min_y=min(nc_y);
max_y=max(nc_y);
n_length=max_x-min_x;
n_width=max_y-min_y;
new_Test_perspectivetransformation(img1,x_pix,y_pix,[nc_y(3) nc_x(3)],[nc_y(1) nc_x(1)],[nc_y(4) nc_x(4)],[nc_y(2) nc_x(2)],n_width,n_length);
% 
% figure,imshow(imgBack)


%plot(c_x(3),c_y(3),'kd');
% [corner_x,corner_y]=cross(lines(1).point1 ,lines(1).point2,lines(2).point1, lines(2).point2);
% plot(corner_x,corner_y,'bd')
%figure,imshow(img5)
%img14 = mat2gray(img3);
%figure,imhist(img14)  