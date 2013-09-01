function [ output_args ] = structuralDataAdapter( array )
%DATASCATTERPLOTADAPTER Adapts structural data to a matrix form
%   array - an array of structures adhering to the following form:
%   {
%       features: [f1,f2],
%       class: c
%   }

        output_args = [];
        for i=1: 1: length(array)
            output_args(end+1, :) = [array(i).features, array(i).class];
        end
end

