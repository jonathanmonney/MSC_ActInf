function [trial] = display_rand(participant, label, mnist, i,...
    participant_folder, image_directory, main_directory, el,...
    delta_x, delta_y)
% Takes the selected MNIST digit and its value - performs task
%1. Fixation cross (press space bar when ready)
%2. Displays alpha hole over MNIST digit
%3. Answer validation instructions (press space bar when staring at digit)
%4. Gives feedback on answer
% KCL Neuroimaging MSc Project
% [created by: J P Monney  23/06/2019 - updated: 26/06/2019]

cd(image_directory);

cgloadbmp(1,mnist,600,600)
cgloadbmp(2,'N_thecircle150.bmp')
cgloadbmp(3,'N_cross.bmp')
cgloadbmp(4,'N_instructionsDECISION.bmp')
cgloadbmp(5,'N_digit_dial.bmp')
cgloadbmp(6,'N_correct.bmp')
cgloadbmp(7,'N_incorrect.bmp')
cgloadbmp(9,'N_white.bmp',1280,1024)
cgloadbmp(10,'N_BG.bmp')
cgloadbmp(11,'N_ready.bmp')
cgloadbmp(12,'N_selection.bmp')
cgtrncol(2,'w')
cgtrncol(12,'w')


if i == 1
    % Uses space bar press as signal for ready to start task
    [ks,kp]=cgkeymap; % to re-initialize accidental button press
    kp=0;
    cgdrawsprite(11,0,0);
    cgflip;
    while ~kp
        [ks,kp]=cgkeymap;
    end
end

tic;
timerV = 0;
eye_used = 0;
xres = 1280; % horizontal resolution
yres = 1024; % vertical resolution
loop_count = 1; %to creat coordinates cell
coordinates = []; %to store gaze data
tmess = [ 'trial_start' num2str(i)]; % 8. MESSAGE - send & log start of each trial
Eyelink('Message', tmess);

cgdrawsprite(3,0,0)
cgflip
r = 50;
x = Inf;
y = Inf;
while sqrt(power(x,2) + power(y,2)) > r
    if Eyelink('NewFloatSampleAvailable') > 0
        % get the sample in the form of an event structure
        evt = Eyelink('NewestFloatSample');
        x = (evt.gx(eye_used+1)) - xres/2 - delta_x; % +1 as we're accessing MATLAB array
        y = yres/2 - (evt.gy(eye_used+1)) - delta_y;
    end
end
cgflip;
start = toc;
[ks,kp]=cgkeymap;
kp = 0;
while  ~kp & (timerV < 3) % either button press or max 3 seconds
    %    [x,y]=cgmouse; % tracks mouse in lieu of gaze [for now...]
    if Eyelink('NewFloatSampleAvailable') > 0
        % get the sample in the form of an event structure
        evt = Eyelink('NewestFloatSample');
        x = evt.gx(eye_used+1);
        y = evt.gy(eye_used+1);
        x = x - xres/2 - delta_x; % +1 as we're accessing MATLAB array
        y = yres/2 - y - delta_y;
        if x ~= el.MISSING_DATA && y ~= el.MISSING_DATA
            if (x < xres/2 ) && (y > yres/2)
                cgdrawsprite(10,0,0);
                cgflip;
                finish = toc;
                [ks, kp] = cgkeymap;
                timerV = (finish - start);
                coordinates(loop_count,1) = NaN;
                coordinates(loop_count,2) = NaN;
                coordinates(loop_count,3) = finish;
                loop_count = loop_count +1;
            else
                cgdrawsprite(10,0,0); % black BG
                cgdrawsprite(1,0,0); % MNIST digit
                cgdrawsprite(2,x,y); % transparent circle
                cgflip;
                finish = toc;
                [ks, kp] = cgkeymap;
                timerV = (finish - start);
                coordinates(loop_count,1) = x;
                coordinates(loop_count,2) = y;
                coordinates(loop_count,3) = finish;
                loop_count = loop_count +1;
            end
        end
    end
end
tmess = [ 'trial_end' num2str(i)];
Eyelink('Message', tmess);
% Explains to participant how to validate their answer
cgdrawsprite(4,0,0);
cgflip;
wait(1000);

% Waits for participant to press space button to validate gaze location
[ks,kp]=cgkeymap; % to re-initialize accidental button press
kp=0;
x = 0;
y = 0;
while ~kp
    if Eyelink('NewFloatSampleAvailable') > 0
        % get the sample in the form of an event structure
        evt = Eyelink('NewestFloatSample');
        x = evt.gx(eye_used+1) - xres/2 - delta_x; % +1 as we're accessing MATLAB array
        y = yres/2 - evt.gy(eye_used+1) - delta_y;
        coordinates(loop_count, 1) = x;
        coordinates(loop_count, 2) = y;
        coordinates(loop_count, 3) = NaN;
    end
    cgdrawsprite(5,0,0);
    cgdrawsprite(12,x,y);
    cgflip;
    [ks,kp]=cgkeymap;
end
tmess = [ 'result_entered' num2str(i)];
Eyelink('Message', tmess);

cgdrawsprite(9,0,0);
cgflip;
wait(100);


% Display correct or incorrect
if label == 0
    r = 81;
    D = ((((x - 9)^2)+((y - 370)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 1
    r = 81;
    D = ((((x - 235)^2)+((y - 300)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 2
    r = 81;
    D = ((((x - 380)^2)+((y - 110)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 3
    r = 81;
    D = ((((x - 380)^2)+((y + 130)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 4
    r = 81;
    D = ((((x - 235)^2)+((y + 320)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 5
    r = 81;
    D = ((((x - 9)^2)+((y + 400)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 6
    r = 81;
    D = ((((x + 215)^2)+((y + 320)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 7
    r = 81;
    D = ((((x + 360)^2)+((y + 130)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 8
    r = 81;
    D = ((((x + 360)^2)+((y - 110)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
elseif label == 9
    r = 81;
    D = ((((x + 215)^2)+((y - 300)^2))^0.5);
    if (D < r)
        cgdrawsprite(6,0,0);
        cgflip;
        wait(1000);
        result = 'correct';
    else
        cgdrawsprite(7,0,0);
        cgflip;
        wait(1000);
        result = 'incorrect';
    end
    
end

reported_digit = ans_rec(x,y);

%Create output file and save label and mnist file data
output_file = strcat(participant, '_TASK3_', int2str(i), '_',...
    result, '_', int2str(label), '.mat');
cd(main_directory);
cd(participant_folder);
cd('TASK3');
save(output_file, 'participant', 'label', 'mnist', 'reported_digit',...
    'result', 'coordinates', 'delta_x', 'delta_y', 'timerV');
trial.participant = participant;
trial.label = label;
trial.file = mnist;
trial.reportedDigit = reported_digit;
trial.result = result;
trial.responseTime = timerV;
trial.coordinates = coordinates;
trial.deltaX = delta_x;
trial.deltaY = delta_y;
cd(image_directory);

end