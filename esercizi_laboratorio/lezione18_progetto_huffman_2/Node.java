public class Node implements Comparable<Node> {

  private final char chr;
  private final int wgt;
  private final Node lft;
  private final Node rgt;

  public Node(char c, int w) {
    this.chr = c;
    this.wgt = w;
    this.lft = null;
    this.rgt = null;
  }

  public Node(Node l, Node r) {
    chr = (char) 0;
    this.wgt = l.weight() + r.weight();
    this.lft = l;
    this.rgt = r;
  }

  public boolean isLeaf() {
    return this.lft == null;
  }

  public char symbol() {
    return this.chr;
  }

  public int weight() {
    return this.wgt;
  }

  public Node left() {
    return this.lft;
  }

  public Node right() {
    return this.rgt;
  }

  @Override
  public int compareTo(Node n) {
    if (this.weight() < n.weight()) return -1;
    else if (this.weight() == n.weight()) return 0;
    return 1;
  }
}
