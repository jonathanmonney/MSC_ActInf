function [reported_digit] = ans_rec(x,y)
%function to determine what digit was recorded as being seen

r = 81; % accepted radius answer

D0 = ((((x - 9)^2)+((y - 370)^2))^0.5);
D1 = ((((x - 235)^2)+((y - 300)^2))^0.5);
D2 = ((((x - 380)^2)+((y - 110)^2))^0.5);
D3 = ((((x - 380)^2)+((y + 130)^2))^0.5);
D4 = ((((x - 235)^2)+((y + 320)^2))^0.5);
D5 = ((((x - 9)^2)+((y + 400)^2))^0.5);
D6 = ((((x + 215)^2)+((y + 320)^2))^0.5);
D7 = ((((x + 360)^2)+((y + 130)^2))^0.5);
D8 = ((((x + 360)^2)+((y - 110)^2))^0.5);
D9 = ((((x + 215)^2)+((y - 300)^2))^0.5);

if (D0 < r)
    reported_digit = 0;
elseif (D1 < r)
    reported_digit = 1;
elseif (D2 < r)
    reported_digit = 2;
elseif (D3 < r)
    reported_digit = 3;
elseif (D4 < r)
    reported_digit = 4;
elseif (D5 < r)
    reported_digit = 5;
elseif (D6 < r)
    reported_digit = 6;
elseif (D7 < r)
    reported_digit = 7;
elseif (D8 < r)
    reported_digit = 8;
elseif (D9 < r)
    reported_digit = 9;
else
    reported_digit = 99999;
    
    
end

