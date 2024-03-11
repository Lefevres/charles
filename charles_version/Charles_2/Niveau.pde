class Niveau {
  String fichier;
  String[] donnerdeniveaux;

  Niveau(String fichier) {
    this.fichier = fichier;
  }


  void dessiner() {
    for (int obstacles = 0; obstacles < obstacle.length; obstacles++) {
      obstacle[obstacles].dessiner();
      for (int ennemie=0; ennemie <ennemi.length; ennemie++) {
        if (obstacle[obstacles].detecterCollisionAvecPlateforme(ennemi[ennemie])) {
         // println("la plateforme n°",obstacles, "detecte une collision avec l'ennemi numero ", ennemie);
          ennemi[ennemie].est_sur_une_plateforme = true;
        }
        ennemi[ennemie].dessiner();
        obstacle[obstacles].detecterCollisionAvecPlateformeGD(ennemi[ennemie]);
      }


      if (obstacle[obstacles].detecterCollisionAvecPlateforme(charles))
      {
        obstacle[obstacles].collisionAvecPersonnage(charles);
      }
    }
    rampe.collisionAvecPersonnage(charles);
  }




  void chargementniveau() {
    int compteur1 = 0;
    int compteur2 = 0;
    donnerdeniveaux = loadStrings(this.fichier);

    // Compter le nombre d'obstacles et d'ennemis
    for (int y = 0; y < donnerdeniveaux.length; y++) {
      String ligne = donnerdeniveaux[y];
      int debutPlateforme = -1;
      for (int x = 0; x < ligne.length(); x++) {
        char caractere = ligne.charAt(x);
        if (caractere == '#') {
          if (debutPlateforme == -1) {
            debutPlateforme = x;
          }
        } else if (caractere == 'E') {
          compteur2++;
        } else if (debutPlateforme != -1) {
          // Si nous trouvons un caractère différent de '#', c'est la fin de la plateforme
          compteur1++;
          debutPlateforme = -1;
        }
      }
      // Vérifier s'il y a une plateforme à la fin de la ligne
      if (debutPlateforme != -1) {
        compteur1++;
      }
    }

    // Initialiser les tableaux obstacle et ennemi avec la bonne taille
    obstacle = new Obstacle[compteur1];
    ennemi = new Ennemi[compteur2];

    // Parcourir à nouveau pour créer les obstacles et les ennemis
    compteur1 = 0;
    compteur2 = 0;
    for (int y = 0; y < donnerdeniveaux.length; y++) {
      String ligne = donnerdeniveaux[y];
      int debutPlateforme = -1;
      int longueur = 0;
      int largeur_plateforme = 25;
      for (int x = 0; x < ligne.length(); x++) {
        char caractere = ligne.charAt(x);
        if (caractere == '#') {
          if (debutPlateforme == -1) {
            debutPlateforme = x;
          } else {
            longueur++;
          }
        } else if (debutPlateforme != -1) {
          obstacle[compteur1] = new Obstacle(x, y, longueur*largeur_plateforme);
          compteur1++;
          debutPlateforme = -1;
          longueur = 0;
        } else if (caractere == 'E') {
          ennemi[compteur2] = new Ennemi(x, y);
          compteur2++;
        }
      }
      // Si nous trouvons une plateforme à la fin de la ligne
      if (debutPlateforme != -1) {
        obstacle[compteur1] = new Obstacle(debutPlateforme, y, longueur*largeur_plateforme);
        compteur1++;
      }
    }

    // Réajuster les positions des obstacles et des ennemis
    for (Obstacle obstacles : obstacle) {
      obstacles.x *= 18;
      obstacles.y *= 20;
    }
    for (Ennemi ennemie : ennemi) {
      ennemie.x *= 18;
      ennemie.y *= 20;
    }
  }
}
