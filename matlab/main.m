% main M file for bayesian classifier


% if (~exist('LEARNING_SET', 'var'))
%     run('createLearningSet');
% end

if(~exist('LEARNING_SET_PARAMETERS', 'var'))
    LEARNING_SET_PARAMETERS = [-15,-15,1; 15,15,1; -15,15,1; 15,-15,1];
end

NumberOfClasses = length(LEARNING_SET_PARAMETERS);

if(~exist('LEARNING_SET_ELEMENTS_COUNT','var'))
    LEARNING_SET_ELEMENTS_COUNT = 20;
end

LEARNING_SET = generateRandomTrainingSet(LEARNING_SET_PARAMETERS, LEARNING_SET_ELEMENTS_COUNT);

if(~exist('ELEMENTS', 'var'))
    ELEMENTS = generateRandomCircleSet(0,0,7, 100);
end

if(~exist('KERNEL', 'var'))
    KERNEL = @kernel_gaussian;
end

% n=3; %number of decimal places

result = classifyElements(KERNEL, ELEMENTS, LEARNING_SET);

for i=1:1:length(LEARNING_SET)
    % Klasa %d (zbiór ucz¹cy)
%     LEARNING_SET(i,end) = LEARNING_SET(i,end) + NumberOfClasses;
end

result = sortrows(result,3);

for i=1:1:length(LEARNING_SET)
    labels{i} = sprintf('Zbiór uczący: klasa %d', LEARNING_SET(i,end));
end

for i=1:1:length(result)
    if(result(i,end) < 0)
        labels{length(LEARNING_SET)+i} = sprintf('Elementy nieprzypisane');
    else
        labels{length(LEARNING_SET)+i} = sprintf('Elementy w: klasa %d', result(i,end));
    end
end

labels = transpose(labels);
result = [LEARNING_SET; result];
gscatter(result(:,1), result(:,2), labels);