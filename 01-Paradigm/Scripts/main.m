%% MSC PROJECT %%
% KCL Neuroimaging MSc Project
% [created by: J P Monney  07/06/2019 - updated: 11/07/2019]

clear all;


%% 1. Dialog box to enter participant number & mode

image_directory = 'C:\Users\EyeTracking\Desktop\N_J_Monney\N_images';
main_directory  = 'C:\Users\EyeTracking\Desktop\N_J_Monney';
prompt          = 'Enter participant number';
participant     = inputdlg(prompt);
participant     = participant{1};
prompt          = 'Enter mode: \n mode 0 = training session \n mode 1 = TASK 1 \n mode 2 = TASK 2 \n mode 3 = TASK 3 \n mode 4 = TASK 4';
mode            = inputdlg(sprintf(prompt));
mode            = mode{1};
mode            = str2num(mode);
N_trials        = 20;


%__________________________________________________________________________
% START TASK 1 = SEQUENCE
if mode == 1
    
    
    cd(main_directory);
    participant_folder = strcat('SUBJECT_', participant);
    mkdir(participant_folder);
    cd(participant_folder);
    mkdir('TASK1');
    
    cgloadlib; % adds all cogent functions and .mex files
    % in config_display(0 = window / 1 = fullscreen, 5 = 1280 x 1024)
    config_display(1,5); % !!! path to my folder must be added
    config_keyboard;
    start_cogent;
    
    task_num = 1;
    [edfFile, el] = eyelink_jona(task_num); % Steps 1.-4. for initialising Eyelink
   
    Eyelink('StartRecording'); % 5.  Start recording eye position
    WaitSecs(0.1) % 6.  Record a few samples before we actually start displaying
    Eyelink('Message', 'SYNCTIME'); % 7.  Mark zero-plot time in data file
    
    cd(image_directory);
    [delta_x, delta_y] = online_calibration(); % online calibration for gaze location adjustment
    cgloadbmp(101,'N_task1.bmp');
    cgloadbmp(102,'N_instructions1234.bmp');
    cgdrawsprite(101,0,0);
    cgflip;
    wait(1500);
    cgdrawsprite(102,0,0);
    cgflip;
    wait(4000);
    
    config_data( 'n_sequence.dat'); % contains sequence of 100 MNIST digits (file names & labels)
    for i = 1:N_trials %in test, i = 1:100
        mnist = getdata(i, 2);
        label = getdata(i, 1);
        TASK1_output(i) = display_sequ(participant, label, mnist,...
            i, participant_folder, image_directory, main_directory,...
            el, delta_x, delta_y);
    end
    
    [totalErrors1, meanTime1] = resCalc(TASK1_output, N_trials);
    for i = 1:N_trials
        TASK1_output(i).totalErros = totalErrors1;
        TASK1_output(i).meanTime = meanTime1;
    end
    
    cd(image_directory);
    cgloadbmp(123,'N_break.bmp');
    cgdrawsprite(123,0,0);
    cgflip;
    
    cd(main_directory);
    cd(participant_folder);
    save('TASK1_output.mat', 'TASK1_output'); %save the struct to a .mat
    
    Eyelink('StopRecording'); % 10. STOP RECORDING the eyetracker & Close the file
    Eyelink('CloseFile'); % 11. DOWNLOAD DATA into your favourite folder
    try
        fprintf('Receiving data file ''%s''\n', edfFile );
        status=Eyelink('ReceiveFile');
        if status > 0
            fprintf('ReceiveFile status %d\n', status);
        end
        if 2==exist(edfFile, 'file')
            fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
        end
    catch
        fprintf('Problem receiving data file ''%s''\n', edfFile );
    end
    
    wait(5000);
    cd(image_directory);
    cgloadbmp(124,'N_ready.bmp');
    cgdrawsprite(124,0,0);
    cgflip;
    kp = 0;
    while ~kp
        [ks,kp] = cgkeymap;
    end
    
    stop_cogent;
    
