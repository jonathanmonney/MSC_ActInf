function [num_errors,averageTime] = resCalc(TASK_output, N_trials)

num_errors = 0;
averageTime = TASK_output(1).responseTime;
for j = 1:N_trials
    
    if strlength(TASK_output(j).result) == 9
       count = num_errors;
       num_errors = num_errors+1;
    end
    
    averageTime = averageTime + TASK_output(j).responseTime;
    
end

averageTime = averageTime/N_trials;

end

