unit Unit_IHMMetalManager;

{$codepage utf8}
{$mode objfpc}{$H+}


interface
uses
UnitLogicMusicienMetalManager ;

function menu_depart_ihm(): string;
procedure afficherMenuPrincipal();
procedure quitterIHM();
function affichageChoixecranPrincipal() : integer;
procedure afficherBilanDuMois();
function affichageChoixMenuGroupe(): integer;

procedure afficherMenuRecruterMembre();
procedure afficherVirerMusicien();
function afficherRecruitorFired():integer;
function afficherContinueOrHomeMenu(): integer;
procedure afficherGroupe(UnGroupe : typeMusicienGroupe);
procedure afficherGroupeComplet();
procedure afficherGroupeInvalide();
function afficherListeTaches(): integer;
procedure afficherUnMembreOccupe();
procedure afficherEnregistrerAlbum();
procedure afficherPasAssezDeChansons();
procedure afficherInterompreAlbum();
procedure afficherBilanAnnee();
procedure afficheGameOver();
procedure afficherMusicienIndispo();
procedure afficherMessageVirer(musicien : typeMusicien);
procedure afficherFaireConcert();
procedure afficherPasAssezAlbum();
procedure afficherPromo(musicien : typeMusicien);
procedure afficherStudio(musicien : typeMusicien);
procedure afficherPasDeChanson();
procedure afficherEntrainement(musicien : typeMusicien);
procedure afficherEcrireChanson(musicien : typeMusicien);
procedure afficherPasChanteur(musicien : typeMusicien);
procedure afficherInterrompreConcert();
procedure afficherPasDeChance();

implementation
uses
unit_logicTachesMetalManager,GestionEcran;




function affichageChoixecranPrincipal() : integer;      //affiche les boutons du menu principal
begin
  deplacerCurseurXY(2,4); write('0/pour gerer les membres du groupe     /1 pour attribuer une tache      /2 pour finir le tour       /9 pour quitter');
  changerColonneCurseur(118);
  readln(affichageChoixecranPrincipal);           //retourne un entier saisit par l'utilisateur
end;





function menu_depart_ihm(): string;           //menu pour commencer une nouvelle partie
begin
  dessinercadreXY(19,5,101,20, simple, White, red )  ;
  deplacerCurseurXY(52,13);  write('1/ nouvelle partie');
  deplacerCurseurXY(52,15);  write('0/ quitter');
  dessinerCadreXY(42,7,77,9,double,black,red);
  deplacerCurseurXY(44,8);write('METAL MANAGER : BACK TO IUT 2022');
  deplacerCurseurXY(42,18);  write('Votre choix');changerColonneCurseur(55);
  readln( menu_depart_ihm);          //retourne un entier saisit par l'utilisateur

end;







procedure cadrePrincipal();                //affiche le grand cadre rouge avec le titre du jeu
begin
  effacerEcran();
  dessinerCadrexY(0,0,119,29,simple, White, red);
  dessinerCadrexY(78,0,117,2,simple, Black, White);
  deplacerCurseurXY(82,1);  writeln('METAL MANAGER : BACK TO IUT 2022');
end;






procedure afficherMessageVirer(musicien : typeMusicien);            //message quand on vire un musicien
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(39,14,72+length(musicien.name),16,simple,white,black);
  deplacerCurseurXY(41,15); write(musicien.name,' ne fait plus parti du groupe !');
  readln();
end;






procedure afficherGroupe(UnGroupe : typeMusicienGroupe);                  //affiche les membres du groupe et leurs caractéristiques
var
  nbMembers : integer;
  i : integer;
