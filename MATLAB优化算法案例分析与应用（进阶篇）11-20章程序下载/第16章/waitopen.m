function waitopen
h1=waitbar(0.1,'Please wait, check hardware......');
pause(0.5)
h1=waitbar(0.8,h1,'Please wait, initialize the window');
pause(0.5)
h1=waitbar(1.0,h1,'Please wait, initialize the window');
close(h1);