img1=imread('D:\MATLAB\R2012b\bin\CV\pic\IMG_20171015_132844.jpg');
img2=rgb2gray(img1);
%imshow(img1)
img3 = imresize(img2, [180  320] , 'bilinear') ;
imshow (img3);
img4=imadjust(img3,[],[],2);
%img4=imadjust(img4,[],[],2);
imshow(img4);
BW1=edge(img4,'canny',0.3);
imshow(BW1);
%corners = corner(BW1, 'Harris',20)
corners = corner(BW1, 'Harris',2)
 hold on
plot(corners(:,1),corners(:,2),'r*')