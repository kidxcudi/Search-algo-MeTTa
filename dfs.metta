; --- Graph ---
(edge A B)
(edge A C)
(edge B D)
(edge B E)
(edge C F)
(edge D G)
(edge E G)

; --- Check if expression is empty ---
(= (empty? $xs) (== (size-atom $xs) 0))

; --- Member check using foldl-atom ---
(= (member? $x $xs)
   (foldl-atom $xs False $acc $el
     (if (== $el $x) True $acc)))

; --- Get neighbors from Atomspace ---
(= (neighbors $n)
   (collapse (match &self (edge $n $nb) $nb)))

; --- DFS ---
(= (dfs $node $visited)
   (if (member? $node $visited)
       $visited
       (let* (($v1   (cons-atom $node $visited))
              ($nbrs (neighbors $node)))
         (dfs-neighbors $nbrs $v1))))

; --- Process each neighbor ---
(= (dfs-neighbors $nbrs $visited)
   (if (empty? $nbrs)
       $visited
       (let* (($head (car-atom $nbrs))
              ($tail (cdr-atom $nbrs))
              ($v1   (dfs $head $visited)))
         (dfs-neighbors $tail $v1))))

; --- Run ---
!(dfs A ())