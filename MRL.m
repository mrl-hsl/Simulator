classdef MRL

	methods
            
%% Forward Kinematics  

            function t = kinematics_forward_head(~, q, neckOffsetZ, cameraOffsetZ)
                t = Transform();
                t = t.translateZ(neckOffsetZ)...
                     .mDH(0, 0, q(19), 0)...
                     .mDH(-pi/2, 0, q(20), 0)...
                     .mDH(pi/2, 0, 0, cameraOffsetZ);
            end
            
            function t = kinematics_forward_rarm(~, q, lALZ, hoX)
                t = Transform();
                t = t.rotateX(-pi/2).rotateZ(pi/2)...
                     .mDH(0, 0, q(1), 0)...
                     .mDH(pi/2, 0, q(3), 0)...
                     .mDH(pi/2, lALZ, q(5), 0)...
                     .translateX(hoX);    
            end
            
            function t = kinematics_forward_larm(~, q, lALZ, hoX)
                t = Transform();
                t = t.rotateX(-pi/2).rotateZ(pi/2)...
                     .mDH(0, 0, q(2), 0)...
                     .mDH(pi/2, 0, q(4), 0)...
                     .mDH(pi/2, lALZ, q(6), 0)...
                     .translateX(hoX);    
            end
            
            function t = kinematics_forward_rleg(~ , q, hipOffsetY, hipOffsetZ, dThigh, dTibia, aThigh, aTibia, footHeight)
                t = Transform();
                t = t.translateY(-hipOffsetY).translateZ(-hipOffsetZ)...
                    .mDH(0, 0,(pi/2)+q(7), 0)...
                    .mDH(pi/2, 0, (pi/2)+q(9) ,0)...
                    .mDH(pi/2, 0, aThigh+q(11), 0)...
                    .mDH(0, -dThigh, -aThigh-aTibia+q(13), 0)...
                    .mDH(0, -dTibia, aTibia+q(15) ,0)...
                    .mDH(-pi/2, 0, q(17), 0)...
                    .rotateZ(pi).rotateY(-pi/2).translateZ(-footHeight);
            end
            
            function t = kinematics_forward_lleg(~ , hipOffsetY, hipOffsetZ, q, dThigh, dTibia,  footHeight)
                t = Transform();
                t = t.translateY(hipOffsetY).translateZ(-hipOffsetZ)...
                    .mDH(0, 0, (pi/2)+q(8), 0)...
                    .mDH(pi/2, 0, (pi/2)+q(10), 0)...
                    .mDH(pi/2, 0, 0+q(12), 0)...
                    .mDH(0, -dThigh, 0+q(14), 0)...
                    .mDH(0, -dTibia, 0+q(16), 0)...
                    .mDH(-pi/2, 0, q(18), 0)...
                    .rotateZ(pi).rotateY(-pi/2).translateZ(-footHeight);
            end  
            
%% Inverse Kinematics            
            
            function [t1 t2 t3 t4] = kinematics_inverse_head(~, x, y, z, neckOffsetZ, cameraOffsetZ)
                t1 = atan2(y,x);
                t2 = atan2(-y,-x);
                t3 = acos((z-neckOffsetZ)/cameraOffsetZ);
                t4 = -acos((z-neckOffsetZ)/cameraOffsetZ);
            end
            
            function t = kinematics_inverse_larm(~, transLArm, lALZ, hoX)
                t = zeros(1,5);
                Calpha = (hoX^2+lALZ^2-transLArm(1,4)^2-transLArm(2,4)^2-transLArm(3,4)^2)/(2*hoX*lALZ);
                t(4) = pi-acos(Calpha); %teta6 Geometry
                t(5) = -acos(Calpha); %teta6 Geometry
%                 (transLArm(3,4)<0)&(transLArm(1,4)<0)
%                 if transLArm(3,4)>0
%                     t(4) = pi-acos(Calpha); 
%                 end
                t(3) = asin(transLArm(2,4)/(lALZ+(hoX*cos(t(4))))); %teta4 Algebra
                a = -hoX*sin(t(4));
                b = (-lALZ*cos(t(3)))-(hoX*cos(t(4))*cos(t(3)));
                c = transLArm(1,4);
                t(1) = 2*atan((b+sqrt(a^2+b^2-c^2))/(a+c));
                t(2) = 2*atan((b-sqrt(a^2+b^2-c^2))/(a+c));        
            end
            
            function t = kinematics_inverse_rarm(~, transRArm, lALZ, hoX)
                t = zeros(1,5);                                            
                Calpha = (hoX^2+lALZ^2-transRArm(1,4)^2-transRArm(2,4)^2-transRArm(3,4)^2)/(2*hoX*lALZ);
                t(4) = pi-acos(Calpha); %teta6 Geometry
                t(5) = -acos(Calpha); %teta6 Geometry
