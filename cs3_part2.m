clear; clc; close all;

%function [img,x,y] = rays2img(rays_x,rays_y,width,Npixels)
load('lightField.mat');
ray = rays2_img(rays(1,:),rays(3,:),0.005,200)