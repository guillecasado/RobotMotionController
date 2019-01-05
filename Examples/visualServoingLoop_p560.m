%% P3 EXERCISE 2: Visual servoing loop
% October 2017
% Jan Rosell
%
% This is an incomplete script to run a visual servoing loop of a pums560
% robot wiht a hand-held camera.
% It uses functions:
%    - plotCameraImagePlane to plot the camera and the camera plane
%    - poseEstimation to estimate the camera pose from the image features
%      corresponding to four known points on the plane z=0 of the object.
% The problem is initially set with:
%       A) TobjTCP_ini = transl(sizex/2, sizey/2, 0.35)*
%                            rpy2tr(10*pi/180, 160*pi/180, 20*pi/180)
%          TobjTCP_goal = transl(sizex/2, sizey/2, 0.4)*troty(pi)
%
% TODO: 
%   1) The for loop in the VISUAL SERVO LOOP section has to be completed
%
%    2) Change the problem setup by considering:
%       B) TobjTCP_ini =  transl(-0.4, -0.3, 0.3)*troty(130*pi/180)*trotx(-10*pi/180)
%          TobjTCP_goal = transl(-0.3, 0.3, 0.4)*troty(160*pi/180);
%
%       C) TobjTCP_ini = transl(sizex/2, sizey/2, 0.35)*rpy2tr(10*pi/180, 160*pi/180, 20*pi/180);
%          TobjTCP_goal = transl(-0.3, 0.3, 0.4)*troty(160*pi/180);
%
%       D) TobjTCP_ini = transl(sizex/2, sizey/2, 0.35)*rpy2tr(10*pi/180, 160*pi/180, 20*pi/180);
%          TobjTCP_goal = transl(sizex/2, sizey/2, 0.8)*troty(pi);
%
clear all;
robot=1
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
                               
%Initial transform of the TCP w.r.t. object frame
TobjTCP_ini = transl(sizex/2, sizey/2, 0.35)*rpy2tr(10*pi/180, 160*pi/180, 20*pi/180);
%TCP transform
TCP = Tobject*TobjTCP_ini;
qini=p560.ikine6s(TCP)

%% SETUP
% Definition of the camera
cam = CentralCamera('default');
cam.f=0.008; %default is 0.008
% The camera reference frame will be coincident with that of the TCP
% Tc0 = Initial transform of the camera w.r.t world
Tc0 = TCP;
%Projection of the points P into the image plane
p0 = cam.project(P, 'objpose', Tobject, 'pose', Tc0) %with object translated
%Desired transform of the object w.r.t. camera
TobjTCP_goal = transl(sizex/2, sizey/2, 0.4)*troty(pi);
TcStar_t = inv(TobjTCP_goal);


%% VISUALIZE 2D IMAGE
% plots the points as seen by the camera when located at Tc0
cam.plot(p0) 
cam.hold;
% plots the points as seen by the camera when located at the desired pose
% of the camera
Tc_desired = Tobject*inv(TcStar_t)
%plots the points as seen by the camera when located at Tc_desired
pStar = cam.plot(P, 'objpose', Tobject, 'pose', Tc_desired, '*r')

%% VISUAL SERVO LOOP
%
% lambda is the percentage of advance towards the desired pose of the cam
lambda0 = 0.1;
% initialize the pose of the camera
Tc = Tc0
T(:,:,1) = Tc;
ph(:,:,1)=p0;
p=p0;
% do the approach in maxn steps
maxn=50
for n = 2:maxn
    % Compute the new pose of the camera
    % First, estimate the pose of the object, w.r.t. camera, from P and p
    
    %Tc_t_est = 
    
    % Compute the error between desired and current camera transform
    
    %Tdelta = 

    % Move a fraction lambda in the direction to reduce the error
    % (lambda can be set greater as we approach the goal)
    % (when multiplying transforms, use trnorm to guarantee that the 
    %  rotation submatrix of the resultant transform is a proper 
    %  orthogonal matrix)
    
    %lambda = 
    %Tdelta =   
    %Tc =  
    
    %plots the points as seen by the camera when located at Tc
    p = cam.plot(P,  'objpose', Tobject,'pose', Tc, '.b');
    ph(:,:,n)=p;
    % store it in a vector for animation purposes
    T(:,:,n) = Tc;
end

if robot
 %q=p560.ikine6s( T(:,:,:))
 for i=1:maxn
    try
        q(i,:)=p560.ikine6s(T(:,:,i)); 
    catch exception
        display('catched ik error')
        if i>1
            q(i,:)=q(i-1,:); 
        else
            q(i,:)=qs;
        end
    end
 end
end


%% PLOT in 3D - Animation
figure(2)  
%plot the object
W = transl(0,0,0);
trplot(W, 'frame', 'W', 'axis', [-.4 1 -.6 .6 0 1.0], 'length', 0.2)
hold on

%plot the object
cube_plot(Tobject,sizex,sizey,sizez,'r');
Pw=Tobject*cat(1,P,ones(1,size(P,2)));
plot3(Pw(1,:),Pw(2,:),Pw(3,:),'*r')%plot the points on the object
%hold on

% Animate motion of the camera frame.
title('Animation')
grid on 
xlabel('X')
ylabel('Y')
zlabel('Z')

if robot
 for qj = q', % for all points on the path
    if sum(isnan(qj)==0) 
        p560.plot(qj', 'noarrow','view', [140 25]);
    else
        disp('IK error')
        break;
    end
 end
end 

for i=1:50
   trplot(T(:,:,i),  'color', 'c', 'length', 0.2) 
end

zplane = 0.15;
scalecamera = 0.08;
cam.T = Tc_desired;
plotCameraImagePlane(cam, zplane, Pw, scalecamera);

%% PLOT CAMERA COORDINATES
%
figure(3)
X=squeeze(T(1,4,:));
Y=squeeze(T(2,4,:));
Z=squeeze(T(3,4,:));
subplot(2,1,1);
plot(X)
hold on
plot(Y,'g')
plot(Z,'r')
title('Camera position');
xlabel('Steps');
legend('X','Y', 'Z');
subplot(2,1,2);
for i=1:size(T,3)
    rpy(i,:)=tr2rpy(T(1:3,1:3,i));
end
plot(rpy(:,1))
hold on
plot(rpy(:,2),'g')
plot(rpy(:,3),'r')
title('Camera orientation');
xlabel('Steps');
legend('r','p', 'y');
%% PLOT PROJECTED POINTS
%
figure(4)
axis([0 1024 0 1024]);
axis ij;
hold on
plot(ph(1,:,1),ph(2,:,1),'ro')
for i=2:size(ph,3)
    plot(ph(1,:,i),ph(2,:,i),'r*')
end
for i=1:size(ph,3)
    plot( squeeze(ph(1,1,:)), squeeze(ph(2,1,:)))
    plot( squeeze(ph(1,2,:)), squeeze(ph(2,2,:)))
    plot( squeeze(ph(1,3,:)), squeeze(ph(2,3,:)))
    plot( squeeze(ph(1,4,:)), squeeze(ph(2,4,:)))
end




