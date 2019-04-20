clear all
clc

MX28_init;
MX106_init;
CM730;
FSR;

robot_gravity = [0 0 0]; % gravity vector -9.80665 m.s^-2

robot_floor_position_gain = -1e5; % N.m^-1 Force (Newton) applied from the floor to the foot per length "pushed" inside the floor
robot_floor_speed_gain = -1e3;    % N.m^-1.s Force (Newton) applied from the floor to the foot per contact speed
robot_floor_friction_coeff = 0.6; % dry friction coefficient = floor tangent force / floor normal force

% utility function to extract moment of inertia
moment_of_inertia = @(mat) [mat(1,1) mat(2,2) mat(3,3)];
% utility function to extract product of inertia
product_of_inertia = @(mat) [mat(3,2) mat(3,1) mat(2,1)];

% for all below characteristics
% dimensions in mm
% weight in g
% inertia in g.mm^2

% Position Zero Motor

% q = [ARSP(1),ARSR(3),ARE(5)
%      ALSP(2),ALSR(4),ALE(6)
%      FRHY(7),FRHR(9),FRHP(11),FRKP(13),FRAP(15),FRAR(17)
%      FLHY(8),FLHR(10),FLHP(12),FLKP(14),FLAP(16),FLAR(18)
%      HP(19),HT(20)]
       
% 3072,1536,1024,... %RArm
% 1024,2560,3072,... %LArm 
    
posZero = [2048,2048,2048,... %RArm
           2048,2048,2048,... %LArm 
           2048,2048,2048,2048,2048,2048,... %RLeg
           2048,2048,2048,2048,2048,2048,... %LLeg 
           2048,2048]; %Head
     
posZero_ID1 = posZero(1);
posZero_ID2 = posZero(4);
posZero_ID3 = posZero(2);
posZero_ID4 = posZero(5);
posZero_ID5 = posZero(3);
posZero_ID6 = posZero(6);
posZero_ID7 = posZero(7);
posZero_ID8 = posZero(13);
posZero_ID9 = posZero(8);
posZero_ID10 = posZero(14);
posZero_ID11 = posZero(9);
posZero_ID12 = posZero(15);
posZero_ID13 = posZero(10);
posZero_ID14 = posZero(16);
posZero_ID15 = posZero(11);
posZero_ID16 = posZero(17);
posZero_ID17 = posZero(12);
posZero_ID18 = posZero(18);
posZero_ID19 = posZero(19);
posZero_ID20 = posZero(20);

% chest mass and transforms
robot_origin_to_center_mass = [1.43 -0.14 -55.76];
robot_chest_mass = 2385.0;
robot_chest_inertia = [30691520.31  -10757.32  -815473.22; -10757.32  25850735.91  52811.53; -815473.22  52811.53  7680064.80];
robot_chest_moment_inertia = moment_of_inertia(robot_chest_inertia);
robot_chest_product_inertia = product_of_inertia(robot_chest_inertia);

robot_origin_to_neck_base_tra = [20 0 195.2];
robot_origin_to_neck_base_rot = [-1 0 0; 0 -1 0; 0 0 1]; %Rz(180)

robot_origin_to_left_hip_base_tra = [15 61 -140];
robot_origin_to_left_hip_base_rot = [0 1 0; -1 0 0; 0 0 1];

robot_origin_to_right_hip_base_tra = [15 -61 -140];
robot_origin_to_right_hip_base_rot = [0 1 0; -1 0 0; 0 0 1];

robot_origin_to_left_shoulder_base_tra = [22.78 124.16 152];
robot_origin_to_left_shoulder_base_rot = [0 1 0;0 0 1; 1 0 0]; %Rxzx(90,-90,0)

robot_origin_to_right_shoulder_base_tra = [22.78 -124.16 152];
robot_origin_to_right_shoulder_base_rot = [0 1 0; 0 0 1; 1 0 0]; %Rxzx(90,-90,0).Ry(180)

