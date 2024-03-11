Personnage personnage;
Niveau niveau;
PImage image_personnage;
PImage image_ennemiDvG;
PImage image_ennemiGvD;
boolean enjeu = true;
int niveauactuel = 0;
int nombreniveau = 4;
String[] niv = new String [nombreniveau];
Obstacle[] plateforme;
Ennemi[] ennemi;
ArrayList<Obstacle> piece = new ArrayList<Obstacle>();
int piecetotal;
ArrayList<Obstacle> plateformeMagic = new ArrayList<Obstacle>();


void setup() {
  niv[0] = "niveau1.txt";
  niv[1] = "niveau2.txt";
  niv[2] = "niveau3.txt";
  niv[3] = "niveau_raphou";

  size(1200, 900, P3D);
  //fullScreen();
  //windowResizable(true);
  frameRate(60);
  image_personnage = loadImage("bosnome.png");
  image_ennemiGvD = loadImage("ennemiGvD.png");
  image_ennemiDvG = loadImage("ennemiDvG.png");
  personnage = new Personnage(image_personnage);
  niveau = new Niveau();
  niveau.charger();
}


void draw() {
  background(0);
  if (!niveau.perdu && !niveau.victoire) {
    niveau.defilement =0;
    //boite();
    personnage.jeu();
    for (Obstacle plateforme : plateforme) {
      plateforme.dessiner();
      for (Ennemi ennemi : ennemi) {
        if (ennemi.y + ennemi.hauteur == plateforme.y) {
          plateforme.detecterGD(ennemi);
        }
      }
    }
    int i = 0;
    while (i < piece.size()) {
      if (piece.get(i).collision(personnage)) {
        piece.get(i).ramasser = true;
        personnage.ajouterPiece();
        piece.remove(i);
      } else {
        if (!piece.get(i).ramasser) {
          piece.get(i).dessiner();
        }
        i++; // Incrémente seulement si l'élément n'est pas supprimé
      }
    }
    for (Ennemi ennemi : ennemi) {
      ennemi.jeu();
    }
    niveau.affichage();
  } else {
    niveau.fin();
  }
}


void keyPressed() {   //Cette fonction est appelée chaque fois qu'une touche est enfoncée. Elle est utilisée pour gérer les actions du joueur en fonction des touches pressées
  if (key == 'z' || key == 'Z') {
    if (plateformeMagic.size() != 0) {
      plateformeMagic.remove(0);
    }
    personnage.appuyeeZ();
  } else if (key == 'q' || key == 'Q') {
    personnage.appuyeeQ();
  } else if (key == 's' || key == 'S') {
    if (plateformeMagic.size() != 0) {
      plateformeMagic.remove(0);
    }
    personnage.appuyeeS();
  } else if (key == 'd' || key == 'D') {
    personnage.appuyeeD();
  } else if (key == 'y' || key == 'y') {
    personnage.ajouterPointDeVie();
  } else if (key == 'e' || key == 'e') {
    personnage.enleverPointDeVie();
  } else if (key == 'r' || key == 'r') {
    personnage.ajouterPlateforme();
  } else if (key == 't' || key == 't') {
    personnage.enleverPlateforme();
  }
  if (key == ' ' && personnage.nombreplateforme > 0) {
    if (plateformeMagic.size() == 0) {
      plateformeMagic.add(new Obstacle());
    } else {
      plateformeMagic.get(0).x = personnage.x;
      plateformeMagic.get(0).y = personnage.y + personnage.hauteur;
    }
    personnage.nombreplateforme --;
  }
  if (key == CODED) {
    if (keyCode == UP && niveau.perdu == true) {
      niveau.perdu = false;
      niveau.victoire = false;
      piece.clear();
      niveau.charger();
    }
  }
}


void keyReleased() {  // Cette fonction est appelée chaque fois qu'une touche est relâchée. Elle est utilisée pour arrêter les actions du joueur lorsque les touches sont relâchées.
  if (key == 'z' || key == 'Z') {
    personnage.relacheeZ();
  } else if (key == 'q' || key == 'Q') {
    personnage.relacheeQ();
  } else if (key == 's' || key == 'S') {
    personnage.relacheeS();
  } else if (key == 'd' || key == 'D') {
    personnage.relacheeD();
  }
}


void boite() {
  noFill();
  stroke(255);
  rect(personnage.x, personnage.y, personnage.largeur, personnage.hauteur);
  for (Ennemi ennemi : ennemi) {
    rect(ennemi.x, ennemi.y, ennemi.largeur, ennemi.hauteur);
  }
}
