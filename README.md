# MeTTa Algorithms

Classic algorithms implemented in [MeTTa](https://metta-lang.dev/) — the core language of the [OpenCog Hyperon](https://hyperon.opencog.org/) AGI framework.

## Implementations

### 1. Depth-First Search (`dfs.metta`)

Graph traversal that explores as far as possible along each branch before backtracking.

**Graph used:**
```
A → B → D → G
A → C → F     
B → E → G
```

**Key design:**
- Graph stored as `(edge From To)` atoms in the Atomspace
- Visited list threaded through recursive calls
- `collapse` used to gather all neighbors via pattern matching

**Run:**
```bash
metta dfs.metta
# Expected output: (A B D G E C F)  [DFS order from A]
```

---

### 2. Breadth-First Search (`bfs.metta`)

Graph traversal that explores all neighbors at the current depth before moving deeper.

**Same graph as DFS.**

**Key design:**
- Explicit queue modeled as a MeTTa list
- `append` used to enqueue new neighbors at the back (FIFO)
- Visited list grows front-to-back in BFS level order

**Run:**
```bash
metta bfs.metta
# Expected output: (A B C D E F G)  [BFS order from A]
```

---

### 3. Binary Search Tree Checker (`bst_checker.metta`)

Validates whether a binary tree satisfies the BST property.

**Tree representation:**
```
(node Value LeftSubtree RightSubtree)
nil   ; empty leaf
```

**Key design:**
- Propagates `(min, max)` bounds down the tree
- At each node: `min < value < max` must hold
- Left recursion tightens upper bound; right tightens lower bound

**Test cases:**

| Tree | Expected |
|------|----------|
| Valid BST (10, 5, 15, 3, 7, 12, 20) | `True` |
| Invalid BST (12 in wrong subtree) | `False` |
| Single node | `True` |
| Empty tree (`nil`) | `True` |

**Run:**
```bash
metta bst_checker.metta
# Expected output: True, False, True, True
```

---

## How to Run

### Install MeTTa (via Hyperon)

```bash
pip install hyperon
```

### Execute a file

```bash
metta dfs.metta
metta bfs.metta
metta bst_checker.metta
```

---

## MeTTa Concepts Used

| Concept | Description |
|---------|-------------|
| `match &self` | Pattern matching against the Atomspace |
| `collapse` | Collects all non-deterministic results into a list |
| `let*` | Sequential variable bindings |
| `cons-atom` | Prepends an element to a list |
| `(= ...)` | Equality / rewrite rules (function definitions) |

---

## Language Notes

MeTTa is a **homoiconic**, **non-deterministic** language where:
- Code and data are both **atoms** stored in a hypergraph (Atomspace)
- Functions are **rewrite rules** matched via unification
- Evaluation can return **multiple results** simultaneously

It's designed for AGI workloads: reasoning, self-modification, and learning.

---
