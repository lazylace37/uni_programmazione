public class NodeQueue {
  private Node[] queue;

  // costruttore: creazione della coda di nodi vuota
  public NodeQueue() {
    this.queue = new Node[0];
  }

  // restituisce il numero di elementi contenuti nella coda
  public int size() {
    return this.queue.length;
  }

  // restituisce l’elemento con “peso minore” (senza rimuoverlo dalla coda)
  public Node peek() {
    int leastWeight = this.queue[0].weight();
    int leastWeightIdx = 0;
    for (int i = 1; i < this.queue.length; i++) {
      Node el = this.queue[i];
      if (el.weight() < leastWeight) {
        leastWeight = el.weight();
        leastWeightIdx = i;
      }
    }
    return this.queue[leastWeightIdx];
  }

  // restituisce e rimuove dalla coda l’elemento con “peso minore”
  public Node poll() {
    Node leastWeightNode = this.peek();

    Node[] newQueue = new Node[this.size() - 1];
    int newQueueIdx = 0;
    for (int i = 0; i < this.size(); i++) {
      // check by reference
      if (this.queue[i] != leastWeightNode) newQueue[newQueueIdx++] = this.queue[i];
    }
    this.queue = newQueue;

    return leastWeightNode;
  }

  // aggiunge un nuovo elemento n alla coda
  public void add(Node n) {
    Node[] newQueue = new Node[this.size() + 1];
    for (int i = 0; i < this.size(); i++) {
      newQueue[i] = this.queue[i];
    }
    newQueue[this.size()] = n;
    this.queue = newQueue;
  }
}
