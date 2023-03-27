unit UnitLogicMusicienMetalManager;
{$codepage utf8}
{$mode objfpc}{$H+}


interface

type
  typeRoleMusicien =(chanteur, batteur, guitariste);            // role du musicien
  typeStatutMusicien = (libre, ecriture,concert,studio,promo,album,entrainement);          //statut de l'occupation
  typeSante = (malade, en_forme,sante_empty);             //état de santé
  typeMusicien = record                 //type musicien
    name : string;
    role : typeRoleMusicien;
    forme : integer;
    salaire : integer;
    statut : typeStatutMusicien;            //attibuts musicien
    niveauInstru : integer;
    niveaustudio : integer;
    niveauConcert : integer;
    sante : typeSante;
    timer_occupation : integer;            // nombre de mois pendant lesquelles le musicien est occupé
  end;

  typeMusicienDispo = array[1..5] of typeMusicien;       //tableau des musiciens dispo
  typeMusicienGroupe = array[1..5] of typeMusicien;               //tableau des musiciens de ton groupe
  typeMois = (janvier,fevrier,mars,avril,mai,juin,juillet,aout,sept,oct,nov,dec);        //mois de l'année
  typeAnnee = array[1..12] of typeMois;                   //tableau contenant tous les mois

 function CreationMusicien : typeMusicienDispo;
 function initialisationGroupe(): typeMusicienGroupe;
 procedure VirerMusicien(var Tableau_musicien_dispo : typeMusicienDispo;var UnGroupe:typeMusicienGroupe);
 procedure recruterMusicien(var Tableau_musicien_dispo : typeMusicienDispo;var UnGroupe:typeMusicienGroupe);
 function checkGroupeValide(unGroupe : typeMusicienGroupe): boolean;
 procedure initialisation();
 function initialisationAnnee() : typeAnnee;


 var
   groupe:typeMusicienGroupe;               //tableau des musiciens du groupe
   musiciendispo : typeMusicienDispo;         //tableau des musiciens disponibles au recrutement

   groupeIsValide : boolean;               //boolean passe à vrai si le groupe est complet avec au moins un batteur et un chanteur
   argent : integer;                                //argent du groupe
   renommee : integer;                               //renommee du groupe
   mois : typeMois;                                   //mois type mois
   nbChansonsEcrites : integer;                      //nombre de chansons écrites par le chanteur
   nbChansonEnregistrees : integer;                  //nombre de chansons enregistrées par un musicien
   nbAlbum : integer;                                //nombre album enregistré
   annee : typeAnnee;
   compteurMois : integer;
   timerBuzzAlbum : integer;                    //entier représentaant le buzz d'un album diminue avec le temps
   Musicien1 : typeMusicien;
   Musicien2 :typeMusicien;
   Musicien3 : typeMusicien;                      //les musiciens du jeu
   Musicien4 : typeMusicien;
   Musicien5 : typeMusicien;
implementation

uses
 Unit_IHMMetalManager;

var



  EspaceLibre : typeMusicien;




