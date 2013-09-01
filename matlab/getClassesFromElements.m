function [ output_args ] = getClassesFromElements( array )
%GETCLASSESFROMELEMENTS Auxilliary function used by classifyElements to get all classes represented by training set elements.

    currentIdx = 1;
    result = array(1,end);

    for i=2:1:length(array)
        if ( ~any(result == array(i, end)) )
            currentIdx = currentIdx + 1; 
            result(currentIdx) = array(i, end);
        end
    end
    output_args = result;
end

