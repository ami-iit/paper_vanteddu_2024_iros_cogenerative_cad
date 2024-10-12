urdfFile = './momentum-based-flight-sim-no-gazebo/robots/model_stl.urdf';

robot = importrobot(urdfFile);
link_name_1 = 'chest_l_bracket'
link_name_2 = 'chest_r_bracket'
link_name_3 = 'l_forearm'
link_name_4 = 'r_forearm'
link_id_l_bracket = find(strcmp(robot.BodyNames, link_name_1))
link_id_r_bracket = find(strcmp(robot.BodyNames, link_name_2))
link_id_l_forearm = find(strcmp(robot.BodyNames, link_name_3))
link_id_r_forearm = find(strcmp(robot.BodyNames, link_name_4))

p_R_j_l_br = robot.Bodies{1,link_id_l_bracket}.Children{1,1}.Joint.JointToParentTransform
p_R_j_r_br = robot.Bodies{1,link_id_r_bracket}.Children{1,1}.Joint.JointToParentTransform
RPY_l_old_br = rotm2eul(p_R_j_l_br(1:3,1:3),'zyx')
RPY_r_old_br = rotm2eul(p_R_j_r_br(1:3,1:3),'zyx')
Rot_x = rotx(0)
Rot_y = roty(ANGLE-105)
Rot_z_l = rotz(-ANGLE_ASSEMBLY)
Rot_z_r = rotz(ANGLE_ASSEMBLY)
p_R_j_l_new_br = p_R_j_l_br(1:3,1:3)*Rot_y
p_R_j_r_new_br = p_R_j_r_br(1:3,1:3)*Rot_y
p_R_j_l_new_br = p_R_j_l_new_br*Rot_z_l
p_R_j_r_new_br = p_R_j_r_new_br*Rot_z_r
RPY_l_br = rotm2eul(p_R_j_l_new_br,'zyx')
RPY_r_br = rotm2eul(p_R_j_r_new_br,'zyx')
RPY_l_br = [RPY_l_br(3) RPY_l_br(2) RPY_l_br(1)] 
RPY_r_br = [RPY_r_br(3) RPY_r_br(2) RPY_r_br(1)] 
p_R_j_l_fr = robot.Bodies{1,link_id_l_forearm}.Children{1,1}.Joint.JointToParentTransform
p_R_j_r_fr = robot.Bodies{1,link_id_r_forearm}.Children{1,1}.Joint.JointToParentTransform
RPY_l_old_fr = rotm2eul(p_R_j_l_fr(1:3,1:3),'zyx')
RPY_r_old_fr = rotm2eul(p_R_j_r_fr(1:3,1:3),'zyx')
RPY_l_fr = [RPY_l_old_fr(3) RPY_l_old_fr(2) RPY_l_old_fr(1)] 
RPY_r_fr = [RPY_r_old_fr(3) RPY_r_old_fr(2) RPY_r_old_fr(1)] 
OriginXYZ_l_br = [(23.0274 + DISTANCE*cosd(ANGLE-90)+15*sind(ANGLE-90))/1000; 0 ; -(15 + DISTANCE*sind(ANGLE-90)-15*cosd(ANGLE-90))/1000]
 
OriginXYZ_l_br = OriginXYZ_l_br';

OriginXYZ_r_br = [(23.0274 + DISTANCE*cosd(ANGLE-90)+15*sind(ANGLE-90))/1000; 0 ; -(15 + DISTANCE*sind(ANGLE-90)-15*cosd(ANGLE-90))/1000]

OriginXYZ_r_br = OriginXYZ_r_br'

OriginXYZ_l_fr = [(-210-LENGTH)/1000; 0 ; -OFFSET/1000]
 
OriginXYZ_l_fr = OriginXYZ_l_fr';

OriginXYZ_r_fr = [(-210-LENGTH)/1000; 0 ; OFFSET/1000]

OriginXYZ_r_fr = OriginXYZ_r_fr'

mass_value_br = MASS_br;
IXX_value_br = IXX_br/1000000;
IYY_value_br = IYY_br/1000000;
IZZ_value_br = IZZ_br/1000000;

mass_value_fr = MASS_fr;
IXX_value_fr = IXX_fr/1000000;
IYY_value_fr = IYY_fr/1000000;
IZZ_value_fr = IZZ_fr/1000000;
%urdfFile = 'C:\Users\pvanteddu\Documents\GitHub\element_co-generative-cad\Geometries\CAD\CREO\jetpack\simulation_model\jetpack_forearms\model_stl.urdf'; % Replace with your URDF file path
% Define arrays or cell arrays for link and joint names
linkNames = {'chest_l_bracket', 'chest_r_bracket','l_forearm','r_forearm'}; % Replace with the names of the links you want to modify
jointNames = {'r_turbine_support', 'l_turbine_support', 'l_elbow_turbine', 'r_elbow_turbine'}; % Replace with the names of the joints you want to modify

% Define arrays or cell arrays for new values
newMassValues = {num2str(mass_value_br), num2str(mass_value_br),num2str(mass_value_fr), num2str(mass_value_fr)}; % New mass values for each link
newIxxValues = {num2str(IXX_value_br), num2str(IXX_value_br),num2str(IXX_value_fr), num2str(IXX_value_fr)}; % New Ixx values for each link
newIyyValues = {num2str(IYY_value_br), num2str(IYY_value_br),num2str(IYY_value_fr), num2str(IYY_value_fr)}; % New Iyy values for each link
newIzzValues = {num2str(IZZ_value_br), num2str(IZZ_value_br),num2str(IZZ_value_fr), num2str(IZZ_value_fr)}; % New Izz values for each link

