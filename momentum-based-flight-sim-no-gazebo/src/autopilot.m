function [joyButtons,joyAxes] = autopilot(time, Config)
    
    persistent front_pressed pitch_c_pressed takeoff_pressed ...
               pitch_ac_pressed yaw_c_pressed yaw_ac_pressed  ...
               up_pressed down_pressed turbo_mode 
    
    front_pressed    = 0;
    pitch_c_pressed  = 0;
    pitch_ac_pressed = 0;
    yaw_c_pressed    = 0;
    yaw_ac_pressed   = 0;
    takeoff_pressed  = 0;
    down_pressed     = 0;
    up_pressed       = 0;
    turbo_mode       = 0;
    
    joyAxes    = zeros(6,1);
    joyButtons = zeros(24,1);
    
    % Perform In-line trajectory
    if Config.FIRST_TRAJECTORY
        
        if time > 10 && time < 15
            up_pressed = 1;             % Climb up
        end
        if time > 18 && time < 23
            front_pressed = 1;         % Move forward
            % turbo_mode    = 1;          % Move max speed
        end
        if time > 25 && time < 30
            pitch_ac_pressed    = 1;    % Bring base vertical
        end
        if time > 32 && time < 35
            down_pressed = 1;           % Approach the ground
        end
        if time > 38 && time < 40
             yaw_c_pressed  = 1;           % Yaw aroud
        end
    elseif Config.SECOND_TRAJECTORY
         if time > 10 && time < 15
             up_pressed = 1; 
             yaw_c_pressed  = 1;           
         end
          if time > 15 && time < 23
            front_pressed = -1;                         
          end
           if time > 23 && time < 30
             yaw_ac_pressed  = 1;           % Yaw aroud
           end
           if time > 30 && time < 35
            front_pressed = 1; 
           end
           if time > 35 && time < 40
            down_pressed = 1;  
            yaw_c_pressed  = 1;
           end
       elseif Config.THIRD_TRAJECTORY
         if time > 10 && time < 15
             up_pressed = 1; 
           end
          if time > 15 && time < 23
            front_pressed = 1; 
            end
          if time > 23 && time < 25
            down_pressed = 1;  
          end
          if time > 25 && time < 30
            front_pressed = - 1;  
          end
          if time > 30 && time < 38
            front_pressed = - 1;  
          end
          if time > 38 && time < 42
            down_pressed = 1;  
          end
        elseif Config.FOURTH_TRAJECTORY
         if time > 10 && time < 25
             up_pressed = 1; 
           end
          if time > 25 && time < 26
            front_pressed = 1; 
            end
          if time > 26 && time < 28
            down_pressed = 1;  
          end
          if time > 28 && time < 30
            front_pressed = 1;  
          end
          if time > 30 && time < 38
            front_pressed = - 1;  
          end
          if time > 38 && time < 42
            down_pressed = 1;  
          end
       elseif Config.FIFTH_TRAJECTORY
         if time > 10 && time < 13
             up_pressed = 1; 
             yaw_c_pressed  = 1;           
         end
          if time > 13 && time < 23
            up_pressed = 1; 
             yaw_ac_pressed  = 1;                         
          end
           if time > 23 && time < 30
             yaw_ac_pressed  = 1;           % Yaw aroud
           end
           if time > 30 && time < 35
            front_pressed = 1; 
           end
           if time > 35 && time < 43
            down_pressed = 1;  
            yaw_c_pressed  = 1;
           end
        elseif Config.SIXTH_TRAJECTORY
         if time > 10 && time < 12
             up_pressed = 1; 
             yaw_c_pressed  = 1;           
         end
          if time > 12 && time < 15
            up_pressed = 1; 
             yaw_ac_pressed  = 1;                         
          end
          if time > 15 && time < 18
             up_pressed = 1; 
             yaw_c_pressed  = 1;           
         end
          if time > 18 && time < 20
            up_pressed = 1; 
             yaw_ac_pressed  = 1;                         
          end
           if time > 20 && time < 25
             yaw_ac_pressed  = 1;           % Yaw aroud
           end
            if time > 25 && time < 26
            front_pressed = 1; 
            end
          if time > 26 && time < 28
            down_pressed = 1;  
          end
          if time > 28 && time < 30
            front_pressed = 1;  
          end
          if time > 30 && time < 38
            front_pressed = - 1;  
          end
          if time > 38 && time < 42
            down_pressed = 1;
            end
    % Perform Closed-loop trajectory
    % elseif Config.CLOSED_LOOP_TRAJECTORY
    % 
    %     if time > 10 && time < 17
    %         up_pressed  = 1;            % Climb up
    %     end
    %     if time > 20 && time < 27
    %         front_pressed   = -1;       % Move forward 1
    %         turbo_mode      = 1;        % Move max speed 1
    %     end
    %     if time > 35 && time < 36
    %         pitch_ac_pressed    = 1;    % Bring base vertical 1
    %     end
    %     if time > 35 && time < 38
    %         yaw_c_pressed  = 1;        % Rotate base to the left 1
    %     end
    %     if time > 45 && time < 52
    %         front_pressed   = -1;       % Move forward 2
    %         turbo_mode      = 1;        % Move max speed 2
    %     end
    %     if time > 60 && time < 61
    %         pitch_ac_pressed    = 1;    % Bring base vertical 2
    %     end
    %     if time > 60 && time < 63
    %         yaw_c_pressed  = 1;        % Rotate base to the left 2
    %     end
    %     if time > 70 && time < 77
    %         front_pressed   = -1;       % Move forward 3
    %         turbo_mode      = 1;        % Move max speed 3
    %     end
    %     if time > 85 && time < 88
    %         yaw_c_pressed  = 1;        % Rotate base to the left 3
    %     end
    %     if time > 95 && time < 102
    %         front_pressed   = -1;       % Move forward 4
    %         turbo_mode      = 1;        % Move max speed 4
    %     end
    %     if time > 110 && time < 113
    %         yaw_c_pressed  = 1;        % Rotate base to the left 4
    %     end
    %     if time > 120 && time < 121
    %         pitch_ac_pressed    = 1;    % Bring base vertical
    %     end
    %     if time > 122 && time < 129
    %         down_pressed = 1;           % Approach the ground
    %     end
    
    % elseif Config.CLOSED_LOOP_TRAJECTORY_NO_TURBO
    % 
    %     if time > 10 && time < 17
    %         up_pressed  = 1;            % Climb up
    %     end
    %     if time > 20 && time < 27
    %         front_pressed   = -1;       % Move forward 1
    %     end
    %     if time > 30 && time < 33
    %         yaw_c_pressed  = 1;        % Rotate base to the left 1
    %     end
    %     if time > 40 && time < 47
    %         front_pressed   = -1;       % Move forward 2
    %     end
    %     if time > 50 && time < 53
    %         yaw_c_pressed  = 1;        % Rotate base to the left 2
    %     end
    %     if time > 60 && time < 67
    %         front_pressed   = -1;       % Move forward 3
    %     end
    %     if time > 70 && time < 73
    %         yaw_c_pressed  = 1;        % Rotate base to the left 3
    %     end
    %     if time > 80 && time < 87
    %         front_pressed   = -1;       % Move forward 4
    %     end
    %     if time > 90 && time < 93
    %         yaw_c_pressed  = 1;        % Rotate base to the left 4
    %     end
    %     if time > 100 && time < 107
    %         down_pressed = 1;           % Approach the ground
    %     end

    end

 
    if front_pressed
        joyAxes(2) = front_pressed;
    end
    if pitch_c_pressed
        joyAxes(6) = pitch_c_pressed;
    else
        joyAxes(6) = pitch_ac_pressed;
    end
        
    joyButtons(13) = up_pressed;
    joyButtons(6)  = takeoff_pressed;
    joyButtons(16) = yaw_ac_pressed;
    joyButtons(15) = yaw_c_pressed;
    joyButtons(14) = down_pressed; 
    joyButtons(7)  = turbo_mode; 
end