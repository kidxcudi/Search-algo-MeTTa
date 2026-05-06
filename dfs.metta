; --- Graph edges ---
(edge A B)
(edge A C)
(edge B D)
(edge B E)
(edge C F)
(edge D G)
(edge E G)

; --- Check if a node has already been visited ---
(= (member? $node $visited-list)
   (foldl-atom $visited-list False $accumulator $element
     (if (== $element $node) True $accumulator)))

; --- Get all neighbors of a node from the Atomspace ---
(= (neighbors $node)
   (collapse (match &self (edge $node $neighbor) $neighbor)))

; --- Reverse an expression ---
(= (reverse $expression $accumulator)
   (if (== (size-atom $expression) 0)
       $accumulator
       (reverse (cdr-atom $expression)
                (cons-atom (car-atom $expression) $accumulator))))

; --- DFS core: explore $current-node, thread visited list through ---
(= (dfs $current-node $visited-list)
   (if (member? $current-node $visited-list)
       $visited-list
       (dfs-neighbors (neighbors $current-node)
                      (cons-atom $current-node $visited-list))))

; --- Process each neighbor in order ---
(= (dfs-neighbors $neighbor-list $visited-list)
   (if (== (size-atom $neighbor-list) 0)
       $visited-list
       (let* (($first-neighbor       (car-atom $neighbor-list))
              ($remaining-neighbors  (cdr-atom $neighbor-list))
              ($updated-visited      (dfs $first-neighbor $visited-list)))
         (dfs-neighbors $remaining-neighbors $updated-visited))))

; --- Run ---
!(reverse (dfs A ()) ())