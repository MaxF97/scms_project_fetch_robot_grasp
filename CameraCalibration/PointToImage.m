clc;
clear;

%Get the following parameters from your calibration
px=319.166862061345000;     %Principal point X
py=239.433267282686018;     %Principal point Y

f= (553.599234489766104+553.614309214737091)/2;%(693.14908+690.66062)/2; %Focal length

%Homogenous transformation matrix
K = [f,0,px;
     0,f,py;
     0,0,1];
 
X_cam = [15;10;80;1];%[8;5;80;1]; %3D location
IM = eye(3,4);

x = K*IM*X_cam;

u = x(1)/x(3)
v = x(2)/x(3)