robot_origin_to_acc_tra = [6.8 7.9 -91.5];
robot_origin_to_acc_rot = [1 0 0; 0 1 0; 0 0 1];

robot_origin_to_gyro_tra = [6.8 7.9 -91.5];
robot_origin_to_gyro_rot = [0 -1 0; -1 0 0; 0 0 -1];

% neck mass and transform
robot_neck_to_center_mass = [0.33 9.18 19.36];
robot_neck_mass = 90;
robot_neck_inertia = [63340.93 -334.20 -601.86; -334.20 50311.05 16762.32; -601.86 16762.32 32872.35];
robot_neck_moment_inertia = moment_of_inertia(robot_neck_inertia);
robot_neck_product_inertia = product_of_inertia(robot_neck_inertia);

robot_neck_axis_to_head_base_tra = [-21.3 0 0];
robot_neck_axis_to_head_base_rot = [-1 0 0; 0 0 1; 0 1 0]; %Rxzx(90,180,180)

% head mass and transform
robot_head_to_center_mass = [-78.54 0.7 0.38];
robot_head_mass = 177.69;
robot_head_inertia = [106835.90 -11543.34 6286.32; -11543.34 1313739.06 -63.08; 6286.32 -63.08 1228686.75];
robot_head_moment_inertia = moment_of_inertia(robot_head_inertia);
robot_head_product_inertia = product_of_inertia(robot_head_inertia);

camera_Endefector_tra = [0 -90 0]; 
camera_Endefector_rot = [1 0 0; 0 0 -1; 0 1 0]; %Rx(90)

% right shoulder mass and transform
robot_right_shoulder_to_center_mass = [0 4.46 13.28];
robot_right_shoulder_mass = 39.00 ;
robot_right_shoulder_inertia = [17254.81 0.00 0.00; 0.00 26080.89 4255.06; 0.00 4255.06 20262.99];
robot_right_shoulder_moment_inertia = moment_of_inertia(robot_right_shoulder_inertia);
robot_right_shoulder_product_inertia = product_of_inertia(robot_right_shoulder_inertia);

robot_right_shoulder_to_right_upper_arm_tra = [0 0 0];
robot_right_shoulder_to_right_upper_arm_rot = [-1 0 0; 0 0 -1; 0 -1 0]; %Rz(180)Rx(90)Rx(180)

% right upper arm mass and transform
robot_right_upper_arm_to_center_mass = [0.37 34.42 1.01];
robot_right_upper_arm_mass = 247.00 ;
robot_right_upper_arm_inertia = [770408.65 5202.96 167.90; 5202.96 84135.05 34194.37; 167.90 34194.37 779510.18];
robot_right_upper_arm_moment_inertia = moment_of_inertia(robot_right_upper_arm_inertia);
robot_right_upper_arm_product_inertia = product_of_inertia(robot_right_upper_arm_inertia);

robot_right_upper_arm_to_right_forearm_tra = [173 0 0];
robot_right_upper_arm_to_right_forearm_rot = [-1 0 0; 0 0 1; 0 1 0]; %Rxzx(90,90,0)Ry(180)Rz(90)

% right forearm mass and transform
robot_right_forearm_to_center_mass = [46.16 1.54 0.01];
robot_right_forearm_mass = 248.00 ;
robot_right_forearm_inertia = [672266.78 -601918.22 232.49; -601918.22 703344.20 -177.05; 232.49 -177.05 1283979.62];
robot_right_forearm_moment_inertia = moment_of_inertia(robot_right_forearm_inertia);
robot_right_forearm_product_inertia = product_of_inertia(robot_right_forearm_inertia);

robot_right_arm_Endefector_tra = [211.48 0 0];
robot_right_arm_Endefector_rot = [0 0 -1; -1 0 0; 0 1 0];

