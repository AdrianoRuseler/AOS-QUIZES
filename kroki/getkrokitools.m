function [toolNames, cmdout]= getkrokitools()

[status, cmdout] = system('curl -s http://localhost:8000/health');
if status ~= 0
    toolNames = {};
    disp(cmdout)
    return      
end

% Assuming cmdout contains the JSON string
jsonStruct = jsondecode(cmdout);

% 1. Extract the structure containing all the versions
versionStruct = jsonStruct.version;

% 2. Get a list of all field names (the tool names)
toolNames = fieldnames(versionStruct);
