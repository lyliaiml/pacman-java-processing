class Menu {
  
  Menu() {//vide
  }
  
  void drawIt() {
    // Cadre du menu
    fill(50, 50, 150);
    stroke(100, 100, 255);
    strokeWeight(3);
    rectMode(CENTER);
    rect(width/2, height/2, 190,220);
    rectMode(CORNER);
    
    // Titre
    fill(255, 255, 0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("PAUSE", width/2, height/2 - 80);
    
    // Options
    fill(255);
    textSize(16);
    text("ESC - Reprendre", width/2, height/2 - 30);
    text("R - Recommencer", width/2, height/2);
    text("E - Quitter", width/2, height/2 + 30);
    text("A - Sauvegarder", width/2, height/2 + 60);
    
    noStroke();//pour desactiver les contours

    
  }
}