%__________________________________________________________________________
% START TASK2 = volatility
elseif mode == 2
    
    
    cd(main_directory);
    participant_folder = strcat('SUBJECT_', participant);
    mkdir(participant_folder);
    cd(participant_folder);
    mkdir('TASK2');
    
    cgloadlib; % adds all cogent functions and .mex files
    % in config_display(0 = window / 1 = fullscreen, 5 = 1280 x 1024)
    config_display(1,5); % !!! path to my folder must be added
    config_keyboard;
    start_cogent;
    
    task_num = 2;
    [edfFile, el] = eyelink_jona(task_num); % Steps 1.-4. for initialising Eyelink
    
    Eyelink('StartRecording'); % 5.  Start recording eye position
    WaitSecs(0.1) % 6.  Record a few samples before we actually start displaying
    Eyelink('Message', 'SYNCTIME'); % 7.  Mark zero-plot time in data file
    
    cd(image_directory);
    [delta_x, delta_y] = online_calibration(); % online calibration for gaze location adjustment
    cgloadbmp(103,'N_task2.bmp');
    cgdrawsprite(103,0,0);
    cgflip;
    wait(1500);
    cgdrawsprite(102,0,0);
    cgflip;
    wait(4000);
    
    config_data( 'volatility.dat');
    for i = 1:N_trials %in test, i = 1:100
        mnist = getdata(i, 2);
        label = getdata(i, 1);
        TASK2_output(i) = display_volatility(participant,label,...
            mnist, i, participant_folder, image_directory,...
            main_directory, el, delta_x, delta_y);
    end
    
    [totalErrors2, meanTime2] = resCalc(TASK2_output, N_trials);
    for i = 1:N_trials
        TASK2_output(i).totalErros = totalErrors2;
        TASK2_output(i).meanTime = meanTime2;
    end
    
    cd(image_directory);
    cgloadbmp(123,'N_break.bmp');
    cgdrawsprite(123,0,0);
    cgflip;
    
    cd(main_directory);
    cd(participant_folder);
    save('TASK2_output.mat', 'TASK2_output');
    
    Eyelink('StopRecording'); % 10. STOP RECORDING the eyetracker & Close the file
    Eyelink('CloseFile'); % 11. DOWNLOAD DATA into your favourite folder
    try
        fprintf('Receiving data file ''%s''\n', edfFile );
        status=Eyelink('ReceiveFile');
        if status > 0
            fprintf('ReceiveFile status %d\n', status);
        end
        if 2==exist(edfFile, 'file')
            fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
        end
    catch
        fprintf('Problem receiving data file ''%s''\n', edfFile );
    end
    
    wait(5000);
    cgdrawsprite(124,0,0);
    cgflip;
    [ks,kp] = cgkeymap;
    kp = 0;
    while ~kp
        [ks,kp] = cgkeymap;
    end
    
    stop_cogent;
    
%     %% TASK3 = higher/lower
%     
%     task_num = 3;
%     [edfFile, el] = eyelink_jona(task_num); % Steps 1.-4. for initialising Eyelink
%     
%     Eyelink('StartRecording'); % 5.  Start recording eye position
%     WaitSecs(0.1) % 6.  Record a few samples before we actually start displaying
%     Eyelink('Message', 'SYNCTIME'); % 7.  Mark zero-plot time in data file
%     
%     cd(image_directory);
%     [delta_x, delta_y] = online_calibration(); % online calibration for gaze location adjustment
%     cgloadbmp(104,'N_task3.bmp');
%     cgdrawsprite(104,0,0);
%     cgflip;
%     wait(1500);
%     cgdrawsprite(102,0,0);
%     cgflip;
%     wait(4000);
%     
%     config_data( 'random.dat');
%     prev_label = 0; % allows for comparison between i and i+1
%     for i = 1:100 %in test, i = 1:100
%         x2 = randi(1000);
%         mnist = getdata(x2, 2);
%         label = getdata(x2, 1);
%         TASK3_output(i) = display_compare(participant, label,...
%             mnist, prev_label, i, participant_folder, image_directory,...
%             main_directory, el, delta_x, delta_y);
%         prev_label = label;
%     end
%     
%     [totalErrors3, meanTime3] = resCalc(TASK3_output);
%     for i = 1:100
%         TASK3_output(i).totalErros = totalErrors3;
%         TASK3_output(i).meanTime = meanTime3;
%     end
%     
%     cd(image_directory);
%     cgloadbmp(123,'N_break.bmp');
%     cgdrawsprite(123,0,0);
%     cgflip;
%     
%     cd(main_directory);
%     cd(participant_folder);
%     save('TASK3_output.mat', 'TASK3_output');
%     
%     Eyelink('StopRecording'); % 10. STOP RECORDING the eyetracker & Close the file
%     Eyelink('CloseFile'); % 11. DOWNLOAD DATA into your favourite folder
%     try
%         fprintf('Receiving data file ''%s''\n', edfFile );
%         status=Eyelink('ReceiveFile');
%         if status > 0
%             fprintf('ReceiveFile status %d\n', status);
%         end
%         if 2==exist(edfFile, 'file')
%             fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
%         end
%     catch
%         fprintf('Problem receiving data file ''%s''\n', edfFile );
%     end
%     
%     wait(5000);
%     cgdrawsprite(124,0,0);
%     cgflip;
%     [ks,kp] = cgkeymap;
%     kp = 0;
%     while ~kp
%         [ks,kp] = cgkeymap;
%     end


