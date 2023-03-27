unit unit_logicTachesMetalManager;
 {$codepage utf8}
{$mode objfpc}{$H+}

interface
uses
UnitLogicMusicienMetalManager;

 procedure menuGestionMusicien() ;                //le menu ou le joueur choisit de recruter ou virer un musicien

 procedure menuPrincipal();                    //menu principal du jeu
 procedure menu_depart();             //menu pour commencer une nouvelle partie
 procedure ecrireUneChanson(var musicien : typeMusicien);
 procedure entrainerMusicien(var musicien : typeMusicien);
 procedure Enregistrement(var musicien : typeMusicien);              //un musicien enregistre une chanson si il y en a au moins une écrite
 procedure faireUnConcert();
 procedure enregistrer_un_album();
 procedure passerUnTour();               //passe au mois suivant



 var
   argentAlbum : integer;         //argent généré par la vente d'album ce mois ci
   ConcertAPayer : boolean;        //boolean qui passe à vrai si un concert n'a pas encore été payé
   argentConcert : integer;
   totalSalaire:integer;            //somme des salaires des musiciens du groupe

implementation
uses
Unit_IHMMetalManager;


var
  partie_continue : boolean;                        //boolean qui ferme la partie







procedure ecrireUneChanson(var musicien : typeMusicien);              //un musicien écrit une chanson si il est chanteur
begin
  if musicien.role=chanteur then                                               //vérifie que le musicien est un chanteur
  begin
    musicien.statut:=ecriture;                                                 //change son statut
    musicien.forme:=musicien.forme-4;                                           //modifie son niveau de forme
    musicien.timer_occupation:=musicien.timer_occupation+2;                      //il est occupé pendant 2 mois
    nbChansonsEcrites:=nbChansonsEcrites+1;                           //le nombre de chanson écrite augmente de 1
    if musicien.forme <= 0 then
    begin
      musicien.forme:=0;                                                         //si sa forme est à 0 il tombe malade et devra se reposer 2 mois de plus
      musicien.sante:=malade;
      musicien.timer_occupation:= musicien.timer_occupation+2;
    end;
  afficherEcrireChanson(musicien);            //affiche le message
  end
  else afficherPasChanteur(musicien);           //affiche le message si ce n'est pas un chanteur
end;






procedure entrainerMusicien(var musicien : typeMusicien);                //procedure de la tache s'entrainer
begin
  musicien.statut:=entrainement;                       //modifie le statut
  musicien.forme:=musicien.forme-4;                    //modifie la forme
  musicien.timer_occupation:=musicien.timer_occupation+2;               //le musicien est occupé 2 mois
  musicien.niveauInstru :=musicien.niveauInstru+1;
  if musicien.forme <= 0 then
    begin
      musicien.forme:=0;                                    //si sa forme est à 0 il tombe malade
      musicien.timer_occupation:=musicien.timer_occupation+2;      //il devra se reposer 2 mois de plus
      musicien.sante:=malade;                   //modifie la forme
    end;
  afficherEntrainement(musicien);              //affiche le message
end;






procedure Enregistrement(var musicien : typeMusicien);              //un musicien enregistre une chanson si il y en a au moins une écrite
begin
  if nbChansonsEcrites>0 then                                     //vérifie qu'il y a au moins une chanson écrite à enregistrer
  begin
    musicien.statut:=studio;                                      //change son statut
    musicien.forme:=musicien.forme-4;                             //modifie son niveau de forme
    musicien.timer_occupation:=musicien.timer_occupation+2;       //il est occupé pendant 2 mois
    nbChansonsEcrites:=nbChansonsEcrites-1;
    nbChansonEnregistrees:=nbChansonEnregistrees+1;
    if musicien.forme <= 0 then
    begin
      musicien.forme:=0;                                    //si sa forme est à 0 il tombe malade
      musicien.timer_occupation:=musicien.timer_occupation+2;      //il devra se reposer 2 mois de plus
      musicien.sante:=malade;
    end;
    afficherStudio(musicien);                     //affiche le message
  end
  else afficherPasDeChanson();                  //affiche le message si il n'y a pas de chanson écrite
end;






procedure faire_promo(var musicien : typeMusicien);              //un musicien fait la promo du groupe
var
   gainRenommee : integer;         //gain de renommée aléatoire
