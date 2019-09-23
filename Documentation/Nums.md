#  Numbers
ZerzuraKit implements a variety of number extensions that aim to bring a lot of useful C++ syntax to Swift.

## Increment and Decrement
You can pre-increment, post-increment, pre-decrement, or post-decrement integers using the same syntax you would use in C++.

``` swift
var a = 0

// pre-increment: increments A, returns the incremented value
let newValue = ++a    // newValue == 1, a == 1

// post-increment: increments A, returns the previous value
let newValue = a++    // newValue == 0, a == 1

// pre-decrement: increments A, returns the incremented value
let newValue = ++a    // newValue == -1, a == -1

// post-decrement: increments A, returns the previous value
let newValue = a++    // newValue == 0, a == -1
```

## Converting Integers
You can convert integers directly into binary or hex with a length of your choosing.

``` swift
let binary = 10.bin(len: 8)    // 00001010
let hex = 10.hex(len: 2)       // 0a
```

## Modulus
No longer shall Swift programmers suffer with typing `.truncatingRemainder(dividingBy: x)` to conduct a simple modulus operation for Doubles!

``` swift
let modResult = 5.3 % 1.2    // 0.5
``` 
