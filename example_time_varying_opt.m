%EXAMPLE_TIME_VARYING_OPT Demonstrates time-varying distributed optimization.

N = 3;             % Number of agents
steps = 200;       % Iterations
alpha = 0.1;       % Step size
Dt = 0.05;         % Time step

% Initial states for each agent (1D problem)
X0 = rand(1, N);

% Simple symmetric mixing matrix
W = (1/N) * ones(N);

% Desired trajectory for each agent
phase = linspace(0, 2*pi, N+1);
phase(end) = []; % remove duplicate

ref = @(t, i) sin(t + phase(i));

% Gradient of local cost: f_i(x,t) = 0.5*(x - ref(t,i))^2
% -> gradient = x - ref(t,i)
grad_func = @(x, t, i) x - ref(t, i);

Xhist = time_varying_distributed_opt(W, grad_func, X0, alpha, steps, 0, Dt);

time = 0:Dt:steps*Dt;

figure;
plot(time, squeeze(Xhist), 'LineWidth', 1.5);
xlabel('Time');
ylabel('State');
title('Time-varying distributed optimization');
legend(arrayfun(@(i) sprintf('agent %d', i), 1:N, 'UniformOutput', false));
