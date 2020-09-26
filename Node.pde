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
    case -1: //Wall
      canvas.fill(20);
      break;
    case 0: //Nothing
      canvas.fill(200);
      break;
    case 1: //Current
      canvas.fill(color(200, 0, 100));
      break;
    case 2: //Neighbor
      canvas.fill(100);
      break;
    case 3: //Visited
      canvas.fill(150);
      break;
    case 4: //Start
      canvas.fill(0, 200, 0);
      break;
    case 5: //End
      canvas.fill(200, 0, 0);
      break;
      
    case 6: //Path
      canvas.fill(0, 150, 176);
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

  @Override
    public int hashCode() {
    return y * BOARD_W + x;
  }

  @Override
    public boolean equals(Object o) {
    if (o == this) return true;
    if (o.getClass() != this.getClass()) return false;

    Node n = (Node) o;
    if (n.getX() == x && n.getY() == y) return true;
    return false;
  }
}
