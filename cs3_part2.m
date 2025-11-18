%function [img,x,y] = rays2img(rays_x,rays_y,width,Npixels)
lF = load('lightField.mat');
ray = rays2img(lF(1,:),lF(3,:),0.005,200)