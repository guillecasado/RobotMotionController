%PUMA560 Configuration
mdl_puma560
p560; %Visualize the kinematic parameters
initialRobot = SerialLink(p560, 'name', 'initialRobot');
desiredRobot = SerialLink(p560, 'name', 'desiredRobot');
movingRobot = SerialLink(p560, 'name', 'movingRobot');

%Initial geometric configuration
initPos = [-0.6, -0.3, 0.5];
initAng = [10*pi/180, 160*pi/180, 20*pi/180];

TTCP_World_init = transl(initPos)*rpy2tr(initAng);
q_init = p560.ikine6s(TTCP_World_init);

figure(1)
initialRobot.plot(q_init) % plot the robot at configuration q_init

%Desired position
desiredPos = [-0.4, -0.3, 0.5];
desiredAng = [10*pi/180, 160*pi/180, 20*pi/180];

TTCP_World_desired = transl(desiredPos)*rpy2tr(desiredAng);
q_desired = p560.ikine6s(TTCP_World_desired);

figure(2)
desiredRobot.plot(q_desired) % plot the robot at configuration q_desired

%Animation from initial position to desired position
qtg=jtraj(q_init,q_desired,50);
figure(3)
for q=qtg'
    movingRobot.plot(q');
end

