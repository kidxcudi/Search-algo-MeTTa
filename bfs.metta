; --- Graph ---
(edge A B)
(edge A C)
(edge B D)
(edge B E)
(edge C F)
(edge D G)
(edge E G)

; --- Check if node is in visited-space ---
(= (visited? $node $vs)
   (not (== (collapse (match $vs (seen $node) True)) ())))

; --- BFS: $queue = expression, $vs = space, $result = expression ---
(= (bfs $queue $vs $result)
   (if (== (size-atom $queue) 0)
       $result
       (let* (($cur  (car-atom $queue))
              ($rest (cdr-atom $queue)))
         (if (visited? $cur $vs)
             (bfs $rest $vs $result)
             (let* (($_ (add-atom $vs (seen $cur)))
                    ($nbrs (collapse (match &self (edge $cur $nb) $nb)))
                    ($q2  (union-atom $rest $nbrs))
                    ($r2  (cons-atom $cur $result)))
               (bfs $q2 $vs $r2))))))

; --- Run ---
!(let $vs (new-space) (bfs (A) $vs ()))