% KCL Neuroimaging MSc Project
% [created by: J P Monney  27/05/2019]

% addpath(genpath('C:\Users\Jona\Documents'));
% cd C:\Users\Jona\Documents\MATLAB\MSc_Project\MSc_Project;
% 640x480;

config_display (1)
cgloadlib
cgopen(1000,1000,0,0,0)
cgloadbmp(1,'mnist_5.bmp',1000,1000)
cgloadbmp(2,'ahole.bmp')
cgloadbmp(3,'cross.bmp',1000,1000)
cgloadbmp(4,'task_instr.bmp',1000,1000)
cgloadbmp(5,'digit_dial.bmp',1000,1000)
cgloadbmp(6,'correct.bmp',1000,1000)
cgloadbmp(7,'incorrect.bmp',1000,1000)
cgtrncol(2,'n')


% Uses space bar press as signal for ready to start task
kp=0;
while ~kp
   [ks,kp]=cgkeymap;
   cgdrawsprite(3,0,0)
   cgflip
end


% Digit stimulus shown behing alpha mask for 4 seconds
%t = timer('TimerFcn', 'timestatus=0;', 'StartDelay',4);
%start(t)
%timestatus=1;
tic;
start = toc;
timerVal = 0;
while (timerVal < 2)  %(timestatus==1)
    % tracks mouse in lieu of gaze [for now...]
   [x,y]=cgmouse;
   cgdrawsprite(1,0,0);
   cgdrawsprite(2,x,y);
   cgflip;
   finish = toc;
   timerVal = (finish - start);
end

% Explains to participant how to validate their answer
cgdrawsprite(4,0,0);
cgflip;
wait(3000);

% Waits for participant to press space button to validate gaze location
kp=0;
while ~kp
    [ks,kp]=cgkeymap;
    cgdrawsprite(5,0,0);
    cgflip;
    [x,y] = cgmouse;
end

% Display correct or incorrect

if (-100<x) && (x<115) && (-490<y) && (y<-310)
    cgdrawsprite(6,0,0);
    cgflip;
    wait(3000);
else
    cgdrawsprite(7,0,0);
    cgflip;
    wait(3000); 
end


cgshut
