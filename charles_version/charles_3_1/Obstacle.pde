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


  
}
