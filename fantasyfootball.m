clc; close all; clear;

% [ffd, ffdt] = fanduel();

[fd,fdt] = rotoguru();

clc;

%% ORGANIZE FANDUEL DATA
% clear('pos','player','id','team','cost','ffpg')


for nn=1:numel(fd)

    pos(nn)     = cellstr(fd(nn).pos);
    player(nn)  = cellstr(fd(nn).player);
    id(nn)      = fd(nn).id;
    %team(nn)    = fd(nn).team;
    cost(nn)    = fd(nn).cost;
    ffpg(nn)    = fd(nn).ffpg;

end



%%


for nn = 1:numel(pos)
    if all(pos{nn}=='QB')
        qbs(nn) = 1;
    else
        qbs(nn) = 0;
    end

    if all(pos{nn}=='RB')
        rbs(nn) = 1;
    else
        rbs(nn) = 0;
    end


    if all(pos{nn}=='WR')
        wrs(nn) = 1;
    else
        wrs(nn) = 0;
    end


    if all(pos{nn}=='TE')
        tes(nn) = 1;
    else
        tes(nn) = 0;
    end


    if all(pos{nn}=='K') || all(pos{nn}=='PK')
        kis(nn) = 1;
    else
        kis(nn) = 0;
    end

    if all(pos{nn}=='D') || all(pos{nn}=='DF')
        dfs(nn) = 1;
    else
        dfs(nn) = 0;
    end

end

%%

qbi = find(qbs);
rbi = find(rbs);
wri = find(wrs);
tei = find(tes);
kii = find(kis);
dfi = find(dfs);


%% ORGANIZE FANTASYPROS DATA

[FantasyPros_QBn,FantasyPros_QBt,FantasyPros_QB] = xlsread('FantasyPros_Fantasy_Football_Rankings_QB.xls');
[FantasyPros_RBn,FantasyPros_RBt,FantasyPros_RB] = xlsread('FantasyPros_Fantasy_Football_Rankings_RB.xls');
[FantasyPros_WRn,FantasyPros_WRt,FantasyPros_WR] = xlsread('FantasyPros_Fantasy_Football_Rankings_WR.xls');
[FantasyPros_TEn,FantasyPros_TEt,FantasyPros_TE] = xlsread('FantasyPros_Fantasy_Football_Rankings_TE.xls');
[FantasyPros_KIn,FantasyPros_KIt,FantasyPros_KI] = xlsread('FantasyPros_Fantasy_Football_Rankings_K.xls');

FantasyPro_QB_name = FantasyPros_QB(2:end,1);
FantasyPro_RB_name = FantasyPros_RB(2:end,1);
FantasyPro_WR_name = FantasyPros_WR(2:end,1);
FantasyPro_TE_name = FantasyPros_TE(2:end,1);
FantasyPro_KI_name = FantasyPros_KI(2:end,1);

FantasyPro_QB_proj = cell2mat(FantasyPros_QB(2:end,12));
FantasyPro_RB_proj = cell2mat(FantasyPros_RB(2:end,10));
FantasyPro_WR_proj = cell2mat(FantasyPros_WR(2:end,10));
FantasyPro_TE_proj = cell2mat(FantasyPros_TE(2:end,7));
FantasyPro_KI_proj = cell2mat(FantasyPros_KI(2:end,6));

%% MATCH FANDUEL AND FANTASYPROS DATA

QBf=0;
RBf=0;
WRf=0;
TEf=0;
KIf=0;

for mm = 1:numel(FantasyPro_QB_name)
    QBfind = strfind(player, FantasyPro_QB_name{mm});
    for nn = 1:numel(QBfind)
        if ~isempty(QBfind{nn})
            QBf(mm) = nn;
        end
    end
end

for mm = 1:numel(FantasyPro_RB_name)
    RBfind = strfind(player, FantasyPro_RB_name{mm});
    for nn = 1:numel(RBfind)
        if ~isempty(RBfind{nn})
            RBf(mm) = nn;
        end
    end
