static final int BOARD_W = 20, BOARD_H = 20;
static final int framesPerStep = 5;
Board board;
Dijkstra searcher;
ArrayList<Pair2D> path;
void setup() {
  size(600, 600);
  background(255);
  board = new Board(BOARD_W, BOARD_H);
  board.seeNeighbors(false);
  searcher = new Dijkstra(board, 0, 0, 15, 6);
}


void draw() {
  background(255);
  
  if (frameCount % framesPerStep == 0) {
    next();
  }
  
  board.show(this.getGraphics());
}


void mousePressed() {
  board.mousePressed();
}

void next() {
  if (!searcher.finished()) {
    searcher.nextStep();
  } else if (path == null) {
    path = searcher.getPath();
    for (Pair2D p : path) {
      board.set(p.x, p.y, 6);
    }
  }
}