% Define arrays or cell arrays for new origin and rpy values for each joint
newOriginXYZs = {num2str(OriginXYZ_l_br), num2str(OriginXYZ_r_br),num2str(OriginXYZ_l_fr), num2str(OriginXYZ_r_fr)}; % New origin xyz values for each joint
newRPYs = {num2str(RPY_l_br), num2str(RPY_r_br),num2str(RPY_l_fr), num2str(RPY_r_fr)}; % New rpy values for each joint

% Define the new URDF file path
newUrdfFilePath = 'new_robot.urdf'; % Replace with the desired output file path

% Read the original URDF file as text
    try
        originalUrdfText = fileread(urdfFile);
    catch
        error('Error opening or reading the original URDF file.');
    end
     % Initialize modifiedUrdfText with the original URDF
    modifiedUrdfText = originalUrdfText;

    % Loop through each link and joint to modify
    for idx = 1:numel(linkNames)
        linkName = linkNames{idx};
        jointName = jointNames{idx};
        newMassValue = newMassValues{idx};
        newIxxValue = newIxxValues{idx};
        newIyyValue = newIyyValues{idx};
        newIzzValue = newIzzValues{idx};
        newOriginXYZ = newOriginXYZs{idx};
        newRPY = newRPYs{idx};

        % Define search and replacement patterns for mass, inertia, origin, and rpy
        massPattern = ['<link name="' linkName '">.*?<mass value="[^"]*"/>'];
        inertiaPattern = ['<link name="' linkName '">.*?<inertia[^>]*>'];
        originPattern = ['<joint name="' jointName '" type="fixed">\s*<origin xyz="[^"]*"[^>]*>'];
        rpyPattern = '<origin xyz="[^"]*" rpy="[^"]*"/>';

        % Find the link portion in the URDF using regular expressions
        linkMatch = regexp(modifiedUrdfText, ['<link name="' linkName '">.*?</link>'], 'match', 'once');

        if isempty(linkMatch)
            error(['Link with name "' linkName '" not found in the original URDF.']);
        end

        % Find the joint portion in the URDF using regular expressions
        jointMatch = regexp(modifiedUrdfText, ['<joint name="' jointName '" type="fixed">.*?</joint>'], 'match', 'once');

        if isempty(jointMatch)
            error(['Joint with name "' jointName '" not found in the original URDF.']);
        end

        % Extract the original mass and inertia values from the link portion
        massValueMatch = regexp(linkMatch, '<mass value="([^"]*)"/>', 'tokens', 'once');
        ixxValueMatch = regexp(linkMatch, 'ixx="([^"]*)"', 'tokens', 'once');
        iyyValueMatch = regexp(linkMatch, 'iyy="([^"]*)"', 'tokens', 'once');
        izzValueMatch = regexp(linkMatch, 'izz="([^"]*)"', 'tokens', 'once');

        % Extract the original origin and rpy values from the joint portion
        originValueMatch = regexp(jointMatch, '<origin xyz="([^"]*)" rpy="([^"]*)"/>', 'tokens', 'once');

        % Update the mass and inertia values
        if ~isempty(massValueMatch)
            originalMassValue = massValueMatch{1};
        else
            error('Mass value not found in the original URDF.');
        end

        if ~isempty(ixxValueMatch) && ~isempty(iyyValueMatch) && ~isempty(izzValueMatch)
            originalIxxValue = ixxValueMatch{1};
            originalIyyValue = iyyValueMatch{1};
            originalIzzValue = izzValueMatch{1};
        else
            error('Inertia values not found in the original URDF.');
        end

        % Update the origin and rpy values
        if ~isempty(originValueMatch)
            originalOriginXYZ = originValueMatch{1};
            originalRPY = originValueMatch{2};
        else
            error('Origin and rpy values not found in the original URDF.');
        end

        % Replace the mass and inertia values with the new values
        linkMatch = strrep(linkMatch, ['<mass value="' originalMassValue '"/>'], ['<mass value="' newMassValue '"/>']);
        linkMatch = strrep(linkMatch, ['ixx="' originalIxxValue '"'], ['ixx="' newIxxValue '"']);
        linkMatch = strrep(linkMatch, ['iyy="' originalIyyValue '"'], ['iyy="' newIyyValue '"']);
        linkMatch = strrep(linkMatch, ['izz="' originalIzzValue '"'], ['izz="' newIzzValue '"']);

        % Replace the origin and rpy values in the joint portion
        jointMatch = strrep(jointMatch, ['<origin xyz="' originalOriginXYZ '" rpy="' originalRPY '"/>'], ['<origin xyz="' newOriginXYZ '" rpy="' newRPY '"/>']);

        % Update the modified URDF text
        modifiedUrdfText = regexprep(modifiedUrdfText, ['<link name="' linkName '">.*?</link>'], linkMatch);
        modifiedUrdfText = regexprep(modifiedUrdfText, ['<joint name="' jointName '" type="fixed">.*?</joint>'], jointMatch);
    end
    % Save the updated URDF as a new file
    try
        fileID = fopen(newUrdfFilePath, 'w');
        fprintf(fileID, '%s', modifiedUrdfText);
        fclose(fileID);
        disp('Modified URDF saved as a new file.');
    catch
        error('Error saving the updated URDF file.');
    end
copyfile('new_robot.urdf', 'C:\Users\pvanteddu\Documents\GitHub\ironcub-mk1-software\models\iRonCub-Mk3\iRonCub\robots\iRonCub-Mk3\new_robot.urdf');

