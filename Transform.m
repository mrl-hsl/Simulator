% Transform class for 3D coordinate transforms
% Contains translation and rotation operations

classdef Transform

  properties
    t % 4x4 homogeneous transform matrix 
  end

  methods

    % Constructor to initialize transform 
    function obj = Transform(x,y,z,roll,pitch,yaw)
        
      if nargin > 0
        obj.t = obj.translate(x,y,z).rotateZ(yaw).rotateY(pitch).rotateX(roll);
      else
        obj.t = eye(4);  
      end
      
    end

    % Translate along X axis 
    function p = translateX(this, offsetX)
    
      assert(isnumeric(offsetX), 'Offset must be numeric');

      Px = [1 0 0 offsetX; 0 1 0 0; 0 0 1 0; 0 0 0 1]; 

      this.t = this.t * Px;

      p = this;

    end

    % Translate along Y axis
    function p = translateY(this, offsetY)

      assert(isnumeric(offsetY), 'Offset must be numeric');
      
      Py = [1 0 0 0; 0 1 0 offsetY; 0 0 1 0; 0 0 0 1];
      
      this.t = this.t * Py;
      
      p = this;

    end

    % Translate along Z axis
    function p = translateZ(this, offsetZ)

      assert(isnumeric(offsetZ), 'Offset must be numeric');
      
      Pz = [1 0 0 0; 0 1 0 0; 0 0 1 offsetZ; 0 0 0 1]; 

      this.t = this.t * Pz;

      p = this;

    end

    % Rotate about X axis
    function r = rotateX(this, rotX)

      assert(isnumeric(rotX), 'Rotation must be numeric');
      
      Rx = [1 0 0 0; 0 cosd(rotX) -sind(rotX) 0; 0 sind(rotX) cosd(rotX) 0; 0 0 0 1];

      this.t = this.t * Rx;

      r = this;

    end

    % Rotate about Y axis
    function r = rotateY(this, rotY)

      assert(isnumeric(rotY), 'Rotation must be numeric');
      
      Ry = [cosd(rotY) 0 sind(rotY) 0; 0 1 0 0; -sind(rotY) 0 cosd(rotY) 0; 0 0 0 1];

      this.t = this.t * Ry;

      r = this;

    end

    % Rotate about Z axis
    function r = rotateZ(this, rotZ)

      assert(isnumeric(rotZ), 'Rotation must be numeric');
      
      Rz = [cosd(rotZ) -sind(rotZ) 0 0; sind(rotZ) cosd(rotZ) 0 0; 0 0 1 0; 0 0 0 1];

      this.t = this.t * Rz;

      r = this;

    end

    % Denavit-Hartenberg transform
    function rp = mDH(this, alpha, a, theta, d)
      
      this = this.rotateX(alpha)...
                .translateX(a)...
                .rotateZ(theta)... 
                .translateZ(d);
              
      rp = this;
      
    end

    % Inverse transform 
    function t = inverse(this)
      
      invT = Transform();
      
      for i = 1:3
        for j = 1:3
          invT.t(i,j) = this.t(j,i);
          invT.t(i,4) = invT.t(i,4) - this.t(j,i)*this.t(j,4); 
        end
      end
      
      t = invT;
      
    end

    % Apply transform to 3D point
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

    % Multiply two transforms 
    function t = multiply(t1, t2)
    
      t = Transform();

      for i = 1:3
        for j = 1:4
          t.t(i,j) = t1.t(i,1)*t2.t(1,j) + ...
                     t1.t(i,2)*t2.t(2,j) + ... 
                     t1.t(i,3)*t2.t(3,j) + ...
                     t1.t(i,4)*t2.t(4,j);
        end
      end

    end

    % Create from 6D pose
    function t = fromPose(this, pose)

      x = pose(1);
      y = pose(2); 
      z = pose(3);
      roll = pose(4);
      pitch = pose(5);
      yaw = pose(6);

      t = this.translate(x,y,z).rotateZ(yaw).rotateY(pitch).rotateX(roll);

    end

  end

end