begin
  randomize();
  gainRenommee:=(random(5)*musicien.niveauInstru) div 10;           //entier aléatoire entre 0 et 5 multiplié par le niveau d'instrument du musicien, le tout divisé par 10
  renommee:=renommee+gainRenommee;              //la renommée gagnée s'ajoute à la renommée actuelle
  musicien.statut:=promo;                                      //change son statut
  musicien.forme:=musicien.forme-4;                             //modifie son niveau de forme
  musicien.timer_occupation:=musicien.timer_occupation+2;       //il est occupé pendant 2 mois
  if musicien.forme <= 0 then
  begin
    musicien.forme:=0;                                    //si sa forme est à 0 il tombe malade
    musicien.timer_occupation:=musicien.timer_occupation+2;      //il devra se reposer 2 mois de plus
    musicien.sante:=malade;
  end;
  afficherPromo(musicien);            //affiche le message

end;




procedure interrompreAlbum();                  //si un musicien tombe malade pendant l'enregistrement de l'album
var
   numMusicien:integer;             // entier compteur de la boucle
begin
  nbAlbum:=nbAlbum-1;               //l'album est annulé
  if renommee>0 then renommee:=renommee-1;             //le groupe perd de la renommée
  nbChansonEnregistrees:=nbChansonEnregistrees+10;                //il n'utilise finalement pas les chansons
  timerBuzzAlbum:=timerBuzzAlbum-5;
  for numMusicien:=1 to length(groupe) do           //boucle sur tous les membres du groupe
  begin
     groupe[numMusicien].timer_occupation:=groupe[numMusicien].timer_occupation-6;       //les musiciens ne sont plus occupés par l'album
     groupe[numMusicien].statut:=libre;
   end;
  afficherInterompreAlbum();             //affiche le message
end;





procedure enregistrer_un_album();                     //le groupe enregistre un album
var
   numMusicien : integer;
   AlbumIsCanceled : boolean;              //passe à vrai si l'album est interrompu
begin
  AlbumIsCanceled:=false;
  if nbChansonEnregistrees>=10 then              //si le groupe a assez de chansons
  begin
    for numMusicien:=1 to length(groupe) do               //boucle sur tout les membres du groupe
    begin
      groupe[numMusicien].statut:=album;                    //change le statut
      groupe[numMusicien].forme:= groupe[numMusicien].forme-9 ;        //modifie la forme
      groupe[numMusicien].timer_occupation:=6;                //le groupe est occupé pendant 6 mois

      if groupe[numMusicien].forme <= 0 then
      begin
        groupe[numMusicien].forme:=0;                         //si sa forme est à 0 il tombe malade
        groupe[numMusicien].sante:=malade;
        groupe[numMusicien].timer_occupation:=groupe[numMusicien].timer_occupation+2;         //il devra se reposer 2 mois de plus
        AlbumIsCanceled:=true;
      end;
    end;
    nbChansonEnregistrees:=nbChansonEnregistrees-10;                 //le groupe utilise 10 chansons de son catalogue
    timerBuzzAlbum:=timerBuzzAlbum+5;        //augmente le buzz
    nbAlbum:=nbAlbum+1;                     //le nombre d'albums augmente de
    afficherEnregistrerAlbum();               //affiche le message d'enregistrement d'album
    if AlbumIsCanceled = true then interrompreAlbum();        //l 'album est interrompu
  end
  else afficherPasAssezDeChansons();             //affiche le message pas assez de chansons
end;





procedure interrompreConcert(gainRenommee : integer);                  //si un musicien tombe malade pendant un concert
var
   numMusicien:integer;             // entier compteur de la boucle
begin
  if renommee>0 then renommee:=renommee-(gainRenommee*2);             //le groupe perd de la renommée
  if renommee<0 then renommee:=1;
  argent:=argent-2000;                //le groupe paie la location de la salle
  ConcertAPayer:=false;
  for numMusicien:=1 to length(groupe) do           //boucle sur tous les membres du groupe
  begin
     groupe[numMusicien].timer_occupation:=groupe[numMusicien].timer_occupation-6;       //les musiciens ne sont plus occupés par le concert
     groupe[numMusicien].statut:=libre;
   end;
  afficherInterrompreConcert();             //affiche le message
end;





procedure faireUnConcert();                  //le groupe fait un concert
var
   numMusicien :integer;   //compteur boucle
   concertIsCanceled : boolean;           //passe à vrai si un des membres du groupe tombe malade
   gainRenommee : integer ;             //entier repésentant le gain de renommée durant le concert
