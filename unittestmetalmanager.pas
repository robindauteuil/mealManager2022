unit UnitTestMetalManager;

interface



procedure tests();
implementation
uses
  unit_logicTachesMetalManager,UnitLogicMusicienMetalManager,TestUnitaire,GestionEcran;


procedure testEcrireChanson();       //vérifie que le statut et la forme du musicien soit correctement modifié et que le nombre de chanson écrites augmente de 1
begin
  newTestsSeries('tests des taches musiciens');
  newTest('tests des taches musiciens', 'test EcrireChanson');
  initialisation();
  CreationMusicien;
  ecrireUneChanson(Musicien2);
  testIsEqual(musicien2.forme,6);
  testIsEqual(musicien2.timer_occupation, 2);
  testIsEqual(nbChansonsEcrites,1);

end;


procedure testSentrainer();
begin
newtest('tests des taches musiciens', 'test s entrainer');

CreationMusicien;
entrainerMusicien(musicien2);
testIsEqual(musicien2.forme,6);
testIsEqual(musicien2.timer_occupation, 2);
testIsEqual(musicien2.niveauInstru,7);
end;



procedure testEnregistrement();
begin
newtest('tests des taches musiciens', 'test enregistrer une chanson');
CreationMusicien;
initialisation();
nbChansonsEcrites:=1;
Enregistrement(musicien2);
testIsEqual(nbChansonEnregistrees,1);
testIsEqual(musicien2.forme,6);
testIsEqual(musicien2.timer_occupation, 2);
end;



procedure testFaireConcert();
var
  i : integer;
begin
  newTestsSeries('tests taches collectives');
  newTest('tests taches collectives','test faire un concert');
  initialisation();
  initialisationGroupe();
  CreationMusicien;
  groupe[1]:=musicien1;
  groupe[2]:=musicien2;
  groupe[3]:=musicien3;
  groupe[4]:=musicien4;
  groupe[5]:=musicien5;
  nbAlbum:=1;
  faireUnConcert();
  for i:=1 to length(groupe) do
  begin
    testIsEqual(groupe[i].forme,1);
    testIsEqual(groupe[i].timer_occupation,6);
  end;
  testIsEqual(ConcertAPayer);
end;




procedure testFaireAlbum();
var
  i :integer;
begin
  newTest('tests taches collectives','test faire un album');
  initialisation();
  initialisationGroupe();
  CreationMusicien;
  groupe[1]:=musicien1;
  groupe[2]:=musicien2;
  groupe[3]:=musicien3;
  groupe[4]:=musicien4;
  groupe[5]:=musicien5;
  nbChansonEnregistrees:=15;
  enregistrer_un_album;
  for i:=1 to length(groupe) do
  begin
    testIsEqual(groupe[i].forme,1);
    testIsEqual(groupe[i].timer_occupation,6);
  end;
  testIsEqual(nbAlbum,1);
end;




procedure testInitialisation();
begin
  newTestsSeries('test initialisation');
  newTest('test initialisation','test initialisation variable de depart');
  initialisation();
  testIsEqual(argent,10000);
  testIsEqual(nbAlbum,0);
  testIsEqual(renommee,1);
  testIsEqual(nbChansonEnregistrees,0);
  testIsEqual(nbChansonsEcrites,0);
end;




procedure testAnnee();
begin
  newTest('test initialisation','test initialisation annee');
  initialisationAnnee();
  testIsEqual(length(annee),12);
end;




procedure testInterrompreConcert();
begin

end;


procedure testPasserTour();
begin
  newTestsSeries('tests menu');
  newTest('tests menu','test passer tour');
  initialisationAnnee();
  CreationMusicien;
  initialisationGroupe();
  groupe[1] := musicien1;
  Musicien1.forme := 9;
  Musicien1.timer_occupation:=1;
  passerUnTour();
  testIsEqual(Musicien1.forme,10);
  testIsEqual(Musicien1.timer_occupation,0);
  testIsEqual(compteurMois,2);
end;

procedure tests();
begin
  testEcrireChanson();
  testSentrainer();
  testEnregistrement();
  testFaireConcert();
  testFaireAlbum();
  testInitialisation();
  testAnnee();
  testPasserTour();
  effacerEcran;
  Summary();
  readln();
end;

end.

