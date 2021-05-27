function endNode = randState(seed)
b = rand;
if b < 0.25
    endNode = 'x';
elseif b < 0.5
    endNode = 'xdot';
elseif b < 0.75
    endNode = 'theta';
else
    endNode = 'thetadot';
end
end