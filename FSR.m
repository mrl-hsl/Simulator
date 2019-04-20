FSR_default = struct( ...
    'fsr_1',uint16(0), ...
    'fsr_2',uint16(0), ...
    'fsr_3',uint16(0), ...
    'fsr_4',uint16(0), ...
    'fsr_x',uint8(0), ...
    'fsr_y',uint8(0));
FSR_bus = Simulink.Bus.createObject(FSR_default);

bus_name = FSR_bus.busName;
FSR_bus = eval(bus_name);
clear(bus_name);
clear('bus_name');

for i=1:length(FSR_bus.Elements)
    element = FSR_bus.Elements(i);
    if strcmp(element.Name,'fsr_1')
        element.Description = 'FSR Sensor 1';
        element.Min = 0;
        element.Max = 65535;
    elseif strcmp(element.Name,'fsr_2')
        element.Description = 'FSR Sensor 2';
        element.Min = 0;
        element.Max = 65535;
    elseif strcmp(element.Name,'fsr_3')
        element.Description = 'FSR Sensor 3';
        element.Min = 0;
        element.Max = 65535;
    elseif strcmp(element.Name,'fsr_4')
        element.Description = 'FSR Sensor 4';
        element.Min = 0;
        element.Max = 65535;
    elseif strcmp(element.Name,'fsr_x')
        element.Description = 'FSR Center X';
        element.Min = 0;
        element.Max = 255;
    elseif strcmp(element.Name,'fsr_y')
        element.Description = 'FSR Center Y';
        element.Min = 0;
        element.Max = 255;
    else
        error('invalid element name "%s"',element.Name);
    end
    FSR_bus.Elements(i) = element;
end

clear element
clear i

FSR_scale = 1000; % point per N (from specs)
FSR_max = 254; % X/Y maximum value
FSR_no_load = 255; % no load X/Y value

FSR_sample_time = 0.001;
