clear; clc; close all;

%function [img,x,y] = rays2img(rays_x,rays_y,width,Npixels)
load('lightField.mat');
imshow(rays2img(rays(1,:),rays(3,:),0.01,700));
%1.
% a) Image is blurry but there is a slightly discernable shape. However, the
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

N = length(rays); 
angles = linspace(-pi/20, pi/20, N);

d = 0.000000010;   

original = rays;


Md = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];

final = Md * original;

figure;
imshow(rays2img(final(1,:),final(3,:),0.1,1000));


%d) there is no d that will create a sharp image. However, there is a d
%that will get you as close as possible to a sharp image which is
%d=0.00001 or any number close to zero or zero itself. Rays stay the same 
%after propogation.The reason for this is because the rays are spreading
%out, so the most focused the rays are are at the source itself (which is
%still not clear enough). 

%2.2
%a) You cannot generate a clear image using just the propogation matrix
%because a real camera has a lens that creates a focal point that then
%shows an image. 

r = 0.02; %m Can see Bruno in this one
r = 0.1; %Overlapped images. Or 0.045


d2 = 0.24; %dist from lens to image
f = 0.15;




d1 = ((1/f) - (1/d2))^-1; %distance from object to lens 


Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1]; %matrix that bends rays to the sensor plane 

Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1]; %matrix that bends rays at the lens

%no Md1 since we don't know d1 and so it acts like the hologram is located
%exactly at the lens

hits = abs(original(1,:)) <= r; %change this to make the radius not centered at zero

rays_after_lens = Mf * original(:, hits);  
rays_final = Md2 * rays_after_lens; 

figure;
imshow(rays2img(rays_final(1,:),rays_final(3,:),0.003,375));



%Part 3
%r = 0.02; %m Can see Bruno in this one
r = 0.1; %Overlapped images

d2 = 0.24; %dist from lens to image
f = 0.15;



d1 = ((1/f) - (1/d2))^-1; %distance from object to lens 


Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];

%rays_in_obj2_new = rays_out_obj2(:, abs(rays_out_obj2(1,:)) <= r_lens); 
%[-0.02,0.02] gives sinopoli. THIS SIZE MAKES SENSE since the size of the
%lens r that made it so we could ONLY see bruno was when it was 0.03.
%Nevermind, that's not right. 
%[-1,-0.02] give the robot
%[0.02,1] gives washu sign

hits2 = (abs(original(1,:)) <= r); 


rays_after = Mf * original(:, hits2);
rays_final = Md2 * rays_after; 
%Filter out angles using trial and error for each image

function [final_rays] = createImage(lower,upper, rays)
    num = rays;
    %this for loop counts how many rays are between a specific angle. We then
    %create an array that's precisely that size of valid angles
    for r = 1:length(rays)
        if (rays(2, r) >= lower) && (rays(2, r) <=upper)
            num(2,r) = 1;
        else
            num(2,r) = 0;
        end
    end

    l=sum(num(2,:)); %calculating the sum of angles in the range
    final_rays = zeros(4,l); %(currently) empty array of filtered angles 
    
    count = 0;
    for r = 1:length(rays)
        if (rays(2, r) >= lower) && (rays(2, r) <= upper)
            count = count+1;
            final_rays(:,count) = rays(:,r);
        end
    end
end

sinopoli = createImage(-0.02,0.02,rays_final);
robot = createImage(-1,-0.02,rays_final);
washU = createImage(0.02,1,rays_final);

figure;
imshow(rays2img(robot(1,:),robot(3,:),0.003,375));
figure;
imshow(rays2img(sinopoli(1,:),sinopoli(3,:),0.003,375));
figure;
imshow(rays2img(washU(1,:),washU(3,:),0.003,375));
