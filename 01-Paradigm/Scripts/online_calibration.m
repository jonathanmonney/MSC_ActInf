function [delta_x, delta_y] = online_calibration ()

% This function allows a direct online calibration to ensure recorded responses match participant’s
% gaze and the transparent mask accurately follows saccade path
%
%[created by: J P Monney  26/06/2019 - updated: 27/06/2019]


cgloadbmp(200,'N_calibBG.bmp');
cgloadbmp(201,'N_calibDOT.bmp');
cgtrncol(201,'w');



[ks, kp] = cgkeymap; % reset any previously stored keyboard presses
kp = 0;
eye_used = 0;
xres = 1280;
yres = 1024;
x = Inf;
y = Inf;
%[xm,ym,bs,bp] = cgmouse; % reset any previously stored mouse button presses
%bp = 0;

while ~kp
    if Eyelink('NewFloatSampleAvailable') > 0
        % get the sample in the form of an event structure
        evt = Eyelink('NewestFloatSample');
        x = (evt.gx(eye_used+1)) - xres/2; % +1 as we're accessing MATLAB array
        y = yres/2 - (evt.gy(eye_used+1));
        cgdrawsprite(200, 0, 0);
        cgdrawsprite(201, x, y);
        cgflip;
        [ks, kp] = cgkeymap;
    end
end

delta_x = x - 0;
delta_y = y - 0;
[ks, kp] = cgkeymap; % reset any previously stored keyboard presses
kp = 0;
while ~kp
    if Eyelink('NewFloatSampleAvailable') > 0
        % get the sample in the form of an event structure
        evt = Eyelink('NewestFloatSample');
        x = (evt.gx(eye_used+1)) - xres/2 -delta_x; % +1 as we're accessing MATLAB array
        y = yres/2 - (evt.gy(eye_used+1)) - delta_y;
        cgdrawsprite(200, 0, 0);
        cgdrawsprite(201, x, y);
        cgflip;
        [ks, kp] = cgkeymap;
    end
end


% [ks, kp] = cgkeymap;
% kp = 0;
% % while ~bp % Until there's a button press, keep displaying calibrator
% %     if ~kp % Keep showing latest x/y delta updates
%         if Eyelink('NewFloatSampleAvailable') > 0
%             % get the sample in the form of an event structure
%             evt = Eyelink('NewestFloatSample');
%             x = (evt.gx(eye_used+1)) - xres/2 - delta_x; % +1 as we're accessing MATLAB array
%             y = yres/2 - (evt.gy(eye_used+1)) - delta_y;
%             cgdrawsprite(200, 0, 0);
%             cgdrawsprite(201, x, y);
%             cgflip;
%             [ks, kp] = cgkeymap;
%             [xm,ym,bs,bp] = cgmouse;
%         end
%     else % if space bar pressed, x/y delta values updated
%         delta_x = x - 0;
%         delta_y = y - 0;
%         [xm,ym,bs,bp] = cgmouse;
%         kp = 0;
%     end
% end

end