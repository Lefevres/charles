Personnage personnage;
Niveau niveau;
PImage image_personnage;
PImage image_ennemiDvG;
PImage image_ennemiGvD;
boolean enjeu = true;
Obstacle[] obstacle;
Ennemi[] ennemi;
ArrayList<Obstacle> liste = new ArrayList<Obstacle>();
boolean perdu;



void setup() {
  size(1200, 999+1);

  frameRate(60);
  //fullScreen();
  image_personnage = loadImage("bosnome.png");
  image_ennemiGvD = loadImage("ennemiGvD.png");
  image_ennemiDvG = loadImage("ennemiDvG.png");
  personnage = new Personnage(image_personnage);
  niveau = new Niveau("niveau.txt");
  niveau.charger();
}


void draw() {
  background(0);
  if (!perdu) {

    boite();
    personnage.gravite();
    personnage.dessiner();
    personnage.deplacer();
    //println(personnage.x,personnage.y,personnage.estsurunappui(), personnage.colision());
    niveau.affichage();
    fill(255);
    //println(personnage.y);
    fill(255, 0, 0);
    ellipse(width/2, 294, 20, 20);
    ellipse(width/2, height/2, 20, 20);
    for (Obstacle plateforme : obstacle) {
      plateforme.dessiner();
      stroke(255);
      line(0, plateforme.y, width, plateforme.y);
      for (Ennemi ennemi : ennemi) {
        if (ennemi.y + ennemi.hauteur == plateforme.y) {
          plateforme.detecterGD(ennemi);
        }
      }
      //println(ennemi[0].estsurunappui(),personnage.estsurunappui());
    }
    for (Ennemi ennemi : ennemi) {
      ennemi.gravite();
      if (ennemi.estsurunappui()) {
        ennemi.deplacement();
      }
      ennemi.dessiner();
      ennemi.toucher(personnage);
    }
  } else {
    niveau.perdu();
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
  if (key == ' ') {
    println(millis()); // Enregistrer le temps au démarrage du compte à rebours
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



void boite() {
  noFill();
  rect(personnage.x, personnage.y, personnage.largeur, personnage.hauteur);
  for (Ennemi ennemi : ennemi) {
    rect(ennemi.x, ennemi.y, ennemi.largeur, ennemi.hauteur);
  }
}