function CreationMusicien : typeMusicienDispo;
begin

     Musicien1.name:= 'Steve Harris';
     Musicien1.role:= guitariste;
     Musicien1.forme:=10;
     Musicien1.salaire:=2000;                                         //creation 1er musicien
     Musicien1.statut:=libre;
     Musicien1.niveauInstru:=5;
     Musicien1.niveauConcert:=5;
     Musicien1.niveaustudio:= 5;
     Musicien1.sante:=en_forme;
     Musicien1.timer_occupation:=0;

     Musicien2.name:= 'Chuck Schuldiner';
     Musicien2.role:= chanteur;
     Musicien2.forme:=10;
     Musicien2.salaire:=2500;
     Musicien2.statut:=libre;                                          //creation 2eme musicien
     Musicien2.niveauInstru:=6;
     Musicien2.niveauConcert:=4;
     Musicien2.niveaustudio:= 3;
     Musicien2.sante:=en_forme;
     Musicien2.timer_occupation:=0;

     Musicien3.name:= 'Ozzy Osbourn';
     Musicien3.role:= chanteur;
     Musicien3.forme:=10;
     Musicien3.salaire:=3000;                                              //creation 3eme musicien
     Musicien3.statut:=libre;
     Musicien3.niveauInstru:=6;
     Musicien3.niveauConcert:=6;
     Musicien3.niveaustudio:= 2;
     Musicien3.sante:=en_forme;
     Musicien3.timer_occupation:=0;

     Musicien4.name:= 'Andre MAtos';
     Musicien4.role:= chanteur;
     Musicien4.forme:=10;                                                 //creation 4eme musicien
     Musicien4.salaire:=4000;
     Musicien4.statut:=libre;
     Musicien4.niveauInstru:=6;
     Musicien4.niveauConcert:=7;
     Musicien4.niveaustudio:= 6;
     Musicien4.sante:=en_forme;
     Musicien4.timer_occupation:=0;

     Musicien5.name:= 'Marilyn Manson';
     Musicien5.role:= batteur;
     Musicien5.forme:=10;                                                 //creation 5eme musicien
     Musicien5.salaire:=3000;
     Musicien5.statut:=libre;
     Musicien5.niveauInstru:=8;
     Musicien5.niveauConcert:=5;
     Musicien5.niveaustudio:= 5;
     Musicien5.sante:=en_forme;
     Musicien5.timer_occupation:=0;

     EspaceLibre.name:='vide';                                  //creation espace libre pour insérer dans les tableaux
     EspaceLibre.role:= batteur;
     EspaceLibre.forme:=0;
     EspaceLibre.salaire:=0;
     EspaceLibre.statut:=libre;
     EspaceLibre.niveauInstru:=0;
     EspaceLibre.niveauConcert:=0;
     EspaceLibre.niveaustudio:= 0;
     EspaceLibre.sante:=en_forme;
     EspaceLibre.timer_occupation:=0;
     musicienDispo[1]:=Musicien1;
     musicienDispo[2]:= Musicien2;                                          //ajout des musiciens dans le tableau des musiciens dispo
     musicienDispo[3]:=Musicien3;
     musicienDispo[4]:= Musicien4;
     musicienDispo[5]:= Musicien5;
     CreationMusicien:=musicienDispo;
   end;






function initialisationGroupe(): typeMusicienGroupe;
var
   i :integer;
   groupe : typeMusicienGroupe;                             //initialisation groupe vide
begin


  for i:=1 to 5 do
  begin
    groupe[i]:=EspaceLibre;
  end;

  initialisationGroupe:=groupe;
                                                   //initialise le mois à 1
end;






procedure initialisation();              //initialise les paramêtres de départ du groupe
begin
  argent:=10000;                                            //attribue l argent et la renomme du debut
  renommee:=1;
  nbChansonsEcrites:=0;
  nbChansonEnregistrees:=20;
  nbAlbum:=1;
  mois:=annee[1];
  timerBuzzAlbum:=1;
end;









function initialisationAnnee() : typeAnnee;               //ajoute les mois dans le tableau année et retourne le tableau
begin
  annee[1] := janvier;
  annee[2] := fevrier;
  annee[3] := mars;
  annee[4] := avril;
  annee[5] := mai;
  annee[6] := juin;
  annee[7] := juillet;
  annee[8] := aout;
  annee[9] := sept;
  annee[10] := oct;
  annee[11] := nov;
  annee[12] := dec;
  compteurMois:=1;
  initialisationAnnee := annee;
end;



procedure VirerMusicien(var Tableau_musicien_dispo : typeMusicienDispo;var UnGroupe:typeMusicienGroupe);          //procedure pour virer un musicien prend en paramêtre d'enrées-sorties un tableau des musiciens dispobibles et un tableau des musiciens du groupe
var
   numMusicien : integer;           //numero du musicien à virer
   i : integer;           //compteur de boucle
   newIndexFund : boolean;       //boolean qui passe à vrai quand une place vide est trouvée dans le tableau des musiciens dispo
   indexeNewMus : integer;
   //i2 : integer;      //compteur boucle while
