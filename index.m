
clear all
clc

% Define the root folder to start the search
rootFolder = pwd;

% Define filename patterns to exclude
% excludePatterns = {'mode', 'func'}; % Adjust patterns as needed
excludePatterns = {}; % Adjust patterns as needed

% Get a list of all .m files in the subfolders
fileList = dir(fullfile(rootFolder, '**', '*.m'));

% Initialize the final list
filteredFiles = {};

for k = 1:length(fileList)
    filePath = fullfile(fileList(k).folder, fileList(k).name);
    fileName = fileList(k).name;

    % Skip files directly in the root folder
    if strcmp(fileList(k).folder, rootFolder)
        continue;
    end

    % Check if the file matches any exclusion pattern
    shouldExclude = false;
    for pattern = excludePatterns
        if contains(fileName, pattern{1})
            shouldExclude = true;
            break;
        end
    end

    % Skip if file is to be excluded
    if shouldExclude
        continue;
    end

    % Check if the file is a MATLAB built-in function
    [~, fileBaseName, ~] = fileparts(fileName);
    if exist(fileBaseName, 'builtin')
        continue;
    end

    % Check for the circuit.nsims field in the file
    try
        fileContent = fileread(filePath);
        if contains(fileContent, 'circuit.nsims')
            % Add the file to the filtered list
            filteredFiles{end+1} = filePath;
        end
    catch
        % If there is an error reading the file, skip it
        warning(['Could not read file: ', filePath]);
    end
end

% Display the results
disp('Filtered files with circuit.nsims field:');
% disp(filteredFiles);


for k = 1:length(filteredFiles)
    disp(filteredFiles{k})
end


% Run files matching all patterns in the full path (e.g., 'example' and 'test')
% patternFilter = {'TE00', 'PSIM'};
patternFilter = {'diode00'};

% Define the new value for circuit.nsims
newValue = 8;

% Call the function to modify circuit.nsims in the matched files
modifyCircuitNsims(filteredFiles, patternFilter, newValue);

runFilteredFiles(filteredFiles, patternFilter);

% Run all files (empty pattern filter)
% patternFilter = {};
% runFilteredFiles(filteredFiles, patternFilter);


% Call the function to clear the content of all .xml and .html files
clearXmlHtmlFilesContent(folderPath);



% 
% findMFiles()
% 
% % Run all files in current directory without changing nsims
% runMFiles
% 
% % Run files in specific directory without changing nsims
% runMFiles([pwd '\TE00\LTspice']) % Error: Unrecognized field name "dateline".
% 
% 
% runMFiles([pwd '\TE00\PSIM'])
% 
% 
% % Run files and set circuit.nsims to 20
% runMFiles('C:\MATLAB\Work', 20)