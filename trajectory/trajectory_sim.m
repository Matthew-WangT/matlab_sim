%reference:CSDN
clear;clc;
T=3;%����ʱ��
Tt=0.001;%������
P=[0 0];%�ӵ��ĳ�ʼλ��
M=3.2e-3;%�ӵ�����3.2g
C=1.55;%��������ϵ��0.35
rou=1.29;%�����ܶ�
D=17e-3;%�ӵ�ֱ��17mm
S=pi*D^2/4;%�ӵ�ӭ�����
k=0.5*C*rou*S/M;%�����������ٶ���ϵ��
disp('k=')
disp(k);
%af=-k*[V(1)^2,V(2)^2];%��������ϵ��
ag=[0,-9.8];%�������ٶ�
figure;
title("the trajectory");
hold on;
%xlim(0,10);
%%
initial_V=15;%�ӵ����ٶ�15 and 18
target=[4.9,-0.2];%���Ŀ��
error_thresh = 0.01;
%%
plot(target(1),target(2),'o');hold on;
start_angle=atan((target(2)-P(2))/(target(1)-P(1)));%+0.1*pi/2;
disp('start angle(deg):');
disp(start_angle*180/pi);
flag=0;%�Ƿ��ҵ�Ŀ��
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
%                 disp('������棬�������');
%                 disp('����Ŀ����·�0.1m���������');
                break;
            end
            if P(2)<(-0.5)
                break;
            end
            error = (target(1)-P(1))^2+(target(2)-P(2))^2;
            if sqrt(error)<error_thresh
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


