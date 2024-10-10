%load and Initilalize PDE tool box and the stl file
model = createpde("structural","static-solid");
   g= importGeometry(model,"cogen_001_p_001.prt_ascii.stl");   
% Figure of the loaded mesh(stl)
%    figure
%     pdegplot(model,"FaceLabels","on","VertexLabels","on") % to understand face and vertex lable distribution
%     view(30,30);
%     title("bracket")  
%generate mesh fo the model
    generateMesh(model);
    ANGLE = 113
    DISTANCE = 85.97
    %evaluate the point of the centre where the force shall be acting upon
    x_n = 23.0274 + DISTANCE*cosd(ANGLE-90)+15*sind(ANGLE-90);
    y_n =0;
    z_n = 15 + DISTANCE*sind(ANGLE-90)-15*cosd(ANGLE-90);
    %obtain the face id of that particular point
    FaceID = nearestFace(g,[x_n y_n z_n]);
    % Designate the model mechanical properties
    structuralProperties(model,"YoungsModulus",71.7e9,"PoissonsRatio",0.3);
    % Apply constraints on the faces
    structuralBC(model,"Face",[1 3 14],"Constraint","fixed");
    % Apply pressure (Force per Area)
    structuralBoundaryLoad(model,"Face", FaceID,"Pressure",250/0.00161365);
    % Plot the mesh file
%     figure
%     pdeplot3D(model)
%     title("Mesh with Quadratic Tetrahedral Elements");   
%     figure
% solve the model  
result = solve(model)
stress_max = max(abs(result.VonMisesStress))
displacement = max(abs(result.Displacement.Magnitude))
safetyfactor_bracket = 524e6/stress_max
pdeplot3D(model,"ColorMapData",result.VonMisesStress)
    % title("Von Mises stress",'FontSize',48)
    % view(30,30)
    % colormap("jet")
    % h = colorbar
    % ax = gca
    % ax.FontSize =40