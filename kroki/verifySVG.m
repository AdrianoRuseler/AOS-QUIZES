function isValid = verifySVG(filename)
isValid = false;

% Check existence
if ~exist(filename, 'file')
    fprintf('Error: File does not exist.\n');
    return;
end

% Check XML validity
try
    xmlDoc = xmlread(filename);
catch ME
    fprintf('Error: Not valid XML - %s\n', ME.message);
    return;
end

% Check SVG root element
rootNode = xmlDoc.getDocumentElement;
if ~strcmp(char(rootNode.getNodeName), 'svg')
    fprintf('Error: Root element is not <svg>\n');
    return;
end

fprintf('✓ Valid SVG file\n');
fprintf('  Root element: %s\n', char(rootNode.getNodeName));

% Display additional info
% if rootNode.hasAttribute('viewBox')
%     fprintf('  ViewBox: %s\n', char(rootNode.getAttribute('viewBox')));
% end

isValid = true;
end