begin
  effacerEcran;
  cadrePrincipal();
  nbMembers:=0;
  for i:=1 to length(UnGroupe) do if (UnGroupe[i].name <> '') and (UnGroupe[i].name<>'vide') then nbMembers:=nbMembers+1;     //compte les membres du groupe

  if nbMembers>=1 then
  begin
    dessinerCadreXY(1, 6, 21, 26,simple,white,black);
    deplacerCurseurXY(3,7);write(UnGroupe[1].name);
    deplacerCurseurXY(3,9);write(UnGroupe[1].role);
    deplacerCurseurXY(3,11);write('salaire : ',UnGroupe[1].salaire);
    deplacerCurseurXY(3,13);write(UnGroupe[1].statut);                  //affiche le cadre et les stats du premier membre du groupe
    deplacerCurseurXY(3,15);write('forme : ',groupe[1].forme);
    deplacerCurseurXY(3,17);write(UnGroupe[1].sante);
    deplacerCurseurXY(3,19);write('niveau instru : ',UnGroupe[1].niveauInstru);
    deplacerCurseurXY(3,21);write('niveau concert : ',UnGroupe[1].niveauConcert);
    deplacerCurseurXY(3,23);write('niveau studio : ',UnGroupe[1].niveaustudio);
    deplacerCurseurXY(3,25);write('indispo pdt : ',UnGroupe[1].timer_occupation);
    deplacerCurseurXY(11,5);write('1');
    if nbMembers>=2 then
    begin
      dessinerCadreXY(24, 6, 44, 26,simple,white,black);
      deplacerCurseurXY(26,7);write(UnGroupe[2].name);
      deplacerCurseurXY(26,9);write(UnGroupe[2].role);
      deplacerCurseurXY(26,11);write('salaire : ',UnGroupe[2].salaire);
      deplacerCurseurXY(26,13);write(UnGroupe[2].statut);                  //affiche le cadre et les stats du deuxieme membre du groupe
      deplacerCurseurXY(26,15);write('forme : ',UnGroupe[2].forme);
      deplacerCurseurXY(26,17);write(UnGroupe[2].sante);
      deplacerCurseurXY(26,19);write('niveau instru : ',UnGroupe[2].niveauInstru);
      deplacerCurseurXY(26,21);write('niveau concert : ',UnGroupe[2].niveauConcert);
      deplacerCurseurXY(26,23);write('niveau studio : ',UnGroupe[2].niveaustudio);
      deplacerCurseurXY(26,25);write('indispo pdt : ',UnGroupe[2].timer_occupation);
      deplacerCurseurXY(34,5);write('2');
      if nbMembers>=3 then
      begin
        dessinerCadreXY(47, 6, 67, 26,simple,white,black);
        deplacerCurseurXY(49,7);write(UnGroupe[3].name);
        deplacerCurseurXY(49,9);write(UnGroupe[3].role);
        deplacerCurseurXY(49,11);write('salaire : ',UnGroupe[3].salaire);
        deplacerCurseurXY(49,13);write(UnGroupe[3].statut);                  //affiche le cadre et les stats du troisieme membre du groupe
        deplacerCurseurXY(49,15);write('forme : ',UnGroupe[3].forme);
        deplacerCurseurXY(49,17);write(UnGroupe[3].sante);
        deplacerCurseurXY(49,19);write('niveau instru : ',UnGroupe[3].niveauInstru);
        deplacerCurseurXY(49,21);write('niveau concert : ',UnGroupe[3].niveauConcert);
        deplacerCurseurXY(49,23);write('niveau studio : ',UnGroupe[3].niveaustudio);
        deplacerCurseurXY(49,25);write('indispo pdt : ',UnGroupe[3].timer_occupation);
        deplacerCurseurXY(57,5);write('3');
        if nbMembers>=4 then
        begin
          dessinerCadreXY(70, 6, 90, 26,simple,white,black);
          deplacerCurseurXY(72,7);write(UnGroupe[4].name);
          deplacerCurseurXY(72,9);write(UnGroupe[4].role);
          deplacerCurseurXY(72,11);write('salaire : ',UnGroupe[4].salaire);
          deplacerCurseurXY(72,13);write(UnGroupe[4].statut);                  //affiche le cadre et les stats du 4eme membre du groupe
          deplacerCurseurXY(72,15);write('forme : ',UnGroupe[4].forme);
          deplacerCurseurXY(72,17);write(UnGroupe[4].sante);
          deplacerCurseurXY(72,19);write('niveau instru : ',UnGroupe[4].niveauInstru);
          deplacerCurseurXY(72,21);write('niveau concert : ',UnGroupe[4].niveauConcert);
          deplacerCurseurXY(72,23);write('niveau studio : ',UnGroupe[4].niveaustudio);
          deplacerCurseurXY(72,25);write('indispo pdt : ',UnGroupe[4].timer_occupation);
          deplacerCurseurXY(80,5);write('4');
          if nbMembers>=5 then
          begin
            dessinerCadreXY(93, 6, 113, 26,simple,white,black);
            deplacerCurseurXY(95,7);write(UnGroupe[5].name);
            deplacerCurseurXY(95,9);write(UnGroupe[5].role);
            deplacerCurseurXY(95,11);write('salaire : ',UnGroupe[5].salaire);
            deplacerCurseurXY(95,13);write(UnGroupe[5].statut);                  //affiche le cadre et les stats du 5eme membre du groupe
            deplacerCurseurXY(95,15);write('forme : ',UnGroupe[5].forme);
            deplacerCurseurXY(95,17);write(UnGroupe[5].sante);
            deplacerCurseurXY(95,19);write('niveau instru : ',UnGroupe[5].niveauInstru);
            deplacerCurseurXY(95,21);write('niveau concert : ',UnGroupe[5].niveauConcert);
            deplacerCurseurXY(95,23);write('niveau studio : ',UnGroupe[5].niveaustudio);
            deplacerCurseurXY(95,25);write('indispo pdt : ',UnGroupe[5].timer_occupation);
            deplacerCurseurXY(103,5);write('5');
          end;
        end;
      end;
    end;
  end;
