public class Frame {
  private int stato;
  private Node left;
  private Node right;

  public int getState() {
    return stato;
  }

  public void setState(int value) {
    stato = value;
  }

  public Node getLeft() {
    return left;
  }

  public void setLeft(Node value) {
    left = value;
  }

  public Node getRight() {
    return right;
  }

  public void setRight(Node value) {
    right = value;
  }

  public Frame() {
    stato = 0;
    left = null;
    right = null;
  }
}