% left shoulder mass and transform
robot_left_shoulder_to_center_mass = [0 4.46 13.28];
robot_left_shoulder_mass = 39.00;
robot_left_shoulder_inertia = [17254.81 0.00 0.00; 0.00 26080.89 4255.06; 0.00 4255.06 20262.99];
robot_left_shoulder_moment_inertia = moment_of_inertia(robot_left_shoulder_inertia);
robot_left_shoulder_product_inertia = product_of_inertia(robot_left_shoulder_inertia);

robot_left_shoulder_to_left_upper_arm_tra = [0 0 0];
robot_left_shoulder_to_left_upper_arm_rot = [-1 0 0; 0 0 -1; 0 -1 0]; %Rz(180)Rx(90)Rx(180)

% left upper arm mass and transform
robot_left_upper_arm_to_center_mass = [0.37 34.42 1.01];
robot_left_upper_arm_mass = 247.00;
robot_left_upper_arm_inertia = [770408.65 5202.96 167.90; 5202.96 84135.05 34194.37; 167.90 34194.37 779510.18];
robot_left_upper_arm_moment_inertia = moment_of_inertia(robot_left_upper_arm_inertia);
robot_left_upper_arm_product_inertia = product_of_inertia(robot_left_upper_arm_inertia);

robot_left_upper_arm_to_left_forearm_tra = [173 0 0];
robot_left_upper_arm_to_left_forearm_rot = [-1 0 0; 0 0 1; 0 1 0]; %Rxzx(90,90,0)Ry(180)Rz(90)

% left forearm mass and transform
robot_left_forearm_to_center_mass = [46.16 1.54 0.01];
robot_left_forearm_mass = 248.00;
robot_left_forearm_inertia = [672266.78 -601918.22 232.49; -601918.22 703344.20 -177.05; 232.49 -177.05 1283979.62];
robot_left_forearm_moment_inertia = moment_of_inertia(robot_left_forearm_inertia);
robot_left_forearm_product_inertia = product_of_inertia(robot_left_forearm_inertia);

robot_left_arm_Endefector_tra = [211.48 0 0];
robot_left_arm_Endefector_rot = [0 0 -1; -1 0 0; 0 1 0];

% left/right hip 1 mass and transform
robot_hip1_to_center_mass = [0 21.02 -9.58];
robot_hip1_mass = 49.00;
robot_hip1_inertia = [110180.71 -0.12 0.0; -0.12 39820.58 22050.05; 0.0 22050.05 79877.42];
robot_hip1_moment_inertia = moment_of_inertia(robot_hip1_inertia);
robot_hip1_product_inertia = product_of_inertia(robot_hip1_inertia);

robot_hip1_to_hip2_tra = [0 0 0];
robot_hip1_to_hip2_rot = [0 1 0; 0 0 -1; -1 0 0]; %Rxzx(-90,-90,0).Ry(180)

% right hip 2 mass and transform
robot_right_hip2_to_center_mass = [-15.11 0.34 -20.5];
robot_right_hip2_mass = 358.00;
robot_right_hip2_inertia = [397381.57 -1122.50 107324.48; -1122.50 524744.12 -2765.90; 107324.48 -2765.90 221366.67];
robot_right_hip2_moment_inertia = moment_of_inertia(robot_right_hip2_inertia);
robot_right_hip2_product_inertia = product_of_inertia(robot_right_hip2_inertia);

robot_right_hip2_to_right_thigh_tra = [0 0 0];
robot_right_hip2_to_right_thigh_rot = [-1 0 0; 0 0 -1; 0 -1 0]; %Rxzx(-90,180,0).Rx(180)

% right thigh mass and transform
robot_right_thigh_to_center_mass = [-122.12 1.75 0.09];
robot_right_thigh_mass = 263.00 ;
robot_right_thigh_inertia = [117785.31 -252157.59 -2034.82; -252157.59 3807035.02 121.12; -2034.82 121.12 3780212.38];
robot_right_thigh_moment_inertia = moment_of_inertia(robot_right_thigh_inertia);
robot_right_thigh_product_inertia = product_of_inertia(robot_right_thigh_inertia);

