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
subplot(2,4,i)
[x,t] = step(sysTF);
plot(t,x)
title(sprintf("Case %.0f: Kp = %.1f Kd = %.1f", i, Kp(i), Kd(i)))
xlabel('time (s)')
ylabel('Position Response')
end

%% <20% overshoot <5% ring in 1s
numcase = Kp(5)*const.Kg*const.Km;
dencase = [const.J*const.Rm (const.Kg*const.Km)^2+const.Kg*const.Km*Kd(5) const.Kg*const.Km*Kp(5)];
sysTFcase = tf(numcase,dencase);
[x,t] = step(sysTFcase);
figure()
plot(t,x)
hold on
xlim([0 1])
ylim([0 1.25])
yline(1.2, 'r--')
yline(1.05, 'b--')
yline(.95, 'b--')
legend("Arm Position", "20% Overshoot", "5% ringing", Location="best")
title("Kp = 10, Kd = 1")
xlabel("Time(s)")
ylabel("Position")

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