begin
  gainRenommee:=0;
   concertIsCanceled:=false;
   if nbAlbum>0 then                  //si le groupe a au moins un album
    begin
      for numMusicien:=1 to length(groupe) do               //boucle sur tout les membres du groupe
      begin
        groupe[numMusicien].statut:=concert;                    //change le statut
        groupe[numMusicien].forme:= groupe[numMusicien].forme-9;        //modifie la forme
        groupe[numMusicien].timer_occupation:=6;                //le groupe est occupé pendant 6 mois
        gainRenommee:=(gainRenommee+groupe[numMusicien].niveauConcert) div 10;          //la renommée augmente selon le niveau en concert des musiciens
        if groupe[numMusicien].forme <= 0 then
        begin
          groupe[numMusicien].forme:=0;                         //si la forme d'un membre est à 0 il tombe malade
          groupe[numMusicien].sante:=malade;
          groupe[numMusicien].timer_occupation:=groupe[numMusicien].timer_occupation+2;         //il devra se reposer 2 mois de plus
          concertIsCanceled:=true;
        end;
      end;
      renommee:=renommee+gainRenommee;                     //le groupe gagne en renommée
      ConcertAPayer:=true;              //passe a vrai quand le groupe fait un concert pour activer le payement à la fin du mois
      afficherFaireConcert();            //affiche le message

      if concertIsCanceled = true then interrompreConcert(gainRenommee);
    end
    else afficherPasAssezAlbum();        //affiche le message si il n'y a pas assez d'album
end;







procedure BilanFinancierMois();                //fait le bilan du mois
begin
  argentAlbum:=(nbalbum*3000*renommee*timerBuzzAlbum);               //il gagne de l'argent proportionnelement à sa renommé et au nombre d'albums enregistrés
  argent :=argent+argentAlbum;
  if ConcertAPayer=True then                 //si il a fait un concert
  begin
    argentConcert:=15000*renommee;            //il gagne de l'argent proportionnelement à sa renommé
    argent:=argent+ argentConcert;            //le total d'argent augmente
  end;
  afficherBilanDuMois();                  //affichage bilan du mois
  if ConcertAPayer=true then ConcertAPayer:=false;  //il n'y a plus de concert a payé
end;






procedure pasDeChance();
var
   nbPasChance : integer;
   randomNb : integer;        //entier aléatoire
   randomMusicien : integer;     //numero d'un musicien aléatoire
begin
  nbpasChance := 5;
  randomNb:=random(20);
  if nbPasChance = randomNb then
  begin
     randomMusicien:=random(4)+1;    //entier entre 1 et 5
     groupe[randomMusicien].sante:=malade;
     groupe[randomMusicien].timer_occupation:=groupe[randomMusicien].timer_occupation+2;
     afficherPasDeChance();
  end;
end;






procedure bilanFinancierAnnee();                  //fait le bilan financier de l'année
var
   numMusicien : integer;         //compteur boucle

begin
  totalSalaire:=0;
  for numMusicien:=1 to length(groupe) do totalSalaire:=totalSalaire+groupe[numMusicien].salaire;            //fait la somme des salaires
  argent:= argent-totalSalaire;               //deduit l'argent restant
  afficherBilanAnnee();           //affiche le message
  if argent<=0 then             //si le groupe n'a plus d'argent c'est perdu
  begin
    afficheGameOver();             //affiche le message de fin de partie
    partie_continue:=False;            //la partie se termine
  end;

end;







procedure passerUnTour();               //passe au mois suivant
 var
    numMusicien : integer;      //compteur boucle
begin
  BilanFinancierMois();               //bilan du mois
  compteurMois := (compteurMois+1);
  if compteurMois=13 then compteurMois:=1;
  mois:=annee[compteurMois];     //le mois passe au suivant
  if timerBuzzAlbum > 0 then timerBuzzAlbum:=timerBuzzAlbum-1;         //diminue le buzz de l'album
  if mois=janvier then bilanFinancierAnnee();           //fait le bilan annuel à la fin de décembre
  pasDeChance();
  for numMusicien:=1 to length(groupe) do              //boucle sur tous les membres du groupe
  begin
    if (groupe[numMusicien].timer_occupation > 0) then groupe[numMusicien].timer_occupation:=groupe[numMusicien].timer_occupation-1;            //les membres sont occuppés un mois de moins
    if groupe[numMusicien].forme<10 then groupe[numMusicien].forme:=groupe[numMusicien].forme+1;       //ils regagnent en forme
    if groupe[numMusicien].timer_occupation=0 then                                 //si ils ne sont plus occuppés
    begin
      groupe[numMusicien].sante:=en_forme;                                     //ils sont de nouveaux en forme et libres
      groupe[numMusicien].statut:=libre;
    end;
  end;
