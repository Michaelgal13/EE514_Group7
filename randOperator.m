function operator = randOperator(seed)
    if rand > seed
        operator = '&+';
    else
        operator = '&*';
    end
end