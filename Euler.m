a = 180;
b = 90;
g = 0;

alpha = a;
beta = b;
gamma = g;
ca = cosd(a);
cb = cosd(b);
cg = cosd(g);
sa = sind(a);
sb = sind(b);
sg = sind(g);

% Rxzy = [ca*cb   -ca*sb*cg+sa*sg   ca*sb*sg+sa*cg
%         sb      cb*sg             -cb*sg
%         -sa*cb   sa*sb*cg+ca*sg   -sa*sb*sg+ca*cg]

% Rxzx = [cb      -sb*cg           sb*sg
%         ca*sb   ca*cb*cg-sa*sg   -ca*cb*sg-sa*cg
%         sa*sb   sa*cb*cg+ca*sg   -sa*cb*sg+ca*cg]
    
% Rxyz = [cb*cg             -cb*sg             sb
%         sa*sb*cg+ca*sg    -sa*sb*sg+ca*cg    -sa*cb
%         -ca*sb*cg+sa*sg   ca*sb*sg+sa*cg     ca*cb]

% Rzxz = [-sa*cb*sg+ca*cg     -sa*cb*cg-ca*sg    sa*sb
%         ca*cb*sg+sa*cg      ca*cb*cg-sa*sg     -ca*sb
%         sb*sg               sb*cg              cb]

% Ryzy = [ca*cb*cg-sa*sg     -ca*sb    ca*cb*sg+sa*cg
%         sb*cg              cb        sb*sg
%         -sa*cb*cg-ca*sg    sa*sb     -sa*cb*sg+ca*cb]

% Ryzx = [ca*cb     -ca*sb*cg+sa*sg      ca*sb*sg+sa*cg
%         sb        cb*cg                -cb*sg
%         -sa*cb    sa*sb*cg+ca*sg       -sa*sb*sg+ca*cg]

% Rzyx = [ca*cb     ca*sb*sg-sa*cg      ca*sb*cg+sa*sg
%         sa*cb     sa*sb*sg+ca*cg      sa*sb*cg-ca*sg
%         -sb           cb*sg               cb*cg]

% Ry = [ca 0 sa; 0 1 0; -sa 0 ca]
% Rz = [ca -sa 0; sa ca 0; 0 0 1]
Rx = [1 0 0; 0 ca -sa; 0 sa ca]

    