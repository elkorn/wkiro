function [ output_args ] = classifyElements( kernel, elements, trainingSet )
%CLASSIFYELEMENTS Iterates through every element of the given data set and classifies it using the implemented bayesian classifier.
%   Parameters:
%   kernel - the kernel function used for kernel estimation.
%   elements - the elements to classify.
%   trainingSet - the training set used as a reference for classification.
    classes = unique(transpose(trainingSet(:,3)));
    
    for i=1:1:length(elements)
        partial = empiricBayesianClassifier(kernel, classes, elements(i,:), trainingSet);
        output_args(i,:) = [elements(i, :), partial];
    end
end

