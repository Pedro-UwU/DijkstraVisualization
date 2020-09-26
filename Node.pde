class Node {
  private int x, y;
  private Node[] neighbors = {null, null, null, null}; //LEFT UP RIGHT DOWN
  private boolean hasNeighbors = false;
  private int value = 0;

  Node(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void show(float posX, float posY, float sclX, float sclY, PGraphics canvas) {
    float spacingX = sclX/30;
    float spacingY = sclY/30;
    canvas.beginDraw();
    switch (value) {
    case -1: 
      canvas.fill(20);
      break;
    case 0: 
      canvas.fill(200);
      break;
    case 1: 
      canvas.fill(100);
      break;
    case 2: 
      canvas.fill(150);
      break;
    default: 
      canvas.fill(255);
    }
    canvas.noStroke();
    canvas.rect(posX + spacingX, posY + spacingY, sclX - 2*spacingX, sclY-2*spacingX, min(sclX, sclY)/8);
    canvas.endDraw();
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public Node[] getNeighbors() {
    return neighbors;
  }

  public boolean hasNeighbors() {
    return hasNeighbors();
  }

  public int getValue() {
    return value;
  }

  public void setValue(int v) {
    value = v;
  }
  
  public void resetNeighbors() {
    for (int i = 0; i < 4; i++) {
      neighbors[i] = null;
    }
  }

  public boolean addNeighbor(Node n) {
    //Adds a neighbor checking if it's valid and its position

    if (x - n.getX() == 1 && n.getY() == y) { //LEFT
      neighbors[0] = n;
      hasNeighbors = true;
      return true;
    }
    if (y - n.getY() == 1 && n.getX() == x) { //UP
      neighbors[1] = n;
      hasNeighbors = true;
      return true;
    }

    if (x - n.getX() == -1 && n.getY() == y) { //RIGHT
      neighbors[2] = n;
      hasNeighbors = true;
      return true;
    }

    if (y - n.getY() == -1 && n.getX() == x) { //DOWN
      neighbors[3] = n;
      hasNeighbors = true;
      return true;
    }

    return false;
  }

  public void setNeighbor(int dir, Node n) {
    //Sets a neighbor in the current position no matter what

    dir -= LEFT;
    neighbors[dir] = n;

    hasNeighbors = false;
    for (Node node : neighbors) {
      if (node != null) {
        hasNeighbors = true; 
        break;
      }
    }
  }



  @Override
    public String toString() {
    return "Node -> X: " + x + ", Y: " + y + ", VALUE: " + value;
  }
}
