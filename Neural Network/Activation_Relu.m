classdef Activation_Relu
    properties
        
    end
    methods
        function out = forward(obj, inputs)
            out = max(0, inputs);
        end
    end
end