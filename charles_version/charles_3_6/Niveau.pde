class Niveau {
  int defilement = 0;
  String fichier;
  String[] donneedeniveau;



  Niveau(String fichier) {
    this.fichier = fichier;
  }


  void affichage() {
    affichercoeur(width/19, height/16, 1.05);
    afficherpiece();
  }


  void affichercoeur(int coeurx, int coeury, float taille) {
    fill(255, 0, 0);
    beginShape();
    for (float angle = 0; angle < TWO_PI; angle += 0.01) {
      float x = taille * 16 * pow(sin(angle), 3);  // Équation paramétrique en x avec facteur d'échelle
      float y = -taille * (13 * cos(angle) - 5 * cos(2*angle) - 2 * cos(3*angle) - cos(4*angle));  // Équation paramétrique en y avec facteur d'échelle
      vertex(x+coeurx, y+coeury);
    }
    endShape(CLOSE);
    fill(255);
    textSize(40);
    text(personnage.pointdevie, coeurx+width/80, coeury+height/75);
  }


  void afficherpiece() {
    fill(177, 191, 37);
    ellipse(width/19, height/8, width * 0.045, height * 0.055);
    fill(212, 227, 53);
    noStroke();
    ellipse(width/19, height/8, width * 0.0375, height * 0.045);
    stroke(1);
    fill(221, 237, 57);
    ellipse(width/19, height/8, width * 0.03125, height * 0.035);
    fill(239, 255, 67);
    ellipse(width/19, height/8, width * 0.00417, height * 0.005);
    fill(255);
    textSize(40);
    text(personnage.piece, width/15+width/80, height/8+height/75);
  }


  void charger() {
    int[] resultatpreparation = preparertableaux();
    plateforme = new Obstacle[resultatpreparation[0]]; // Initialisez le tableau obstacle avec la taille obtenue
    ennemi = new Ennemi[resultatpreparation[1]];
    mur = new Obstacle[resultatpreparation[2]];
    creationtableaux();
  }


  int[] preparertableaux() {
    int[] retour = new int[3];
    donneedeniveau = loadStrings(this.fichier);
    int compteurplateforme = 0;
    int compteurennemi = 0;
    int compteurmur = 0;
    for (int y = 0; y < donneedeniveau.length; y++) {
      String ligne = donneedeniveau[y];
      boolean enPlateforme = false;
      for (int x = 0; x < ligne.length(); x++) {
        char caractere = ligne.charAt(x);
        if (caractere == '#') {
          if (!enPlateforme) {
            enPlateforme = true;
            compteurplateforme++;
          }
        } else {
          enPlateforme = false;
          if (caractere == 'E' || caractere == 'e') {
            compteurennemi++;
          }
          if (caractere == 'm' || caractere == 'M') {
            compteurmur ++;
          }
        }
      }
    }
    retour[0] = compteurplateforme;
    retour[1] = compteurennemi;
    retour[2] = compteurmur;
    return retour;
  }


  void creationtableaux() {
    donneedeniveau = loadStrings(this.fichier);
    int coefx = width/100;
    int coefy = height/100;
    int compteurplateforme = 0;
    int compteurennemi = 0;
    int compteurmur = 0;
    for (int y = 0; y < donneedeniveau.length; y++) {
      String ligne = donneedeniveau[y];
      int longueurplateforme = 0;
      for (int x = 0; x < ligne.length(); x++) {
        char caractere = ligne.charAt(x);
        if (caractere == '#') {
          longueurplateforme++;
        } else {
          if (caractere == 'E' || caractere == 'e') {
            ennemi[compteurennemi] = new Ennemi(image_ennemiGvD, x*coefx, y*coefy);
            compteurennemi++;
          } else if (caractere == 'm' || caractere == 'M') {
            mur[compteurmur] = new Obstacle (x*coefx, y*coefy, 50, 50, "mur");
            compteurmur ++;
          } else if (caractere == 'p' || caractere == 'P') {
            piece.add( new Obstacle (x*coefx, y*coefy, "piece", false));
          }
          if (longueurplateforme != 0) {
            plateforme[compteurplateforme] = new Obstacle((x - longueurplateforme)*coefx, y*coefy, longueurplateforme*10, "plateforme");
            compteurplateforme++;
            longueurplateforme = 0;
          }
        }
      }
      // Si la ligne se termine par un obstacle, ajoutez-le également
      if (longueurplateforme != 0) {
        plateforme[compteurplateforme] = new Obstacle((ligne.length() - longueurplateforme)*coefx, y*coefy, longueurplateforme*10, "plateforme");
        compteurplateforme++;
        longueurplateforme = 0;
      }
    }
  }


  void fin() {
    textAlign(CENTER, CENTER);
    textSize(width/15);
    fill(255);
    if (perdu) {
      text("Vous avez perdu", width/2, height/2);
    } else {
      text("Vous avez gagnez", width/2, height/2);
    }
  }
}
