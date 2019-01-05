

%Initialization of the Unimation PUMA 560 serial manipulator Model
mdl_puma560
%Verify the data
p560

%Initial angle configuration
q_initial = qz; %qz --> zero angle [0,0,0,0,0,0]
%Desired final configuration
q_desired = [pi/4,3*pi/4,0,3*pi/4,-pi/4,-3*pi/4];

%Controller parameters
kp = 2;
kd = 5;

%Upper and lower saturation limits for qd
qd_upper_sat_limit = 5;
qd_lower_sat_limit = -5;

%Display parameters
fps = 5;




