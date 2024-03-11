class Obstacle {
  int x;
  float y;
  int largeur;
  int epaisseur;
  String type;
  int hauteur;
  boolean ramasser;




  Obstacle(int x, int y, int largeur, String type) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.type = type;
    this.hauteur = height/80;
  }


  Obstacle(int x, int y, String type, boolean ramasser) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.type = type;
    this.ramasser = ramasser;
  }


  Obstacle(int x, int y, int largeur, int epaisseur, String type) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.epaisseur = epaisseur;
    this.type = type;
  }


  Obstacle() {
    this.x = personnage.x;
    this.y = personnage.y + personnage.hauteur;
    this.largeur = personnage.largeur;
    this.epaisseur = height/80;
    this.type = "plateformemagic";
  }

  void dessiner() {
    this.x -= niveau.defilement;
    if (this.type == "plateforme") {
      fill(0, 0, 255);
      rect(this.x, this.y, this.largeur, height/80);
    } else if (this.type == "plateformemagic") {
      fill(240, 12, 236);
      rect(this.x, this.y, this.largeur, this.epaisseur);
    } else if (this.type == "mur") {
      fill (246, 250, 30);
      rect(this.x, this.y, this.largeur, this.epaisseur);
    } else if (this.type == "piece") {
      //this.x = width/2;
      //this.y = height/2;
      float ellipse1 = width*0.23;
      float ellipse2 = width*0.1875;
      float ellipse3 = width*0.15625;
      float ellipse4 = width*0.15625;
      fill(177, 191, 37);
      ellipse(this.x, this.y, width * 0.045, height * 0.055);
      fill(212, 227, 53);
      noStroke();
      ellipse(this.x, this.y, width * 0.0375, height * 0.045);
      stroke(1);
      fill(221, 237, 57);
      ellipse(this.x, this.y, width * 0.03125, height * 0.035);
      fill(239, 255, 67);
      ellipse(this.x, this.y, width * 0.00417, height * 0.005);
    }
  }


  void detecterGD(Ennemi ennemi) {
    if (ennemi.colisionplateforme()) {
      if (ennemi.deplacement == "D") {

        if (ennemi.x + ennemi.largeur + ennemi.vitesse > this.x + this.largeur ) {

          ennemi.deplacement = "G";
          ennemi.image = image_ennemiDvG;
        }
      } else {
        if (ennemi.x -ennemi.vitesse < this.x) {
          ennemi.deplacement = "D";
          ennemi.image = image_ennemiGvD;
        }
      }
    } else if (ennemi.estausol()) {
      if (ennemi.deplacement == "D") {
        if (ennemi.x + ennemi.largeur + ennemi.vitesse >= width) {
          ennemi.deplacement = "G";
          ennemi.image = image_ennemiDvG;
        }
      } else {
        if (0 >= this.x) {
          ennemi.deplacement = "D";
          ennemi.image = image_ennemiGvD;
        }
      }
    }
  }
  
  
  boolean collision(Personnage personnage) {
  // Trouver le point le plus proche du cercle à l'intérieur du rectangle
  float closestX = constrain(this.x, personnage.x, personnage.x + personnage.largeur);
  float closestY = constrain(this.y, personnage.y, personnage.y + personnage.hauteur);
  
  // Calcul de la distance entre le cercle et le point le plus proche
  float distanceX = this.x - closestX;
  float distanceY = this.y - closestY;
  float distanceSquared = (distanceX * distanceX) + (distanceY * distanceY);
  
  // La distance au carré est inférieure ou égale au rayon au carré du cercle (collision détectée)
  return distanceSquared <= ((this.largeur / 2) * (this.largeur / 2));
}
}
