% UNICYCLE - closed loop I/O liniarized control of the (x,y) position
% of the look-ahead point used to linearize the system 
%(see siciliano book)

%Geometric parameters of the pahts
geometricParams
%Temporal parameters of the trajectories
temporalParams
%Gain parameters for y1 and y2
k1=1
k2=1
%Look-ahead reference point
b=0.5
%Initial robot configuration
x0 = Pi %+ [-0.3 0.3 -pi/4]
%Unicycle parameters
accel_limit = 1
drive_limit = 10
steer_limit = 10
