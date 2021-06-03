% Group 7
% System constants
M = 10;
m = 2;
L = 0.66;
g = 9.8;

% states = x, xdot, theta, thetadot
% Linearized model around vertical position
A = [0 1 0 0; 0 0 -m*g/M 0; 0 0 0 1; 0 0 (M+m)*g/(L*M) 0];
B = [0; 1/M; 0; -1/(L*M)];
C = eye(4);
D = zeros(4,1);
sys = ss(A,B,C,D);

Q = [1 0 0 0; 0 1 0 0; 0 0 5 0; 0 0 0 1];
R = [1];

K = lqr(sys,Q,R);

% Function for linear model
linCart = @(t,x) A*x + B*-K*x;

% Create state trajectory plot for first inital condition
t = [0:0.01:20];
x0 = [0; 0; pi/10; 0];
[Lint,Linx] = ode45(linCart, t, x0);
Linu = zeros(size(t))';
for i=1:size(Linx, 1)
    Linu(i) = (-K * Linx(i,:)')';
end
[NLint,NLinx] = ode45(@nonLinearCart, t, x0);
NLinu = zeros(size(t))';
for i=1:size(NLinx, 1)
    NLinu(i) = (-K * NLinx(i,:)')';
end
figure(1)
clf
sgtitle("LQR Controller w/Initial $\theta = \frac{\pi}{10}$", ...
    'interpreter', 'latex', 'FontSize', 20)
subplot(2,3,1)      % Position Plot
hold on
plot(Lint, Linx(:,1), 'LineWidth', 2)
plot(NLint, NLinx(:,1), 'LineWidth', 2)
xlabel("Time [s]")
ylabel("Position [m]")
set(gca, "FontSize", 14)
hold off
subplot(2,3,2)      % Velocity Plot
hold on
plot(Lint, Linx(:,2), 'LineWidth', 2)
plot(NLint, NLinx(:,2), 'LineWidth', 2)
xlabel("Time [s]")
ylabel("Velocity [m/s]")
set(gca, "FontSize", 14)
hold off
subplot(2,3,3)      % Angular Position Plot
hold on
plot(Lint, Linx(:,3), 'LineWidth', 2)
plot(NLint, NLinx(:,3), 'LineWidth', 2)
xlabel("Time [s]")
ylabel("Anglular Position [rad]")
set(gca, "FontSize", 14)
hold off
subplot(2,3,4)      % Angular Velocity Plot
hold on
plot(Lint, Linx(:,4), 'LineWidth', 2)
plot(NLint, NLinx(:,4), 'LineWidth', 2)
xlabel("Time [s]")
ylabel("Angular Velocity [rad/s]")
set(gca, "FontSize", 14)
hold off
subplot(2,3,5)      % Control Effort Plot
hold on
plot(Lint, Linu, 'LineWidth', 2)
plot(NLint, NLinu, 'LineWidth', 2)
hold off
xlabel("Time [s]")
ylabel("Actuation Effort [N]")
set(gca, "FontSize", 14)
subplot(2,3,6)      % Empty plot for legend
plot(0,0, 0,0, 'LineWidth', 2)
axis off
legend("Linear", "Non-Linear")
set(gca, "FontSize", 20)

% Create state trajectory plot for second inital condition
t = [0:0.01:20];
x0 = [0; 0; pi/5; 0];
[Lint,Linx] = ode45(linCart, t, x0);
for i=1:size(Linx, 1)
    Linu(i) = (-K * Linx(i,:)')';
end
[NLint,NLinx] = ode45(@nonLinearCart, t, x0);
for i=1:size(NLinx, 1)
    NLinu(i) = (-K * NLinx(i,:)')';
end
figure(2)
clf
sgtitle("LQR Controller w/Initial $\theta = \frac{\pi}{5}$", ...
    'interpreter', 'latex', 'FontSize', 20)
subplot(2,3,1)      % Position Plot
hold on
plot(Lint, Linx(:,1), 'LineWidth', 2)
plot(NLint, NLinx(:,1), 'LineWidth', 2)
xlabel("Time [s]")
ylabel("Position [m]")
set(gca, "FontSize", 14)
hold off
subplot(2,3,2)      % Velocity Plot
hold on
plot(Lint, Linx(:,2), 'LineWidth', 2)
plot(NLint, NLinx(:,2), 'LineWidth', 2)
xlabel("Time [s]")
ylabel("Velocity [m/s]")
set(gca, "FontSize", 14)
hold off
subplot(2,3,3)      % Angular Position Plot
hold on
plot(Lint, Linx(:,3), 'LineWidth', 2)
plot(NLint, NLinx(:,3), 'LineWidth', 2)
xlabel("Time [s]")
ylabel("Anglular Position [rad]")
set(gca, "FontSize", 14)
hold off
subplot(2,3,4)      % Angular Velocity Plot
hold on
plot(Lint, Linx(:,4), 'LineWidth', 2)
plot(NLint, NLinx(:,4), 'LineWidth', 2)
xlabel("Time [s]")
ylabel("Angular Velocity [rad/s]")
set(gca, "FontSize", 14)
hold off
subplot(2,3,5)      % Control Effort Plot
hold on
plot(Lint, Linu, 'LineWidth', 2)
plot(NLint, NLinu, 'LineWidth', 2)
hold off
xlabel("Time [s]")
ylabel("Actuation Effort [N]")
set(gca, "FontSize", 14)
subplot(2,3,6)      % Empty plot for legend
plot(0,0, 0,0, 'LineWidth', 2)
axis off
legend("Linear", "Non-Linear")
set(gca, "FontSize", 20)

% Function for non-linear model of system
function [y] = nonLinearCart(t, x) 
    M = 10;
    m = 2;
    L = 0.66;
    g = 9.8;
    A = [0 1 0 0; 0 0 -m*g/M 0; 0 0 0 1; 0 0 (M+m)*g/(L*M) 0];
    B = [0; 1/M; 0; -1/(L*M)];
    Q = [1 0 0 0; 0 1 0 0; 0 0 5 0; 0 0 0 1];
    R = [1];
    K = lqr(A,B,Q,R);
    
    % Deadzone
    u = -K*x;
    if (u < 0.1) && (u > -0.1)
        u = 0;
    end
    
    y(1,1) = x(2,1);
    y(2,1) = (u+m*sin(x(3,1))*(L*x(4,1)^2-g*cos(x(3,1))))/ ...
        (M+m*sin(x(3,1))^2);
    y(3,1) = x(4,1);
    y(4,1) = (-u*cos(x(3,1))-m*L*x(4,1)^2*sin(x(3,1))*cos(x(3,1))+(M+m)*g*sin(x(3,1)))/ ...
        (L*(M+m*sin(x(3,1))^2));
end