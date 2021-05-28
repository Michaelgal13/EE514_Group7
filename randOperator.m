function operator = randOperator(opts)
if isempty(opts) || (size(opts,2) < 2)
    seed = 0.5;
else
    %loops = opts(1);'
    a = find(opts(:) == "OperatorSeed");
    if isempty(a)
        seed = 0.5;
    else
        seed = opts(a(1)+1);
        seed = str2double(seed);
    end
end
if rand > seed
        operator = '&+';
    else
        operator = '&*';
    end
end