clc
clear all

% toolNames = getkrokitools();
toolNames={'tikz'};
% List all files inside each targetDir and display their names
for i = 1:length(toolNames)
    targetDir = fullfile('tests/', toolNames{i});
    % List all files inside each targetDir and display their names
    files = dir(targetDir);
    % Exclude the current directory and parent directory from the list
    files = files(~ismember({files.name}, {'.', '..'}));
    files = files(~endsWith({files.name}, {'.md','.svg'})); % Exclude .md and .svg files from the list

    % Display the total number of files found in the directory
    fprintf('Total files in %s: %d\n', targetDir, length(files));

    % Create curl command for each file
    for f=1:length(files)
        % Execute the curl command for the current file
        curl_command = sprintf('curl -s -X POST -H "Content-Type: text/plain" --data-binary "@%s" http://localhost:8000/%s/svg', fullfile(targetDir, files(f).name), toolNames{i});
        [status, cmdout] = system(curl_command);
        if status == 0
            % disp(['Curl command for ', toolNames{i}, ' executed successfully.']);
            % Save cmdout as an SVG file
            [~,name] = fileparts(files(f).name);
            svgFilePath = fullfile(targetDir, [name, '.svg']);
            fidSvg = fopen(svgFilePath, 'w');
            if fidSvg ~= -1
                fwrite(fidSvg, cmdout);
                fclose(fidSvg);
                disp(['SVG file saved: ', svgFilePath]);
            else
                disp(['Error saving SVG file for ', files(f).name]);
            end
        else
            disp(['Error executing curl command for ', toolNames{i}, '. Status: ', num2str(status)]);
        end
    end
end

%% Create info quiz
clc
clear all

infos.xmlpath=[pwd '\xmlfiles']; % xmlfiles
infos.fname='Kroki-tests';

% toolNames = getkrokitools();

toolNames={'tikz'};
% List all files inside each targetDir and display their names
q=1;
for i = 1:length(toolNames)
    targetDir = fullfile('tests/', toolNames{i});
    % List all files inside each targetDir and display their names
    files = dir(targetDir);
    % Exclude the current directory and parent directory from the list
    files = files(~ismember({files.name}, {'.', '..'}));
    files = files(~endsWith({files.name}, {'.md','.svg'})); % Exclude .md and .svg files from the list

    % Display the total number of files found in the directory
    fprintf('Total files in %s: %d\n', targetDir, length(files));

    % Create curl command for each file
    for f=1:length(files)
        % Execute the curl command for the current file
        curl_command = sprintf('curl -s -X POST -H "Content-Type: text/plain" --data-binary "@%s" http://localhost:8000/%s/svg', fullfile(targetDir, files(f).name), toolNames{i});
        [status, cmdout] = system(curl_command);
        if status == 0
            encoded_string = matlab.net.base64encode(cmdout);
            imgstr=['<img src="data:image/svg+xml;base64,' encoded_string '">'];
            infos.q(q).text=['<code>' curl_command '</code><p>' imgstr '</p>'];
            infos.q(q).name=[toolNames{i} ': ' files(f).name];
            q=q+1;
        else
            disp(['Error executing curl command for ', toolNames{i}, '. Status: ', num2str(status)]);
        end
    end
end


info2ioxml(infos)


