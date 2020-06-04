clc
clear
close all
clear all
%% input and target
inputs = rand(1,3);
targets = [0.3 0.5 0.9];
%targets = [0.3 0.9 0.3];
%% Upper bound and Lower bound
Ra = 25.00;
Rb = 0;

% Learning rate
learning_rate = 0.001;

early_stop = false;

% Create Hidden Layer
layer1 = Layer_Dense(3,4);
layer2 = Layer_Dense(4,4);
layer3 = Layer_Dense(4,3);

%% Activation Hidden Layer
activation = Activation_Relu;
best_loss = inf;

for i=1:100
    %% Forward
    out1 = activation.forward(layer1.forward(inputs));
    out2 = activation.forward(layer2.forward(out1));
    out3 = activation.forward(layer3.forward(out2));

    [out,~,~,~,~] = pid_loss(out3, Ra, Rb);
    
    %% Backward
    [loss,delta] = loss_fn(out, targets);
        
    layer3_.w = layer3.w - learning_rate*(out2' * delta);
    layer2_.w = layer2.w - learning_rate*(out1' * delta * layer3.w');
    layer1_.w = layer1.w - learning_rate*(inputs' * delta * layer3.w' * layer2.w);

    layer1.w = layer1_.w;
    layer2.w = layer2_.w;
    layer3.w = layer3_.w;
    %% Early Stopping
    if early_stop
        if loss > best_loss
            break
        end
    end
    %% Save best value
    if loss < best_loss
        best_loss = loss;
        best_out = out;
    end
    %% Show Iterations and loss
    fprintf(['Training Iterations: ', num2str(i),'\t','loss: ',num2str(loss),'\n']); 
end

[best,sys,kp,ki,kd] = pid_loss(best_out, Ra, Rb);
stepinfo(sys)
stepplot(sys,100)

