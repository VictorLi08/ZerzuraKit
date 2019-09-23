#  Abstract Data Types
ZerzuraKit defines abstract data types to help you organize objects and structs. Read up on abstract data types [here](https://algs4.cs.princeton.edu/13stacks/).

## Bags
### Initialization
``` swift
let bagOfIntegers = Bag<Int>()
```

### Adding Items
``` swift
bagOfIntegers.add(5)
```

Remember your ADTs: you cannot remove items from a Bag.

### Iterating
``` swift
for item in bagOfIntegers.items {
    print(item)
}
```

### Properties
#### Size
``` swift
bagOfIntegers.size    // 1
```

#### Emptiness
``` swift
bagOfIntegers.isEmpty    // false
```

## Stacks (LIFO)
### Initialization
``` swift
let stackOfStrings = Stack<String>()
```

### Adding Items
``` swift
stackOfStrings.push("Hello world!")
```

### Removing Items
``` swift
let removedItem = stackOfStrings.pop()
```

### Iterating
``` swift
while !stackOfStrings.isEmpty {
    print(stackOfStrings.pop())
}
```

### Properties
#### Size
``` swift
stackOfStrings.size    // 1
```

#### Emptiness
``` swift
stackOfStrings.isEmpty    // false
```

## Queue (FIFO) 
### Initialization
``` swift
let queueOfDoubles = Queue<Double>()
```

### Adding Items
``` swift
queueOfDoubles.enqueue(3.14)
```

### Removing Items
``` swift
let removedItem = queueOfDoubles.dequeue()
```

### Iterating
``` swift
while !queueOfDoubles.isEmpty {
    print(queueOfDoubles.dequeue())
}
```

### Properties
#### Size
``` swift
queueOfDoubles.size    // 1
```

#### Emptiness
``` swift
queueOfDoubles.isEmpty    // false
```

