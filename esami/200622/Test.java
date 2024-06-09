public class Test {
  // 2
  public static int llds(double[] s) {
    int n = s.length;
    int[] mem = new int[n + 1];
    for (int i = 0; i < mem.length; i++) {
      mem[i] = UNKNOWN;
    }
    return lldsRec(s, 2, mem);
  }

  private static int lldsRec(double[] s, int k, int[] mem) {
    if (mem[k] == UNKNOWN) {
      if (k == s.length) mem[k] = 0;
      else if (Math.min(s[k - 2], s[k - 1]) < s[k] && s[k] < Math.max(s[k - 2], s[k - 1])) {
        mem[k] = Math.max(1 + lldsRec(s, k + 1, mem), lldsRec(s, k + 1, mem));
      } else {
        mem[k] = lldsRec(s, k + 1, mem);
      }
    }

    return mem[k];
  }

  private static final int UNKNOWN = -1; // indice i indefinito

  // 3. Ricorsione e iterazione
  public class Frame {
    public final Node node;
    public final int depth;

    public Frame(Node n, int d) {
      this.node = n;
      this.depth = d;
    }
  } // class Frame

  public static int codeSizeIter(Node root) {
    long bits = 0;
    Stack<Frame> stack = new Stack<Frame>();
    stack.push(new Frame(root, 0));
    do {
      Frame current = stack.pop();
      Node n = current.node;
      int depth = current.depth;
      if (n.isLeaf()) {
        bits += depth + n.weight();
      } else {
        stack.push(new Frame(n.left(), depth + 1));
        stack.push(new Frame(n.right(), depth + 1));
      }
    } while (!stack.empty());
    return (int) (bits / 7) + ((bits % 7 > 0) ? 1 : 0);
  }

  // 4
  public class FrameStack {
    private SList<Frame> frames;

    public FrameStack() {
      this.frames = new SList<>();
    }

    public boolean empty() {
      return this.frames.isNull();
    }

    public void push(Frame frame) {
      this.frames.cons(frame);
    }

    public Frame peek() {
      return this.frames.car();
    }

    public Frame pop() {
      Frame car = this.frames.car();
      this.frames = this.frames.cdr();
      return car;
    }
  } // class FrameStack

  public static void main(String[] args) {
    int l = llds(new double[] {1.0, 9.0, 5.0, 8.0, 7.0});
    System.out.println(l);
  }
}
