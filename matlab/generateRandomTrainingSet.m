function [ output_args ] = generateRandomTrainingSet( array, quantity )
%generateRandomTrainingSet Generates a training set of elements
%   Detailed explanation goes here

    output_args = [];
    
    numberOfClasses = length(array(:,1));
    for i=1:numberOfClasses
        tmpResult{:,:,i} = generateRandomCircleSet( array(i,1), array(i,2), array(i,3), quantity, i );
    end
    
    for i=1:1:numberOfClasses
        output_args = cat(1,output_args, tmpResult{i});
    end
end

