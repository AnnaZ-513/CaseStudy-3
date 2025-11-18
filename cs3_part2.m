clear; clc; close all;

%function [img,x,y] = rays2img(rays_x,rays_y,width,Npixels)
load('lightField.mat');
imshow(rays2img(rays(1,:),rays(3,:),0.1,1000));
%a) Image is blurry but there is a slightly discernable shape. However, the
%sides of the shape are not well defined and are grainy. It looks like an
%upside down fish or a vase. 
%b) Now that I've set the width of the sensor to 0.1 the image can be seen
%to be an photo of a person (probably Mr. Sinopoli). By increasing the
%width, the image becomes clearer. However, the image also becomes
%smaller. This is because making the sensor wider allows for more light to
%pass through while smaller sensors allow for less light. 
%c) Not really. There are more pixels the more you increase sensor pixels,
%but the image is not defined. This is because if the image is not already
%perfectly shown, the pixel amount does not make a change. An unclear image
%will not suddenly become clear if you increase the amount of pixels. 

x = rays(1,:);  
y = rays(3,:);      

N = length(y); 
angles = linspace(-pi/20, pi/20, N);

d = 0.00001   

original = zeros(4,N);

for i = 1:N
    original(1,i) = x(i);
    original(2,i) = angles(i);
    original(3,i) = y(i);
    original(4,i) = angles(i);
end


Md = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];

final = Md * original;

figure;
imshow(rays2img(final(1,:),final(3,:),0.1,1000));


%d) there is no d that will create a sharp image. However, there is a d
%that will get you as close as possible to a sharp image which is
%d=0.00001. Idk what to put for "What happens to the rays after
%propagation?"
