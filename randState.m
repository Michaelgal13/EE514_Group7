function endNode = randState(opts)
b = rand;
if isempty(opts) || (size(opts,2) < 2)
    StatexSeed = 0.25;
    StatexdotSeed = 0.25;
    StatethetaSeed = 0.25;
else
    %loops = opts(1);'
    a = find(opts(:) == "StatexSeed");
    if isempty(a)
        StatexSeed = 0.25;
    else
        StatexSeed = opts(a(1)+1);
        StatexSeed = str2double(StatexSeed);
    end
    a = find(opts(:) == "StatexdotSeed");
    if isempty(a)
        StatexdotSeed = 0.25;
    else
        StatexdotSeed = opts(a(1)+1);
        StatexdotSeed = str2double(StatexdotSeed);
    end
    a = find(opts(:) == "StatethetaSeed");
    if isempty(a)
        StatethetaSeed = 0.25;
    else
        StatethetaSeed = opts(a(1)+1);
        StatethetaSeed = str2double(StatethetaSeed);
    end
end
if b < StatexSeed
    endNode = 'x';
elseif b < StatexSeed + StatexdotSeed
    endNode = 'xdot';
elseif b < StatexSeed + StatexdotSeed + StatethetaSeed
    endNode = 'theta';
else
    endNode = 'thetadot';
end
end