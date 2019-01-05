%Temporal Parameters to define a trajectory

%s(tau)
tau=linspace(0,1,100);
linear = 1;
if(linear)
    s=tau; %s(t)=t
else
    %s(tau) = ks*tau^2/2 when t in [0, t1] 
    %s(tau) = ks*tau^2/2 when t in [0, t1] 
    %s(tau) = 1-ks*(1-tau)^2/2 when t in [t2, 1] 
    ks=3;
    t1=0.3;
    t2=0.7;
    %check if correct configured parameters, if not set linear s(t)=t
    if(t1>0 & t2>0 & t1<1 & t2<1 & t2>t1 & ((1-ks*(1-t2)^2/2)> ks*t1^2/2))
        s=(tau<t1).*(ks*tau.^2/2)+((tau>=t1)&(tau<t2)).*((((1-ks*(1-t2)^2/2)-ks*t1^2/2)/(t2-t1))*(tau-t1)+ks*t1^2/2) + (tau>=t2).*(1-ks*(1-tau).^2/2);
    else 
        s=tau;
    end
end