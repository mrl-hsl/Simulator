mrl = MRL();
syms q1 q3 q5 q2 q4 q6 shoulderOffsetY shoulderOffsetZ upperArmLengthY upperArmLengthZ lowerArmLengthX lowerArmLengthZ q hipOffsetY hipOffsetZ dThigh dTibia aThigh aTibia footHeight
% q = [q1 q2 q3 q4 q5 q6];
% LARM = mrl.kinematics_forward_larm(q2, q4, q6, shoulderOffsetY, shoulderOffsetZ, upperArmLengthY, upperArmLengthZ, lowerArmLengthX, lowerArmLengthZ);
LLEG = mrl.kinematics_forward_lleg(q, hipOffsetY, hipOffsetZ, dThigh, dTibia, aThigh, aTibia, footHeight)
LLEG.t