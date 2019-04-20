CM730_default = struct( ...
    'acc_x',int16(512), ...
    'acc_y',int16(512), ...
    'acc_z',int16(512), ...
    'gyro_x',int16(512), ...
    'gyro_y',int16(512), ...
    'gyro_z',int16(512));
CM730_bus = Simulink.Bus.createObject(CM730_default);

bus_name = CM730_bus.busName;
CM730_bus = eval(bus_name);
clear(bus_name);
clear('bus_name');

for i=1:length(CM730_bus.Elements)
    element = CM730_bus.Elements(i);
    if strcmp(element.Name,'acc_x')
        element.Description = 'Accelerometer X-axis';
        element.Min = 0;
        element.Max = 1023;
    elseif strcmp(element.Name,'acc_y')
        element.Description = 'Accelerometer Y-axis';
        element.Min = 0;
        element.Max = 1023;
    elseif strcmp(element.Name,'acc_z')
        element.Description = 'Accelerometer Z-axis';
        element.Min = 0;
        element.Max = 1023;
    elseif strcmp(element.Name,'gyro_x')
        element.Description = 'Gyroscope X-axis';
        element.Min = 0;
        element.Max = 1023;
    elseif strcmp(element.Name,'gyro_y')
        element.Description = 'Gyroscope Y-axis';
        element.Min = 0;
        element.Max = 1023;
    elseif strcmp(element.Name,'gyro_z')
        element.Description = 'Gyroscope Z-axis';
        element.Min = 0;
        element.Max = 1023;
    else
        error('invalid element name "%s"',element.Name);
    end
    CM730_bus.Elements(i) = element;
end

clear element
clear i

CM730_acc_center = (4 * 9.80665); % accelerometer output center value
CM730_acc_gain = 512 / CM730_acc_center; % m.s^-2 to accelerometer output
CM730_gyro_center = (1600 / 360 * 2 * pi); % gyro output center value
CM730_gyro_gain = 512 / CM730_gyro_center; % rad.s-1 to gyro output
CM730_sample_time = 1e-3;