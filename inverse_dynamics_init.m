

%Initialization of the Unimation PUMA 560 serial manipulator Model
mdl_puma560
%Verify the data
p560

%Joint interpolated trajectory generator parameters
%Initial angle configuration
q_initial = qs; %qs --> stretch configuration [0,0,‐pi/2,0,0,0]
%Desired final configuration
q_desired = [pi,pi/4,-pi,0,pi/4,0];
%Max time [s]
tmax = 5;
%Step-time
ts = 0.2;

%Controller parameters
kp = 3;
kd = 5;

%Upper and lower saturation limits for qd
qd_upper_sat_limit = 5;
qd_lower_sat_limit = -5;

%Display parameters
fps = 5;



