function [fd,fdt] = rotoguru()
% http://undocumentedmatlab.com/blog/expanding-urlreads-capabilities
clc; close all; clear; 

% http://rotoguru1.com/cgi-bin/fyday.pl?week=8&game=fd&scsv=1

URLfull = 'http://rotoguru1.com/cgi-bin/fyday.pl?week=8&game=fd&scsv=1';

html_firstname = '<pre>Week;Year;';

% Open connection to FanDuel page
fprintf(1,'\n Retrieving player data from: %s \n\n', URLfull);

url     = java.net.URL(URLfull);        % Construct a URL object
is      = openStream(url);              % Open a connection to the URL
isr     = java.io.InputStreamReader(is);
br      = java.io.BufferedReader(isr);

%{
players: {
"6894":["QB","Aaron Rodgers","99671","23","39","9300",23.1,"1",false,4,"","recent",""],
"11612":["WR","Antonio Brown","99666","5","1000","9200",23.8,"1",false,4,"","recent",""],
"6703":["RB","Adrian Peterson","99663","21","1","9000",6.7,"1",false,4,"","recent",""],
"21939":["QB","Andrew Luck","...

%}

%%
% <td class="player-position">QB</td>

% <hr><br>Semi-colon delimited format:</P><P><pre>Week;Year;GID;Name;Pos;Team;h/a;Oppt;FD points;FD salary

p1 = java.lang.String('<hr><br>Semi-colon delimited format:</P><P><pre>Week;');
p2 = java.lang.String('</pre>');
s = readLine(br);
while ~(s.startsWith(p1))
   s = readLine(br);
end
disp(s.substring(p1.length,s.length-p2.length))


mm=1;
while ~(s.startsWith(p2))
   s = readLine(br);
   playerList{mm} = char(s);
   mm=mm+1;
end

playerList(end) = [];

disp(playerList)
disp(playerList{1})




%%


fdlist = playerList;

fd.wk = {};
fd.yr = {};
fd.id = {};
fd.player = {};
fd.pos = {};
fd.team = {};
fd.ha = {};
fd.oppt = {};
fd.ffpg = {};
fd.cost = {};


% Week;Year;GID;Name;Pos;Team;h/a;Oppt;FD points;FD salary
% 8;2015;1151;Brees, Drew;QB;nor;h;nyg;47.54;7900

for nn=1:numel(fdlist)

Delim = strfind(fdlist{nn}, ';');
Delims = [1, Delim];


fd(nn).wk       = fdlist{nn}(1:Delims(2)-1);
fd(nn).yr       = fdlist{nn}(Delims(2)+1:Delims(3)-1);
fd(nn).id       = str2num(fdlist{nn}(Delims(3)+1:Delims(4)-1));
fd(nn).player   = fdlist{nn}(Delims(4)+1:Delims(5)-1);
fd(nn).pos      = fdlist{nn}(Delims(5)+1:Delims(6)-1);
fd(nn).team     = fdlist{nn}(Delims(6)+1:Delims(7)-1);
fd(nn).ha       = fdlist{nn}(Delims(7)+1:Delims(8)-1);
fd(nn).oppt     = fdlist{nn}(Delims(8)+1:Delims(9)-1);
fd(nn).ffpg     = str2num(fdlist{nn}(Delims(9)+1:Delims(10)-1));
fd(nn).cost     = str2num(fdlist{nn}(Delims(10)+1:end));


end



%% Remove Players With Blank or Zero Cost

nocost=[];
for nn=1:numel(fd)
    if isempty(fd(nn).cost)
        nocost(end+1) = nn;
    elseif fd(nn).cost < 1
        nocost(end+1) = nn;
    end
end

fd(nocost) = [];


%% Standardize Position Labels

for nn=1:numel(fd)
    if all(fd(nn).pos(1:2)=='De')
        fd(nn).pos = 'D';
    elseif all(fd(nn).pos(1:2)=='PK')
        fd(nn).pos = 'K';
    end
end


%% Standardize Player Names

for nn=1:numel(fd)

    playername = [fd(nn).player ' '];

    comma = strfind(playername, ',');

    if comma

    playername = circshift(playername,-comma-1,2);

    playername(end-1:end) = [];

    fd(nn).player = playername;

    end

end


%% Export Table


fdt = struct2table(fd);

end


