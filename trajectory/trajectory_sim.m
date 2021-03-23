%reference:CSDN
clear;clc;
T=30;%����ʱ��
Tt=0.05;%������
P=[0 0];%�ӵ��ĳ�ʼλ��
V=[50 50];%�ӵ����ٶ�
M=2;%�ӵ�����
C=0.35;%��������ϵ��
rou=1.29;%�����ܶ�
D=0.06;%�ӵ�ֱ��
S=pi*D^2/4;%�ӵ�ӭ�����
k=0.5*C*rou*S/M;%�����������ٶ���ϵ��
af=-k*[V(1)^2,V(2)^2];%��������ϵ��
ag=[0,-9.8];%�������ٶ�
pi=3.14159;
figure;
title("the trajectory");
hold on;

initial_V=50;
target=[150,10];%���Ŀ��
plot(target(1),target(2),'o');hold on;
start_angle=atan((target(2)-P(2))/(target(1)-P(1)))+0.1*pi/2;
disp('start angle(deg):');
disp(start_angle*180/pi);
flag=0;%�Ƿ��ҵ�Ŀ��
time=1;
for iter=1:1:50
    P=[0 0];
    theta = time/50*0.4*pi;
    if(theta>start_angle)
        V=[initial_V*cos(theta) initial_V*sin(theta)];
        af=-k*[V(1)^2,V(2)^2];
        for i=0:Tt:T
            if P(2)<0
                disp('������棬�������');
                break;
            end
            error = (target(1)-P(1))^2+(target(2)-P(2))^2;
            if sqrt(error)<2
                plot(P(1),P(2),'x');hold on;
                disp('����Ŀ��㣬�������');
                flag=1;
                break;
            end
            %disp('������棬�������'),disp([num2str(i),'s']),break,end;
            plot(P(1),P(2),'.');hold on;
            a=af+ag;
            V=V+a*Tt;
            P=P+V*Tt;
            af=-k*[V(1)^2, V(2)^2];
            pause(0.01);
        end
    end    
    if(flag==1)
        disp('The ideal START angle(deg) is:');
        disp(theta*180/pi);
        break;
    end
    time=time+1;
end


