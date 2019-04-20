classdef Transform
                
    properties
        t
    end
    
	methods
%% Functions: Denavit-Hartenburg, Rotates, Translates
            
            function obj = Transform()
                obj.t = eye(4);
            end   

            function r =  rotateX(this, rotX)
                Rx = [1 0 0 0;0 cos(rotX) -sin(rotX) 0;0 sin(rotX) cos(rotX) 0;0 0 0 1]; %Rotate(X)
                this.t = Rx * this.t;
                r = this;
            end
            
            function r =  rotateY(this, rotY)
                Ry = [cos(rotY) 0 sin(rotY) 0;0 1 0 0;-sin(rotY) 0 cos(rotY) 0;0 0 0 1]; %Rotate(Y)
                this.t = Ry * this.t;
                r = this;
            end
            
            function r =  rotateZ(this, rotZ)
                Rz = [cos(rotZ) -sin(rotZ) 0 0;sin(rotZ) cos(rotZ) 0 0;0 0 1 0;0 0 0 1]; %Rotate(Z)
                this.t = Rz * this.t;
                r = this;
            end
            
            function p =  translateX(this, offsetX)
                Px = [1 0 0 offsetX;0 1 0 0;0 0 1 0;0 0 0 1]; %Translate(x)
                this.t = this.t + Px;
                p = this;
            end
            
            function p =  translateY(this, offsetY)
                Py = [1 0 0 0;0 1 0 offsetY;0 0 1 0;0 0 0 1]; %Translate(y)
                this.t = this.t + Py;
                p = this;
            end
            
           function p =  translateZ(this, offsetZ)
                Pz = [1 0 0 0;0 1 0 0;0 0 1 offsetZ;0 0 0 1]; %Translate(Z)
                this.t = this.t + Pz;
                p = this;
           end
            
           function rp = mDH(this, alpha, a, d, theta)
                this = this.rotateX(alpha).translateX(a).rotateZ(theta).translateZ(d);
                rp = this;
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