%                 (transLArm(3,4)<0)&(transLArm(1,4)<0)
%                 if transLArm(3,4)>0
%                     t(4) = pi-acos(Calpha); 
%                 end
                t(3) = asin(transRArm(2,4)/(lALZ+(hoX*cos(t(4))))); %teta4 Algebra
                a = -hoX*sin(t(4));
                b = (-lALZ*cos(t(3)))-(hoX*cos(t(4))*cos(t(3)));
                c = transRArm(1,4);
                t(1) = 2*atan((b+sqrt(a^2+b^2-c^2))/(a+c));
                t(2) = 2*atan((b-sqrt(a^2+b^2-c^2))/(a+c));        
            end
            
            function qLeg = kinematics_inverse_leg(this, trLeg, isLeft)
                
                hipOffsetX = 15; % robot_origin_to_left_hip_base_tra = [15 61 -240];
                hipOffsetY = 60; % robot_origin_to_right_hip_base_tra = [15 -61 -240]; 
                hipOffsetZ = 141.6; % 240;
                thighLength = 160; % robot_right_thigh_to_right_lower_leg_tra = [-160 0 0];
                tibiaLength = 160; % robot_right_lower_leg_to_right_ankle_tra = [-160 0 0];
                footHeight = 52; % robot_right_foot_Endefector_tra = [-52.6 0 0];
                kneeOffsetX = 0.0;
                dThigh = sqrt(thighLength*thighLength+kneeOffsetX*kneeOffsetX);
                aThigh = atan(kneeOffsetX/thighLength);
                dTibia = sqrt(tibiaLength*tibiaLength+kneeOffsetX*kneeOffsetX);
                aTibia = atan(kneeOffsetX/tibiaLength);
                
                trInvLeg = trLeg.inverse();
               
                xHipOffset = zeros(1,3);
                xLeg = zeros(1,3);
                
                if isLeft == true
                    xHipOffset(1) = 0.0;
                    xHipOffset(2) = hipOffsetY;
                    xHipOffset(3) = -hipOffsetZ;
                else
                    xHipOffset(1) = 0.0;
                    xHipOffset(2) = -hipOffsetY;
                    xHipOffset(3) = -hipOffsetZ;
                end
                
                for i = 1:3
                    xLeg(i) = xHipOffset(i);
                end
                
                xLeg = trInvLeg.apply(xLeg);
                xLeg(3) = xLeg(3)-footHeight;

                dLeg = xLeg(1)*xLeg(1) + xLeg(2)*xLeg(2) + xLeg(3)*xLeg(3);
                cKnee = 0.5*(dLeg-dTibia^2-dThigh^2)/(dTibia*dThigh);
                
                if cKnee > 1
                    cKnee = 1;
                elseif cKnee < -1
                    cKnee = -1;
                end
                
                kneePitch = acos(cKnee);
                ankleRoll = atan2(xLeg(2), xLeg(3));
                lLeg = sqrt(dLeg);
                
                if lLeg < 1e-16
                    lLeg = 1e-16;
                end
                
                pitch0 = asin(dThigh*sin(kneePitch)/lLeg);
                anklePitch = asin(-xLeg(1)/lLeg) - pitch0;
                rHipT = trLeg;
                rHipT = rHipT.rotateX(-ankleRoll).rotateY(-anklePitch-kneePitch);
                R12 = rHipT.t(1,2);
                R22 = rHipT.t(2,2);
                R32 = rHipT.t(3,2);
                R31 = rHipT.t(3,1);
                R33 = rHipT.t(3,3);
                hipYaw = atan2(-R12, R22);
                hipRoll = asin(R32);
                hipPitch = atan2(-R31, R33);
                
                qLeg = zeros(1,6);
                qLeg(1) = hipYaw;
                qLeg(2) = -hipRoll;
                qLeg(3) = hipPitch-aThigh;
                qLeg(4) = kneePitch+aThigh+aTibia;
                qLeg(5) = -anklePitch-aTibia;
                qLeg(6) = -ankleRoll;
                
            end    
            
            function t = kinematics_inverse_lleg(this,transLLeg)
                 t = this.kinematics_inverse_leg(transLLeg,true);
            end
            
            function t = kinematics_inverse_rleg(this,transRLeg)
                t = this.kinematics_inverse_leg(transRLeg,false); 
            end
            
%             function t = kinematics_inverse_leg(transLeg,isLeft)
%                 
%             end    

            function t = kinematics_inverse_legs(this, pLLeg, pRLeg, pTorso, legSupport)
                
                trLLeg = Transform();
                trLLeg = trLLeg.transform6D(pLLeg);
                trRLeg = Transform();
                trRLeg = trRLeg.transform6D(pRLeg);
                trTorso = Transform();
                trTorso = trTorso.transform6D(pTorso);

                trTorso_LLeg = multiple(trTorso.inverse(), trLLeg);
                trTorso_RLeg = multiple(trTorso.inverse(), trRLeg);
               
                qLLeg = this.kinematics_inverse_lleg(trTorso_LLeg);
                qRLeg = this.kinematics_inverse_rleg(trTorso_RLeg);

                qLLeg = [qLLeg qRLeg];
                t = qLLeg;
                
            end    
            
     end
end