%__________________________________________________________________________
% START TASK 3 = random scanning
elseif mode == 3
    
    cd(main_directory);
    participant_folder = strcat('SUBJECT_', participant);
    mkdir(participant_folder);
    cd(participant_folder);
    mkdir('TASK3');
    
    cgloadlib; % adds all cogent functions and .mex files
    % in config_display(0 = window / 1 = fullscreen, 5 = 1280 x 1024)
    config_display(1,5); % !!! path to my folder must be added
    config_keyboard;
    start_cogent;
    
    task_num = 3;
    [edfFile, el] = eyelink_jona(task_num); % Steps 1.-4. for initialising Eyelink
    
    Eyelink('StartRecording'); % 5.  Start recording eye position
    WaitSecs(0.1) % 6.  Record a few samples before we actually start displaying
    Eyelink('Message', 'SYNCTIME'); % 7.  Mark zero-plot time in data file
    
    cd(image_directory);
    [delta_x, delta_y] = online_calibration(); % online calibration for gaze location adjustment
    cgloadbmp(105,'N_task4.bmp',1000,1000);
    cgdrawsprite(105,0,0);
    cgflip;
    wait(1500);
    cgdrawsprite(102,0,0);
    cgflip;
    wait(4000);
    
    config_data( 'random.dat' );
    for i = 1:N_trials %in test, i = 1:100
        x1 = randi(1000);
        mnist = getdata(x1, 2);
        label = getdata(x1, 1);
        TASK3_output(i) = display_rand(participant, label, mnist,...
            i, participant_folder, image_directory, main_directory,...
            el, delta_x, delta_y);
    end
    
    [totalErrors3, meanTime3] = resCalc(TASK3_output, N_trials);
    for i = 1:N_trials
        TASK3_output(i).totalErros = totalErrors3;
        TASK3_output(i).meanTime   = meanTime3;
    end
    
    cd(image_directory);
    cgloadbmp(125,'N_endsession.bmp');
    cgdrawsprite(125,0,0);
    cgflip;
    
    cd(main_directory);
    cd(participant_folder);
    save('TASK3_output.mat', 'TASK3_output');
    
    Eyelink('StopRecording'); % 10. STOP RECORDING the eyetracker & Close the file
    Eyelink('CloseFile'); % 11. DOWNLOAD DATA into your favourite folder
    try
        fprintf('Receiving data file ''%s''\n', edfFile );
        status=Eyelink('ReceiveFile');
        if status > 0
            fprintf('ReceiveFile status %d\n', status);
        end
        if 2==exist(edfFile, 'file')
            fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
        end
    catch
        fprintf('Problem receiving data file ''%s''\n', edfFile );
    end
    
    wait(5000);
    cd(image_directory);
    cgloadbmp(124,'N_ready.bmp');
    cgdrawsprite(124,0,0);
    cgflip;
    kp = 0;
    while ~kp
        [ks,kp] = cgkeymap;
    end
    
    stop_cogent;
    