end;







function afficherListeTaches(): integer;          //affiche la liste des taches
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadrexY(2,0,17,2,simple, Black, White);
  deplacerCurseurXY(4,1);write('MENU TACHES');
  deplacerCurseurXY(4,6);write('Entrez le numero de la tache');
  deplacerCurseurXY(4,9);write('1/ecrire une chanson');
  deplacerCurseurXY(4,11);write('2/enregistrer en studio');
  deplacerCurseurXY(4,13);write('3/enregistrer un album de groupe');
  deplacerCurseurXY(4,15);write('4/faire un concert');
  deplacerCurseurXY(4,17);write('5/s entrainer');
  deplacerCurseurXY(4,19);write('6/faire la promo du groupe');
  deplacerCurseurXY(4,21);write('9/pour revenir au menu principal');
  deplacerCurseurXY(33,6);
  readln(afficherListeTaches);             //retourne un entier saisit par l'utilisateur
end;






procedure afficherUnMembreOccupe();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(40,14,80,16,simple,white,black);
  deplacerCurseurXY(42,15); write('Tout le groupe n est pas disponible !');
  readln();
end;






procedure afficherPromo(musicien : typeMusicien);
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(38,14,66+length(musicien.name),16,simple,white,black);
  deplacerCurseurXY(40,15); write(musicien.name,' fait la promo du groupe!');
  readln();
end;




procedure afficherPasChanteur(musicien : typeMusicien);
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(41,14,65+length(musicien.name),16,simple,white,black);
  deplacerCurseurXY(43,15); write(musicien.name,' n est pas un chanteur !');
  readln();
end;




procedure afficherFaireConcert();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(45,14,81,16,simple,white,black);
  deplacerCurseurXY(47,15); write('Tout le groupe fait un concert !');
  readln();
end;





procedure afficherPasAssezAlbum();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(35,14,85,16,simple,white,black);
  deplacerCurseurXY(37,15); write('Il faut au moins un album pour faire un concert!');
  readln();
end;




procedure afficherPasDeChance();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(35,14,86,16,simple,white,black);
  deplacerCurseurXY(37,15); write('Un des musiciens à le Covid et doit s isoler!');
  readln();
