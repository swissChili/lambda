# λ

λ is a purely functional language inspired by Lambda Calculus, ML, Haskell, and F#.
It is not aimed to be a high level language, but rather, more of an assembler. It
is high enough level that compiling to it should not be that difficult, and writing
in λ is not that painfull, but still simple enough the runtime has fairly low
overhead.

### examples

```haskell
let hello_world = λ _ . (puts "Hello, λ!")

let fact = λ a . (if (< a 2) 1 (* a (fact (- a 1))))
```
