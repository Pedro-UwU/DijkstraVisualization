class Board {
  private int boardWidth, boardHeight;
  Node[][] nodes;
  boolean seeNeighbors = false;

  Board(int w, int h) {
    boardWidth = w;
    boardHeight = h;
    reset();
  }

  void show(PGraphics canvas) {
    float sclX = 1.0*width/boardWidth;
    float sclY = 1.0*height/boardHeight;
    for (int i = 0; i < boardHeight; i++) {
      for (int j = 0; j < boardHeight; j++) {
        nodes[i][j].show(j * sclX, i * sclY, sclX, sclY, canvas);
      }
    }

    if (seeNeighbors) {
      int x = (int)(mouseX/sclX);
      int y = (int)(mouseY/sclY);
      canvas.beginDraw();
      if (y >= 0 && y < boardHeight && x >= 0 && x < boardWidth) {
        canvas.fill(255, 0, 0);
        canvas.noStroke();
        canvas.ellipse(nodes[y][x].getX() * sclX + sclX/2, nodes[y][x].getY() * sclY + sclY/2, 10, 10);
        for (Node n : nodes[y][x].getNeighbors()) {
          if (n!=null) {
            canvas.ellipse(n.getX() * sclX + sclX/2, n.getY() * sclY + sclY/2, 10, 10);
          }
        }
      }
      canvas.endDraw();
    }
  }

  public void reset() {
    nodes = new Node[boardWidth][boardHeight];
    //Create the tiles
    for (int i = 0; i < boardHeight; i++) {
      for (int j = 0; j < boardHeight; j++) {
        nodes[i][j] = new Node(j, i);
      }
    }

    //Add Neighbors
    for (int i = 0; i < boardHeight; i++) {
      for (int j = 0; j < boardHeight; j++) {
        addToNeighbors(j, i);
      }
    }
  }

  public void set(int x, int y, int val) {
    if (y >= 0 && y < boardHeight && x >= 0 && x < boardWidth) {
      int previousVal = nodes[y][x].getValue();
      nodes[y][x].setValue(val);

      if (previousVal < 0 && val >= 0) {
        addToNeighbors(x, y);
      }
      if (val < 0)  //If it is a wall, delete it from it's neighbors array
        deleteFromNeighbors(x, y);
      nodes[x][y].resetNeighbors();
    }
  }

  private void deleteFromNeighbors(int x, int y) {
    Node[] neighbors = nodes[y][x].getNeighbors();
    if (neighbors[0]!= null) neighbors[0].setNeighbor(RIGHT, null);
    if (neighbors[1]!= null) neighbors[1].setNeighbor(DOWN, null);
    if (neighbors[2]!= null) neighbors[2].setNeighbor(LEFT, null);
    if (neighbors[3]!= null) neighbors[3].setNeighbor(UP, null);
  }

  private void addToNeighbors(int x, int y) {
    if (y > 0) {
      nodes[y][x].addNeighbor(nodes[y-1][x]);
    }
    if (y < boardHeight-1) {
      nodes[y][x].addNeighbor(nodes[y+1][x]);
    }
    if (x > 0) {
      nodes[y][x].addNeighbor(nodes[y][x-1]);
    }
    if (x < boardWidth-1) {
      nodes[y][x].addNeighbor(nodes[y][x+1]);
    }
  }

  public void setNeighbors(int x, int y, int val) {
    if (y >= 0 && y < boardHeight && x >= 0 && x < boardWidth) {
      for (Node n : nodes[y][x].getNeighbors()) {
        if (n!=null) n.setValue(val);
      }
    }
  }

  public int get(int x, int y) {
    if (y >= 0 && y < boardHeight && x >= 0 && x < boardWidth) {
      return nodes[y][x].getValue();
    } else return Integer.MIN_VALUE;
  }

  public void seeNeighbors(boolean bool) {
    seeNeighbors = bool;
  }

  public void mousePressed() {
    int x = (int)(mouseX/(width/boardWidth));
    int y = (int)(mouseY/(height/boardHeight));

    int previousValue = board.get(x, y);

    if (previousValue < 0) {
      board.set(x, y, 0);
    } else {
      board.set(x, y, -1);
    }
  }
}
