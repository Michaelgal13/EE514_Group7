function endNode = randEndNode(seed)
if rand > seed
    endNode = randState(seed);
else
    endNode = randNumber(seed);
end