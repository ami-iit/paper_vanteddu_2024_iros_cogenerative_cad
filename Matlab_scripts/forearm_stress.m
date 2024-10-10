close all
%load and Initilalize PDE tool box and the stl file
model = createpde("structural","static-solid");
g= importGeometry(model,"cogen_001_p_002.prt_ascii.stl");   
LENGTH = 58
AREA = 4010.99
% Figure of the loaded mesh(stl)
%    figure
%     pdegplot(model,"FaceLabels","on",'FaceAlpha',0.5,"CellLabels","on") % to understand face distribution
%     view(30,30);
%     title("forearm")  
   %evaluate the point of the centre where the force shall be acting upon
    x_n = -(57.9+LENGTH);
    y_n = 20;
    z_n = 15;
    AREA = AREA/1000000
    %obtain the face id of that particular point
    FaceID = nearestFace(g,[x_n y_n z_n]);
    % Designate the model mechanical properties
    structuralProperties(model,'Cell',1,"YoungsModulus",71.7e9,"PoissonsRatio",0.3);
    % Apply constraints on the faces
    structuralBC(model,"Face",1:14,"Constraint","fixed");   
    % Apply surfacetraction
    structuralBoundaryLoad(model,"Face", FaceID ,"Pressure",250/AREA);
    % Plot the mesh file
    generateMesh(model);
%     figure
%     pdeplot3D(model)
%     title("Mesh with Quadratic Tetrahedral Elements");
  
% solve the model  
result = solve(model)
stress_max = max(result.VonMisesStress)
displacement_forearm = max(abs(result.Displacement.Magnitude))
safetyfactor_forearm = 524e6/stress_max
% plot the dispacement and stress distribution
figure
pdeplot3D(model,"ColorMapData",result.VonMisesStress)
    % title("von Mises stress","FontSize",48)
    % colormap("jet")
    % ax=gca
    % ax.FontSize =40
%     figure
%     pdeplot3D(model,"ColorMapData",result.Displacement.Magnitude)
%     title("magnitude")
%     colormap("jet")
