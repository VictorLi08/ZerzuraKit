#  Arrays
ZerzuraKit defines a variety of operators and methods that allow for easier processing and comparisons with arrays holding equatable elements.

## Subsets
Determine if an array is a subset of another (that is, all of one array's elements exist in the other). 

``` swift
let A = ["hello"]
let B = ["hello", "there"]

// is A a subset of B?
let result = A.isSubset(B)      // true
```

## Intersection
Compute the common elements of two arrays.

``` swift
let A = ["hello"]
let B = ["hello", "there"]

let common = A.intersect(B)     // ["hello"]

let common = A & B              // ["hello"], alternative syntax
```

## Difference
Compute the uncommon elements of two arrays.
``` swift
let A = ["hello"]
let B = ["hello", "there"]

let diff1 = A.diff(B)      // empty array
let diff2 = B.diff(A)      // ["there"]

let diff3 = B - A          // ["there"], alternative syntax
```

## Equivalence
### ==
Returns true if two arrays contain the same elements, otherwise returns false. This tests for __equivalence of contents__, but it does not examine item order. Overrides the standard `==` (exactly equals).

### !=
Returns true if two arrays do not contain the same elements, otherwise returns false. Effectively a negation of `==`.

### &=
Returns true if both arrays are exactly equal, otherwise returns false. This tests for __equivalence of contents__ and __order of items__. Replaces `==` for exactly equals.