%__________________________________________________________________________
% START TASK 4 = random scanning
elseif mode == 4
    
    cd(main_directory);
    participant_folder = strcat('SUBJECT_', participant);
    mkdir(participant_folder);
    cd(participant_folder);
    mkdir('TASK4');
    
    cgloadlib; % adds all cogent functions and .mex files
    % in config_display(0 = window / 1 = fullscreen, 5 = 1280 x 1024)
    config_display(1,5); % !!! path to my folder must be added
    config_keyboard;
    start_cogent;
        
    task_num = 4;

    [edfFile, el] = eyelink_jona(task_num); % Steps 1.-4. for initialising Eyelink
   
    Eyelink('StartRecording'); % 5.  Start recording eye position
    WaitSecs(0.1) % 6.  Record a few samples before we actually start displaying
    Eyelink('Message', 'SYNCTIME'); % 7.  Mark zero-plot time in data file
    
    cd(image_directory);
    [delta_x, delta_y] = online_calibration(); % online calibration for gaze location adjustment
    cgloadbmp(101,'N_task1.bmp');
    cgloadbmp(102,'N_instructions1234.bmp');
    cgdrawsprite(101,0,0);
    cgflip;
    wait(1500);
    cgdrawsprite(102,0,0);
    cgflip;
    wait(4000);
    
    config_data( 'sequence.dat'); % contains sequence of 100 MNIST digits (file names & labels)
    for i = 1:N_trials %in test, i = 1:100
        mnist = getdata(i, 2);
        label = getdata(i, 1);
        TASK4_output(i) = display_sequUF(participant, label, mnist,...
            i, participant_folder, image_directory, main_directory,...
            el, delta_x, delta_y);
    end
    
    [totalErrors4, meanTime4] = resCalc(TASK4_output, N_trials);
    for i = 1:N_trials
        TASK4_output(i).totalErros = totalErrors4;
        TASK4_output(i).meanTime = meanTime4;
    end
    
    cd(image_directory);
    cgloadbmp(123,'N_break.bmp');
    cgdrawsprite(123,0,0);
    cgflip;
    
    cd(main_directory);
    cd(participant_folder);
    save('TASK4_output.mat', 'TASK4_output'); %save the struct to a .mat
    
    Eyelink('StopRecording'); % 10. STOP RECORDING the eyetracker & Close the file
    Eyelink('CloseFile'); % 11. DOWNLOAD DATA into your favourite folder
    try
        fprintf('Receiving data file ''%s''\n', edfFile );
        status=Eyelink('ReceiveFile');
        if status > 0
            fprintf('ReceiveFile status %d\n', status);
        end
        if 2==exist(edfFile, 'file')
            fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
        end
    catch
        fprintf('Problem receiving data file ''%s''\n', edfFile );
    end
    
    
    cd(image_directory);
    cgloadbmp(125,'N_endsession.bmp');
    cgdrawsprite(125,0,0);
    cgflip;
    wait(5000);
    
    stop_cogent;
    
    
%--------------------------------------------------------------------------
% Enter into training mode (if mode == 0)
elseif mode == 0
    task_num = 0;
    [edfFile, el] = eyelink_jona(task_num); % Steps 1.-4. for initialising Eyelink
    
    cgloadlib; % adds all cogent functions and .mex files
    % in config_display(0 = window / 1 = fullscreen, 5 = 1280 x 1024)
    config_display(1,5); % !!! path to my folder must be added
    config_keyboard;
    start_cogent;
    cd(main_directory);
    mkdir TRIAL; % output directory for Trial session
    
    Eyelink('StartRecording'); % 5.  Start recording eye position
    WaitSecs(0.1) % 6. Record a few samples before we actually start displaying
    Eyelink('Message', 'SYNCTIME'); % 7.  Mark zero-plot time in data file
    
    cd(image_directory);
    [delta_x, delta_y] = online_calibration(); % online calibration for gaze location adjustment
    cgloadbmp(107,'N_trialsession.bmp');
    cgloadbmp(108,'N_instructions1234.bmp');
    cgdrawsprite(107,0,0);
    cgflip;
    wait(2000);
    cgdrawsprite(108,0,0);
    cgflip;
    wait(3000);
    
    config_data( 'random.dat' ); % contains list of 1000 MNIST digits (file names & labels)
    for i = 1:5
        x1 = randi(1000);
        mnist = getdata(x1, 2);
        label = getdata(x1, 1);
        display_test(label, mnist, i,...
            image_directory, main_directory, el,...
            delta_x, delta_y);
    end
    
    Eyelink('StopRecording') ;% 10. STOP RECORDING the eyetracker & Close the file
    Eyelink('CloseFile');
    
    cd(main_directory);
    cd TRIAL;
    
    try % 11. DOWNLOAD DATA into desired .edf file
        fprintf('Receiving data file ''%s''\n', edfFile );
        status=Eyelink('ReceiveFile');
        if status > 0
            fprintf('ReceiveFile status %d\n', status);
        end
        if 2==exist(edfFile, 'file')
            fprintf('Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
        end
    catch
        fprintf('Problem receiving data file ''%s''\n', edfFile );
    end
    
    stop_cogent;
    
%--------------------------------------------------------------------------
end

