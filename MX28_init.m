MX28_default = struct( ...
    'CW_angle_limit',int16(0), ...
    'CCW_angle_limit',int16(4095), ...
    'torque_enable',true, ...
    'D_gain',uint8(0), ...
    'I_gain',uint8(0), ...
    'P_gain',uint8(32), ...
    'goal_position',int16(2048), ...
    'moving_speed',int16(0), ...
    'torque_limit',int16(1023), ...
    'present_position',int16(0), ...
    'present_speed',int16(0), ...
    'present_load',int16(0), ...
    'moving',false, ...
    'pwm',int16(0));
MX28_bus = Simulink.Bus.createObject(MX28_default);

bus_name = MX28_bus.busName;
MX28_bus = eval(bus_name);
clear(bus_name);
clear('bus_name');

for i=1:length(MX28_bus.Elements)
    element = MX28_bus.Elements(i);
    if strcmp(element.Name,'CW_angle_limit')
        element.Description = 'Clockwise Angle Limit';
        element.Min = 0;
        element.Max = 4095;
    elseif strcmp(element.Name,'CCW_angle_limit')
        element.Description = 'Counter-Clockwise Angle Limit';
        element.Min = 0;
        element.Max = 4095;
    elseif strcmp(element.Name,'torque_enable')
        element.Description = 'Torque On/Off';
        element.Min = 0;
        element.Max = 1;
    elseif strcmp(element.Name,'D_gain')
        element.Description = 'Derivative Gain';
        element.Min = 0;
        element.Max = 255;
    elseif strcmp(element.Name,'I_gain')
        element.Description = 'Integral Gain';
        element.Min = 0;
        element.Max = 255;
    elseif strcmp(element.Name,'P_gain')
        element.Description = 'Proportional Gain';
        element.Min = 0;
        element.Max = 255;
    elseif strcmp(element.Name,'goal_position')
        element.Description = 'Goal Position';
        element.Min = 0;
        element.Max = 4095;
    elseif strcmp(element.Name,'moving_speed')
        element.Description = 'Moving Speed';
        element.Min = 0;
        element.Max = 1023;
    elseif strcmp(element.Name,'torque_limit')
        element.Description = 'Torque Limit';
        element.Min = 0;
        element.Max = 1023;
    elseif strcmp(element.Name,'present_position')
        element.Description = 'Present Position';
        element.Min = 0;
        element.Max = 4095;
    elseif strcmp(element.Name,'present_speed')
        element.Description = 'Present Speed';
        element.Min = -1023;
        element.Max = +1023;
    elseif strcmp(element.Name,'present_load')
        element.Description = 'Present Load';
        element.Min = -1023;
        element.Max = +1023;
    elseif strcmp(element.Name,'moving')
        element.Description = 'Moving';
        element.Min = 0;
        element.Max = 1;
    elseif strcmp(element.Name,'pwm')
        element.Description = 'pwm';
        element.Min = -1023;
        element.Max = +1023;
    else
        error('invalid element name "%s"',element.Name);
    end
    MX28_bus.Elements(i) = element;
end

clear element
clear i

MX28_reduction = 192.6; % from specs
MX28_max_speed = 55 * MX28_reduction / 60 * 2 * pi; % rad.s-1 from specs
MX28_stall_torque = 2.5 / MX28_reduction; % N.m from specs
MX28_stall_current = 1.4; % A from specs
MX28_supply_voltage = 12; % V supply voltage from specs
MX28_position_gain = 4096 / 2 / pi; % rad to 0..4095
MX28_speed_gain = 1024 / 8; % position difference to -1023..1023
MX28_resistor = 8.3; % Ohm from measurements
MX28_inductor = 2.06e-4; % H from measurements
MX28_Kv = 9.926e-3; % V.rad-1.s from measurements
MX28_Kc = 8e-3; % N.m.A-1 derived from measurements by T. Baroche (initial value 9.9e-3 modified to avoid simulation instability)
MX28_inertia = 9e-8 * MX28_reduction^2; % kg.m² from measurements
MX28_amplifier = MX28_supply_voltage/1024; % guessed
MX28_Te = 1/1000; % guessed
MX28_Kp = 1/4; % from measurements
MX28_Ki = 1/1024; % from measurements
MX28_Kd = 1/8; % from measurements
MX28_Kl = 1024 / MX28_stall_torque;
MX28_lub_friction = 0.05; % N.m.rad-1.s test value
%MX28_lub_friction = 8.49e-4; % N.m.rad-1.s from measurements
MX28_dry_friction = 0; % N.m test value
%MX28_dry_friction = 1.07; % N.m from measurements
MX28_init_position = pi; % rad
MX28_init_speed = 0; % rad.s-1
