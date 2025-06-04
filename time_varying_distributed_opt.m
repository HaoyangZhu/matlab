function Xhist = time_varying_distributed_opt(W, grad_func, X0, alpha, steps, t0, dt)
%TIME_VARYING_DISTRIBUTED_OPT Simple time-varying distributed optimization.
%   Xhist = time_varying_distributed_opt(W, grad_func, X0, alpha, steps, t0, dt)
%   performs a distributed gradient descent over a network.
%
%   W         - NxN row-stochastic mixing matrix.
%   grad_func - function handle @(x, t, i) returning gradient of agent i.
%   X0        - d x N matrix of initial states for N agents.
%   alpha     - positive stepsize for gradient descent.
%   steps     - number of iterations.
%   t0        - initial time for gradient evaluation.
%   dt        - time increment per step.
%
%   Xhist is a d x N x (steps+1) tensor containing the state of each
%   agent after each iteration.

[d, N] = size(X0);
X = X0;
Xhist = zeros(d, N, steps + 1);
Xhist(:, :, 1) = X0;

for k = 1:steps
    t = t0 + (k - 1) * dt;
    % Consensus step
    Xmix = X * W';
    % Gradient step for each agent
    for i = 1:N
        gi = grad_func(X(:, i), t, i);
        Xmix(:, i) = Xmix(:, i) - alpha * gi;
    end
    X = Xmix;
    Xhist(:, :, k + 1) = X;
end
end