end

for mm = 1:numel(FantasyPro_WR_name)
    WRfind = strfind(player, FantasyPro_WR_name{mm});
    for nn = 1:numel(WRfind)
        if ~isempty(WRfind{nn})
            WRf(mm) = nn;
        end
    end
end

for mm = 1:numel(FantasyPro_TE_name)
    TEfind = strfind(player, FantasyPro_TE_name{mm});
    for nn = 1:numel(TEfind)
        if ~isempty(TEfind{nn})
            TEf(mm) = nn;
        end
    end
end


for mm = 1:numel(FantasyPro_KI_name)
    KIfind = strfind(player, FantasyPro_KI_name{mm});
    for nn = 1:numel(KIfind)
        if ~isempty(KIfind{nn})
            KIf(mm) = nn;
        end
    end
end


QBfp=0;
RBfp=0;
WRfp=0;
TEfp=0;
KIfp=0;

for mm = 1:numel(player)
    QBfind = strfind(FantasyPro_QB_name, player{mm});
    for nn = 1:numel(QBfind)
        if ~isempty(QBfind{nn})
            QBfp(mm) = nn;
        end
    end
end

for mm = 1:numel(player)
    RBfind = strfind(FantasyPro_RB_name, player{mm});
    for nn = 1:numel(RBfind)
        if ~isempty(RBfind{nn})
            RBfp(mm) = nn;
        end
    end
end

for mm = 1:numel(player)
    WRfind = strfind(FantasyPro_WR_name, player{mm});
    for nn = 1:numel(WRfind)
        if ~isempty(WRfind{nn})
            WRfp(mm) = nn;
        end
    end
end

for mm = 1:numel(player)
    TEfind = strfind(FantasyPro_TE_name, player{mm});
    for nn = 1:numel(TEfind)
        if ~isempty(TEfind{nn})
            TEfp(mm) = nn;
        end
    end
end

for mm = 1:numel(player)
    KIfind = strfind(FantasyPro_KI_name, player{mm});
    for nn = 1:numel(KIfind)
        if ~isempty(KIfind{nn})
            KIfp(mm) = nn;
        end
    end
end



%% CREATE VARIABLE 'FPpg' AND ADD FANTASYPRO PROJECTIONS BASED ON FANDUEL ORDERINGS

FPpg = ffpg.*0;
for nn = 1:numel(QBfp)
    if QBfp(nn)>0
        FPpg(nn) = FantasyPro_QB_proj(QBfp(nn));
    end
end

for nn = 1:numel(RBfp)
    if RBfp(nn)>0
        FPpg(nn) = FantasyPro_RB_proj(RBfp(nn));
    end
end

for nn = 1:numel(WRfp)
    if WRfp(nn)>0
        FPpg(nn) = FantasyPro_WR_proj(WRfp(nn));
    end
end

for nn = 1:numel(TEfp)
    if TEfp(nn)>0
        FPpg(nn) = FantasyPro_TE_proj(TEfp(nn));
    end
end

for nn = 1:numel(KIfp)
    if KIfp(nn)>0
        FPpg(nn) = FantasyPro_KI_proj(KIfp(nn));
    end
end


% FPpgZeros = find(~FPpg);
% FPpg(FPpgZeros) = ffpg(FPpgZeros);


%% REMOVE LOWEST PROJECTED PLAYERS


% players with projections lower than 'projection_threshhold' are not considered

projection_threshhold = 7; 



badplayers = find(FPpg<projection_threshhold);

for mm = 1:numel(badplayers)
    for nn = 1:numel(qbi)
        if badplayers(mm)==qbi(nn)
            qbi(nn) = 0;
        end
    end
    for nn = 1:numel(rbi)
        if badplayers(mm)==rbi(nn)
            rbi(nn) = 0;
        end
    end
    for nn = 1:numel(wri)
        if badplayers(mm)==wri(nn)
            wri(nn) = 0;
        end
    end
    for nn = 1:numel(tei)
        if badplayers(mm)==tei(nn)
            tei(nn) = 0;
        end
    end
    for nn = 1:numel(kii)
        if badplayers(mm)==kii(nn)
            kii(nn) = 0;
        end
    end
    for nn = 1:numel(dfi)
        if badplayers(mm)==dfi(nn)
            dfi(nn) = 0;
        end
    end