end;






procedure attribuertaches();                  //menu pour attribuer une tache aux musiciens
var
   numMusicien : integer;  //numéro musicien
   i : integer;
   tache : integer;    //numero de la tache
   quit : boolean;     //boolean qui ferme la boucle du menu
   toutLeMondeEstLibre : boolean;             //boolean qui passe à vrai si tous les membres du groupes sont libres
begin
  toutLeMondeEstLibre:=true;           //initialisation boolean
  quit:=false;
  while quit=false do                    //boucle du menu des taches
  begin
     tache := afficherListeTaches();        //affiche la liste des taches et retourne la tache choisie
     if tache=9 then quit:=true             //si le joueur entre 9 il retourne au menu principal
     else                                  //sinon
     begin
       if (tache=3) or (tache=4) then             // si c'est une tache de groupe
       begin
         for i:=1 to length(groupe) do if (groupe[i].statut<>libre) or (groupe[i].sante<>en_forme) then toutLeMondeEstLibre:=false;       //vérifie si tout les musiciens sont libres et en bonne santé
         if toutLeMondeEstLibre=True then               //si tout le monde est en bonne santé et libre
         begin
           if tache=3 then enregistrer_un_album();       //le groupe fait un album
           if tache=4 then faireUnConcert();              //le groupe fait un concert
         end;
         if toutLeMondeEstLibre=false then afficherUnMembreOccupe();            //affiche le message si un membre n'est pas libre
       end
       else             //si c'est une tache individuelle
       begin
         afficherGroupe(groupe);           //affiche les membres du groupe
         numMusicien := affichageChoixMenuGroupe();
         if (groupe[numMusicien].sante=malade) or (groupe[numMusicien].statut<>libre) then afficherMusicienIndispo();            //affiche le message si le musicien sélectionné n'est pas libre
         if (groupe[numMusicien].sante=en_forme) and (groupe[numMusicien].statut=libre) then                  //si il est libre
         begin
           if tache=1 then ecrireUneChanson(groupe[numMusicien]);
           if tache=2 then Enregistrement(groupe[numMusicien]);
           if tache=5 then entrainerMusicien(groupe[numMusicien]);                        //appelle la tache correspondante
           if tache=6 then faire_promo(groupe[numMusicien]);
         end;
       end;
     end;

  end;
end;







procedure menuGestionMusicien() ;                  //menu ou l'utilisateur choisit de virer ou recruter un musicien
var
   quit : boolean;               //ferme le menu si il passe à vrai
   stopOrContinue : integer;          //entier saisit par l'utilisateur
   recruteOrFired : integer;           //entier saisit par l'utilisateur pour choisir de virer ou recruter

begin
  quit:=False;
  while quit=False do
  begin
    recruteOrFired:= afficherRecruitorFired();            //retourne entier saisit par l'utilisateur pour choisir de virer ou recruter
    if recruteOrFired=1 then recruterMusicien(MusicienDispo,groupe);
    if recruteOrFired=0 then VirerMusicien(musicienDispo,groupe);
    groupeIsValide:=checkGroupeValide(groupe);       //vérifie  que le groupe est valide après les modifications
    stopOrContinue := afficherContinueOrHomeMenu;           //retourne entier saisit par l'utilisateur pour choisir de continuer ou revenir au menu principal
    if stopOrContinue=0 then quit:=True;
  end;
end;







procedure menuPrincipal();             //menu principal
var
   choix : integer;         //entier chois de l'utilisateur
begin
  partie_continue :=true;         //boolean ferme la partie si passe à faux
  while partie_continue = true do         //tant que patie_continue est vrai
  begin
   afficherMenuPrincipal();             //affiche l'écran du menu principal
   choix:=affichageChoixecranPrincipal();          //affiche les choix et retourne celui choisit
   if choix=0 then menuGestionMusicien();
   if (choix=1) or (choix=2) then
   begin
     if GroupeIsValide=True then
     begin
       if choix = 1 then attribuertaches();
       if choix = 2 then passerUnTour();
     end
     else afficherGroupeInvalide();
   end;
   if choix=9 then partie_continue:=false;
  end;
end;






procedure menu_depart();
var choix : string;
begin
     choix := menu_depart_ihm();
     if choix = '1' then
     begin
       CreationMusicien();         //initialise les musiciens
       initialisationGroupe();
       initialisation();
       initialisationAnnee();
       menuprincipal();
     end;
     if choix = '0' then quitterIHM();
end;



end.