end;



procedure afficherMusicienIndispo();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(45,14,78,16,simple,white,black);
  deplacerCurseurXY(47,15); write('Ce musicien est indisponible !');
  readln();
end;






procedure afficherEcrireChanson(musicien : typeMusicien);
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(42,14,63+length(musicien.name),16,simple,white,black);
  deplacerCurseurXY(43,15); write(musicien.name,' ecrit une chanson !');
  readln();
end;





procedure afficherStudio(musicien : typeMusicien);
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(35,14,63+length(musicien.name),16,simple,white,black);
  deplacerCurseurXY(37,15); write(musicien.name,' enregistre une chanson !');
  readln();
end;





procedure afficherEnregistrerAlbum();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(41,14,79,16,simple,white,black);
  deplacerCurseurXY(43,15); write('Tout le groupe enregistre un album !');
  readln();
end;




procedure afficherPasDeChanson();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(30,14,84,16,simple,white,black);
  deplacerCurseurXY(32,15); write('Il faut au moins une chanson ecrite a enregistrer !');
  readln();
end;



procedure afficherPasAssezDeChansons();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(25,14,91,16,simple,white,black);
  deplacerCurseurXY(27,15); write('Le groupe n a pas assez de chansons pour enregistrer un album !');
  readln();
end;





procedure afficherInterrompreConcert();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(10,14,105,16,simple,white,black);
  deplacerCurseurXY(12,15); write('Un des membres du groupe est malade, le concert est annule, le groupe doit payer la salle!');
  readln();
end;



procedure afficherInterompreAlbum();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(10,14,105,16,simple,white,black);
  deplacerCurseurXY(12,15); write('Un des membres du groupe est malade, l album est annule, le groupe perd de la renomme!');
  readln();
end;




procedure afficherEntrainement(musicien : typeMusicien);
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(30,14,71+length(musicien.name),16,simple,white,black);
  deplacerCurseurXY(32,15); write(musicien.name,' s entraine et ameliorera son niveau !');
  readln();
end;




procedure afficherGroupeComplet();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(45,14,75,16,simple,white,black);
  deplacerCurseurXY(47,15); write('le groupe est deja complet !');
  readln();
end;








procedure afficherGroupeInvalide();
begin
  effacerEcran;
  cadrePrincipal();
  dessinerCadreXY(45,14,72,16,simple,white,black);
  deplacerCurseurXY(47,15); write('le groupe est invalide !');
  readln();
end;





procedure afficherStatsGroupe();
begin
  deplacerCurseurxy(1,28);write('argent : ',argent);
  deplacerCurseurxy(17,28);write('albums enregistres : ',nbAlbum);
  deplacerCurseurxy(41,28);write('chansons ecrites : ',nbChansonsEcrites);
  deplacerCurseurxy(63,28);write('chansons enregistres : ',nbChansonEnregistrees);
  deplacerCurseurxy(90,28);write('renommee : ',renommee);
  deplacerCurseurxy(105,28);write('mois : ',mois);
end;





procedure afficherMenuRecruterMembre();
var
  nbMusicienDispo : integer;          //nombre musiciens disponibles
  i : integer;