end


qbi(qbi<1) = [];
rbi(rbi<1) = [];
wri(wri<1) = [];
tei(tei<1) = [];
kii(kii<1) = [];
dfi(dfi<1) = [];

%% DELETES

%dfi(4)=[]; % carolina

%% COUNTERS

nQB = numel(qbi);
nRB = numel(rbi);
nWR = numel(wri);
nTE = numel(tei);
nKI = numel(kii);
nDF = numel(dfi);

QBcost = 5500;
RBcost = 7000;
WRcost = 7000;
TEcost = 5000;
KIcost = 5000;
DFcost = 5000;

QBproj = 20;
RBproj = 15;
WRproj = 15;
TEproj = 15;
KIproj = 10;
DFproj = 15;

Nt=3;

clc



%% MAIN LOOP - RB WR TE
%{.

for Nteams = 1:Nt

topteam_FPpg_sum = 0;

%----------------------------------
for nn = 1:50000


    tqb = qbi(randperm(nQB,1));
    trb = rbi(randperm(nRB,2));
    twr = wri(randperm(nWR,3));
    tte = tei(randperm(nTE,1));
    %tki = kii(randperm(nKI,1));
    %tdf = dfi(randperm(nDF,1));
    
    %team = [tqb trb twr tte tki tdf];
    team = [trb twr tte];

    team_FPpg_sum = sum(FPpg(team));
	team_cost_sum = sum(cost(team));
    
     
    if team_cost_sum <= (60000-QBcost-KIcost-DFcost) && team_FPpg_sum >= topteam_FPpg_sum

        topteam_FPpg = FPpg(team);
        topteam_cost = cost(team);
        topteam_pos = pos(team);
        topteam_player = player(team);

        topteam_FPpg_sum = sum(topteam_FPpg);
        topteam_cost_sum = sum(topteam_cost);


    end

end
%----------------------------------

topteam_FPpg_sum = topteam_FPpg_sum+QBproj+KIproj+DFproj;
topteam_cost_sum = topteam_cost_sum+QBcost+KIcost+DFcost;

str1 = sprintf('Projected: %4.1f    TeamCost: %d   ', topteam_FPpg_sum, topteam_cost_sum);

str2top = [topteam_pos' topteam_player' cellstr(num2str(topteam_FPpg')) cellstr(num2str(topteam_cost'))];
str2QB = [cellstr('QB') cellstr('YOURCHOICE!') cellstr(num2str(QBproj)) cellstr(num2str(QBcost))];
str2KI = [cellstr('KI') cellstr('YOURCHOICE!') cellstr(num2str(KIproj)) cellstr(num2str(KIcost))];
str2DF = [cellstr('DF') cellstr('YOURCHOICE!') cellstr(num2str(DFproj)) cellstr(num2str(DFcost))];
str2 = [str2QB; str2top; str2KI; str2DF];

disp(str1);
disp(str2);


end

%}



