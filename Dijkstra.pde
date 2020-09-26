import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;
import java.lang.Math;

class Dijkstra {
  Board board;
  Node current, target, start;
  Map<Node, NodeInfo> distances = new HashMap<Node, NodeInfo>();
  SortedSet<NodeInfo> unvisited = new TreeSet<NodeInfo>();
  boolean found = false;


  Dijkstra(Board b, int startX, int startY, int endX, int endY) {
    board = b;

    start = current = b.getNode(startX, startY);
    current = start;
    current.setValue(4);
    target = b.getNode(endX, endY);
    target.setValue(5);

    for (int i = 0; i < b.getHeight(); i++) {
      for (int j = 0; j < b.getHeight(); j++) {
        Node n = b.getNode(i, j);
        float dist = (j == startX && i == startY)?0:Float.POSITIVE_INFINITY;
        NodeInfo nodeInfo = new NodeInfo(n, dist);
        distances.put(n, nodeInfo);
        unvisited.add(nodeInfo);
      }
    }
  }

  public boolean finished() {
    return found;
  }

  public void nextStep() {
    if (found) return;
    NodeInfo currentInfo = distances.get(current);
    //println(current);

    for (Node n : current.getNeighbors()) {
      if (n == null) continue;
      NodeInfo neighborInfo = distances.get(n);
      if (!unvisited.contains(neighborInfo)) continue;
      float newDist = currentInfo.getDist() + 1; //The 1 is the weight between links
      if (newDist < neighborInfo.getDist()) {
        unvisited.remove(neighborInfo);

        neighborInfo.setDist(newDist);
        neighborInfo.setPrev(currentInfo);

        unvisited.add(neighborInfo);
      }
    }

    if (current != start) current.setValue(3); //3 -> visited;
    unvisited.remove(currentInfo);
    if (!unvisited.isEmpty()) {
      current = unvisited.first().getNode();
      if (current.equals(target)) {
        found = true;
        return;
      }
      current.setValue(1); // 1 -> current;
      for (Node n : current.getNeighbors()) 
        if (n != null && n.getValue()==0) n.setValue(2); // 2 -> neighbor of current;
    }
  }




  ArrayList<Pair2D> getPath() {
    if (!found) return null;
    ArrayList<Pair2D> path = new ArrayList<Pair2D>();
    NodeInfo visiting = distances.get(current);
    while (visiting != null) {
      path.add(new Pair2D(visiting.getNode().getX(), visiting.getNode().getY()));
      visiting = visiting.getPrev();
    }
    return path;
  }
}

class NodeInfo implements Comparable<NodeInfo> {
  private float dist;
  private NodeInfo prev = null;
  private Node node;

  NodeInfo(Node n, float dist) {
    node = n;
    this.dist = dist;
  }

  Node getNode() {
    return node;
  }

  void setPrev(NodeInfo n) {
    prev = n;
  }

  NodeInfo getPrev() {
    return prev;
  }

  void setDist(float dist) {
    this.dist = dist;
  }

  float getDist() {
    return dist;
  }

  @Override
    public int compareTo(NodeInfo n) {
    if (dist > n.getDist()) {
      return 1;
    }
    if (dist < n.getDist()) {
      return -1;
    }
    int diff = node.getX() - n.getNode().getX();
    if (diff != 0) return (int)diff;
    return (int)(node.getY() - n.getNode().getY());
  }

  @Override
    public int hashCode() {
    return node.hashCode();
  }
}
