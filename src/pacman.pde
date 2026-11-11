PImage spriteSheet;//c limage qui contient les sprites
Game game;

void setup() {
  size(500,500);//chercher P2D
  spriteSheet = loadImage("img/pacman_sprites.png");
  game = new Game();
}

void draw() {
  game.update();//met a jour la logique du jeu
  game.drawIt();//dessine les elem du jeu
}

void keyPressed() {//quand la touche est presse , cette fonction est appelee
  game.handleKey(key);
}

void mousePressed() {//quand la souris est utilisee
 //vide
}
