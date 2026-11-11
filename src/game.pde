class Game {
  Board _board;
  Hero _hero;
  ArrayList<Ghost> _ghosts;//liste des fantomes
  Menu _menu;
  
  String _levelName;
  int _score;
  int _lives;//nbr de vie
  boolean _gameOver;//partie perdu
  boolean _paused;//en pause
  boolean _won;//partie gagne
  
  boolean _superMode;//mode super
  int _superModeTimer;//la duree environ 5 sec
  
  Game() {//constructeur
    _board = new Board(new PVector(0, 0), CELL_SIZE);
    
    PVector startPos = _board.findHeroStartPosition();// creation a pos initiale
    _hero = new Hero((int)startPos.x, (int)startPos.y, 16, _board);
    
    _ghosts = new ArrayList<Ghost>();//fantomes
    _ghosts.add(new Ghost(9, 10, 651, 55, 0, _board));     
_ghosts.add(new Ghost(10, 10, 700, 55, 60, _board));     
_ghosts.add(new Ghost(11, 10, 751, 55, 120, _board));  
_ghosts.add(new Ghost(12, 10, 800, 55, 180, _board));
    
    _menu = new Menu();// ici, on initialise les var du jeu
    _score = 0;
    _lives = INITIAL_LIVES;
    _gameOver = false;
    _paused = false;
    _won = false;
    _superMode = false;
    _superModeTimer = 0;
  
  }
  
  void update() {//si termine ou pause , on fait rien
    if (_paused || _gameOver || _won) return;
    
    _hero.update(_board);//maj de pacman
    
    // maj des fantomes 
  for (Ghost g : _ghosts) {
  g.update(_board);
  if (g._cellX == _hero._cellX && g._cellY == _hero._cellY) {//collision pacman et fantomes
    handleGhostCollision(g);
  }
}
    
    checkCollections();//verifier obj ramasse
    updateSuperMode();//mode super
    checkEndConditions();//verifier condition de fin
  }
  
 void handleGhostCollision(Ghost g) {//la quand ya collision avec fantome
  if (!_superMode) {//si pacman nest pas en mode super
    _lives--;
    if (_lives <= 0) {//si plus de vie
      _gameOver = true;
    } else {//on reinitialise les pos
      _hero.reset(_board);
      
      for (Ghost ghost : _ghosts) {
        ghost.reset(_board);
      }
    }
  } else {//si pacman est  en mode super
    
    g.reset(_board);
    _score += 200;
  }
}

 
  void drawIt() {
    background(0);
    _board.drawIt();
    
    // Dessine les fantomes
    for (Ghost g : _ghosts) {
      g.drawIt(_superMode);
    }
    
    _hero.drawIt();//dessin de pacman
    drawUI();
    
    if (_paused) {//si je met pause , affichage du menu
      _menu.drawIt();
    }
    
    if (_gameOver || _won) {
      drawEndScreen();//ecran a la fin
    }
  }
  
  void checkCollections() {
    TypeCell currentCell = _board.getCell(_hero._cellX, _hero._cellY);
   //gomme classique
    if (currentCell == TypeCell.DOT) {
      _board.setCell(_hero._cellX, _hero._cellY, TypeCell.EMPTY);
      _score += SCORE_DOT;
    
  //super gomme 
  } else if (currentCell == TypeCell.SUPER_DOT) {
      _board.setCell(_hero._cellX, _hero._cellY, TypeCell.EMPTY);
      _score += SCORE_SUPER_DOT;
      _superMode = true;
      _superModeTimer = SUPER_MODE_DURATION;
     
    }
  }
  
  void updateSuperMode() {//mode super
    if (_superMode) {
      _superModeTimer--;
      if (_superModeTimer <= 0) {
        _superMode = false;
      }
    }
  }
    
  void checkEndConditions() {//la condition de fin
    if (!_board.hasDotsRemaining()) {
      _won = true;
    }
  }
  
  void drawUI() {
    fill(255);
    textSize(16);
    textAlign(LEFT);
    text("SCORE: " + _score, 20, height - 20);
    textAlign(RIGHT);
    text("VIES: " + _lives, width - 20, height - 20);
  }
  
  void drawEndScreen() {//ecrand e fin
    fill(0, 0, 0, 200);
    rect(0, 0, width, height);
    fill(_won ? color(0, 255, 0) : color(255, 0, 0));
    textSize(32);
    textAlign(CENTER, CENTER);
    text(_won ? "VICTOIRE !" : "GAME OVER", width/2, height/2 - 40);
    fill(255);
    textSize(20);
    text("Score final: " + _score, width/2, height/2);
    text("Appuyez sur R pour recommencer", width/2, height/2 + 40);
  }
  
  void handleKey(int k) {//la gestion du clavier
    if (k == ESC) {
      _paused = !_paused;
      key = 0;
      return;
    }
    if (k == 'r' || k == 'R') {
      restartGame();
      return;
    }
    if (k == 'E' || k == 'e') {
      exit();
      return;
    }
    
    if (_paused || _gameOver || _won) return;

    if (k == CODED) {
      if (keyCode == UP) _hero.launchMove(new PVector(0, -1));
      else if (keyCode == DOWN) _hero.launchMove(new PVector(0, 1));
      else if (keyCode == LEFT) _hero.launchMove(new PVector(-1, 0));
      else if (keyCode == RIGHT) _hero.launchMove(new PVector(1, 0));
    } else {
      char c = Character.toLowerCase((char)k);
      if (c == 'z') _hero.launchMove(new PVector(0, -1));
      else if (c == 's') _hero.launchMove(new PVector(0, 1));
      else if (c == 'q') _hero.launchMove(new PVector(-1, 0));
      else if (c == 'd') _hero.launchMove(new PVector(1, 0));
    }
  }
  
  void restartGame() {//redemarrer la partie
    _board = new Board(new PVector(0, 0), CELL_SIZE);
    PVector startPos = _board.findHeroStartPosition();
    _hero = new Hero((int)startPos.x, (int)startPos.y, 16, _board);
    _ghosts = new ArrayList<Ghost>();
     _ghosts.add(new Ghost(9, 10, 651, 55, 0, _board));     
_ghosts.add(new Ghost(10, 10, 700, 55, 60, _board));   
_ghosts.add(new Ghost(11, 10, 751, 55, 120, _board));   
_ghosts.add(new Ghost(12, 10, 800, 55, 180, _board));
    _score = 0;
    _lives = INITIAL_LIVES;
    _gameOver = false;
    _paused = false;
    _won = false;
    _superMode = false;
    _superModeTimer = 0;
  }
  
}
