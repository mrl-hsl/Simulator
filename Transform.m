classdef Transform
                
    properties
        t
    end
    
	methods
%% Functions: Denavit-Hartenburg, Rotates, Translates
            
            function obj = Transform(x,y,z,roll,pitch,yaw)
                obj.t = eye(4);
                if nargin > 5
                    obj = obj.translateX(x).translateY(y).translateZ(z).rotateZ(yaw).rotateY(pitch).rotateX(roll);
                end
            end   

            function r =  rotateX(this, rotX)
                Rx = [1 0 0 0;0 cosd(rotX/pi*180) -sind(rotX/pi*180) 0;0 sind(rotX/pi*180) cosd(rotX/pi*180) 0;0 0 0 1]; %Rotate(X)
                this.t =  this.t * Rx;
                r = this;
            end
            
            function r =  rotateY(this, rotY)
                Ry = [cosd(rotY/pi*180) 0 sind(rotY/pi*180) 0;0 1 0 0;-sind(rotY/pi*180) 0 cosd(rotY/pi*180) 0;0 0 0 1]; %Rotate(Y)
                this.t = this.t * Ry;
                r = this;
            end
            
            function r =  rotateZ(this, rotZ)
                Rz = [cosd(rotZ/pi*180) -sind(rotZ/pi*180) 0 0;sind(rotZ/pi*180) cosd(rotZ/pi*180) 0 0;0 0 1 0;0 0 0 1]; %Rotate(Z)
                this.t =  this.t * Rz ;
                r = this;
            end
            
            function p =  translateX(this, offsetX)
                Px = [1 0 0 offsetX;0 1 0 0;0 0 1 0;0 0 0 1]; %Translate(x)
                this.t = this.t * Px  ;
                p = this;
            end
            
            function p =  translateY(this, offsetY)
                Py = [1 0 0 0;0 1 0 offsetY;0 0 1 0;0 0 0 1]; %Translate(y)
                this.t =  this.t*Py ;
                p = this;
            end
            
            function p =  translateZ(this, offsetZ)
                Pz = [1 0 0 0;0 1 0 0;0 0 1 offsetZ;0 0 0 1]; %Translate(Z)
                this.t = this.t * Pz  ;
                p = this;
            end
            
            function rp = mDH(this, alpha, a, theta, d)
                this = this.rotateX(alpha).translateX(a).rotateZ(theta).translateZ(d);
                rp = this;
            end
           
            function t = inverse(this)
               invT = Transform();
               for  i = 1:3
                for j = 1:3
                  invT.t(i,j) = this.t(j,i);
                  invT.t(i,4) = invT.t(i,4) - this.t(j,i)*this.t(j,4);
                end
               end
               t = invT;
            end
                      
            function app = apply(this, x)
            x0 = zeros(1,3);
                for i = 1:3
                    x0(i) = x(i);
                end
                for i = 1:3
                    x(i) = this.t(i,4);
                    for j = 1:3
                        x(i) = x(i) + this.t(i,j)*x0(j);
                    end
                end
                app = x;
            end
            
            function t = multiple(t1, t2)
                t = Transform();
                for i = 1:3
                    for j = 1:4
                        t.t(i,j) = t1.t(i,1)*t2.t(1,j) + t1.t(i,2)*t2.t(2,j) + t1.t(i,3)*t2.t(3,j) + t1.t(i,4)*t2.t(4,j);  
                    end
                end
            end
                      
            function t = transform6D(this, p)
                % t = t.translate(p[0],p[1],p[2]).rotateZ(p[5]).rotateY(p[4]).rotateX(p[3]);
                cwx = cos(p(4)); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                swx = sin(p(4)); 
                cwy = cos(p(5));
                swy = sin(p(5));
                cwz = cos(p(6));
                swz = sin(p(6));
                this.t(1,1) = cwy*cwz;
                this.t(1,2) = swx*swy*cwz-cwx*swz;
                this.t(1,3) = cwx*swy*cwz+swx*swz;
                this.t(1,4) = p(1);
                this.t(2,1) = cwy*swz;
                this.t(2,2) = swx*swy*swz+cwx*cwz;
                this.t(2,3) = cwx*swy*swz-swx*cwz;
                this.t(2,4) = p(2);
                this.t(3,1) = -swy;
                this.t(3,2) = swx*cwy;
                this.t(3,3) = cwx*cwy;
                this.t(3,4) = p(3);
                t = this;
            end
                    
           % Rotate(alpha)*Translate(a)*Rotate(theta)*Translate(d)::Craig
           % equal to
           % Translate(a)*Rotate(alpha)*Translate(d)*Rotate(theta)::DarwinOP
           % T1 = [1 0 0 0;0 cos(alpha) -sin(alpha) 0;0 sin(alpha) cos(alpha) 0;0 0 0 1]; %Rotate(alpha)
           % T2 = [1 0 0 a;0 1 0 0;0 0 1 0;0 0 0 1]; %Translate(a)
           % T3 = [cos(theta) -sin(theta) 0 0;sin(theta) cos(theta) 0 0;0 0 1 0; 0 0 0 1]; %Rotate(theta)
           % T4 = [1 0 0 0;0 1 0 0;0 0 1 d;0 0 0 1]; %Translate(d)
           % T = T1*T2*T3*T4;
                              
    end
end