function [loss, delta] = loss_fn(out, target)
    delta = (out - target);
    loss = 0.5*(out - target).^2;
    loss = mean(loss);
end