begin
  cadrePrincipal();
  dessinerCadrexY(2,0,17,2,simple, Black, White);
  deplacerCurseurXY(4,1);write('MENU GROUPE');
  nbMusicienDispo:=0;

  for i:=1 to length(musiciendispo) do if (musiciendispo[i].name <> '') and (musiciendispo[i].name<>'vide') then nbMusicienDispo:=nbMusicienDispo+1;     //compte les membres du groupe
  dessinerCadreXY(2,4,117,6,simple,white,red);deplacerCurseurXY(3,5);write('nom','                     ','role','         ','salaire','     ','instru','   ',' studio','   ',' concert','   ','forme','      ','etat de sante', '     numero');
  if nbMusicienDispo>=1 then
  begin
    dessinerCadreXY(2,6,117,8,simple,white,red);deplacerCurseurXY(3,7);write(musiciendispo[1].name);changerColonneCurseur(24);write(musiciendispo[1].role);changerColonneCurseur(41);write(musiciendispo[1].salaire);changerColonneCurseur(54);write(musiciendispo[1].niveauInstru);changerColonneCurseur(64);write(musiciendispo[1].niveaustudio);changerColonneCurseur(74);write(musiciendispo[1].niveauConcert);changerColonneCurseur(84);write(musiciendispo[1].forme);changerColonneCurseur(95);write(musiciendispo[1].sante);changerColonneCurseur(113);write('1');
    if nbMusicienDispo>=2 then
    begin
      dessinerCadreXY(2,8,117,10,simple,white,red);deplacerCurseurXY(3,9);write(musiciendispo[2].name);changerColonneCurseur(24);write(musiciendispo[2].role);changerColonneCurseur(41);write(musiciendispo[2].salaire);changerColonneCurseur(54);write(musiciendispo[2].niveauInstru);changerColonneCurseur(64);write(musiciendispo[2].niveaustudio);changerColonneCurseur(74);write(musiciendispo[2].niveauConcert);changerColonneCurseur(84);write(musiciendispo[2].forme);changerColonneCurseur(95);write(musiciendispo[2].sante);changerColonneCurseur(113);write('2');
      if nbMusicienDispo>=3 then
      begin
        dessinerCadreXY(2,10,117,12,simple,white,red);deplacerCurseurXY(3,11);write(musiciendispo[3].name);changerColonneCurseur(24);write(musiciendispo[3].role);changerColonneCurseur(41);write(musiciendispo[3].salaire);changerColonneCurseur(54);write(musiciendispo[3].niveauInstru);changerColonneCurseur(64);write(musiciendispo[3].niveaustudio);changerColonneCurseur(74);write(musiciendispo[3].niveauConcert);changerColonneCurseur(84);write(musiciendispo[3].forme);changerColonneCurseur(95);write(musiciendispo[3].sante);changerColonneCurseur(113);write('3');
         if nbMusicienDispo>=4 then
         begin
           dessinerCadreXY(2,12,117,14,simple,white,red);deplacerCurseurXY(3,13);write(musiciendispo[4].name);changerColonneCurseur(24);write(musiciendispo[4].role);changerColonneCurseur(41);write(musiciendispo[4].salaire);changerColonneCurseur(54);write(musiciendispo[4].niveauInstru);changerColonneCurseur(64);write(musiciendispo[4].niveaustudio);changerColonneCurseur(74);write(musiciendispo[4].niveauConcert);changerColonneCurseur(84);write(musiciendispo[4].forme);changerColonneCurseur(95);write(musiciendispo[4].sante);changerColonneCurseur(113);write('4');
            if nbMusicienDispo>=5 then
            begin
              dessinerCadreXY(2,14,117,16,simple,white,red);deplacerCurseurXY(3,15);write(musiciendispo[5].name);changerColonneCurseur(24);write(musiciendispo[5].role);changerColonneCurseur(41);write(musiciendispo[5].salaire);changerColonneCurseur(54);write(musiciendispo[2].niveauInstru);changerColonneCurseur(64);write(musiciendispo[5].niveaustudio);changerColonneCurseur(74);write(musiciendispo[5].niveauConcert);changerColonneCurseur(84);write(musiciendispo[5].forme);changerColonneCurseur(95);write(musiciendispo[5].sante);changerColonneCurseur(113);write('5');
               if nbMusicienDispo>=6 then
               begin
                 dessinerCadreXY(2,16,110,18,simple,white,red);
                 if nbMusicienDispo>=7 then
                 begin
                   dessinerCadreXY(2,18,110,20,simple,white,red);
                   if nbMusicienDispo>=8 then
                   begin
                     dessinerCadreXY(2,20,110,22,simple,white,red);
                     if nbMusicienDispo>=9 then
                     begin
                       dessinerCadreXY(2,22,110,24,simple,white,red);
                       if nbMusicienDispo>=10 then
                       begin
                         dessinerCadreXY(2,24,110,26,simple,white,red);
                         dessinerCadreXY(2,26,110,28,simple,white,red);
                       end;
                     end;
                   end;
                 end;
               end;
          end;
        end;
      end;
    end;
  end;