%% MAIN LOOP - QB RB WR TE
%{.


for Nteams = 1:Nt

topteam_FPpg_sum = 0;

%----------------------------------
for nn = 1:50000


    tqb = qbi(randperm(nQB,1));
    trb = rbi(randperm(nRB,2));
    twr = wri(randperm(nWR,3));
    tte = tei(randperm(nTE,1));
    %tki = kii(randperm(nKI,1));
    %tdf = dfi(randperm(nDF,1));
    
    %team = [tqb trb twr tte tki tdf];
    team = [tqb trb twr tte];

    team_FPpg_sum = sum(FPpg(team));
	team_cost_sum = sum(cost(team));
    
     
    if team_cost_sum <= (60000-KIcost-DFcost) && team_FPpg_sum >= topteam_FPpg_sum

        topteam_FPpg = FPpg(team);
        topteam_cost = cost(team);
        topteam_pos = pos(team);
        topteam_player = player(team);

        topteam_FPpg_sum = sum(topteam_FPpg);
        topteam_cost_sum = sum(topteam_cost);


    end

end
%----------------------------------

topteam_FPpg_sum = topteam_FPpg_sum+KIproj+DFproj;
topteam_cost_sum = topteam_cost_sum+KIcost+DFcost;

str1 = sprintf('Projected: %4.1f    TeamCost: %d   ', topteam_FPpg_sum, topteam_cost_sum);

str2top = [topteam_pos' topteam_player' cellstr(num2str(topteam_FPpg')) cellstr(num2str(topteam_cost'))];
str2QB = [cellstr('QB') cellstr('YOURCHOICE!') cellstr(num2str(QBproj)) cellstr(num2str(QBcost))];
str2KI = [cellstr('KI') cellstr('YOURCHOICE!') cellstr(num2str(KIproj)) cellstr(num2str(KIcost))];
str2DF = [cellstr('DF') cellstr('YOURCHOICE!') cellstr(num2str(DFproj)) cellstr(num2str(DFcost))];
str2 = [str2top; str2KI; str2DF];

disp(str1);
disp(str2);


end
%}






%% MAIN LOOP - RB WR TE KI
%{.

for Nteams = 1:Nt

topteam_FPpg_sum = 0;

%----------------------------------
for nn = 1:50000

    %tqb = qbi(randperm(nQB,1));
    trb = rbi(randperm(nRB,2));
    twr = wri(randperm(nWR,3));
    tte = tei(randperm(nTE,1));
    tki = kii(randperm(nKI,1));
   

    team = [trb twr tte tki];

    team_FPpg_sum = sum(FPpg(team));
	team_cost_sum = sum(cost(team));
    

    if team_cost_sum <= (60000-QBcost-DFcost) && team_FPpg_sum >= topteam_FPpg_sum

        topteam_FPpg = FPpg(team);
        topteam_cost = cost(team);
        topteam_pos = pos(team);
        topteam_player = player(team);

        topteam_FPpg_sum = sum(topteam_FPpg);
        topteam_cost_sum = sum(topteam_cost);


    end

end
%----------------------------------


topteam_FPpg_sum = topteam_FPpg_sum+QBproj+DFproj;
topteam_cost_sum = topteam_cost_sum+QBcost+DFcost;

str1 = sprintf('Projected: %4.1f    TeamCost: %d   ', topteam_FPpg_sum, topteam_cost_sum);

str2top = [topteam_pos' topteam_player' cellstr(num2str(topteam_FPpg')) cellstr(num2str(topteam_cost'))];
str2QB = [cellstr('QB') cellstr('YOURCHOICE!') cellstr(num2str(QBproj)) cellstr(num2str(QBcost))];
str2KI = [cellstr('KI') cellstr('YOURCHOICE!') cellstr(num2str(KIproj)) cellstr(num2str(KIcost))];
str2DF = [cellstr('DF') cellstr('YOURCHOICE!') cellstr(num2str(DFproj)) cellstr(num2str(DFcost))];
str2 = [str2QB; str2top; str2DF];

disp(str1);
disp(str2);


end
%}



