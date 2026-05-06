; --- Graph edges ---
(edge A B)
(edge A C)
(edge B D)
(edge B E)
(edge C F)
(edge D G)
(edge E G)

; --- Check if a node has already been visited ---
(= (visited? $node $visited-space)
   (not (== (collapse (match $visited-space (seen $node) True)) ())))

; --- Reverse an expression ---
(= (reverse $expression $accumulator)
   (if (== (size-atom $expression) 0)
       $accumulator
       (reverse (cdr-atom $expression)
                (cons-atom (car-atom $expression) $accumulator))))

; --- BFS core: queue = expression, visited-space = Space, result = expression ---
(= (bfs $queue $visited-space $result)
   (if (== (size-atom $queue) 0)
       (reverse $result ())
       (let* (($current-node     (car-atom $queue))
              ($remaining-queue  (cdr-atom $queue)))
         (if (visited? $current-node $visited-space)
             (bfs $remaining-queue $visited-space $result)
             (let* (($_ (add-atom $visited-space (seen $current-node)))
                    ($neighbors   (collapse (match &self (edge $current-node $neighbor) $neighbor)))
                    ($next-queue  (union-atom $remaining-queue $neighbors))
                    ($next-result (cons-atom $current-node $result)))
               (bfs $next-queue $visited-space $next-result))))))

; --- Run ---
!(let $visited-space (new-space) (bfs (A) $visited-space ()))