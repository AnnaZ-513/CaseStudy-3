clear; clc; close all;

%function [img,x,y] = rays2img(rays_x,rays_y,width,Npixels)
load('lightField.mat');
imshow(rays2img(rays(1,:),rays(3,:),0.005,1000));
%a) Image is blurry but there is a slightly discernable shape. However, the
%sides of the shape are not well defined and are grainy. It looks like an
%upside down fish or a vase. 
%b) Now that I've set the width of the sensor to 0.075 the image can be seen
%to be an photo of a person (probably Mr. Sinopoli). By increasing the
%width, the image becomes clearer. However, the image also becomes
%smaller. This is because making the sensor wider allows for more light to
%pass through while smaller sensors allow for less light. 
%c) Not really. There are more pixels the more you increase sensor pixels,
%but the image is not defined. This is because if the image is not already
%perfectly shown, the pixel amount does not make a change. An unclear image
%will not suddenly become clear if you increase the amount of pixels. 