begin
  //for i:= 1 to length(UnGroupe) do writeln(i, 'name = ', UnGroupe[i].name);         //affiche la liste des musiciens du groupe avec leur nom et numéro dans tableau
  //writeln('entrer le numero du musicien a virer');
  //readln(n);
  afficherVirerMusicien();
  numMusicien := affichageChoixMenuGroupe();
  if UnGroupe[numMusicien].statut = libre then           //on ne peut pas virer un musicien occupé
  begin
    newIndexFund:=false;
    indexeNewMus:=1;
    while (newIndexFund=false) and (indexeNewMus<=length(Tableau_musicien_dispo)) do          //tant qu'une place n'est pas trouvée dans la limite du tableau
    begin
      if (Tableau_musicien_dispo[indexeNewMus].name='') or (Tableau_musicien_dispo[indexeNewMus].name='vide') then                  //trouve la première place disponible dans le tableau des musiciens dispo et attribue son indexe à indexNewMus
        begin
          //indexeNewMus:=i2;
          newIndexFund:= True;
        end
      else
        indexeNewMus:=indexeNewMus+1;           //augemente l'indice de 1
    end;

    Tableau_musicien_dispo[indexeNewMus]:= UnGroupe[numMusicien];               //ajoute le musicien choisit dans le tableau des musiciens dispo
    for i:=numMusicien to length(UnGroupe)-1 do groupe[i]:=UnGroupe[i+1];                        //enleve le musicien du tableau et redecale tous les autres d'une place vers le début du tableau
    UnGroupe[length(UnGroupe)]:=EspaceLibre;           //ajoute 'espace libre' à la fin du tableau du groupe
    afficherMessageVirer(Tableau_musicien_dispo[indexeNewMus]);
  end;
end;







procedure recruterMusicien(var Tableau_musicien_dispo : typeMusicienDispo;var UnGroupe:typeMusicienGroupe);                //procedure pour recruter un musicien
var
   i : integer;                 //compteur 1ere boucle qui affiche les musiciens dispo
   numMusicien:integer;                   //numero du musicien à recruter
   indexeNewMus : integer;   //indexe du nouveau musicien dans le tableau
  // i2 : integer;   //compteur 2eme boucle qui ajoute le musicien à la bonne place

   newIndexFund : boolean;
begin
  afficherMenuRecruterMembre();         //afiche les musicinens diponibles au recrutement
  numMusicien:=affichageChoixMenuGroupe();          //affiche la fonction qui retourne le numéro de musicien choisit
  indexeNewMus:=1;
  newIndexFund:=false;
  while (newIndexFund=false) and (indexeNewMus<=length(UnGroupe)) do             //tant qu'une place n'est pas trouvée dans la limite du tableau
  begin
       if (UnGroupe[indexeNewMus].name='') or (UnGroupe[indexeNewMus].name='vide') then newIndexFund:= True                //trouve la première place disponible dans le groupe et attribue son indexe à indexNewMus

       else indexeNewMus:=indexeNewMus+1;

  end;
  if indexeNewMus<=length(UnGroupe) then              //vérifie que la place trouvée soit dans la limite deu tableau
  begin
    UnGroupe[indexeNewMus]:= Tableau_musicien_dispo[numMusicien];                    //ajoute le musicien dans le tableau du groupe à la bonne place
    for i:=numMusicien to length(Tableau_musicien_dispo)-1 do Tableau_musicien_dispo[i]:=Tableau_musicien_dispo[i+1];     //supprime le musicien choisit de la liste des musiciens disponibles
    Tableau_musicien_dispo[length(Tableau_musicien_dispo)]:=EspaceLibre;
  end
  else afficherGroupeComplet();                  //sinon affiche le message groupe complet
end;







function checkGroupeValide(unGroupe : typeMusicienGroupe): boolean;              //vérifie si un groupe est valide
var
   isValide : boolean;          //passe à vrai si le groupe contient 5 membrs et au moins un chanteur et un batteur
   have1Batteur : boolean;        //passe à vrai si le groupe contient un batteur
   have1Chanteur : boolean;       //passe à vrai si le groupe contient un chanteur
   nbMembers : integer;           //entier qui compte les membres du groupe
   numMusicien : integer;           //entier compteur de boucle

begin
  isValide:=false;
  have1Batteur:=false;
  have1Chanteur:=false;
  nbMembers:=0;
  for numMusicien:=1 to length(unGroupe) do         //itère sur tous les membres du groupe
  begin
    if unGroupe[numMusicien].role=chanteur then have1Chanteur:=True;              //vérifie si un des membres du groupe est chanteur
    if unGroupe[numMusicien].role=batteur then have1Batteur:=True;                 //vérifie si un des membres du groupe est batteur
    if (unGroupe[numMusicien].name <> '') and (unGroupe[numMusicien].name<>'vide') then nbMembers:=nbMembers+1;     //compte les membres du groupe
  end;
  if(have1Chanteur=true) and (have1Batteur=true) and (nbMembers=5) then isValide:=True;         //si tous les critères sont réunis le groupe est valide
  checkGroupeValide:=isValide;          //retourne

end;



  end.
