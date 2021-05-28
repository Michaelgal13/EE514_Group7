%%
function strName = parseTree(tree)
    check = parseTreeHelper(tree);
    c = clock;
    c2 = strcat(dec2hex(c(1)), dec2hex(c(2)), dec2hex(c(3)), dec2hex(c(4)), dec2hex(c(5)), num2hex(c(6)));
    dirName = "genFiles/";
    strName = strcat("MG", c2);
    fullStrName = strcat(dirName, strName, ".m");
    fileID = fopen(strcat(fullStrName),'w+');
    while fileID == -1
        fileID = fopen(strcat(fullStrName),'w+');
    end
    stringName = strcat("function k = ", strName, "(x, xdot, theta, thetadot)"); 
    fprintf(fileID, stringName);
    fprintf(fileID, "\nk = ");
    fprintf(fileID, check);
    fprintf(fileID, ";\n");
    fclose(fileID);
end
