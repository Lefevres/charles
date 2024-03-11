class Ennemi {
  int x;
  int y;
  int largeur;
  PImage image;
  int hauteur;
  int vitesse;
  int[] contrainte = new int[2];
  float grav;
  boolean[] direction = new boolean[2];
  boolean est_sur_une_plateforme=false;   //si sur une plateforme
  String deplacement = "G";


  Ennemi(int x, int y) {
    this.x=x;
    this.y=y;
    this.largeur=50;
    this.hauteur=50;
    this.contrainte[0] = 0;
    this.contrainte[1] = height-hauteur;
    this.direction[0] = false;
    this.direction[1] = false;
    this.grav=0;
    this.vitesse = 1;
  }


  Ennemi(int x, int y, int vitesse) {
    this.x=x;
    this.y=y;
    this.largeur=50;
    this.hauteur=50;
    this.vitesse=vitesse;
    this.direction[0] = false;
    this.direction[1] = false;
    this.contrainte[0] = 0;
    this.contrainte[1] = height-hauteur;
    this.grav=0;
  }

  void dessiner() {
    if (charles.toucher){fill(255,0,0);}else{
    fill(255);}
    this.fixer();
    this.graviter();
    this.colision(charles);
    this.y=constrain(this.y, contrainte[0], contrainte[1]);
    if (this.deplacement == "G"){
      image(imgennemig,this.x, this.y,this.largeur, this.hauteur);
    }else {
    image(imgennemid,this.x, this.y,this.largeur*2, this.hauteur);}
    
  }
  void colision(Perso personnage) {
    if (this.x + this.largeur == personnage.x || this.x == personnage.x + personnage.largeur) {
      if (this.y + this.hauteur == personnage.y + personnage.hauteur) {
        personnage.toucher();
      }
    }
  }


  void fixer() {
    this.x-=defilement;
  }


  boolean est_au_sol() {
    float marge = 1.0;
    if (this.y >= height - this.hauteur - marge) {
      return true;
    }
    return false;
  }


  void se_deplacer_a_droite() {
    this.x+=vitesse;
  }
  
  
  void se_deplacer_a_gauche() {
    this.x-=vitesse;
  }
  

  void graviter() {
    if (!this.est_au_sol() && this.est_sur_une_plateforme == false) {
      this.y += gravite;
    }
  }
}
