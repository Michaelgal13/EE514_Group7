function cost = costFunction(simOut)

t = simOut.tout;
u = simOut.yout;
xnew = simOut.xnew;

% x = xnew.Data(:,1);
% xdot = xnew.Data(:,2);
% theta = xnew.Data(:,3);
% thetadot = xnew.Data(:,4);

x = [   xnew.Data(:,1)';...
        xnew.Data(:,2)';...
        xnew.Data(:,3)';...
        xnew.Data(:,4)'  ];

Q = [   1 0 0 0;
        0 1 0 0;
        0 0 1 0;
        0 0 0 1     ];
R = 1;

cost = 0;
for i=2:length(t)
    cost =  cost + (x(:,i)'*Q*x(:,i) + u(i)'*R*u(i)).*(t(i)-t(i-1));
end

% figure(101)
% plot (t,x(1,:))
% hold on
% plot (t,x(2,:))
% plot (t,x(3,:))
% plot (t,x(4,:))
% cost
% cost = y(1)^2;