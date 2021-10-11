unit expression;

interface

uses Math,SysUtils;

procedure Eval( ett : string;var result : real;VAR ereval : integer);

implementation

type pile = record
                  priorite : byte;
                  texte : string;
            end;

var g_priorite  :  array[' '..'z'] of byte;
    l_pile,infix : array[0..255] of pile;
    erreur_expression : integer;

Function Evalu_exp( gisp : string ) : real;
VAR giap            :  string;
    g_p_g,g_p_d :  array[' '..'z'] of byte;
    g_postfix  :  array[0..255] of string;

    lip,lpp : integer;

    l_indice,indval,l_base : integer;
    pilval : array[0..255] of real;
    symb : char;

BEGIN
     { convertis_infix_en_postfix }
     { convertion de la chaine en un tableau de valeur ou de propriete }
     l_base:=0;
     gisp:=gisp+'z';
	 giap:='';
     FOR l_indice:=1 TO length(gisp) do
         Begin
              symb:='0';
              if ((gisp[l_indice]>='0') and (gisp[l_indice]<='9'))
                 or (gisp[l_indice]=',') or (gisp[l_indice]='E') or (gisp[l_indice]='.')
                 or ((l_indice=1) and (gisp[1]='-'))
                 or ((l_indice>1)and(gisp[l_indice-1]='E')and (gisp[l_indice]='-'))
                 or ((l_indice>1)and(gisp[l_indice-1]='E')and (gisp[l_indice]='+'))then
                 begin
                      giap:=giap+gisp[l_indice];
                      symb:='1';
                 end;
              if ((l_indice>1)and((gisp[l_indice-1]<'0')or (gisp[l_indice-1]>'9'))and (gisp[l_indice]='-'))then
                 begin
                      giap:=giap+gisp[l_indice];
                      symb:='1';
                 end;
              if symb='0' then
                 begin
                      if giap<>'' then
                         begin
                              infix[l_base].priorite:=6;
                              infix[l_base].texte:=giap;
                              giap:='';
                              l_base:=l_base+1;
                              infix[l_base].priorite:=g_priorite[gisp[l_indice]];
                              infix[l_base].texte:=gisp[l_indice];
                         end else
                         begin
                              infix[l_base].priorite:=g_priorite[gisp[l_indice]];
                              infix[l_base].texte:=gisp[l_indice];
                         end;
                      l_base:=l_base+1;
                 end;
              if (giap<>'')and(l_indice=length(gisp)) then
                 begin
                      infix[l_base].priorite:=6;
                      infix[l_base].texte:=giap;
                      giap:='';
                      l_base:=l_base+1;
                 end;
         end;

     l_pile[0].texte:='%';
     l_pile[0].priorite:=1;
     lip:=0;
     lpp:=0;
     giap:='';
     g_postfix[0]:='';
     FOR l_indice:=0 TO l_base-1 do
         Begin
              if l_pile[lip].priorite>infix[l_indice].priorite then
                 while l_pile[lip].priorite>=infix[l_indice].priorite do
                       begin
                            g_postfix[lpp]:=l_pile[lip].texte;
                            lip:=lip-1;
                            lpp:=lpp+1;
                       end;
              lip:=lip+1;
              l_pile[lip].texte:=infix[l_indice].texte;
              l_pile[lip].priorite:=infix[l_indice].priorite;
         end;
     { evalue_postfix }
     indval:=-1;
     for l_indice:=0 to lpp-1 do
         begin
              if (length(g_postfix[l_indice])=1)and
                 ((g_postfix[l_indice]<'0') or
                 (g_postfix[l_indice]>'9')) then
                 begin
                      symb:=g_postfix[l_indice,1];
                      case symb of
                           '+' : pilval[indval-1]:=pilval[indval-1]+pilval[indval];
                           '-' : pilval[indval-1]:=pilval[indval-1]-pilval[indval];
                           '*' : pilval[indval-1]:=pilval[indval-1]*pilval[indval];
                           '/' : pilval[indval-1]:=pilval[indval-1]/pilval[indval];
                           '^' : pilval[indval-1]:=exp(pilval[indval]*ln(pilval[indval-1]));
                           's' : pilval[indval]:=sin(pilval[indval]); {sin}
                           'c' : pilval[indval]:=cos(pilval[indval]); {cos}
                           't' : pilval[indval]:=tan(pilval[indval]); {tan}
                           'l' : pilval[indval]:=log10(pilval[indval]); {log}
                           'r' : pilval[indval]:=arcsin(pilval[indval]); {arcsin}
                           'm' : pilval[indval]:=arccos(pilval[indval]); {arccos}
                           'n' : pilval[indval]:=arctan(pilval[indval]); {arctan}
                           'o' : pilval[indval]:=ln(pilval[indval]); {ln}
                           'p' : pilval[indval]:=exp(pilval[indval]); {exp}
                           'q' : pilval[indval]:=sqrt(pilval[indval]); {racine carré}
                      end;
                      case symb of
                           '+' : dec(indval);
                           '-' : dec(indval);
                           '*' : dec(indval);
                           '/' : dec(indval);
                           '^' : dec(indval);
                      end;
                 end else
                 begin
                      inc(indval);
                      pilval[indval]:=StrToFloat(g_postfix[l_indice]);
                 end;
         end;
     Evalu_exp:=pilval[0];
