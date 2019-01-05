
%% CUBE OBJECT DEFINITION
%Cube size; origin at a vertex.
sizex=.08;
sizey=.08;
sizez=.05;
% Definition of 3D points w.r.t. cube frame
P1 = [sizex,  sizey, 0]'; 
P2 = [sizex,  0, 0]'; 
P3 = [0,  sizey, 0]'; 
P4 = [0,  0, 0]'; 
P = [P1 P2 P3 P4]
% Setting object frame (with orientation defined by consecutive rotations
%around fixed axis x,y,z)
Tobject = transl(0.2, -0.2, sizez)*rpy2tr(0,0,-10*pi/180);
%% ROBOT
% puma560t
mdl_puma560
p560.tool = transl(0, 0, 0.18);%define the camera to be placed ahead the 
                               %gripper z-axis
TCP = Tobject*transl(sizex/2, sizey/2, 0.4)*rpy2tr(0, pi, 0);
q=p560.ikine6s(TCP)
%% CAMERA SETUP
%
cam = CentralCamera('default');
cam.f=0.008; %default is 0.008
% setting camera frame (with orientation defined by consecutive rotations
%around fixed axis x,y,z)
cam.T = TCP;
p = cam.plot(P, 'objpose', Tobject ) %with object translated

%% VISUALIZE THE 3D SCENE
%
figure
% plot world frame
W = transl(0,0,0);
trplot(W, 'frame', 'W', 'axis', [-.4 1 -.6 .6 0 1.0], 'length', 0.2)
hold on
% plot camera frame 
trplot(cam.T, 'frame', 'C', 'color', 'k', 'length', 0.1)
% plot object frame
trplot(Tobject, 'frame', 'O', 'color', 'r', 'length', 0.1)
% plot Pw, i.e. point P w.r.t. world frame
% Pw=Tobject*[P;1];
Pw=Tobject*cat(1,P,ones(1,size(P,2)));
plot3(Pw(1,:),Pw(2,:),Pw(3,:),'*r')

% Plot the camera and the virtual image plane
zplane = 0.15;
scalecamera = 0.08;
plotCameraImagePlane(cam, zplane, Pw, scalecamera);

%plot the object
cube_plot(Tobject,sizex,sizey,sizez,'r');
hold on
p560.plot(q, 'noarrow', 'view', [140 25]) %plot options in page 230 of Robotics toolbox manual




