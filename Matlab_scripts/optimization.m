%system('wrapper_script.bat')
%pause(5)
%setutp_iRonCub()

%run('initMomentumBasedFlight.m')
% Load the model
simOut = sim('C:\Users\pvanteddu\Documents\GitHub\ironcub-mk1-software\flight-controllers-stable\momentum-based-flight-sim-no-gazebo\momentumBasedFlight.mdl');    
%momentum error
ang_mom_err = norm([angMom_err_SCOPE.signals(1).values, angMom_err_SCOPE.signals(2).values, angMom_err_SCOPE.signals(3).values])
lin_mom_err = norm([linMom_err_SCOPE.signals(1).values, linMom_err_SCOPE.signals(2).values, linMom_err_SCOPE.signals(3).values])
%joint velocity error
torse_joint_vel_error= norm(reshape(jointVelErr_SCOPE.signals(1).values,length(jointVelErr_SCOPE.signals(1).values),3))
l_arm_joint_vel_error= norm(reshape(jointVelErr_SCOPE.signals(2).values,length(jointVelErr_SCOPE.signals(2).values),4))
r_arm_joint_vel_error= norm(reshape(jointVelErr_SCOPE.signals(3).values,length(jointVelErr_SCOPE.signals(3).values),4))
%average thrust
T= mean(thrusts_SCOPE.signals.values(:,1)+thrusts_SCOPE.signals.values(:,2)+thrusts_SCOPE.signals.values(:,3)+thrusts_SCOPE.signals.values(:,4))
qp_status_m = max(abs(QPStatusMomentum_SCOPE.signals.values))
qp_status_t = max(abs(QPStatusTorques_SCOPE.signals.values))
%qpstatus
qpstatus = qp_status_m +qp_status_t
%matrix concatenation
result = [ang_mom_err lin_mom_err torse_joint_vel_error l_arm_joint_vel_error r_arm_joint_vel_error T qpstatus]
MOM_Obj= ang_mom_err + lin_mom_err
Vel_obj = 2*torse_joint_vel_error + l_arm_joint_vel_error + r_arm_joint_vel_error
Thrust_obj = T
% Display the result
disp('Result from optimization:');
disp(result);
save('result.mat', 'result');
save_system('C:\Users\pvanteddu\Documents\GitHub\ironcub-mk1-software\flight-controllers-stable\momentum-based-flight-sim-no-gazebo\momentumBasedFlight.mdl')