end;








procedure afficherVirerMusicien();
begin
  effacerEcran;
  CadrePrincipal;
  afficherGroupe(groupe);

  dessinerCadrexY(2,0,17,2,simple, Black, White);
  deplacerCurseurXY(4,1);write('MENU GROUPE');
  //affichageChoixMenuGroupe();
end;







function afficherRecruitorFired():integer;
begin
  effacerEcran;
  afficherGroupe(groupe);
  cadrePrincipal();

  dessinerCadrexY(2,0,17,2,simple, Black, White);
  deplacerCurseurXY(4,1);write('MENU GROUPE');
  deplacerCurseurXY(2,4);write('Tapez 1 pour recruter ou 0 pour virer un musicien');
  changerColonneCurseur(53);
  readln(afficherRecruitorFired);
end;







function affichageChoixMenuGroupe(): integer;
var
  verbe : string;
begin
  deplacerCurseurXY(20,3); write('Selectionner le musicien avec son numero');
  changerColonneCurseur(64);
  readln(affichageChoixMenuGroupe);
end;





procedure afficherBilanDuMois();
begin
  cadrePrincipal();
  dessinercadreXY(9,5,101,20, simple, White, Black )  ;
  dessinerCadrexY(2,0,17,2,simple, Black, White);
  deplacerCurseurXY(4,1);write('BILAN DU MOIS');
  deplacerCurseurXY(11,7); write('nombre d album en vente : ',nbAlbum);
  deplacerCurseurXY(11,9); write('argent genere par la vente d albums : ',argentAlbum);
  deplacerCurseurXY(11,11); write('buzz albums : ',timerBuzzAlbum);
  if ConcertAPayer = True then
  begin
   deplacerCurseurXY(11,13); write('recette du dernier concert : ',argentConcert);
  end;
  deplacerCurseurXY(11,15); write('argent total : ',argent);
  readln();

end;





procedure afficherBilanAnnee();
begin
  cadrePrincipal();
  dessinercadreXY(9,5,101,20, simple, White, Black )  ;
  dessinerCadrexY(2,0,21,2,simple, Black, White);
  deplacerCurseurXY(4,1);write('BILAN DE L ANNEE');
  deplacerCurseurXY(11,7); write('total des salaires a paye : ',totalSalaire);
  deplacerCurseurXY(11,9); write('argent restant : ',argent);
  readln();
end;





procedure afficheGameOver();
begin
  effacerEcran;
  dessinercadreXY(30,14,90,16, double, White, Black )  ;
  deplacerCurseurXY(55,15);  write('C est perdu !');
  readln();
end;



function afficherContinueOrHomeMenu(): integer;
begin
  effacerEcran;
  cadrePrincipal();
  afficherGroupe(groupe);
  dessinerCadrexY(2,0,17,2,simple, Black, White);
  deplacerCurseurXY(4,1);write('MENU GROUPE');
  deplacerCurseurXY(5,4); write('Entrez 1 pour continue ou 0 pour retourner au menu principal');
  deplacerCurseurXY(67,4);
  readln(afficherContinueOrHomeMenu);
end;







procedure quitterIHM();
begin
  effacerEcran;
  dessinercadreXY(30,14,90,16, double, White, Black )  ;
  deplacerCurseurXY(55,15);  write('Au revoir');
  readln();
end;









procedure afficherMenuPrincipal();
begin

  //cadrePrincipal();
  afficherGroupe(groupe);
  afficherStatsGroupe();
  dessinerCadrexY(2,0,20,2,simple, Black, White);
  deplacerCurseurXY(4,1);write('MENU PRINCIPAL');
end;

end.

