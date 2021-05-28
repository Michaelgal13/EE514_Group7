function operator = randNumber(opts)
if isempty(opts) || (size(opts,2) < 2)
    numMax = 4;
    numLim = 0.5;
else
    %loops = opts(1);'
    a = find(opts(:) == "NumberMax");
    if isempty(a)
        numMax = 4;
    else
        numMax = opts(a(1)+1);
        numMax = str2double(numMax);
    end
    %loops = opts(1);'
    a = find(opts(:) == "NumberDelims");
    if isempty(a)
        numLim = 4;
    else
        numLim = opts(a(1)+1);
        numLim = str2double(numLim);
    end
end
a = -numMax:numLim:numMax;
val = cast(rand * size(a,2) + 1, 'int32');
if val > size(a,2)
    val = size(a,2);
elseif val <= 0
    val = 1;
end
operator = a(val);


%     if rand > seed
%         operator = 1;
%     else
%         operator = -1;
%     end
end