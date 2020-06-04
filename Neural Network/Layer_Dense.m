classdef Layer_Dense
    properties
       w
       b
       out
    end
    methods
        function obj = Layer_Dense(n_inputs, n_neurons)
            obj.w = rand(n_inputs, n_neurons);
            obj.b = zeros(1, n_neurons);
        end
        function out = forward(obj, inputs)
            out = (inputs * obj.w) + obj.b; 
        end
    end
end