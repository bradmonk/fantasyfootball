function [fd,fdt] = fantasypros()
% http://undocumentedmatlab.com/blog/expanding-urlreads-capabilities
clc; close all; clear; 


% https://www.fanduel.com/nextnflgame
URLbase = 'http://www.fantasypros.com/nfl/projections/';
URLpos = 'qb.php';
URLfull = strcat(URLbase,  URLpos);

% Open connection to FantasyPros webpage
fprintf(1,'Retrieving %s player data from fantasypros.com \r', URLpos);

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

p1 = java.lang.String('            <tr class="mpb-available');
p2 = java.lang.String('</tr>');
s = readLine(br);
while ~(s.startsWith(p1))
   s = readLine(br);
end
disp(s.substring(p1.length,s.length-p2.length))

players = char(s.substring(p1.length,s.length-p2.length));
% playersList = players;
% players = playersList;

playerSrt = strfind(players, '[');
playerEnd = strfind(players, ']');

%%

player = {};
for nn = 1:numel(playerSrt)
    player{nn} = players(playerSrt(nn):playerEnd(nn));
end


%%

% for nn = 1:numel(player)
%     disp(player{nn})
%     pause(.05)
% end

%%


fdlist = player;

fd.pos = {};    % 1-2
fd.player = {}; % 2-3
fd.id = {};     % 3-4
fd.team = {};   % 4-5
fd.val = {};    % 5-6
fd.cost = {};   % 6-7
fd.ffpg = {};   % 7-8
fd.gp = {};     % 8-9
fd.tf = {};     % 9-10
fd.injid = {};  % 10-11
fd.inj = {};    % 11-12
fd.news = {};   % 12-13

for nn=1:numel(fdlist)

Quote = strfind(fdlist{nn}, '"');
fdlist{nn}(Quote) = [];

Comma = strfind(fdlist{nn}, ',');
Commas = [1, Comma];

fd(nn).pos      = fdlist{nn}(Commas(1)+1:Commas(2)-1);              % 1-2
fd(nn).player   = fdlist{nn}(Commas(2)+1:Commas(3)-1);              % 2-3
fd(nn).id       = str2num(fdlist{nn}(Commas(3)+1:Commas(4)-1));     % 3-4
fd(nn).team     = str2num(fdlist{nn}(Commas(4)+1:Commas(5)-1));     % 4-5
fd(nn).val      = str2num(fdlist{nn}(Commas(5)+1:Commas(6)-1));     % 5-6
fd(nn).cost     = str2num(fdlist{nn}(Commas(6)+1:Commas(7)-1));     % 6-7
fd(nn).ffpg     = str2num(fdlist{nn}(Commas(7)+1:Commas(8)-1));     % 7-8
fd(nn).gp       = str2num(fdlist{nn}(Commas(8)+1:Commas(9)-1));     % 8-9
fd(nn).tf       = fdlist{nn}(Commas(9)+1:Commas(10)-1);             % 9-10
fd(nn).injid    = str2num(fdlist{nn}(Commas(10)+1:Commas(11)-1));   % 10-11
fd(nn).inj      = fdlist{nn}(Commas(11)+1:Commas(12)-1);            % 11-12
fd(nn).news     = fdlist{nn}(Commas(12)+1:Commas(13)-1);            % 12-13
end



fdt = struct2table(fd);


end



% http://www.fantasypros.com/nfl/projections/qb.php
%{
<th style="width:50px;"><small>CMP</small></th>
<th style="width:50px;"><small>YDS</small></th>
<th style="width:50px;"><small>TDS</small></th>
<th style="width:50px;"><small>INTS</small></th>
<th style="width:50px;"><small>ATT</small></th>
<th style="width:50px;"><small>YDS</small></th>
<th style="width:50px;"><small>TDS</small></th>
<th style="width:50px;"><small>FL</small></th>
<th style="width:50px;"><small>FPTS</small></th>
</tr>          </thead>
          <tbody>
            <tr class="mpb-available mpb-player-11172"><td><a href="/nfl/projections/andrew-luck.php">Andrew Luck</a> <small style="color:#888888;">IND</small> <a href="#" class="fp-player-link fp-id-11172" fp-player-name="Andrew Luck"></a></td>
<td>39.9</td>
<td>24.1</td>
<td>294.3</td>
<td>2.1</td>
<td>0.7</td>
<td>3.7</td>
<td>15.8</td>
<td>0.1</td>
<td>0.3</td>
<td>20.2</td>
</tr>
<tr class="mpb-available mpb-player-9200"><td><a href="/nfl/projections/drew-brees.php">Drew Brees</a> <small style="color:#888888;">NO</small> <a href="#" class="fp-player-link fp-id-9200" fp-player-name="Drew Brees"></a></td>
<td>40.0</td>
<td>27.5</td>
<td>318.8</td>
<td>2.1</td>
<td>0.7</td>
<td>1.5</td>
<td>3.2</td>
<td>0.1</td>
<td>0.2</td>
<td>20.0</td>
</tr>


%}


%{

<script>
window.newrelic.setCustomAttribute("userId", 471932);
window.newrelic.setCustomAttribute("page", "games");
</script>


<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6894_13002')">Aaron Rodgers</div></td>
<td class="player-fppg">23.1</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$9,300</td>



%}