end;


{ **************************** PROCEDURE PRINCIPALE ************************ }
Procedure Eval( ett : string;var result : real;VAR ereval : integer);
var parant_droite,parant_gauche : integer;
    ie,sortir,je : integer;
    ett1,ett_deb,ett_fin,ett_mil,ettr : string;
    valeur : real;
BEGIN
     parant_droite:=0;
     parant_gauche:=0;
     erreur_expression:=0;
     ettr:=ett;
     for ie:=1 to length(ettr) do     { On compte le nombre de paranthese droite et gauche }
         begin
              if (ettr[ie]='(')or(ettr[ie]='[')or (ettr[ie]='{') then
                 begin
                      ettr[ie]:='(';
                      parant_gauche:=parant_gauche+1;
                 end;
              if (ettr[ie]=')')or(ettr[ie]=']')or (ettr[ie]='}') then
                 begin
                      parant_droite:=parant_droite+1;
                      ettr[ie]:=')';
                 end;
              ettr[ie]:=upcase(ettr[ie]);
         end;
     if parant_gauche<>parant_droite then erreur_expression:=1; { erreur_expression de nombre de paranthese }
     { On convertit les sin,cos,log,tan,arctan,etc en code simple ascii pour simplifier la reconnaissance }
     if erreur_expression=0 then
        begin
             ie:=1;
             repeat
                   ett1:='';
                   if (ettr[ie]>='A') and (ettr[ie]<='Z') then
                      begin
                           sortir:=0;
                           repeat
                                 if (ettr[ie]>='A') and (ettr[ie]<='Z') then
                                    begin
                                         ett1:=ett1+ettr[ie];
                                         ie:=ie+1;
                                    end else sortir:=1;
                           until (ie>=length(ettr)) or (sortir=1);
                      end;
                   if ett1<>'' then
                      begin
                        ett_deb:=copy(ettr,1,ie-length(ett1)-1);
                        ett_mil:='';
                        for je:=ie to length(ettr) do ett_mil:=ett_mil+ettr[je];
                        ie:=ie-length(ett1);
                        ettr:=ett_deb+' '+ett_mil;
                        if ett1='SIN' then ettr[ie]:='s';
                        if ett1='COS' then ettr[ie]:='c';
                        if ett1='TAN' then ettr[ie]:='t';
                        if ett1='LOG' then ettr[ie]:='l';
                        if ett1='ARCSIN' then ettr[ie]:='r';
                        if ett1='ARCCOS' then ettr[ie]:='m';
                        if ett1='ARCTAN' then ettr[ie]:='n';
                        if ett1='LN' then ettr[ie]:='o';
                        if ett1='EXP' then ettr[ie]:='p';
                        if ett1='SQRT' then ettr[ie]:='q';
                        if ett1='E' then ettr[ie]:='E';
                        if ett1='PI' then
                           begin
                                ettr:=ett_deb+FloatToStr(pi)+ett_mil;
                           end;
                        if ettr[ie]=' ' then erreur_expression:=2; { opération inconnue }
                      end;
                   ie:=ie+1;
             until (ie>=length(ettr)) or (erreur_expression=2);
        end;
     if erreur_expression=0 then
        begin
             { on fait la convertion pour obtenir la résultat }
             repeat
                   ett_deb:='';
                   ett_fin:='';
                   ett_mil:='';
                   ie:=1;
                   je:=0;
                   if parant_gauche>0 then
                      begin
                           repeat
                                 if ettr[ie]='(' then je:=je+1;
                                 ie:=ie+1;
                           until je=parant_gauche;
                           ett_deb:=copy(ettr,1,ie-2);
                           repeat
                                 if ettr[ie]<>')' then ett_mil:=ett_mil+ettr[ie];
                                 ie:=ie+1;
                           until ettr[ie]=')';
                           for je:=ie+1 to length(ettr) do ett_fin:=ett_fin+ettr[je];
                           valeur:=evalu_exp(ett_mil);
                           ett_mil:=FloatToStr(valeur);
                           ettr:=ett_deb+ett_mil+ett_fin;
                           parant_gauche:=parant_gauche-1;
                           parant_droite:=parant_droite-1;
                      end else
                      begin
                           ett_mil:=ettr;
                           valeur:=evalu_exp(ett_mil);
                           ett_mil:='';
                      end;
             until (ett_mil='')or (erreur_expression<>0);
        end;
     result:=valeur;
     ereval:=erreur_expression;
end;

begin
     fillchar(g_priorite,sizeof(g_priorite),6);
     g_priorite['s']:=6; {sin}
     g_priorite['c']:=6; {cos}
     g_priorite['t']:=6; {tan}
     g_priorite['l']:=6; {log}
     g_priorite['r']:=6; {arcsin}
     g_priorite['m']:=6; {arccos}
     g_priorite['n']:=6; {arctan}
     g_priorite['o']:=6; {ln}
     g_priorite['p']:=6; {exp}
     g_priorite['q']:=5; { racinne carré}
     g_priorite['^']:=5;
     g_priorite['*']:=4;
     g_priorite['/']:=4;
     g_priorite['+']:=3;
     g_priorite['-']:=3;
     g_priorite['z']:=2;
     g_priorite['%']:=1;
end.
