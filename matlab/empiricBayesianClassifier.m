function [ output_args ] = empiricBayesianClassifier( kernel, classes, element, trainingSet )
%EMPIRICBAYESIANCLASSIFIER Classifies an element based on a training set.
%   Returns a class at which an element belongs basen od the values of
%   disriminant functions for it's features guided by the traning dataset.
%   Parameters:
%   kernel - the kernel function used.
%   classes - all classes beared by the training set elements.
%   element - the element to classify.
%   trainingSet - the set of elemens used as reference for classification.

    partialResults = -Inf(1,length(classes));

    for cI=1:1:length(classes)
        trainingSetForClassI = getElementsByClass(trainingSet,cI);
        tmpResultForClassI = discriminantFunction(kernel, element, trainingSetForClassI);
        for cJ=1:1:length(classes)
            trainingSetForClassJ = getElementsByClass(trainingSet,cJ);
            tmpResultForClassJ = discriminantFunction(kernel, element, trainingSetForClassJ);
            
            if ( (tmpResultForClassI > tmpResultForClassJ) && (partialResults(cI) < tmpResultForClassI) )
                partialResults(cI) = tmpResultForClassI;
            end
        end
    end
    
    partialClass = classes( find(partialResults == max(partialResults)) );
    if(length(partialClass) > 1)
        partialClass = -1;
    end
    output_args = partialClass;
    
end

