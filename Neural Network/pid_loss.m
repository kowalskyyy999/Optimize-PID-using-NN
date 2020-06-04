function [out,sys_PID,kp,ki,kd] = pid_loss(out_, UB, LB)
    out_ = LB + (UB - LB)*out_;
    
    kp = out_(1);
    ki = out_(2);
    kd = out_(3);

    SP = 1;
    num = [3.019];
    den = [1 23 73.75 22.32];

    sys = tf(num,den);

    num_PID = [kd kp ki];
    den_PID = [1 0];
    PID = tf(num_PID,den_PID);

    sys_PID = feedback(PID*sys,1);
    [y,t]=step(sys_PID);
    hasil = stepinfo(y,t,SP);
    ess = abs(SP-y(end));
    RiseTime = hasil.RiseTime;
    Overshoot = hasil.Overshoot;
    Settlingtime = hasil.SettlingTime;
    
    fitness1 = 1/(RiseTime + 1);
    fitness2 = 1/(ess+1);
    fitness3 = 1/(Overshoot +1);
    fitness4 = 1/(Settlingtime+1);

    out = [fitness1 fitness4 fitness3];
end