%% MAIN LOOP - QB RB WR TE KI
%{.

for Nteams = 1:Nt

topteam_FPpg_sum = 0;

%----------------------------------
for nn = 1:50000

    tqb = qbi(randperm(nQB,1));
    trb = rbi(randperm(nRB,2));
    twr = wri(randperm(nWR,3));
    tte = tei(randperm(nTE,1));
    tki = kii(randperm(nKI,1));
   

    team = [tqb trb twr tte tki];

    team_FPpg_sum = sum(FPpg(team));
	team_cost_sum = sum(cost(team));
    

    if team_cost_sum <= (60000-DFcost) && team_FPpg_sum >= topteam_FPpg_sum

        topteam_FPpg = FPpg(team);
        topteam_cost = cost(team);
        topteam_pos = pos(team);
        topteam_player = player(team);

        topteam_FPpg_sum = sum(topteam_FPpg);
        topteam_cost_sum = sum(topteam_cost);


    end

end
%----------------------------------


topteam_FPpg_sum = topteam_FPpg_sum+DFproj;
topteam_cost_sum = topteam_cost_sum+DFcost;

str1 = sprintf('Projected: %4.1f    TeamCost: %d   ', topteam_FPpg_sum, topteam_cost_sum);

str2top = [topteam_pos' topteam_player' cellstr(num2str(topteam_FPpg')) cellstr(num2str(topteam_cost'))];
str2QB = [cellstr('QB') cellstr('YOURCHOICE!') cellstr(num2str(QBproj)) cellstr(num2str(QBcost))];
str2KI = [cellstr('KI') cellstr('YOURCHOICE!') cellstr(num2str(KIproj)) cellstr(num2str(KIcost))];
str2DF = [cellstr('DF') cellstr('YOURCHOICE!') cellstr(num2str(DFproj)) cellstr(num2str(DFcost))];
str2 = [str2top; str2DF];

disp(str1);
disp(str2);


end
%}


%% MAIN LOOP - QB RB WR TE KI DF
%{

% FPpgZeros = find(~FPpg);
% FPpg(FPpgZeros) = ffpg(FPpgZeros);

for Nteams = 1:Nt

% topteam_FPpg = FPpg(topteam);
% topteam_ffpg = ffpg(topteam);
% topteam_cost = cost(topteam);
% topteam_pos = pos(topteam);
% topteam_player = player(topteam);

topteam_FPpg_sum = 0;

%----------------------------------
for nn = 1:10000


    tqb = qbi(randperm(nQB,1));
    trb = rbi(randperm(nRB,2));
    twr = wri(randperm(nWR,3));
    tte = tei(randperm(nTE,1));
    tki = kii(randperm(nKI,1));
   
%     tqb = randsample(qbi,1);
%     trb = randsample(rbi,2);
%     twr = randsample(wri,3);
%     tte = randsample(tei,1);
%     tki = randsample(kii,1);
%     tdf = randsample(dfi,1);


    team = [tqb trb twr tte tki tdf];

    team_FPpg_sum = sum(FPpg(team));
	team_ffpg_sum = sum(ffpg(team));
	team_cost_sum = sum(cost(team));
    

    if team_cost_sum <= (60000-DFcost) && team_FPpg_sum >= topteam_FPpg_sum

        topteam_FPpg = FPpg(team);
        %topteam_ffpg = ffpg(team);
        topteam_cost = cost(team);
        topteam_pos = pos(team);
        topteam_player = player(team);

        topteam_FPpg_sum = sum(topteam_FPpg);
        %topteam_ffpg_sum = sum(topteam_ffpg);
        topteam_cost_sum = sum(topteam_cost);


    end

end
%----------------------------------


% topteam_FPpg_sum = topteam_FPpg_sum+DFproj;
% topteam_cost_sum = topteam_cost_sum+DFcost;

str1 = sprintf('Projected: %4.1f    TeamCost: %d   ', topteam_FPpg_sum, topteam_cost_sum);
str2 = [topteam_pos' topteam_player' cellstr(num2str(topteam_FPpg')) cellstr(num2str(topteam_cost'))];
% str2 = [str2; cellstr('QB') cellstr('YOURCHOICE!') cellstr(num2str(QBproj)) cellstr(num2str(QBcost))];
% str2 = [str2; cellstr('KI') cellstr('YOURCHOICE!') cellstr(num2str(KIproj)) cellstr(num2str(KIcost))];
% str2 = [str2; cellstr('DF') cellstr('YOURCHOICE!') cellstr(num2str(DFproj)) cellstr(num2str(DFcost))];

disp(str1);
disp(str2);


end
%}
