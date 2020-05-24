clc;
clear;

%Get the following parameters from your calibration
px=319.166862061345000;     %Principal point X
py=239.433267282686018;     %Principal point Y

fx = 553.599234489766104;
fy = 553.614309214737091;%(693.14908+690.66062)/2; %Focal length

%Homogenous transformation matrix
K = [fx,0,px;
     0,fy,py;
     0,0,1];

X_cam = sym('X_cam', [4, 1]);
%X_cam = [X;Y;Z;1];%[8;5;80;1]; %3D location
IM = eye(3,4);

% x = K*IM*X_cam;
% 
% u = x(1)/x(3)
% v = x(2)/x(3)

u = (fx*X_cam(1)+X_cam(3)*px)/X_cam(3);
v = (fy*X_cam(2)+X_cam(3)*py)/X_cam(3);

x = [X_cam(3)*u;
    X_cam(3)*v;
    X_cam(3)];
X_cam = inv(K)*x
    