robot_right_thigh_to_right_lower_leg_tra = [-160 0 0];
robot_right_thigh_to_right_lower_leg_rot = [-1 0 0; 0 -1 0; 0 0 1]; %Rz(180)

% right lower leg mass and transform
robot_right_lower_leg_to_center_mass = [-68.7 6.85 0.01];
robot_right_lower_leg_mass = 129.00 ;
robot_right_lower_leg_inertia = [71833.70 -8994.44 10.33; -8994.44 585194.12 30.52; 10.33 30.52 562366.81];
robot_right_lower_leg_moment_inertia = moment_of_inertia(robot_right_lower_leg_inertia);
robot_right_lower_leg_product_inertia = product_of_inertia(robot_right_lower_leg_inertia);

robot_right_lower_leg_to_right_ankle_tra = [-160 0 0];
robot_right_lower_leg_to_right_ankle_rot = [-1 0 0; 0 -1 0; 0 0 1]; %Rz(180)

% right ankle mass and transform
robot_right_ankle_to_center_mass = [15.22 -21.21 -0.22];
robot_right_ankle_mass = 360.00 ;
robot_right_ankle_inertia = [411441.35 -110765.25 1949.80; -110765.25 221743.37 -3040.97; 1949.80 -3040.97 540318.75];
robot_right_ankle_moment_inertia = moment_of_inertia(robot_right_ankle_inertia);
robot_right_ankle_product_inertia = product_of_inertia(robot_right_ankle_inertia);

robot_right_ankle_to_right_foot_tra = [0 0 0];
robot_right_ankle_to_right_foot_rot = [-1 0 0; 0 0 1; 0 1 0]; %Rxzx(90,180,0)

% right foot mass and transform
robot_right_foot_to_center_mass = [-35.76 4.91 5.51];
robot_right_foot_mass = 267.00;
robot_right_foot_inertia = [1039895.83 39185.16 -39465.64; 39185.16 1113141.12 -17610.12; -39465.64 -17610.12 500677.56];
robot_right_foot_moment_inertia = moment_of_inertia(robot_right_foot_inertia);
robot_right_foot_product_inertia = product_of_inertia(robot_right_foot_inertia);

robot_right_foot_to_front_left_floor_tra = [-52.6 -37 87];
robot_right_foot_to_front_right_floor_tra = [-52.6 57 87];
robot_right_foot_to_back_left_floor_tra = [-52.6 -37 -88];
robot_right_foot_to_back_right_floor_tra = [-52.6 57 -88];
robot_right_foot_to_floor_rot = [0 0 1; 0 -1 0; 1 0 0]; %Rxyz(-90,90,0).Rz(-90)
robot_right_foot_Endefector_tra = [-52.6 0 0];
robot_right_foot_Endefector_rot = [0 0 1; 0 -1 0; 1 0 0]; %Rxyz(-90,90,0).Rz(-90)

% left hip 2 mass and transform
robot_left_hip2_to_center_mass = [-15.11 0.34 -20.5];
robot_left_hip2_mass = 358.00;
robot_left_hip2_inertia = [416458.33 -3110.67 115045.23;-3110.67 552856.47 -2958.15; 115045.23 -2958.15 235849.38];%[397381.57 -1122.50 107324.48; -1122.50 524744.12 -2765.90; 107324.48 -2765.90 221366.67];
robot_left_hip2_moment_inertia = moment_of_inertia(robot_left_hip2_inertia);
robot_left_hip2_product_inertia = product_of_inertia(robot_left_hip2_inertia);

robot_left_hip2_to_left_thigh_tra = [0 0 0];
robot_left_hip2_to_left_thigh_rot = [-1 0 0; 0 0 -1; 0 -1 0]; %Rxzx(-90,180,0).Rx(180)