% https://www.fanduel.com/nextnflgame
%{
<tbody>
<tr id="playerListPlayerId_6894" data-role="player" data-position="QB" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6894_13002')">Aaron Rodgers</div></td>
<td class="player-fppg">23.1</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$9,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6894" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6894" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11612" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11612_13002')">Antonio Brown</div></td>
<td class="player-fppg">23.8</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$9,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11612" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11612" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6703" data-role="player" data-position="RB" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6703_13002')">Adrian Peterson</div></td>
<td class="player-fppg">6.7</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$9,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6703" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6703" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21939" data-role="player" data-position="QB" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('21939_13002')">Andrew Luck</div></td>
<td class="player-fppg">17.7</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$8,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21939" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21939" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6504" data-role="player" data-position="QB" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6504_13002')">Drew Brees</div></td>
<td class="player-fppg">17.5</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$8,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6504" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6504" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6899" data-role="player" data-position="RB" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6899_13002')">Matt Forte</div></td>
<td class="player-fppg">25.1</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$8,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6899" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6899" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14190" data-role="player" data-position="WR" data-fixture="99665" class="pR injured fixtureId_99665 teamId_27   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14190_13002')">Julio Jones<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">30.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$8,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14190" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14190" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6616" data-role="player" data-position="QB" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6616_13002')">Matt Ryan</div></td>
<td class="player-fppg">18.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$8,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6616" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6616" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31360" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('31360_13002')">Odell Beckham Jr.</div></td>
<td class="player-fppg">6.9</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$8,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31360" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31360" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_9371" data-role="player" data-position="RB" data-fixture="99671" class="pR injured fixtureId_99671 teamId_31   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('9371_13002')">Marshawn Lynch<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">14.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$8,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="9371" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="9371" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22015" data-role="player" data-position="QB" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('22015_13002')">Russell Wilson</div></td>
<td class="player-fppg">16.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$8,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22015" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22015" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6639" data-role="player" data-position="QB" data-fixture="99670" class="pR injured fixtureId_99670 teamId_18   news-breaking">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6639_13002')">Tony Romo<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">24.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$8,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6639" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6639" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31397" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('31397_13002')">Jeremy Hill</div></td>
<td class="player-fppg">18.3</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$8,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31397" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31397" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6589" data-role="player" data-position="QB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6589_13002')">Ben Roethlisberger</div></td>
<td class="player-fppg">17</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$8,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6589" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6589" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14254" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14254_13002')">DeMarco Murray</div></td>
<td class="player-fppg">16</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$8,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14254" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14254" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11460" data-role="player" data-position="TE" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11460_13002')">Rob Gronkowski</div></td>
<td class="player-fppg">29.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$8,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11460" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11460" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6498" data-role="player" data-position="QB" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6498_13002')">Tom Brady</div></td>
<td class="player-fppg">27.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$8,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6498" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6498" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_10777" data-role="player" data-position="RB" data-fixture="99659" class="pR injured fixtureId_99659 teamId_11   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('10777_13002')">Arian Foster<span class="player-badge player-badge-injured-possible">D</span></div></td>
<td class="player-fppg">19.6</td>
<td class="player-played">13</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$8,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="10777" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="10777" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29253" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('29253_13002')">Keenan Allen</div></td>
<td class="player-fppg">24.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$8,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29253" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29253" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7968" data-role="player" data-position="QB" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('7968_13002')">Philip Rivers</div></td>
<td class="player-fppg">22</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$8,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7968" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7968" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14257" data-role="player" data-position="WR" data-fixture="99671" class="pR injured fixtureId_99671 teamId_23   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14257_13002')">Randall Cobb<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">12.3</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$8,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14257" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14257" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6655" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6655_13002')">Calvin Johnson</div></td>
<td class="player-fppg">4.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$8,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6655" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6655" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_16606" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('16606_13002')">DeAndre Hopkins</div></td>
<td class="player-fppg">28.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$8,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="16606" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="16606" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30968" data-role="player" data-position="RB" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('30968_13002')">Eddie Lacy</div></td>
<td class="player-fppg">16.9</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$8,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30968" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30968" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32384" data-role="player" data-position="WR" data-fixture="99664" class="pR injured fixtureId_99664 teamId_26   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('32384_13002')">Mike Evans<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">14.1</td>
<td class="player-played">15</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$8,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32384" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32384" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6714" data-role="player" data-position="QB" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6714_13002')">Joe Flacco</div></td>
<td class="player-fppg">2.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$8,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6714" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6714" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21980" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('21980_13002')">Alshon Jeffery</div></td>
<td class="player-fppg">10.3</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$8,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21980" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21980" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14187" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14187_13002')">A.J. Green</div></td>
<td class="player-fppg">8.8</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$8,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14187" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14187" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6779" data-role="player" data-position="RB" data-fixture="99658" class="pR injured fixtureId_99658 teamId_4   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6779_13002')">LeSean McCoy<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">10.2</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$8,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6779" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6779" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6826" data-role="player" data-position="QB" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6826_13002')">Eli Manning</div></td>
<td class="player-fppg">8.5</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$8,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6826" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6826" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14211" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14211_13002')">Mark Ingram</div></td>
<td class="player-fppg">16.2</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$8,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14211" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14211" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21948" data-role="player" data-position="QB" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('21948_13002')">Ryan Tannehill</div></td>
<td class="player-fppg">11.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$8,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21948" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21948" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6748" data-role="player" data-position="QB" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6748_13002')">Carson Palmer</div></td>
<td class="player-fppg">25.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$7,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6748" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6748" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14231" data-role="player" data-position="QB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14231_13002')">Colin Kaepernick</div></td>
<td class="player-fppg">10.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$7,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14231" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14231" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6857" data-role="player" data-position="RB" data-fixture="99669" class="pR injured fixtureId_99669 teamId_6   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6857_13002')">Justin Forsett<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">7.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$7,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6857" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6857" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24682" data-role="player" data-position="RB" data-fixture="99660" class="pR injured fixtureId_99660 teamId_29   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('24682_13002')">Andre Ellington<span class="player-badge player-badge-injured-possible">D</span></div></td>
<td class="player-fppg">12.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$7,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24682" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24682" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6654" data-role="player" data-position="QB" data-fixture="99663" class="pR injured fixtureId_99663 teamId_24   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6654_13002')">Matthew Stafford<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">15.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$7,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6654" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6654" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14185" data-role="player" data-position="QB" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14185_13002')">Cam Newton</div></td>
<td class="player-fppg">13.5</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$7,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14185" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14185" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7859" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7859_13002')">Julian Edelman</div></td>
<td class="player-fppg">16.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$7,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7859" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7859" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22031" data-role="player" data-position="WR" data-fixture="99776" class="pR injured fixtureId_99776 teamId_10   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22031_13002')">T.Y. Hilton<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">12.3</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$7,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22031" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22031" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11414" data-role="player" data-position="QB" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('11414_13002')">Sam Bradford</div></td>
<td class="player-fppg">15.4</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$7,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11414" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11414" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29358" data-role="player" data-position="QB" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-breaking">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('29358_13002')">Marcus Mariota</div></td>
<td class="player-fppg">25</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$7,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29358" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29358" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6732" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6732_13002')">DeAngelo Williams</div></td>
<td class="player-fppg">13.7</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$7,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6732" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6732" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6759" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6759_13002')">Brandon Marshall</div></td>
<td class="player-fppg">15.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$7,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6759" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6759" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6618" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6618_13002')">Roddy White</div></td>
<td class="player-fppg">10.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$7,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6618" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6618" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29501" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('29501_13002')">Brandin Cooks</div></td>
<td class="player-fppg">7.3</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$7,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29501" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29501" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22113" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22113_13002')">Alfred Morris</div></td>
<td class="player-fppg">12.1</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$7,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22113" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22113" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22037" data-role="player" data-position="RB" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22037_13002')">Lamar Miller</div></td>
<td class="player-fppg">8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$7,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22037" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22037" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7953" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7953_13002')">Vincent Jackson</div></td>
<td class="player-fppg">7.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$7,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7953" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7953" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6898" data-role="player" data-position="QB" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6898_13002')">Jay Cutler</div></td>
<td class="player-fppg">15.1</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$7,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6898" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6898" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31261" data-role="player" data-position="RB" data-fixture="99667" class="pR injured fixtureId_99667 teamId_32   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('31261_13002')">Tre Mason<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">10.6</td>
<td class="player-played">12</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$7,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31261" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31261" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31394" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('31394_13002')">Jarvis Landry</div></td>
<td class="player-fppg">16.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$7,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31394" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31394" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21941" data-role="player" data-position="QB" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('21941_13002')">Robert Griffin III</div></td>
<td class="player-fppg">10.4</td>
<td class="player-played">9</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$7,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21941" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21941" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11512" data-role="player" data-position="TE" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11512_13002')">Jimmy Graham</div></td>
<td class="player-fppg">14.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$7,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11512" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11512" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25290" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('25290_13002')">Giovani Bernard</div></td>
<td class="player-fppg">11.8</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$7,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25290" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25290" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30837" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('30837_13002')">Jordan Matthews</div></td>
<td class="player-fppg">15.2</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$7,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30837" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30837" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6840" data-role="player" data-position="RB" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6840_13002')">Frank Gore</div></td>
<td class="player-fppg">4.1</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$7,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6840" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6840" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33259" data-role="player" data-position="QB" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('33259_13002')">Teddy Bridgewater</div></td>
<td class="player-fppg">9.8</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$7,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33259" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33259" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28473" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('28473_13002')">Carlos Hyde</div></td>
<td class="player-fppg">31.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$7,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28473" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28473" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6739" data-role="player" data-position="WR" data-fixture="99667" class="pR injured fixtureId_99667 teamId_20   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6739_13002')">DeSean Jackson<span class="player-badge player-badge-injured-out">O</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$6,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6739" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6739" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11864" data-role="player" data-position="RB" data-fixture="99776" class="pR injured fixtureId_99776 teamId_1   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11864_13002')">Christopher Ivory<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">22.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$6,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11864" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11864" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14225" data-role="player" data-position="QB" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14225_13002')">Andy Dalton</div></td>
<td class="player-fppg">18.9</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$6,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14225" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14225" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54604" data-role="player" data-position="QB" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('54604_13002')">Jimmy Garoppolo</div></td>
<td class="player-fppg">2</td>
<td class="player-played">6</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$6,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54604" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54604" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34331" data-role="player" data-position="RB" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('34331_13002')">Latavius Murray</div></td>
<td class="player-fppg">11.5</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$6,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34331" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34331" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6681" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6681_13002')">Andre Johnson</div></td>
<td class="player-fppg">4.4</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$6,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6681" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6681" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6733" data-role="player" data-position="RB" data-fixture="99659" class="pR injured fixtureId_99659 teamId_25   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6733_13002')">Jonathan Stewart<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">10.1</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$6,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6733" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6733" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31001" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('31001_13002')">Amari Cooper</div></td>
<td class="player-fppg">7.2</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$6,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31001" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31001" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6735" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6735_13002')">Steve Smith</div></td>
<td class="player-fppg">2.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$6,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6735" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6735" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11485" data-role="player" data-position="WR" data-fixture="99663" class="pR injured fixtureId_99663 teamId_24   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11485_13002')">Golden Tate<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">4.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$6,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11485" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11485" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7659" data-role="player" data-position="QB" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('7659_13002')">Ryan Fitzpatrick</div></td>
<td class="player-fppg">14.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$6,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7659" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7659" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21970" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('21970_13002')">Doug Martin</div></td>
<td class="player-fppg">5.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$6,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21970" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21970" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27553" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27553_13002')">Joseph Randle</div></td>
<td class="player-fppg">12.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$6,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27553" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27553" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24641" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('24641_13002')">Sammy Watkins</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$6,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24641" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24641" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24849" data-role="player" data-position="QB" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('24849_13002')">Jameis Winston</div></td>
<td class="player-fppg">16.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$6,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24849" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24849" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_62497" data-role="player" data-position="RB" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('62497_13002')">David Johnson</div></td>
<td class="player-fppg">12</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$6,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="62497" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="62497" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14267" data-role="player" data-position="QB" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-breaking">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14267_13002')">Ryan Mallett</div></td>
<td class="player-fppg">8.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$6,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14267" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14267" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27776" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27776_13002')">Tevin Coleman</div></td>
<td class="player-fppg">8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$6,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27776" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27776" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22027" data-role="player" data-position="QB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('22027_13002')">Nick Foles</div></td>
<td class="player-fppg">19</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$6,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22027" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22027" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29991" data-role="player" data-position="RB" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('29991_13002')">Bishop Sankey</div></td>
<td class="player-fppg">21.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$6,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29991" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29991" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31061" data-role="player" data-position="RB" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('31061_13002')">T.J. Yeldon</div></td>
<td class="player-fppg">8.2</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$6,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31061" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31061" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32415" data-role="player" data-position="QB" data-fixture="99662" class="pR injured fixtureId_99662 teamId_7   news-breaking">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('32415_13002')">Johnny Manziel<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">9.8</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$6,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32415" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32415" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28900" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('28900_13002')">Melvin Gordon</div></td>
<td class="player-fppg">6.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$6,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28900" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28900" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7806" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('7806_13002')">Darren McFadden</div></td>
<td class="player-fppg">4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$6,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7806" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7806" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11779" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11779_13002')">LeGarrette Blount</div></td>
<td class="player-fppg">5.8</td>
<td class="player-played">16</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$6,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11779" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11779" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_8052" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('8052_13002')">Rashad Jennings</div></td>
<td class="player-fppg">11.2</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$6,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="8052" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="8052" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6687" data-role="player" data-position="QB" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6687_13002')">Mark Sanchez</div></td>
<td class="player-fppg">16.7</td>
<td class="player-played">9</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$6,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6687" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6687" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6479" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6479_13002')">Anquan Boldin</div></td>
<td class="player-fppg">5.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$6,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6479" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6479" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27229" data-role="player" data-position="RB" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27229_13002')">Ameer Abdullah</div></td>
<td class="player-fppg">17.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$6,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27229" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27229" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_45889" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('45889_13002')">Davante Adams</div></td>
<td class="player-fppg">7.9</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$6,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="45889" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="45889" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7778" data-role="player" data-position="QB" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('7778_13002')">Matt Cassel</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$6,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7778" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7778" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31836" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('31836_13002')">Terrance Williams</div></td>
<td class="player-fppg">8.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$6,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31836" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31836" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24920" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('24920_13002')">Devonta Freeman</div></td>
<td class="player-fppg">6.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$6,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24920" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24920" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14377" data-role="player" data-position="QB" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14377_13002')">Tyrod Taylor</div></td>
<td class="player-fppg">15.9</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$6,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14377" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14377" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7872" data-role="player" data-position="QB" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-breaking">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('7872_13002')">Brian Hoyer</div></td>
<td class="player-fppg">10.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$6,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7872" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7872" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30447" data-role="player" data-position="RB" data-fixture="99667" class="pR injured fixtureId_99667 teamId_32   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('30447_13002')">Todd Gurley<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$6,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30447" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30447" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14245" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14245_13002')">Shane Vereen</div></td>
<td class="player-fppg">8</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$6,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14245" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14245" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_9421" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('9421_13002')">Danny Woodhead</div></td>
<td class="player-fppg">20.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$6,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="9421" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="9421" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6607" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6607_13002')">Mike Wallace</div></td>
<td class="player-fppg">9.3</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$6,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6607" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6607" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54606" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('54606_13002')">John Brown</div></td>
<td class="player-fppg">12.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$6,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54606" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54606" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24949" data-role="player" data-position="QB" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('24949_13002')">E.J. Manuel</div></td>
<td class="player-fppg">12.3</td>
<td class="player-played">5</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$6,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24949" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24949" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11999" data-role="player" data-position="WR" data-fixture="99665" class="pR injured fixtureId_99665 teamId_17   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11999_13002')">Victor Cruz<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">8.5</td>
<td class="player-played">6</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$6,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11999" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11999" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21957" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('21957_13002')">Kendall Wright</div></td>
<td class="player-fppg">18.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$6,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21957" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21957" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11419" data-role="player" data-position="RB" data-fixture="99664" class="pR injured fixtureId_99664 teamId_28   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11419_13002')">C.J. Spiller<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">6.9</td>
<td class="player-played">9</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$6,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11419" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11419" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6448" data-role="player" data-position="TE" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6448_13002')">Martellus Bennett</div></td>
<td class="player-fppg">14</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$6,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6448" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6448" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11712" data-role="player" data-position="RB" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11712_13002')">Joique Bell</div></td>
<td class="player-fppg">5.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$6,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11712" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11712" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34308" data-role="player" data-position="QB" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('34308_13002')">Blake Bortles</div></td>
<td class="player-fppg">11.9</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$6,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34308" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34308" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_45859" data-role="player" data-position="QB" data-fixture="99669" class="pR injured fixtureId_99669 teamId_15   news-breaking">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('45859_13002')">Derek Carr<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">3.2</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$6,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="45859" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="45859" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14626" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14626_13002')">Doug Baldwin</div></td>
<td class="player-fppg">7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$6,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14626" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14626" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_8118" data-role="player" data-position="QB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('8118_13002')">Michael Vick</div></td>
<td class="player-fppg">4.5</td>
<td class="player-played">10</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$6,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="8118" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="8118" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6914" data-role="player" data-position="TE" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-breaking">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6914_13002')">Greg Olsen</div></td>
<td class="player-fppg">1.6</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$6,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6914" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6914" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11501" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11501_13002')">Eric Decker</div></td>
<td class="player-fppg">10.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$6,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11501" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11501" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6641" data-role="player" data-position="TE" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6641_13002')">Jason Witten</div></td>
<td class="player-fppg">22</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$6,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6641" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6641" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31871" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('31871_13002')">Charles Sims</div></td>
<td class="player-fppg">4.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$6,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31871" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31871" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31561" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('31561_13002')">Donte Moncrief</div></td>
<td class="player-fppg">13.6</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$6,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31561" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31561" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7660" data-role="player" data-position="RB" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('7660_13002')">Fred Jackson</div></td>
<td class="player-fppg">3.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$6,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7660" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7660" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33557" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('33557_13002')">Tyler Eifert</div></td>
<td class="player-fppg">26.9</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$5,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33557" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33557" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6803" data-role="player" data-position="QB" data-fixture="99662" class="pR injured fixtureId_99662 teamId_7   news-breaking">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6803_13002')">Josh McCown<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">2.3</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$5,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6803" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6803" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6883" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6883_13002')">Larry Fitzgerald</div></td>
<td class="player-fppg">11.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$5,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6883" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6883" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14288" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14288_13002')">Torrey Smith</div></td>
<td class="player-fppg">1.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$5,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14288" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14288" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7844" data-role="player" data-position="QB" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('7844_13002')">Chad Henne</div></td>
<td class="player-fppg">10.4</td>
<td class="player-played">3</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$5,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7844" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7844" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54684" data-role="player" data-position="RB" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('54684_13002')">Isaiah Crowell</div></td>
<td class="player-fppg">4.3</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$5,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54684" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54684" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39649" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('39649_13002')">Benny Cunningham</div></td>
<td class="player-fppg">14.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$5,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39649" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39649" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6704" data-role="player" data-position="WR" data-fixture="99658" class="pR injured fixtureId_99658 teamId_4   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6704_13002')">Percy Harvin<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">17.3</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6704" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6704" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6566" data-role="player" data-position="RB" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6566_13002')">Chris Johnson</div></td>
<td class="player-fppg">3.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6566" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6566" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29683" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('29683_13002')">Nelson Agholor</div></td>
<td class="player-fppg">1</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29683" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29683" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28643" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('28643_13002')">Allen Robinson</div></td>
<td class="player-fppg">3.2</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28643" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28643" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22038" data-role="player" data-position="QB" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('22038_13002')">Kirk Cousins</div></td>
<td class="player-fppg">9.7</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22038" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22038" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7645" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7645_13002')">Steve Johnson</div></td>
<td class="player-fppg">17.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7645" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7645" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22288" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22288_13002')">Cole Beasley</div></td>
<td class="player-fppg">4.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22288" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22288" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7053" data-role="player" data-position="QB" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('7053_13002')">Matt Flynn</div></td>
<td class="player-fppg">-0.2</td>
<td class="player-played">7</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7053" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7053" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11425" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11425_13002')">Ryan Mathews</div></td>
<td class="player-fppg">10.3</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11425" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11425" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31406" data-role="player" data-position="RB" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('31406_13002')">Alfred Blue</div></td>
<td class="player-fppg">5.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$5,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31406" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31406" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22047" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22047_13002')">Ladarius Green</div></td>
<td class="player-fppg">15.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$5,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22047" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22047" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21952" data-role="player" data-position="WR" data-fixture="99660" class="pR injured fixtureId_99660 teamId_29   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('21952_13002')">Michael Floyd<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">2.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$5,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21952" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21952" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7972" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('7972_13002')">Darren Sproles</div></td>
<td class="player-fppg">16.1</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$5,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7972" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7972" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31421" data-role="player" data-position="QB" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('31421_13002')">Zach Mettenberger</div></td>
<td class="player-fppg">-0.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$5,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31421" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31421" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54608" data-role="player" data-position="RB" data-fixture="99663" class="pR injured fixtureId_99663 teamId_21   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('54608_13002')">Jerick McKinnon<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">3.8</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$5,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54608" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54608" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25837" data-role="player" data-position="RB" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('25837_13002')">Duke Johnson</div></td>
<td class="player-fppg">2.2</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$5,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25837" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25837" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28677" data-role="player" data-position="QB" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('28677_13002')">Matt McGloin</div></td>
<td class="player-fppg">10.7</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$5,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28677" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28677" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26141" data-role="player" data-position="QB" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('26141_13002')">Ryan Nassib</div></td>
<td class="player-fppg">0.5</td>
<td class="player-played">4</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$5,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26141" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26141" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21959" data-role="player" data-position="QB" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('21959_13002')">Brandon Weeden</div></td>
<td class="player-fppg">4.2</td>
<td class="player-played">5</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$5,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21959" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21959" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14292" data-role="player" data-position="TE" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('14292_13002')">Jordan Cameron</div></td>
<td class="player-fppg">9.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$5,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14292" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14292" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_9392" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('9392_13002')">Michael Crabtree</div></td>
<td class="player-fppg">6.2</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$5,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="9392" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="9392" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14268" data-role="player" data-position="RB" data-fixture="99776" class="pR injured fixtureId_99776 teamId_1   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14268_13002')">Stevan Ridley<span class="player-badge player-badge-injured-out">NA</span></div></td>
<td class="player-fppg">8.3</td>
<td class="player-played">6</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14268" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14268" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28088" data-role="player" data-position="RB" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('28088_13002')">Denard Robinson</div></td>
<td class="player-fppg">5.5</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28088" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28088" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14194" data-role="player" data-position="QB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14194_13002')">Blaine Gabbert</div></td>
<td class="player-fppg">6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14194" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14194" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22848" data-role="player" data-position="QB" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('22848_13002')">Austin Davis</div></td>
<td class="player-fppg">11.7</td>
<td class="player-played">10</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22848" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22848" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39449" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('39449_13002')">Charles Johnson</div></td>
<td class="player-fppg">3.7</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39449" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39449" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21999" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('21999_13002')">Rueben Randle</div></td>
<td class="player-fppg">3.8</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21999" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21999" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14317" data-role="player" data-position="TE" data-fixture="99668" class="pR injured fixtureId_99668 teamId_12   news-breaking">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('14317_13002')">Julius Thomas<span class="player-badge player-badge-injured-out">O</span></div></td>
<td class="player-fppg">11</td>
<td class="player-played">13</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14317" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14317" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22219" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22219_13002')">Jermaine Kearse</div></td>
<td class="player-fppg">11.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22219" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22219" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6580" data-role="player" data-position="TE" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6580_13002')">Heath Miller</div></td>
<td class="player-fppg">12.4</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6580" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6580" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14305" data-role="player" data-position="RB" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14305_13002')">Roy Helu</div></td>
<td class="player-fppg">7.6</td>
<td class="player-played">14</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14305" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14305" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6808" data-role="player" data-position="QB" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6808_13002')">Matt Moore</div></td>
<td class="player-fppg">0.3</td>
<td class="player-played">2</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6808" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6808" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6774" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6774_13002')">Pierre Garcon</div></td>
<td class="player-fppg">10.4</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6774" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6774" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6662" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6662_13002')">Reggie Wayne</div></td>
<td class="player-fppg">8</td>
<td class="player-played">15</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6662" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6662" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7222" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7222_13002')">James Jones</div></td>
<td class="player-fppg">19.1</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$5,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7222" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7222" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27441" data-role="player" data-position="RB" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27441_13002')">Damien Williams</div></td>
<td class="player-fppg">0.8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27441" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27441" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11466" data-role="player" data-position="QB" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('11466_13002')">Jimmy Clausen</div></td>
<td class="player-fppg">4.2</td>
<td class="player-played">4</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11466" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11466" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21972" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('21972_13002')">Brian Quick</div></td>
<td class="player-fppg">9.7</td>
<td class="player-played">7</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21972" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21972" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6643" data-role="player" data-position="RB" data-fixture="99666" class="pR injured fixtureId_99666 teamId_30   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6643_13002')">Reggie Bush<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">0.8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6643" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6643" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25607" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('25607_13002')">Josh Harris</div></td>
<td class="player-fppg">0.3</td>
<td class="player-played">5</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25607" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25607" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11431" data-role="player" data-position="TE" data-fixture="99660" class="pR injured fixtureId_99660 teamId_29   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11431_13002')">Jermaine Gresham<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">0.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11431" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11431" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25694" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('25694_13002')">Andre Williams</div></td>
<td class="player-fppg">1.4</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25694" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25694" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54612" data-role="player" data-position="RB" data-fixture="99669" class="pR injured fixtureId_99669 teamId_6   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('54612_13002')">Lorenzo Taliaferro<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">5.1</td>
<td class="player-played">13</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54612" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54612" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30244" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('30244_13002')">Matt Jones</div></td>
<td class="player-fppg">2.8</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30244" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30244" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6679" data-role="player" data-position="QB" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6679_13002')">Matt Schaub</div></td>
<td class="player-fppg">0.1</td>
<td class="player-played">11</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6679" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6679" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_38269" data-role="player" data-position="RB" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('38269_13002')">Cameron Artis-Payne</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="38269" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="38269" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54607" data-role="player" data-position="RB" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('54607_13002')">Terrance West</div></td>
<td class="player-fppg">2.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54607" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54607" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21123" data-role="player" data-position="TE" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('21123_13002')">Larry Donnell</div></td>
<td class="player-fppg">3.6</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21123" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21123" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6645" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6645_13002')">Marques Colston</div></td>
<td class="player-fppg">4.4</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$5,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6645" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6645" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7761" data-role="player" data-position="TE" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('7761_13002')">Jared Cook</div></td>
<td class="player-fppg">11</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7761" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7761" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_8071" data-role="player" data-position="QB" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('8071_13002')">Dan Orlovsky</div></td>
<td class="player-fppg">2.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="8071" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="8071" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14307" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14307_13002')">Cecil Shorts</div></td>
<td class="player-fppg">7.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14307" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14307" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7744" data-role="player" data-position="QB" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('7744_13002')">Drew Stanton</div></td>
<td class="player-fppg">10.9</td>
<td class="player-played">9</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7744" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7744" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6373" data-role="player" data-position="QB" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6373_13002')">Derek Anderson</div></td>
<td class="player-fppg">8.4</td>
<td class="player-played">6</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6373" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6373" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14339" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14339_13002')">Dion Lewis</div></td>
<td class="player-fppg">14</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14339" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14339" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14320" data-role="player" data-position="RB" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14320_13002')">Bilal Powell</div></td>
<td class="player-fppg">8.8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14320" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14320" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_8051" data-role="player" data-position="QB" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('8051_13002')">Luke McCown</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="8051" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="8051" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33260" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('33260_13002')">DeVante Parker</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33260" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33260" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6863" data-role="player" data-position="TE" data-fixture="99662" class="pR injured fixtureId_99662 teamId_9   news-breaking">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6863_13002')">Delanie Walker<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">11.8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6863" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6863" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7919" data-role="player" data-position="QB" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('7919_13002')">Kellen Clemens</div></td>
<td class="player-fppg">3.4</td>
<td class="player-played">2</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7919" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7919" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22004" data-role="player" data-position="TE" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22004_13002')">Dwayne Allen</div></td>
<td class="player-fppg">9.2</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22004" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22004" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14198" data-role="player" data-position="QB" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14198_13002')">Christian Ponder</div></td>
<td class="player-fppg">6.7</td>
<td class="player-played">2</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14198" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14198" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7900" data-role="player" data-position="K" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('7900_13002')">Stephen Gostkowski</div></td>
<td class="player-fppg">4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7900" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7900" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34295" data-role="player" data-position="WR" data-fixture="99669" class="pR injured fixtureId_99669 teamId_6   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('34295_13002')">Breshad Perriman<span class="player-badge player-badge-injured-out">O</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34295" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34295" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6535" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6535_13002')">Kenny Britt</div></td>
<td class="player-fppg">4.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6535" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6535" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_23045" data-role="player" data-position="K" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-old">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('23045_13002')">Justin Tucker</div></td>
<td class="player-fppg">10</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="23045" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="23045" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_47294" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('47294_13002')">Terrence Franks</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="47294" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="47294" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27457" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('27457_13002')">Kenny Stills</div></td>
<td class="player-fppg">1.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27457" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27457" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6814" data-role="player" data-position="QB" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6814_13002')">Tarvaris Jackson</div></td>
<td class="player-fppg">6.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6814" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6814" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28249" data-role="player" data-position="RB" data-fixture="99662" class="pR injured fixtureId_99662 teamId_9   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('28249_13002')">David Cobb<span class="player-badge player-badge-injured-out">IR</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28249" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28249" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6488" data-role="player" data-position="WR" data-fixture="99662" class="pR injured fixtureId_99662 teamId_7   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6488_13002')">Dwayne Bowe<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">7.1</td>
<td class="player-played">15</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6488" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6488" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29645" data-role="player" data-position="RB" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('29645_13002')">Javorius Allen</div></td>
<td class="player-fppg">3.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29645" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29645" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29780" data-role="player" data-position="TE" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('29780_13002')">Zach Ertz</div></td>
<td class="player-fppg">6.1</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29780" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29780" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11609" data-role="player" data-position="RB" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11609_13002')">James Starks</div></td>
<td class="player-fppg">0.2</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11609" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11609" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25813" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('25813_13002')">Phillip Dorsett</div></td>
<td class="player-fppg">3.5</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25813" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25813" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_46882" data-role="player" data-position="RB" data-fixture="99668" class="pR injured fixtureId_99668 teamId_2   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('46882_13002')">Jay Ajayi<span class="player-badge player-badge-injured-out">IR</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$5,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="46882" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="46882" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29003" data-role="player" data-position="RB" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('29003_13002')">Ka'Deem Carey</div></td>
<td class="player-fppg">1.7</td>
<td class="player-played">14</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29003" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29003" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14696" data-role="player" data-position="QB" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14696_13002')">Scott Tolzien</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14696" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14696" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6724" data-role="player" data-position="K" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-old">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6724_13002')">Steven Hauschka</div></td>
<td class="player-fppg">11</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6724" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6724" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7952" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7952_13002')">Malcom Floyd</div></td>
<td class="player-fppg">3.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7952" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7952" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6897" data-role="player" data-position="K" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6897_13002')">Mason Crosby</div></td>
<td class="player-fppg">7</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6897" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6897" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29500" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('29500_13002')">Markus Wheaton</div></td>
<td class="player-fppg">9</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29500" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29500" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14344" data-role="player" data-position="QB" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('14344_13002')">T.J. Yates</div></td>
<td class="player-fppg">1.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14344" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14344" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29685" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('29685_13002')">Robert Woods</div></td>
<td class="player-fppg">3.7</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29685" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29685" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6870" data-role="player" data-position="TE" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6870_13002')">Vernon Davis</div></td>
<td class="player-fppg">6.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6870" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6870" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39373" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('39373_13002')">Jaelen Strong</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39373" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39373" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12539" data-role="player" data-position="D" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12539_13002')">Miami Dolphins</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12539" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12539" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_41807" data-role="player" data-position="RB" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('41807_13002')">Michael Dyer</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="41807" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="41807" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14237" data-role="player" data-position="TE" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('14237_13002')">Kyle Rudolph</div></td>
<td class="player-fppg">7.8</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14237" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14237" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22898" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22898_13002')">Brandon Bolden</div></td>
<td class="player-fppg">1.8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22898" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22898" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_44952" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('44952_13002')">Dri Archer</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="44952" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="44952" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22054" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22054_13002')">Jarius Wright</div></td>
<td class="player-fppg">3.2</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22054" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22054" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25410" data-role="player" data-position="QB" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('25410_13002')">Mike Glennon</div></td>
<td class="player-fppg">15.9</td>
<td class="player-played">6</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25410" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25410" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31047" data-role="player" data-position="QB" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('31047_13002')">AJ McCarron</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31047" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31047" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6844" data-role="player" data-position="QB" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6844_13002')">Shaun Hill</div></td>
<td class="player-fppg">10.8</td>
<td class="player-played">9</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$5,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6844" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6844" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6702" data-role="player" data-position="K" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6702_13002')">Phil Dawson</div></td>
<td class="player-fppg">8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6702" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6702" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31280" data-role="player" data-position="K" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('31280_13002')">Cody Parkey</div></td>
<td class="player-fppg">6</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31280" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31280" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22128" data-role="player" data-position="QB" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('22128_13002')">Ryan Lindley</div></td>
<td class="player-fppg">9.1</td>
<td class="player-played">3</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22128" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22128" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22165" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22165_13002')">Bryce Brown</div></td>
<td class="player-fppg">5.2</td>
<td class="player-played">7</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22165" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22165" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25760" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('25760_13002')">Allen Hurns</div></td>
<td class="player-fppg">6.5</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25760" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25760" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14761" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14761_13002')">Andre Holmes</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14761" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14761" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28930" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('28930_13002')">James White</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28930" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28930" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6688" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6688_13002')">Jerricho Cotchery</div></td>
<td class="player-fppg">12.5</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6688" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6688" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30298" data-role="player" data-position="TE" data-fixture="99667" class="pR injured fixtureId_99667 teamId_20   news-breaking">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('30298_13002')">Jordan Reed<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">15.8</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30298" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30298" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27050" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('27050_13002')">Tyler Lockett</div></td>
<td class="player-fppg">11.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27050" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27050" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26094" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('26094_13002')">Brandon Coleman</div></td>
<td class="player-fppg">12.1</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26094" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26094" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14952" data-role="player" data-position="K" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('14952_13002')">Dan Bailey</div></td>
<td class="player-fppg">9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14952" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14952" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22018" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22018_13002')">Mohamed Sanu</div></td>
<td class="player-fppg">4.4</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22018" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22018" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6668" data-role="player" data-position="K" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6668_13002')">Adam Vinatieri</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6668" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6668" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22035" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22035_13002')">Travis Benjamin</div></td>
<td class="player-fppg">16.4</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22035" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22035" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12555" data-role="player" data-position="D" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12555_13002')">Baltimore Ravens</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12555" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12555" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11436" data-role="player" data-position="QB" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('11436_13002')">Tim Tebow</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11436" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11436" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39492" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('39492_13002')">Josh Hill</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39492" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39492" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11454" data-role="player" data-position="RB" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11454_13002')">Dexter McCluster</div></td>
<td class="player-fppg">0.8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11454" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11454" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_10647" data-role="player" data-position="K" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-old">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('10647_13002')">Matt Bryant</div></td>
<td class="player-fppg">17</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="10647" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="10647" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11562" data-role="player" data-position="TE" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11562_13002')">Andrew Quarless</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$5,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11562" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11562" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21971" data-role="player" data-position="TE" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('21971_13002')">Coby Fleener</div></td>
<td class="player-fppg">3</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21971" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21971" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21984" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('21984_13002')">Isaiah Pead</div></td>
<td class="player-fppg">-1.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21984" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21984" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6610" data-role="player" data-position="WR" data-fixture="99659" class="pR injured fixtureId_99659 teamId_11   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6610_13002')">Nate Washington<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">13.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6610" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6610" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14757" data-role="player" data-position="RB" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14757_13002')">Matt Asiata</div></td>
<td class="player-fppg">4.2</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14757" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14757" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14905" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14905_13002')">Kamar Aiken</div></td>
<td class="player-fppg">0.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14905" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14905" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12538" data-role="player" data-position="D" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12538_13002')">St Louis Rams</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12538" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12538" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27134" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('27134_13002')">Dorial Green-Beckham</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27134" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27134" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28080" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('28080_13002')">Devin Funchess</div></td>
<td class="player-fppg">1.4</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28080" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28080" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_47953" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('47953_13002')">Lucky Whitehead</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="47953" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="47953" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26458" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('26458_13002')">Tavon Austin</div></td>
<td class="player-fppg">14.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26458" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26458" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30807" data-role="player" data-position="TE" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('30807_13002')">Mychal Rivera</div></td>
<td class="player-fppg">0.9</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30807" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30807" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22163" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22163_13002')">Rishard Matthews</div></td>
<td class="player-fppg">11.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22163" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22163" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_10158" data-role="player" data-position="TE" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('10158_13002')">Scott Chandler</div></td>
<td class="player-fppg">6.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="10158" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="10158" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32354" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('32354_13002')">Malcome Kennedy</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32354" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32354" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39900" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('39900_13002')">Khiry Robinson</div></td>
<td class="player-fppg">9.5</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39900" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39900" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34275" data-role="player" data-position="RB" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('34275_13002')">Storm Johnson</div></td>
<td class="player-fppg">3.5</td>
<td class="player-played">6</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34275" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34275" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34288" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('34288_13002')">Rannell Hall</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34288" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34288" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_37245" data-role="player" data-position="RB" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('37245_13002')">Foswhitt Whittaker</div></td>
<td class="player-fppg">1.5</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="37245" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="37245" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_38301" data-role="player" data-position="TE" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('38301_13002')">Darren Fells</div></td>
<td class="player-fppg">16.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,900</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="38301" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="38301" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22187" data-role="player" data-position="QB" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('22187_13002')">Chandler Harnish</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22187" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22187" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6636" data-role="player" data-position="K" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6636_13002')">Mike Nugent</div></td>
<td class="player-fppg">9</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6636" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6636" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22994" data-role="player" data-position="QB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('22994_13002')">Case Keenum</div></td>
<td class="player-fppg">12.5</td>
<td class="player-played">2</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22994" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22994" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25272" data-role="player" data-position="TE" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('25272_13002')">Eric Ebron</div></td>
<td class="player-fppg">13.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25272" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25272" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22958" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22958_13002')">Bobby Rainey</div></td>
<td class="player-fppg">1.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22958" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22958" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7788" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7788_13002')">Louis Murphy</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7788" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7788" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24891" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('24891_13002')">Chris Thompson</div></td>
<td class="player-fppg">1.1</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24891" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24891" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11500" data-role="player" data-position="QB" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('11500_13002')">Colt McCoy</div></td>
<td class="player-fppg">13.2</td>
<td class="player-played">5</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11500" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11500" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_10030" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('10030_13002')">Harry Douglas</div></td>
<td class="player-fppg">9.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="10030" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="10030" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22100" data-role="player" data-position="K" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('22100_13002')">Randy Bullock</div></td>
<td class="player-fppg">7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22100" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22100" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6884" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6884_13002')">Hakeem Nicks</div></td>
<td class="player-fppg">5.2</td>
<td class="player-played">16</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6884" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6884" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6387" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6387_13002')">Miles Austin</div></td>
<td class="player-fppg">3.2</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6387" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6387" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22109" data-role="player" data-position="K" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('22109_13002')">Greg Zuerlein</div></td>
<td class="player-fppg">10</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22109" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22109" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11761" data-role="player" data-position="QB" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('11761_13002')">Thaddeus Lewis</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11761" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11761" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11479" data-role="player" data-position="RB" data-fixture="99668" class="pR injured fixtureId_99668 teamId_12   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11479_13002')">Toby Gerhart<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">5.1</td>
<td class="player-played">14</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11479" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11479" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6831" data-role="player" data-position="QB" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('6831_13002')">Matt Hasselbeck</div></td>
<td class="player-fppg">4.2</td>
<td class="player-played">4</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6831" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6831" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6768" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6768_13002')">Eddie Royal</div></td>
<td class="player-fppg">1.3</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6768" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6768" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14362" data-role="player" data-position="TE" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('14362_13002')">Charles Clay</div></td>
<td class="player-fppg">6.3</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14362" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14362" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24760" data-role="player" data-position="QB" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('24760_13002')">Sean Renfree</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24760" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24760" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_43956" data-role="player" data-position="QB" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('43956_13002')">David Fales</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="43956" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="43956" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_8023" data-role="player" data-position="QB" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('8023_13002')">Josh Johnson</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="8023" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="8023" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_45797" data-role="player" data-position="QB" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('45797_13002')">Garrett Grayson</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="45797" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="45797" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6910" data-role="player" data-position="K" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6910_13002')">Robbie Gould</div></td>
<td class="player-fppg">14</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6910" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6910" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11615" data-role="player" data-position="QB" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('11615_13002')">Joe Webb</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11615" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11615" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_10354" data-role="player" data-position="RB" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('10354_13002')">Marcel Reece</div></td>
<td class="player-fppg">16.1</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="10354" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="10354" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31798" data-role="player" data-position="QB" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('31798_13002')">Bryce Petty</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31798" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31798" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29605" data-role="player" data-position="QB" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('29605_13002')">Matt Barkley</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29605" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29605" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6810" data-role="player" data-position="K" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6810_13002')">Dan Carpenter</div></td>
<td class="player-fppg">11</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6810" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6810" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30910" data-role="player" data-position="RB" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('30910_13002')">Zac Stacy</div></td>
<td class="player-fppg">4.3</td>
<td class="player-played">13</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30910" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30910" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22774" data-role="player" data-position="RB" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22774_13002')">Jonas Gray</div></td>
<td class="player-fppg">9.1</td>
<td class="player-played">8</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22774" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22774" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26355" data-role="player" data-position="QB" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('26355_13002')">Logan Thomas</div></td>
<td class="player-fppg">3.6</td>
<td class="player-played">2</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26355" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26355" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29445" data-role="player" data-position="QB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('29445_13002')">Sean Mannion</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29445" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29445" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26498" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('26498_13002')">Stedman Bailey</div></td>
<td class="player-fppg">7.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26498" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26498" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_47640" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('47640_13002')">Branden Oliver</div></td>
<td class="player-fppg">2.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="47640" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="47640" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54705" data-role="player" data-position="QB" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('54705_13002')">Dustin Vaughan</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54705" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54705" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29915" data-role="player" data-position="QB" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-old">
<td class="player-position">QB</td>
<td class="player-name"><div onclick="sSts('29915_13002')">Brett Hundley</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29915" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29915" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7975" data-role="player" data-position="RB" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('7975_13002')">Mike Tolbert</div></td>
<td class="player-fppg">2.3</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7975" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7975" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22292" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22292_13002')">Lance Dunbar</div></td>
<td class="player-fppg">11</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,800</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22292" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22292" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6664" data-role="player" data-position="TE" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6664_13002')">Jacob Tamme</div></td>
<td class="player-fppg">3.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6664" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6664" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11766" data-role="player" data-position="TE" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11766_13002')">Jeff Cumberland</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11766" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11766" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14369" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14369_13002')">Jordan Todman</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14369" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14369" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22762" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22762_13002')">Chris Owusu</div></td>
<td class="player-fppg">7.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22762" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22762" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12553" data-role="player" data-position="D" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12553_13002')">Carolina Panthers</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12553" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12553" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6896" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6896_13002')">Greg Jennings</div></td>
<td class="player-fppg">4.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6896" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6896" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6782" data-role="player" data-position="K" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-old">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6782_13002')">Matt Prater</div></td>
<td class="player-fppg">4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6782" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6782" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22234" data-role="player" data-position="RB" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22234_13002')">Chris Polk</div></td>
<td class="player-fppg">3.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22234" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22234" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12550" data-role="player" data-position="D" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12550_13002')">Seattle Seahawks</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12550" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12550" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24907" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('24907_13002')">Karlos Williams</div></td>
<td class="player-fppg">11.5</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24907" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24907" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7831" data-role="player" data-position="K" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('7831_13002')">Sebastian Janikowski</div></td>
<td class="player-fppg">1</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7831" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7831" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30733" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('30733_13002')">Cordarrelle Patterson</div></td>
<td class="player-fppg">0.6</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30733" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30733" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22110" data-role="player" data-position="K" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('22110_13002')">Blair Walsh</div></td>
<td class="player-fppg">3</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22110" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22110" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29314" data-role="player" data-position="TE" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-breaking">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('29314_13002')">Richard Rodgers</div></td>
<td class="player-fppg">5.3</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29314" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29314" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14274" data-role="player" data-position="TE" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('14274_13002')">Rob Housler</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14274" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14274" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29734" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('29734_13002')">Ty Montgomery</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29734" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29734" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11577" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11577_13002')">Riley Cooper</div></td>
<td class="player-fppg">4</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11577" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11577" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6672" data-role="player" data-position="TE" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6672_13002')">Marcedes Lewis</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6672" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6672" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6627" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6627_13002')">Ted Ginn Jr.</div></td>
<td class="player-fppg">6.4</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6627" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6627" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33137" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('33137_13002')">Justin Hardy</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33137" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33137" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24569" data-role="player" data-position="K" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('24569_13002')">Chandler Catanzaro</div></td>
<td class="player-fppg">8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24569" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24569" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24862" data-role="player" data-position="WR" data-fixture="99668" class="pR injured fixtureId_99668 teamId_12   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('24862_13002')">Rashad Greene<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">12.3</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24862" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24862" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22048" data-role="player" data-position="RB" data-fixture="99662" class="pR injured fixtureId_99662 teamId_7   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22048_13002')">Robert Turbin<span class="player-badge player-badge-injured-out">O</span></div></td>
<td class="player-fppg">4.2</td>
<td class="player-played">16</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,700</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22048" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22048" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_44351" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('44351_13002')">L.T. Smith</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="44351" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="44351" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12546" data-role="player" data-position="D" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12546_13002')">Arizona Cardinals</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12546" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12546" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12529" data-role="player" data-position="D" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12529_13002')">Cleveland Browns</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12529" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12529" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6676" data-role="player" data-position="K" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6676_13002')">Josh Scobee</div></td>
<td class="player-fppg">8</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6676" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6676" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6904" data-role="player" data-position="WR" data-fixture="99665" class="pR injured fixtureId_99665 teamId_27   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6904_13002')">Devin Hester<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">5.9</td>
<td class="player-played">16</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6904" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6904" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12534" data-role="player" data-position="D" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12534_13002')">Tennessee Titans</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12534" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12534" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14301" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14301_13002')">Kendall Hunter</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14301" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14301" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28144" data-role="player" data-position="TE" data-fixture="99668" class="pR injured fixtureId_99668 teamId_2   news-breaking">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('28144_13002')">Dion Sims<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28144" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28144" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_10744" data-role="player" data-position="K" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('10744_13002')">Graham Gano</div></td>
<td class="player-fppg">10</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="10744" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="10744" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_8117" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('8117_13002')">Danny Amendola</div></td>
<td class="player-fppg">3.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="8117" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="8117" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6642" data-role="player" data-position="K" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6642_13002')">Nick Folk</div></td>
<td class="player-fppg">7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6642" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6642" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12556" data-role="player" data-position="D" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12556_13002')">Houston Texans</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12556" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12556" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28502" data-role="player" data-position="WR" data-fixture="99776" class="pR injured fixtureId_99776 teamId_1   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('28502_13002')">Devin Smith<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28502" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28502" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11538" data-role="player" data-position="TE" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11538_13002')">Garrett Graham</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11538" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11538" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14240" data-role="player" data-position="TE" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('14240_13002')">Lance Kendricks</div></td>
<td class="player-fppg">11.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14240" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14240" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29593" data-role="player" data-position="WR" data-fixture="99668" class="pR injured fixtureId_99668 teamId_12   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('29593_13002')">Marqise Lee<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">5.2</td>
<td class="player-played">13</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29593" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29593" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11556" data-role="player" data-position="TE" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11556_13002')">Michael Hoomanawanui</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11556" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11556" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_15176" data-role="player" data-position="K" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('15176_13002')">Kai Forbath</div></td>
<td class="player-fppg">5</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="15176" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="15176" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29827" data-role="player" data-position="TE" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('29827_13002')">Joseph Fauria</div></td>
<td class="player-fppg">2.6</td>
<td class="player-played">7</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29827" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29827" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28346" data-role="player" data-position="TE" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('28346_13002')">Maxx Williams</div></td>
<td class="player-fppg">2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28346" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28346" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6767" data-role="player" data-position="K" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6767_13002')">Ryan Succop</div></td>
<td class="player-fppg">6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6767" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6767" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12528" data-role="player" data-position="D" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12528_13002')">Cincinnati Bengals</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12528" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12528" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22228" data-role="player" data-position="TE" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22228_13002')">Chase Ford</div></td>
<td class="player-fppg">3.9</td>
<td class="player-played">11</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22228" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22228" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6778" data-role="player" data-position="TE" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6778_13002')">Anthony Fasano</div></td>
<td class="player-fppg">2.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,600</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6778" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6778" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_64160" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('64160_13002')">Arthur Williams</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="64160" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="64160" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30385" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('30385_13002')">Marlon Brown</div></td>
<td class="player-fppg">3.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30385" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30385" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39411" data-role="player" data-position="TE" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('39411_13002')">Gavin Escobar</div></td>
<td class="player-fppg">7.8</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39411" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39411" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30805" data-role="player" data-position="K" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('30805_13002')">Michael Palardy</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30805" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30805" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39427" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('39427_13002')">Quinton Patton</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39427" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39427" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_65926" data-role="player" data-position="TE" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-none">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('65926_13002')">Anthony Ezeakunne</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="65926" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="65926" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29728" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-none">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('29728_13002')">Ricky Seale</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29728" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29728" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30414" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('30414_13002')">Michael Bennett</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30414" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30414" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_64045" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('64045_13002')">Trent Steelman</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="64045" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="64045" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54623" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('54623_13002')">Jeff Janis</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54623" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54623" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_64046" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('64046_13002')">Ed Williams</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="64046" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="64046" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30775" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('30775_13002')">Justin Hunter</div></td>
<td class="player-fppg">1.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30775" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30775" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_46001" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('46001_13002')">Joey Iosefa</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="46001" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="46001" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30108" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('30108_13002')">Marquess Wilson</div></td>
<td class="player-fppg">6.9</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30108" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30108" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30598" data-role="player" data-position="TE" data-fixture="99666" class="pR injured fixtureId_99666 teamId_30   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('30598_13002')">Rory Anderson<span class="player-badge player-badge-injured-out">IR</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30598" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30598" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30709" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('30709_13002')">Bruce Ellington</div></td>
<td class="player-fppg">1.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30709" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30709" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30667" data-role="player" data-position="TE" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('30667_13002')">Justice Cunningham</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30667" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30667" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_47828" data-role="player" data-position="RB" data-fixture="99662" class="pR injured fixtureId_99662 teamId_9   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('47828_13002')">Antonio Andrews<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">0.5</td>
<td class="player-played">4</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="47828" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="47828" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30297" data-role="player" data-position="TE" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('30297_13002')">Trey Burton</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30297" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30297" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30591" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('30591_13002')">Ace Sanders</div></td>
<td class="player-fppg">1</td>
<td class="player-played">12</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30591" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30591" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54663" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('54663_13002')">Seantavius Jones</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54663" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54663" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_30635" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('30635_13002')">Mike Davis</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="30635" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="30635" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54782" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-none">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('54782_13002')">Cameron Brate</div></td>
<td class="player-fppg">0.4</td>
<td class="player-played">5</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54782" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54782" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_64104" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-none">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('64104_13002')">Terrell Watson</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="64104" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="64104" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29994" data-role="player" data-position="K" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('29994_13002')">Travis Coons</div></td>
<td class="player-fppg">4</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29994" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29994" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_38517" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('38517_13002')">Dreamius Smith</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="38517" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="38517" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_44163" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('44163_13002')">James Butler</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="44163" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="44163" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39512" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-none">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('39512_13002')">Kendall Gaskins</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39512" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39512" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_60800" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('60800_13002')">Jarryd Hayne</div></td>
<td class="player-fppg">0.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="60800" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="60800" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33232" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('33232_13002')">Dominique Brown</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33232" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33232" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33242" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('33242_13002')">Kai De La Cruz</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33242" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33242" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_59424" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-none">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('59424_13002')">Taylor Sloat</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="59424" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="59424" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_60745" data-role="player" data-position="K" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('60745_13002')">Jason Myers</div></td>
<td class="player-fppg">3</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="60745" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="60745" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33037" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('33037_13002')">Kenbrell Thompkins</div></td>
<td class="player-fppg">2.7</td>
<td class="player-played">14</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33037" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33037" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39539" data-role="player" data-position="TE" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-none">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('39539_13002')">Brian Leonhardt</div></td>
<td class="player-fppg">1</td>
<td class="player-played">12</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39539" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39539" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32429" data-role="player" data-position="K" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('32429_13002')">Josh Lambo</div></td>
<td class="player-fppg">9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32429" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32429" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32418" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('32418_13002')">Christine Michael</div></td>
<td class="player-fppg">1.9</td>
<td class="player-played">10</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32418" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32418" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39615" data-role="player" data-position="TE" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('39615_13002')">Brandon Williams</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39615" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39615" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_62505" data-role="player" data-position="TE" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('62505_13002')">MyCole Pruitt</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="62505" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="62505" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33007" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('33007_13002')">Blake Annen</div></td>
<td class="player-fppg">0</td>
<td class="player-played">5</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33007" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33007" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_57348" data-role="player" data-position="RB" data-fixture="99662" class="pR injured fixtureId_99662 teamId_7   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('57348_13002')">Glenn Winston<span class="player-badge player-badge-injured-out">O</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">5</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="57348" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="57348" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34154" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('34154_13002')">Jamarcus Nelson</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34154" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34154" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33703" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('33703_13002')">Ryan Grant</div></td>
<td class="player-fppg">2</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33703" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33703" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34125" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('34125_13002')">Geremy Davis</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34125" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34125" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33981" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('33981_13002')">Eric Frohnapfel</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33981" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33981" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39428" data-role="player" data-position="RB" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('39428_13002')">Kyle Juszczyk</div></td>
<td class="player-fppg">3.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39428" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39428" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34073" data-role="player" data-position="TE" data-fixture="99659" class="pR injured fixtureId_99659 teamId_11   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('34073_13002')">Ryan Griffin<span class="player-badge player-badge-injured-out">IR</span></div></td>
<td class="player-fppg">2.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34073" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34073" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39445" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('39445_13002')">Brice Butler</div></td>
<td class="player-fppg">3.4</td>
<td class="player-played">15</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39445" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39445" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33691" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('33691_13002')">Orleans Darkwa</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33691" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33691" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33465" data-role="player" data-position="RB" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('33465_13002')">Theo Riddick</div></td>
<td class="player-fppg">10.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33465" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33465" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_54753" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('54753_13002')">Taylor Gabriel</div></td>
<td class="player-fppg">3</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="54753" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="54753" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33488" data-role="player" data-position="TE" data-fixture="99660" class="pR injured fixtureId_99660 teamId_29   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('33488_13002')">Troy Niklas<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33488" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33488" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_33541" data-role="player" data-position="K" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('33541_13002')">Kyle Brindza</div></td>
<td class="player-fppg">2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="33541" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="33541" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_55536" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('55536_13002')">Tyler McDonald</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="55536" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="55536" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_62510" data-role="player" data-position="TE" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('62510_13002')">Nick Boyle</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="62510" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="62510" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32410" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('32410_13002')">Trey Williams</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32410" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32410" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_44560" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('44560_13002')">Alex Bayer</div></td>
<td class="player-fppg">0</td>
<td class="player-played">6</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="44560" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="44560" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31207" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('31207_13002')">C.J. Uzomah</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31207" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31207" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_44361" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('44361_13002')">Jawon Chisholm</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="44361" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="44361" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31241" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('31241_13002')">Sammie Coates</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31241" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31241" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_34014" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('34014_13002')">Aaron Dobson</div></td>
<td class="player-fppg">1.4</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="34014" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="34014" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_62631" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('62631_13002')">Gus Johnson</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="62631" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="62631" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31188" data-role="player" data-position="TE" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('31188_13002')">Chris Gragg</div></td>
<td class="player-fppg">1.4</td>
<td class="player-played">10</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31188" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31188" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31109" data-role="player" data-position="K" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('31109_13002')">Zach Hocker</div></td>
<td class="player-fppg">14</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31109" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31109" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_45723" data-role="player" data-position="TE" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('45723_13002')">Crockett Gillmore</div></td>
<td class="player-fppg">3.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="45723" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="45723" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31036" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('31036_13002')">Kevin Norwood</div></td>
<td class="player-fppg">1.6</td>
<td class="player-played">9</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31036" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31036" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_44791" data-role="player" data-position="RB" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('44791_13002')">Bronson Hill</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="44791" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="44791" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_44670" data-role="player" data-position="TE" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('44670_13002')">Deon Butler</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="44670" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="44670" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_63858" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('63858_13002')">AJ Cruz</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="63858" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="63858" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31329" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('31329_13002')">Russell Shepard</div></td>
<td class="player-fppg">1.1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31329" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31329" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_44090" data-role="player" data-position="RB" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('44090_13002')">Alonzo Harris</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="44090" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="44090" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32234" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('32234_13002')">Malcolm Brown</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32234" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32234" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32045" data-role="player" data-position="TE" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('32045_13002')">Vance McDonald</div></td>
<td class="player-fppg">1</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32045" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32045" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32243" data-role="player" data-position="WR" data-fixture="99658" class="pR injured fixtureId_99658 teamId_4   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('32243_13002')">Marquise Goodwin<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">0.6</td>
<td class="player-played">10</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32243" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32243" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39716" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('39716_13002')">Adam Thielen</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39716" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39716" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_62616" data-role="player" data-position="RB" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('62616_13002')">Zach Zenner</div></td>
<td class="player-fppg">0.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="62616" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="62616" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_62619" data-role="player" data-position="K" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-none">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('62619_13002')">Andrew Franks</div></td>
<td class="player-fppg">5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="62619" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="62619" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_32000" data-role="player" data-position="TE" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('32000_13002')">Luke Willson</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="32000" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="32000" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29725" data-role="player" data-position="TE" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('29725_13002')">Levine Toilolo</div></td>
<td class="player-fppg">0.9</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29725" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29725" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6422" data-role="player" data-position="TE" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6422_13002')">Gary Barnidge</div></td>
<td class="player-fppg">5.3</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6422" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6422" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_31675" data-role="player" data-position="RB" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('31675_13002')">Josh Robinson</div></td>
<td class="player-fppg">1.1</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="31675" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="31675" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_62628" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('62628_13002')">DeAndre Carter</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="62628" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="62628" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_39859" data-role="player" data-position="TE" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('39859_13002')">Jack Doyle</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="39859" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="39859" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_64014" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('64014_13002')">Avius Capers</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="64014" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="64014" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22144" data-role="player" data-position="WR" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22144_13002')">Tommy Streeter</div></td>
<td class="player-fppg">0</td>
<td class="player-played">2</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22144" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22144" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14265" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14265_13002')">Austin Pettis</div></td>
<td class="player-fppg">4.8</td>
<td class="player-played">5</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14265" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14265" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6597" data-role="player" data-position="TE" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6597_13002')">Craig Stevens</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6597" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6597" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14253" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14253_13002')">Greg Little</div></td>
<td class="player-fppg">1.9</td>
<td class="player-played">6</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14253" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14253" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14277" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14277_13002')">Vincent Brown</div></td>
<td class="player-fppg">2.5</td>
<td class="player-played">7</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14277" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14277" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14283" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14283_13002')">Leonard Hankerson</div></td>
<td class="player-fppg">2.6</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14283" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14283" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14302" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14302_13002')">Kris Durham</div></td>
<td class="player-fppg">2.1</td>
<td class="player-played">4</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14302" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14302" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14297" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14297_13002')">Greg Salas</div></td>
<td class="player-fppg">2.9</td>
<td class="player-played">10</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14297" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14297" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14230" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14230_13002')">Ryan Williams</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14230" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14230" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6622" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6622_13002')">Eric Weems</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6622" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6622" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12055" data-role="player" data-position="TE" data-fixture="99667" class="pR injured fixtureId_99667 teamId_20   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('12055_13002')">Logan Paulsen<span class="player-badge player-badge-injured-out">IR</span></div></td>
<td class="player-fppg">1.1</td>
<td class="player-played">16</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12055" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12055" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11870" data-role="player" data-position="WR" data-fixture="99670" class="pR injured fixtureId_99670 teamId_19   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11870_13002')">Seyi Ajirotutu<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11870" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11870" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12533" data-role="player" data-position="D" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12533_13002')">Green Bay Packers</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12533" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12533" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12535" data-role="player" data-position="D" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12535_13002')">Indianapolis Colts</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12535" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12535" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12903" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('12903_13002')">Andrew Hawkins</div></td>
<td class="player-fppg">3.9</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12903" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12903" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12542" data-role="player" data-position="D" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12542_13002')">New Orleans Saints</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12542" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12542" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14304" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('14304_13002')">Luke Stocker</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14304" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14304" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14336" data-role="player" data-position="RB" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14336_13002')">Jacquizz Rodgers</div></td>
<td class="player-fppg">1.6</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14336" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14336" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14704" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14704_13002')">Chris Hogan</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14704" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14704" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14683" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14683_13002')">Patrick DiMarco</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14683" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14683" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14815" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-breaking">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14815_13002')">Joseph Morgan</div></td>
<td class="player-fppg">3.6</td>
<td class="player-played">5</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14815" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14815" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14837" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14837_13002')">Jeremy Ross</div></td>
<td class="player-fppg">2.8</td>
<td class="player-played">16</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14837" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14837" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_15032" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('15032_13002')">Henry Hynoski</div></td>
<td class="player-fppg">0.1</td>
<td class="player-played">16</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="15032" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="15032" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_15006" data-role="player" data-position="RB" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('15006_13002')">Shaun Draughn</div></td>
<td class="player-fppg">0.4</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="15006" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="15006" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14649" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('14649_13002')">Kyle Miller</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14649" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14649" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29723" data-role="player" data-position="RB" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('29723_13002')">Stepfan Taylor</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29723" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29723" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14349" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14349_13002')">Jeremy Kerley</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14349" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14349" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14338" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14338_13002')">Denarius Moore</div></td>
<td class="player-fppg">1.6</td>
<td class="player-played">10</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14338" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14338" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14358" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14358_13002')">Dwayne Harris</div></td>
<td class="player-fppg">1.1</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14358" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14358" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14372" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14372_13002')">Aldrick Robinson</div></td>
<td class="player-fppg">0.2</td>
<td class="player-played">5</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14372" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14372" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14629" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14629_13002')">Ricardo Lockette</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14629" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14629" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14406" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('14406_13002')">Bruce Miller</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14406" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14406" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11829" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11829_13002')">Preston Parker</div></td>
<td class="player-fppg">3.6</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11829" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11829" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11718" data-role="player" data-position="WR" data-fixture="99666" class="pR injured fixtureId_99666 teamId_5   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11718_13002')">David Nelson<span class="player-badge player-badge-injured-out">IR</span></div></td>
<td class="player-fppg">1.8</td>
<td class="player-played">6</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11718" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11718" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7394" data-role="player" data-position="TE" data-fixture="99663" class="pR injured fixtureId_99663 teamId_24   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('7394_13002')">Brandon Pettigrew<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7394" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7394" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7244" data-role="player" data-position="RB" data-fixture="99671" class="pR  fixtureId_99671 teamId_23   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('7244_13002')">John Kuhn</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SEA@<b>GB</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7244" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7244" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7001" data-role="player" data-position="TE" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('7001_13002')">Kellen Davis</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7001" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7001" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7706" data-role="player" data-position="TE" data-fixture="99662" class="pR  fixtureId_99662 teamId_9   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('7706_13002')">Chase Coffman</div></td>
<td class="player-fppg">1.2</td>
<td class="player-played">13</td>
<td class="player-fixture"><b>TEN</b>@CLE</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7706" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7706" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7718" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('7718_13002')">Cedric Peerman</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7718" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7718" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7784" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7784_13002')">Darrius Heyward-Bey</div></td>
<td class="player-fppg">7.8</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7784" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7784" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7722" data-role="player" data-position="WR" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7722_13002')">Kevin Ogletree</div></td>
<td class="player-fppg">1.2</td>
<td class="player-played">7</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7722" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7722" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6868" data-role="player" data-position="TE" data-fixture="99665" class="pR injured fixtureId_99665 teamId_17   news-breaking">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6868_13002')">Daniel Fells<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">4.8</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6868" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6868" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6828" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6828_13002')">Tim Hightower</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6828" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6828" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6684" data-role="player" data-position="WR" data-fixture="99661" class="pR injured fixtureId_99661 teamId_14   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6684_13002')">Jacoby Jones<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6684" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6684" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6694" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6694_13002')">Joshua Cribbs</div></td>
<td class="player-fppg">1.4</td>
<td class="player-played">6</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6694" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6694" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6742" data-role="player" data-position="TE" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6742_13002')">Brent Celek</div></td>
<td class="player-fppg">1.1</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6742" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6742" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6783" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6783_13002')">Lance Moore</div></td>
<td class="player-fppg">2.7</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6783" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6783" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6823" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6823_13002')">John Phillips</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6823" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6823" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6809" data-role="player" data-position="WR" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('6809_13002')">Brian Hartline</div></td>
<td class="player-fppg">3</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6809" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6809" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7801" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('7801_13002')">Brandon Myers</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7801" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7801" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7856" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('7856_13002')">Matthew Slater</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7856" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7856" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11594" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11594_13002')">Anthony Dixon</div></td>
<td class="player-fppg">6.1</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11594" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11594" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11557" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11557_13002')">John Conner</div></td>
<td class="player-fppg">1</td>
<td class="player-played">12</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11557" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11557" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11622" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11622_13002')">Trindon Holliday</div></td>
<td class="player-fppg">1.7</td>
<td class="player-played">2</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11622" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11622" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11635" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11635_13002')">Marc Mariani</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11635" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11635" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11671" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('11671_13002')">Erik Lorig</div></td>
<td class="player-fppg">1.2</td>
<td class="player-played">10</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11671" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11671" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11648" data-role="player" data-position="TE" data-fixture="99662" class="pR  fixtureId_99662 teamId_7   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11648_13002')">Jim Dray</div></td>
<td class="player-fppg">1.8</td>
<td class="player-played">1</td>
<td class="player-fixture">TEN@<b>CLE</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11648" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11648" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11543" data-role="player" data-position="TE" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11543_13002')">Clay Harbor</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11543" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11543" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11504" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('11504_13002')">Andre Roberts</div></td>
<td class="player-fppg">5.1</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11504" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11504" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6660" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('6660_13002')">Donald Brown</div></td>
<td class="player-fppg">4.5</td>
<td class="player-played">13</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6660" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6660" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_7870" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('7870_13002')">Benjamin Watson</div></td>
<td class="player-fppg">3.4</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="7870" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="7870" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_9442" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('9442_13002')">Brandon Tate</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="9442" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="9442" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_10382" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('10382_13002')">Chris Ogbonnaya</div></td>
<td class="player-fppg">1.6</td>
<td class="player-played">7</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="10382" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="10382" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_11488" data-role="player" data-position="TE" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('11488_13002')">Ed Dickson</div></td>
<td class="player-fppg">1.4</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="11488" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="11488" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_10695" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('10695_13002')">Darrel Young</div></td>
<td class="player-fppg">0.5</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="10695" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="10695" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_15121" data-role="player" data-position="WR" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('15121_13002')">Chris Matthews</div></td>
<td class="player-fppg">1.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="15121" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="15121" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_14645" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('14645_13002')">Dontrelle Inman</div></td>
<td class="player-fppg">3.1</td>
<td class="player-played">7</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="14645" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="14645" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25886" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('25886_13002')">Devin Street</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25886" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25886" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25783" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('25783_13002')">Mike James</div></td>
<td class="player-fppg">0.3</td>
<td class="player-played">11</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25783" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25783" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25775" data-role="player" data-position="TE" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('25775_13002')">Clive Walford</div></td>
<td class="player-fppg">0.6</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25775" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25775" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26038" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('26038_13002')">Tyler Kroft</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26038" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26038" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26074" data-role="player" data-position="TE" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('26074_13002')">Tim Wright</div></td>
<td class="player-fppg">4.7</td>
<td class="player-played">16</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26074" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26074" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26799" data-role="player" data-position="TE" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('26799_13002')">Ernst Brun Jr.</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26799" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26799" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26343" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('26343_13002')">Corey Fuller</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26343" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26343" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_26199" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('26199_13002')">Jarrod West</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="26199" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="26199" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25654" data-role="player" data-position="RB" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('25654_13002')">Tommy Bohanon</div></td>
<td class="player-fppg">0.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25654" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25654" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25561" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_6   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('25561_13002')">Michael Campanaro</div></td>
<td class="player-fppg">1.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>BAL</b>@OAK</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25561" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25561" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6522" data-role="player" data-position="K" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-recent">
<td class="player-position">K</td>
<td class="player-name"><div onclick="sSts('6522_13002')">Josh Brown</div></td>
<td class="player-fppg">17</td>
<td class="player-played">1</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6522" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6522" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24589" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('24589_13002')">Jaron Brown</div></td>
<td class="player-fppg">1.3</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24589" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24589" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_15178" data-role="player" data-position="RB" data-fixture="99667" class="pR injured fixtureId_99667 teamId_32   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('15178_13002')">Chase Reynolds<span class="player-badge player-badge-injured-possible">Q</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="15178" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="15178" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_24755" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('24755_13002')">Jamison Crowder</div></td>
<td class="player-fppg">0.7</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="24755" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="24755" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25052" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('25052_13002')">Zach Laskey</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25052" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25052" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25420" data-role="player" data-position="RB" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('25420_13002')">Tony Creecy</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25420" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25420" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_25079" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('25079_13002')">Stefon Diggs</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="25079" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="25079" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27199" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27199_13002')">Marcus Murphy</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27199" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27199" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27266" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('27266_13002')">Quincy Enunwa</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27266" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27266" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28694" data-role="player" data-position="TE" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('28694_13002')">Jesse James</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28694" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28694" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28486" data-role="player" data-position="WR" data-fixture="99659" class="pR  fixtureId_99659 teamId_25   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('28486_13002')">Corey (Philly) Brown</div></td>
<td class="player-fppg">2.3</td>
<td class="player-played">1</td>
<td class="player-fixture">HOU@<b>CAR</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28486" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28486" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28408" data-role="player" data-position="WR" data-fixture="99664" class="pR  fixtureId_99664 teamId_28   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('28408_13002')">Kyle Prater</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">TB@<b>NO</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28408" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28408" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28936" data-role="player" data-position="WR" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('28936_13002')">Kenzel Doe</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28936" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28936" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29340" data-role="player" data-position="WR" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('29340_13002')">Josh Huff</div></td>
<td class="player-fppg">2.9</td>
<td class="player-played">1</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29340" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29340" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29672" data-role="player" data-position="RB" data-fixture="99667" class="pR injured fixtureId_99667 teamId_20   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('29672_13002')">Silas Redd<span class="player-badge player-badge-injured-out">IR</span></div></td>
<td class="player-fppg">1.9</td>
<td class="player-played">15</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29672" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29672" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29540" data-role="player" data-position="RB" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('29540_13002')">Terron Ward</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29540" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29540" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_29357" data-role="player" data-position="RB" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('29357_13002')">Kenjon Barner</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="29357" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="29357" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28311" data-role="player" data-position="TE" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('28311_13002')">MarQueis Gray</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28311" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28311" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_28202" data-role="player" data-position="RB" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('28202_13002')">Jeremy Langford</div></td>
<td class="player-fppg">0.1</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="28202" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="28202" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27378" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27378_13002')">Trey Millard</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27378" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27378" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27338" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27338_13002')">Rex Burkhead</div></td>
<td class="player-fppg">2.9</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27338" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27338" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27269" data-role="player" data-position="RB" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27269_13002')">Braylon Heard</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27269" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27269" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27403" data-role="player" data-position="TE" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('27403_13002')">Blake Bell</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27403" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27403" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27445" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('27445_13002')">Jalen Saunders</div></td>
<td class="player-fppg">-0.1</td>
<td class="player-played">9</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27445" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27445" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27908" data-role="player" data-position="TE" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('27908_13002')">C.J. Fiedorowicz</div></td>
<td class="player-fppg">2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27908" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27908" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_27878" data-role="player" data-position="RB" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('27878_13002')">Mark Weisman</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="27878" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="27878" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_23055" data-role="player" data-position="TE" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('23055_13002')">Brandon Bostick</div></td>
<td class="player-fppg">0.6</td>
<td class="player-played">13</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="23055" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="23055" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_23076" data-role="player" data-position="RB" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('23076_13002')">Jorvorskie Lane</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="23076" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="23076" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22181" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22181_13002')">David Paulson</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22181" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22181" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22123" data-role="player" data-position="TE" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22123_13002')">James Hanna</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22123" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22123" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22108" data-role="player" data-position="RB" data-fixture="99776" class="pR injured fixtureId_99776 teamId_10   news-breaking">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22108_13002')">Vick Ballard<span class="player-badge player-badge-injured-out">IR</span></div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22108" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22108" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22103" data-role="player" data-position="WR" data-fixture="99661" class="pR  fixtureId_99661 teamId_8   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22103_13002')">Marvin Jones</div></td>
<td class="player-fppg">2.9</td>
<td class="player-played">1</td>
<td class="player-fixture">SD@<b>CIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22103" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22103" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22185" data-role="player" data-position="RB" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22185_13002')">Brad Smelley</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22185" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22185" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22198" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_29   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22198_13002')">Brittan Golden</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>ARI</b>@CHI</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22198" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22198" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22447" data-role="player" data-position="WR" data-fixture="99776" class="pR  fixtureId_99776 teamId_10   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22447_13002')">Griff Whalen</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">NYJ@<b>IND</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22447" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22447" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22336" data-role="player" data-position="WR" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22336_13002')">Josh Bellamy</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22336" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22336" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22258" data-role="player" data-position="RB" data-fixture="99658" class="pR injured fixtureId_99658 teamId_3   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22258_13002')">Travaris Cadet<span class="player-badge player-badge-injured-probable">P</span></div></td>
<td class="player-fppg">3.6</td>
<td class="player-played">15</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22258" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22258" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22067" data-role="player" data-position="TE" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22067_13002')">Adrien Robinson</div></td>
<td class="player-fppg">0.8</td>
<td class="player-played">16</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22067" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22067" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22065" data-role="player" data-position="TE" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22065_13002')">Rhett Ellison</div></td>
<td class="player-fppg">0.8</td>
<td class="player-played">1</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22065" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22065" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_21990" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-old">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('21990_13002')">Ryan Broyles</div></td>
<td class="player-fppg">0.7</td>
<td class="player-played">5</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="21990" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="21990" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6567" data-role="player" data-position="TE" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6567_13002')">David Johnson</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6567" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6567" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_16923" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('16923_13002')">Austin Seferian-Jenkins</div></td>
<td class="player-fppg">25.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="16923" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="16923" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_6595" data-role="player" data-position="TE" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('6595_13002')">Matt Spaeth</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="6595" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="6595" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22000" data-role="player" data-position="RB" data-fixture="99668" class="pR  fixtureId_99668 teamId_2   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22000_13002')">LaMichael James</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>MIA</b>@JAC</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22000" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22000" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22029" data-role="player" data-position="RB" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22029_13002')">Bernard Pierce</div></td>
<td class="player-fppg">0.9</td>
<td class="player-played">1</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22029" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22029" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22063" data-role="player" data-position="WR" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22063_13002')">Keshawn Martin</div></td>
<td class="player-fppg">0.7</td>
<td class="player-played">16</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22063" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22063" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22042" data-role="player" data-position="TE" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22042_13002')">Evan Rodriguez</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22042" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22042" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22034" data-role="player" data-position="WR" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22034_13002')">Chris Givens</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22034" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22034" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22754" data-role="player" data-position="TE" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22754_13002')">Garrett Celek</div></td>
<td class="player-fppg">5.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22754" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22754" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22800" data-role="player" data-position="RB" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-old">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22800_13002')">Derrick Coleman</div></td>
<td class="player-fppg">0.2</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22800" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22800" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_23023" data-role="player" data-position="TE" data-fixture="99671" class="pR  fixtureId_99671 teamId_31   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('23023_13002')">Cooper Helfet</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>SEA</b>@GB</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="23023" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="23023" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22938" data-role="player" data-position="WR" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-recent">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('22938_13002')">Rod Streater</div></td>
<td class="player-fppg">1.3</td>
<td class="player-played">1</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22938" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22938" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22991" data-role="player" data-position="RB" data-fixture="99659" class="pR  fixtureId_99659 teamId_11   news-recent">
<td class="player-position">RB</td>
<td class="player-name"><div onclick="sSts('22991_13002')">Jonathan Grimes</div></td>
<td class="player-fppg">3.5</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>HOU</b>@CAR</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22991" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22991" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22920" data-role="player" data-position="TE" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-recent">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22920_13002')">Derek Carrier</div></td>
<td class="player-fppg">1.8</td>
<td class="player-played">1</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22920" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22920" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_22849" data-role="player" data-position="TE" data-fixture="99667" class="pR  fixtureId_99667 teamId_32   news-old">
<td class="player-position">TE</td>
<td class="player-name"><div onclick="sSts('22849_13002')">Cory Harkey</div></td>
<td class="player-fppg">0</td>
<td class="player-played">1</td>
<td class="player-fixture"><b>STL</b>@WAS</td>
<td class="player-salary">$4,500</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="22849" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="22849" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12526" data-role="player" data-position="D" data-fixture="99658" class="pR  fixtureId_99658 teamId_4   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12526_13002')">Buffalo Bills</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">NE@<b>BUF</b></td>
<td class="player-salary">$4,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12526" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12526" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12540" data-role="player" data-position="D" data-fixture="99663" class="pR  fixtureId_99663 teamId_21   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12540_13002')">Minnesota Vikings</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">DET@<b>MIN</b></td>
<td class="player-salary">$4,400</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12540" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12540" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12544" data-role="player" data-position="D" data-fixture="99776" class="pR  fixtureId_99776 teamId_1   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12544_13002')">New York Jets</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>NYJ</b>@IND</td>
<td class="player-salary">$4,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12544" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12544" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12532" data-role="player" data-position="D" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12532_13002')">Detroit Lions</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$4,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12532" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12532" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12541" data-role="player" data-position="D" data-fixture="99658" class="pR  fixtureId_99658 teamId_3   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12541_13002')">New England Patriots</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>NE</b>@BUF</td>
<td class="player-salary">$4,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12541" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12541" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12545" data-role="player" data-position="D" data-fixture="99670" class="pR  fixtureId_99670 teamId_19   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12545_13002')">Philadelphia Eagles</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">DAL@<b>PHI</b></td>
<td class="player-salary">$4,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12545" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12545" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12548" data-role="player" data-position="D" data-fixture="99661" class="pR  fixtureId_99661 teamId_14   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12548_13002')">San Diego Chargers</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SD</b>@CIN</td>
<td class="player-salary">$4,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12548" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12548" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12549" data-role="player" data-position="D" data-fixture="99666" class="pR  fixtureId_99666 teamId_30   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12549_13002')">San Francisco 49ers</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>SF</b>@PIT</td>
<td class="player-salary">$4,300</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12549" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12549" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12537" data-role="player" data-position="D" data-fixture="99669" class="pR  fixtureId_99669 teamId_15   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12537_13002')">Oakland Raiders</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">BAL@<b>OAK</b></td>
<td class="player-salary">$4,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12537" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12537" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12530" data-role="player" data-position="D" data-fixture="99670" class="pR  fixtureId_99670 teamId_18   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12530_13002')">Dallas Cowboys</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>DAL</b>@PHI</td>
<td class="player-salary">$4,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12530" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12530" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12547" data-role="player" data-position="D" data-fixture="99666" class="pR  fixtureId_99666 teamId_5   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12547_13002')">Pittsburgh Steelers</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">SF@<b>PIT</b></td>
<td class="player-salary">$4,200</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12547" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12547" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12552" data-role="player" data-position="D" data-fixture="99667" class="pR  fixtureId_99667 teamId_20   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12552_13002')">Washington Redskins</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">STL@<b>WAS</b></td>
<td class="player-salary">$4,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12552" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12552" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12525" data-role="player" data-position="D" data-fixture="99665" class="pR  fixtureId_99665 teamId_27   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12525_13002')">Atlanta Falcons</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>ATL</b>@NYG</td>
<td class="player-salary">$4,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12525" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12525" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12554" data-role="player" data-position="D" data-fixture="99668" class="pR  fixtureId_99668 teamId_12   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12554_13002')">Jacksonville Jaguars</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">MIA@<b>JAC</b></td>
<td class="player-salary">$4,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12554" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12554" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12543" data-role="player" data-position="D" data-fixture="99665" class="pR  fixtureId_99665 teamId_17   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12543_13002')">New York Giants</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">ATL@<b>NYG</b></td>
<td class="player-salary">$4,100</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12543" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12543" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12527" data-role="player" data-position="D" data-fixture="99660" class="pR  fixtureId_99660 teamId_22   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12527_13002')">Chicago Bears</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture">ARI@<b>CHI</b></td>
<td class="player-salary">$4,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12527" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12527" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_12551" data-role="player" data-position="D" data-fixture="99664" class="pR  fixtureId_99664 teamId_26   news-none">
<td class="player-position">D</td>
<td class="player-name"><div onclick="sSts('12551_13002')">Tampa Bay Buccaneers</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>TB</b>@NO</td>
<td class="player-salary">$4,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="12551" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="12551" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
<tr id="playerListPlayerId_66519" data-role="player" data-position="WR" data-fixture="99663" class="pR  fixtureId_99663 teamId_24   news-none">
<td class="player-position">WR</td>
<td class="player-name"><div onclick="sSts('66519_13002')">Kendrick Ings</div></td>
<td class="player-fppg">0</td>
<td class="player-played">0</td>
<td class="player-fixture"><b>DET</b>@MIN</td>
<td class="player-salary">$3,000</td>
<td class="player-add">
<a data-role="add" id="add-button" data-player-id="66519" class="button tiny text player-add-button"><i class="icon">?</i></a>
<a data-role="remove" id="remove-button" data-player-id="66519" class="button tiny text player-remove-button"><i class="icon">?</i></a>
</td>
</tr>
</tbody>

%}


%{


%}