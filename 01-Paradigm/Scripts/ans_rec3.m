function [reported_ans] = ans_rec3(x,y)
%function to determine what digit was recorded as being seen


if (-445 < x) && (x < 445) && (-115 < y) && (y < 115)
    reported_ans = 'equal';
elseif (-445 < x) && (x < 445) && (190 < y) && (y < 425)
    reported_ans = 'greater than previous';
elseif (-445 < x) && (x < 445) && (-430 < y) && (y < -200)
    reported_ans = 'smaller than previous';   
    
end