% left thigh mass and transform
robot_left_thigh_to_center_mass = [-121.51 8.85 0.23];
robot_left_thigh_mass = 1263.00;
robot_left_thigh_inertia = [154313.17 -374112.04 7408.95; -374112.04 5842352.97 -425.30; 7408.95 -425.30 5810373.89];%[117419.71 -251140.12 8946.53; -251140.12 3791255.18 -543.75; 8946.53 -543.75 3764849.80];
robot_left_thigh_moment_inertia = moment_of_inertia(robot_left_thigh_inertia);
robot_left_thigh_product_inertia = product_of_inertia(robot_left_thigh_inertia);

robot_left_thigh_to_left_lower_leg_tra = [-160 0 0];
robot_left_thigh_to_left_lower_leg_rot =  [-1 0 0; 0 -1 0; 0 0 1]; %Rz(180)

% left lower leg mass and transform
robot_left_lower_leg_to_center_mass = [-68.7 6.85 0.01];
robot_left_lower_leg_mass = 129.00;
robot_left_lower_leg_inertia = [127893.53 -15999.96 19.39; -15999.96 1027984.81 57.27; 19.39 57.27 989075.93];%[71833.70 -8994.44 10.33; -8994.44 585194.12 30.52; 10.33 30.52 562366.81];
robot_left_lower_leg_moment_inertia = moment_of_inertia(robot_left_lower_leg_inertia);
robot_left_lower_leg_product_inertia = product_of_inertia(robot_left_lower_leg_inertia);

robot_left_lower_leg_to_left_ankle_tra = [-160 0 0];
robot_left_lower_leg_to_left_ankle_rot = [-1 0 0; 0 -1 0; 0 0 1]; %Rz(180)

% left ankle mass and transform
robot_left_ankle_to_center_mass = [15.22 -21.21 -0.22];
robot_left_ankle_mass = 360.00;
robot_left_ankle_inertia = [426375.54 -116346.22 -847.97; -116346.22 237912.72 23.92; -847.97 23.92 565177.63];%[411441.35 -110765.25 1949.80; -110765.25 221743.37 -3040.97; 1949.80 -3040.97 540318.75];
robot_left_ankle_moment_inertia = moment_of_inertia(robot_left_ankle_inertia);
robot_left_ankle_product_inertia = product_of_inertia(robot_left_ankle_inertia);

robot_left_ankle_to_left_foot_tra = [0 0 0];
robot_left_ankle_to_left_foot_rot = [-1 0 0; 0 0 1; 0 1 0]; %Rxzx(90,180,0)

% left foot mass and transform
robot_left_foot_to_center_mass = [-35.76 -4.91 5.51];
robot_left_foot_mass = 267.00;
robot_left_foot_inertia = [1296975.31 49127.92 -53283.96; 49127.92 1389682.46 -22250.74; -53283.96 -22250.74 625271.80];%[1039895.83 39185.16 -39465.64; 39185.16 1113141.12 -17610.12; -39465.64 -17610.12 500677.56];
robot_left_foot_moment_inertia = moment_of_inertia(robot_left_foot_inertia);
robot_left_foot_product_inertia = product_of_inertia(robot_left_foot_inertia);

robot_left_foot_to_front_left_floor_tra = [-52.6 -57 87];
robot_left_foot_to_front_right_floor_tra = [-52.6 37 87];
robot_left_foot_to_back_left_floor_tra = [-52.6 -57 -88];
robot_left_foot_to_back_right_floor_tra = [-52.6 37 -88];
robot_left_foot_to_floor_rot = [0 0 1; 0 -1 0; 1 0 0]; %Rxyz(-90,90,0).Rz(-90)
robot_left_foot_Endefector_tra = [-52.6 0 0];
robot_left_foot_Endefector_rot = [0 0 1; 0 -1 0; 1 0 0]; %Rxyz(-90,90,0).Rz(-90)
