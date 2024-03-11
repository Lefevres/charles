class Obstacle {
  int x;
  int y;
  int largeur;
  int epaisseur;
  String type;



  Obstacle(int x, int y, int largeur) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.type = "plateforme";
  }


  Obstacle(int x, int y, int largeur, int epaisseur) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.epaisseur = epaisseur;
    this.type = "obstacle";
  }


  void dessiner() {
    if (this.type == "plateforme") {
      fill(0, 0, 255);
      rect(this.x, this.y, this.largeur, height/80);
    }
  }


  void detecterGD(Ennemi ennemi) {
    if (ennemi.colisionplateforme()) {
      println(ennemi.x + ennemi.largeur + ennemi.vitesse ,this.x + this.largeur);
      if (ennemi.deplacement == "D") {
        
        if (ennemi.x + ennemi.largeur + ennemi.vitesse > this.x + this.largeur) {
          
          ennemi.deplacement = "G";
        }
      } else {
        if (ennemi.x -ennemi.vitesse < this.x) {
          ennemi.deplacement = "D";
        }
      }
    } else if (ennemi.estausol()) {
      if (ennemi.deplacement == "D") {
        if (ennemi.x + ennemi.largeur + ennemi.vitesse >= width) {
          ennemi.deplacement = "G";
        }
      } else {
        if (0 >= this.x) {
          ennemi.deplacement = "D";
        }
      }
    }
  }
}
