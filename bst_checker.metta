; --- and / not helpers ---
(= (and True True)  True)
(= (and True False) False)
(= (and False $x)   False)
(= (not True)  False)
(= (not False) True)

; --- BST checker with min/max bounds ---
(= (is-bst Nil $min $max) True)
(= (is-bst (Node $val $left $right) $min $max)
   (if (not (and (> $val $min) (< $val $max)))
       False
       (and (is-bst $left  $min $val)
            (is-bst $right $val $max))))


; Valid BST:
;        10
;       /  \
;      5    15
;     / \   / \
;    3   7 12  20
!(is-bst
    (Node 10
      (Node 5
        (Node 3 Nil Nil)
        (Node 7 Nil Nil))
      (Node 15
        (Node 12 Nil Nil)
        (Node 20 Nil Nil)))
    -1000 1000)
; Expected: True

; Invalid BST — 12 is right child of 5, but 12 > 10 (violates upper bound)
;        10
;       /  \
;      5    15
;     / \
;    3   12
!(is-bst
    (Node 10
      (Node 5
        (Node 3 Nil Nil)
        (Node 12 Nil Nil))
      (Node 15 Nil Nil))
    -1000 1000)
; Expected: False

; Single node
!(is-bst (Node 42 Nil Nil) -1000 1000)
; Expected: True

; Empty tree
!(is-bst Nil -1000 1000)
; Expected: True
