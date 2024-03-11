Personnage personnage;
Niveau niveau;
PImage image_personnage;
PImage image_ennemiDvG;
PImage image_ennemiGvD;
boolean enjeu = true;
int niveauactuel = 0;
String[] niv = new String [2];
Obstacle[] plateforme;
Ennemi[] ennemi;
ArrayList<Obstacle> piece = new ArrayList<Obstacle>();
int piecetotal;
ArrayList<Obstacle> plateformemagic = new ArrayList<Obstacle>();
boolean perdu;
boolean victoire;



void setup() {
  niv[0] = "niveau1.txt";
  niv[1] = "niveau2.txt";
  //niv[2] = "niveau3.txt";
  size(1200, 900,P3D);
  windowResizable(true);
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
  if (!perdu && !victoire) {
    niveau.defilement =0;
    //boite();
    personnage.gravite();
    personnage.dessiner();
    personnage.deplacer();


    //fill(0);

    //fill(255, 0, 0);

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
        personnage.ajouterpiece();
        piece.remove(i);
      } else {
        if (!piece.get(i).ramasser) {
          piece.get(i).dessiner();
        }
        i++; // Incrémente seulement si l'élément n'est pas supprimé
      }
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
    niveau.fin();
  }
  niveau.affichage();
}



void keyPressed() {
  if (key == 'z' || key == 'Z') {
    if (plateformemagic.size() != 0) {
      plateformemagic.remove(0);
    }
    personnage.Zappuyee();
  } else if (key == 'q' || key == 'Q') {
    personnage.Qappuyee();
  } else if (key == 's' || key == 'S') {
    if (plateformemagic.size() != 0) {
      plateformemagic.remove(0);
    }
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
  if (key == ' ' && personnage.nombreplateforme > 0) {
    if (plateformemagic.size() == 0) {
      plateformemagic.add(new Obstacle());
    } else {
      plateformemagic.get(0).x = personnage.x;
      plateformemagic.get(0).y = personnage.y + personnage.hauteur;
    }
    personnage.nombreplateforme --;
  }
  if (key == CODED) {
    if (keyCode == UP && perdu == true) {
      perdu = false;
      victoire = false;
      piece.clear();
      niveau.charger();
    }
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
