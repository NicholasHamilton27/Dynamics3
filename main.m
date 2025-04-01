clc;
clear all;
close all;
const = getconst();
Kp = [1 10 20 5 10 10 10];
Kd = [1 0 0 0 1 -1 -.5];

%% Closed Loop System
for i = 1:length(Kp)
num = Kp(i)*const.Kg*const.Km;
den = [const.J*const.Rm (const.Kg*const.Km)^2+const.Kg*const.Km*Kd(i) const.Kg*const.Km*Kp(i)];
sysTF = tf(num,den);

%% Step Response
figure
[x,t] = step(sysTF);
plot(t,x)
end


function [const] = getconst()
    const.Kg = 33.3;
    const.Km = .0401;
    const.Rm = 19.2;
    const.Jhub = .0005;
    const.Jext = .2*.2794^2;
    const.Jload = .0015;
    const.J = const.Jhub + const.Jext + const.Jload;
    const.L = .45;
    const.Marm = .06;
    const.Jarm = const.Marm * const.L^2 /3;
    const.Mtip = .05;
    const.Jtip = const.Mtip * const.L^2;
    const.fc = 1.8;
    const.JL = const.Jarm + const.Jtip;
    const.Karm = (2*pi*const.fc)^2 * const.JL;
end
