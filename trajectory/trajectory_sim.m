%reference:CSDN
clear;clc;
T=3;%仿真时间
Tt=0.001;%仿真间隔
P=[0 0];%子弹的初始位置
M=3.2e-3;%子弹质量3.2g
C=1.55;%空气阻力系数0.35
rou=1.29;%空气密度
D=17e-3;%子弹直径17mm
S=pi*D^2/4;%子弹迎风面积
k=0.5*C*rou*S/M;%空气阻力加速度总系数
disp('k=')
disp(k);
%af=-k*[V(1)^2,V(2)^2];%空气阻力系数
ag=[0,-9.8];%重力加速度
figure;
title("the trajectory");
hold on;
%xlim(0,10);
%%
initial_V=15;%子弹初速度15 and 18
target=[4.9,-0.2];%打击目标
error_thresh = 0.01;
%%
plot(target(1),target(2),'o');hold on;
start_angle=atan((target(2)-P(2))/(target(1)-P(1)));%+0.1*pi/2;
disp('start angle(deg):');
disp(start_angle*180/pi);
flag=0;%是否找到目标
time=1;
for iter=1:1:300
    P=[0 0];
    theta = start_angle+time/300*45/180*pi;
    %if(1)
    if(theta>=(start_angle-0.0))
        V=[initial_V*cos(theta) initial_V*sin(theta)];
        af=-k*[V(1)^2,V(2)^2];
        for i=0:Tt:T
%             if P(1)>(target(1)-0.1)
            if P(1)>(target(1)+0.1)
%                 disp('到达地面，仿真结束');
%                 disp('到达目标点下方0.1m，仿真结束');
                break;
            end
            if P(2)<(-0.5)
                break;
            end
            error = (target(1)-P(1))^2+(target(2)-P(2))^2;
            if sqrt(error)<error_thresh
                plot(P(1),P(2),'x');hold on;
                disp('到达目标点，仿真结束');
                flag=1;
                break;
            end
            %disp('到达地面，仿真结束'),disp([num2str(i),'s']),break,end;
            plot(P(1),P(2),'.');hold on;
            a=af+ag;
            V=V+a*Tt;
            P=P+V*Tt;
            af=-k*[V(1)^2, V(2)^2];
            %pause(0.01);
        end
    end    
    if(flag==1)
        disp('The ideal START angle(deg) is:');
        disp(theta*180/pi);
        break;
    end
    time=time+1;
end


