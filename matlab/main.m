% main M file for bayesian classifier

clear labels;

% if (~exist('TRAINING_SET', 'var'))
%     run('createLearningSet');
% end

if(~exist('TRAINING_SET_PARAMETERS', 'var'))
    TRAINING_SET_PARAMETERS = [-15,0,1; 15,0,1; 0,15,1; 0,-15,1];
end

NumberOfClasses = length(TRAINING_SET_PARAMETERS);

if(~exist('TRAINING_SET_ELEMENTS_COUNT','var'))
    TRAINING_SET_ELEMENTS_COUNT = 20;
end

TRAINING_SET = generateRandomTrainingSet(TRAINING_SET_PARAMETERS, TRAINING_SET_ELEMENTS_COUNT);

if(~exist('ELEMENTS', 'var'))
    ELEMENTS = generateRandomCircleSet(0,0,27, 1000);
end

if(~exist('KERNEL', 'var'))
    KERNEL = @kernel_gaussian;
end

% n=3; %number of decimal places

result = classifyElements(KERNEL, ELEMENTS, TRAINING_SET);

for i=1:1:length(TRAINING_SET)
    % Klasa %d (zbiÃ³r uczÂ¹cy)
%     TRAINING_SET(i,end) = TRAINING_SET(i,end) + NumberOfClasses;
end

result = sortrows(result,3);

for i=1:1:length(TRAINING_SET)
    labels{i} = sprintf('Zbiór ucz¹cy dla klasy %d', TRAINING_SET(i,end));
end

for i=1:1:length(result)
    if(result(i,end) < 0)
        labels{length(TRAINING_SET)+i} = sprintf('Elementy nieprzypisane');
    else
        labels{length(TRAINING_SET)+i} = sprintf('Elementy w klasie %d', result(i,end));
    end
end

labels = transpose(labels);
result = [TRAINING_SET; result];
gscatter(result(:,1), result(:,2), labels);