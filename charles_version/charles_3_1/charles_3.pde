Personnage personnage;
Niveau niveau;
PImage image_personnage;
PImage image_ennemi;
float grav=0;
Obstacle[] obstacle;
Ennemi[] ennemi;


void setup() {
  size(900, 999+1);
  //fullScreen();

  image_personnage = loadImage("bosnome.png");
  image_ennemi = loadImage("ennemiDvG.png");
  personnage = new Personnage(image_personnage);
  niveau = new Niveau("niveau.txt");
  niveau.charger();
}


void draw() {
  background(0);
  personnage.gravite();
  personnage.dessiner();
  personnage.deplacer();
  //println(personnage.x,personnage.y,personnage.estsurunappui(), personnage.colision());
  niveau.affichage();
  fill(255);
  println(personnage.estsurunappui());
  ellipse(width/2,height/2,20,20);
  for (Obstacle plateforme : obstacle){
  plateforme.dessiner();
  }
  for (Ennemi ennemi : ennemi){
    ennemi.gravite();
    ennemi.dessiner();
  }
}


void keyPressed() {
  if (key == 'z' || key == 'Z') {
    personnage.Zappuyee();
  } else if (key == 'q' || key == 'Q') {
    personnage.Qappuyee();
  } else if (key == 's' || key == 'S') {
    personnage.Sappuyee();
  } else if (key == 'd' || key == 'D') {
    personnage.Dappuyee();
  } else if (key == 'y' || key == 'y') {
    personnage.ajouterpointdevie();
  } else if (key == 'e' || key == 'e') {
    personnage.enleverpointdevie();
  } else if (key == 'r' || key == 'r') {
    personnage.ajouterplateforme();
  } else if (key == 't' || key == 't') {
    personnage.enleverplateforme();
  }
}


void keyReleased() {
  if (key == 'z' || key == 'Z') {
    personnage.Zrelachee();
  } else if (key == 'q' || key == 'Q') {
    personnage.Qrelachee();
  } else if (key == 's' || key == 'S') {
    personnage.Srelachee();
  } else if (key == 'd' || key == 'D') {
    personnage.Drelachee();
  }
}
