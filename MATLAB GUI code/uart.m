%fclose(s);
% s = serial('COM18');
% set(s,'BaudRate',115200,'Databits',8,'Parity','none','Terminator',0); %,'FlowControl','Hardware'
% %set(s,'BaudRate',19200,'Databits',8,'Parity','none','Terminator',0); %%,'FlowControl','Hardware'
% fopen(s);

disp('serial port open');

%close all;

first_time = 1;
count = 0; % unique count given to each draw

while(1)
    i = 0;
    character = 0;
    %clear buffer
    while(s.BytesAvailable > 48)
        %fread(s, s.BytesAvailable); %clear buffer
        character = fgets(s); %new data
        i = i+1;
    end
    
    %next character
    character = fgets(s);

     if(length(character) == 128)
         % disp(character);
        if(first_time == 1)
            first_time = 0;
        	[NS,EW,NS_busy,EW_busy,local_busy_in,blinking] = draw(count,character);
            count = count + 1;
        else
             draw(count,character,NS,EW,NS_busy,EW_busy,local_busy_in,blinking);
             count = count + 1;
        end
    else
%          disp('length error - ');
%          length(character)
    end
end

%fclose(s);