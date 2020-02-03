function [edfFile, el] = eyelink_jona(task_num)
%% EYELINK INITIALIZER
% 24/06/2019 J P Monney - Credit to Berk Mirza (got code from him)

xres         = 1280; % horizontal resolution
yres         = 1024; % vertical resolution
TopDist      = 540; % Subject's eye distance to the top of the screen
BottomDist   = 615; % Subject's eye distance to the bottom of the screen
H            = 363; % Horizontal length of the screen
V            = 270; % Vertical length of the screen



dummymode = 0;
% 1. Initialization of the connection with the Eyelink Gazetracker.
%    exit program if this fails.
%    dummymode=0 ---> real initialization,
%    dummymode=1 ---> mouse serves as eyetracker
if ~EyelinkInit(dummymode, 1)
    fprintf('Eyelink Init aborted.\n');
    cleanup;  % cleanup function
    return;
end

el = EyelinkInitDefaults();

ScrnPxCoord = ['screen_pixel_coords = ' num2str(0) ' ' num2str(0) ' ' num2str(xres-1) ' ' num2str(yres-1)];
ScrnPhysCoord = ['screen_phys_coords = ' num2str(-H/2) ' ' num2str(V/2) ' ' num2str(H/2) ' ' num2str(-V/2) ];
ScrnDist = ['screen_distance = ' num2str(TopDist) ' ' num2str(BottomDist)];
Eyelink('Command', ScrnPxCoord);
Eyelink('Command', ScrnPhysCoord);
Eyelink('Command', ScrnDist);

% 2.  SPECIFY DATA 
%     make sure that we get gaze data from the Eyelink
Eyelink('Command', 'link_sample_data = LEFT,RIGHT,GAZE,AREA,PUPIL,FIXATION,BLINK,SACCADE,BUTTON');
% Eyelink('Command', 'link_sample_data = LEFT,RIGHT,GAZE,AREA,SACCADE');
% % Eyelink('Command', 'link_event_filter = LEFT,RIGHT,FIXATION,BLINK,SACCADE,BUTTON');

% 3.  CHECK EYE which eye is being used today
% 0=left, 1=right, 2=both :)
eye_used = 0;
% eye_used = Eyelink('EyeAvailable');

% 4.  OPEN FILE to record data to
edfFile = strcat('Task',int2str(task_num),'.edf'); %<-make sure it isn't too long, error code -3 !
Eyelink('Openfile', edfFile);










