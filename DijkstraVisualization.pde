int BOARD_W = 10, BOARD_H = 10;
Board board;

void setup() {
  size(600, 600);
  background(255);
  board = new Board(BOARD_W, BOARD_H);
  board.seeNeighbors(true);
}


void draw() {
  board.show(this.getGraphics());
}


void mousePressed() {
  board.mousePressed();
}
