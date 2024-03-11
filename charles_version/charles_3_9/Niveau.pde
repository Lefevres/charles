class Niveau {
  int defilement = 0;
  String fichier;
  String[] donneedeniveau;
  boolean perdu;
  boolean victoire;


  Niveau() {
    this.fichier = niv[niveauactuel];
  }


  void affichage() {  //Méthode de la classe Niveau. Elle gère l'affichage des éléments du niveau, tels que les points de vie du joueur et les pièces collectées.
    afficherCoeur(width/19, height/16, 1.05);
    afficherPiece();
  }


  void afficherCoeur(int coeurx, int coeury, float taille) {//Méthode de la classe Niveau. Elle dessine un cœur pour représenter les points de vie du joueur.
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


  void afficherPiece() {   //Méthode de la classe Niveau. Elle dessine une pièce pour représenter les pièces collectées par le joueur.
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


  void charger() {  //Méthode de la classe Niveau. Elle charge les données du niveau à partir d'un fichier texte et initialise les obstacles et les ennemis en fonction de ces données.
    perdu = false;
    victoire = false;
    plateformeMagic.clear();
    personnage.piece = 0;
    personnage.pointdevie += 2;
    personnage.x = width/5;
    personnage.y = height; 
    this.fichier = niv[niveauactuel];
    personnage.nombreplateforme += 2;
    int[] resultatpreparation = preparerTableaux();
    plateforme = new Obstacle[resultatpreparation[0]]; // Initialisez le tableau obstacle avec la taille obtenue
    ennemi = new Ennemi[resultatpreparation[1]];
    creationTableaux();
    piecetotal = piece.size();
  }


  int[] preparerTableaux() { // Méthode de la classe Niveau. Elle prépare les tableaux pour stocker les obstacles et les ennemis en fonction des données du niveau.
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


  void creationTableaux() {  //Méthode de la classe Niveau. Elle crée les obstacles et les ennemis en fonction des données du niveau et les stocke dans les tableaux correspondants.
    donneedeniveau = loadStrings(this.fichier);
    int coefx = width/100;
    int coefy = height/100;
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
            ennemi[compteurennemi] = new Ennemi( x*coefx, y*coefy);
            compteurennemi++;
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


  void fin() {   //Méthode de la classe Niveau. Elle gère l'affichage de l'écran de fin de jeu, soit en cas de victoire, soit en cas de défaite.
    textAlign(CENTER, CENTER);
    textSize(width/15);
    fill(255);
    if (perdu) {
      text("Vous avez perdu", width/2, height/2);
    } else {
      delay(100);
      if (niveauactuel+1 < niv.length) {
        niveauactuel++ ;
        this.charger();
      } else {
        text("vous avez gagnez ! ", width/2, height/2);
      }
    }
  }
}
