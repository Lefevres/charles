class Niveau {
  String fichier;
  String[] donneedeniveau;



  Niveau(String fichier) {
    this.fichier = fichier;
  }


  void affichage() {
    affichercoeur(width/19, height/16, 1.05);
    
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
    text(personnage.pointdevie,coeurx+width/80,coeury+height/75);
    
    
  }


  void charger() {
    int[] resultatpreparation = preparertableaux();
    obstacle = new Obstacle[resultatpreparation[0]]; // Initialisez le tableau obstacle avec la taille obtenue
    ennemi = new Ennemi[resultatpreparation[1]];
    creationtableaux();
  }


  int[] preparertableaux() {
    int[] retour = new int[2];
    donneedeniveau = loadStrings(this.fichier);
    int compteurplateforme = 0;
    int compteurennemi = 0;
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
        }
      }
    }
    retour[0] = compteurplateforme;
    retour[1] = compteurennemi;
    return retour;
  }


  void creationtableaux() {
    donneedeniveau = loadStrings(this.fichier);
    int compteurplateforme = 0;
    int compteurennemi = 0;
    for (int y = 0; y < donneedeniveau.length; y++) {
      String ligne = donneedeniveau[y];
      int longueurplateforme = 0;
      for (int x = 0; x < ligne.length(); x++) {
        char caractere = ligne.charAt(x);
        if (caractere == '#') {
          longueurplateforme++;
        } else {
          if (caractere == 'E' || caractere == 'e') {
            ennemi[compteurennemi] = new Ennemi(image_ennemi, x*10, y*10);
            compteurennemi++;
          }
          if (longueurplateforme != 0) {
            obstacle[compteurplateforme] = new Obstacle((x - longueurplateforme)*10, y*10, longueurplateforme*10);
            compteurplateforme++;
            longueurplateforme = 0;
          }
        }
      }
      // Si la ligne se termine par un obstacle, ajoutez-le également
      if (longueurplateforme != 0) {
        obstacle[compteurplateforme] = new Obstacle((ligne.length() - longueurplateforme)*10, y*10, longueurplateforme*10);
        compteurplateforme++;
        longueurplateforme = 0;
      }
    }
  }
}
