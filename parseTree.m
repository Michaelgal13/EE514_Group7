%%
function strName = parseTree(tree)
    % DOES NOT WORK IF LOOKING AT THE END DIRECTORY IDFK KNOW WHY BUT DON'T
    % LOOK AT IT. A WATCHED POT NEVER BOILS AND OBSERVER EFFECT AND STUFF
    %passes tree to helper function that returns sting
    check = parseTreeHelper(tree);
    %generate hash for naming the file
    c = clock;
    c2 = strcat(dec2hex(c(1)), dec2hex(c(2)), dec2hex(c(3)), dec2hex(c(4)), dec2hex(c(5)), num2hex(c(6)));
    % sets directory
    dirName = "genFiles/";
    %adds MG to function name to ensure it will be valid, also to claim
    %ownership :)
    strName = strcat("MG", c2);
    %creates folder/filename.extension
    fullStrName = strcat(dirName, strName, ".m");
    %opens the new file
    fileID = fopen(strcat(fullStrName),'w+');
    % attempts to open the file until it is open
    % DONT LOOK AT THE DIRECTORY. IT GETS NERVOUS!
    while fileID == -1
        fileID = fopen(strcat(fullStrName),'w+');
    end
    %writes function name
    stringName = strcat("function k = ", strName, "(x, xdot, theta, thetadot)"); 
    %writes function code
    fprintf(fileID, stringName);
    fprintf(fileID, "\nk = ");
    fprintf(fileID, check);
    fprintf(fileID, ";\n");
    %closes the file
    fclose(fileID);
    %returns function name
end
