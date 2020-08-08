# Swift Intro
## Variables and Constants
Declare a variable with the `var` keyword.
```swift
var str = "Hello, playground" // str is of type string
str = 5 // This is an error, compiler won't let you assign an Int to a type String 
```
Swift is a type safe language, meaning once a variable is declared as a certain type, it must maintain that type.

If you don’t specify the type of value you need, Swift uses type inference.
```swift
var currency = 5    // This infers the type to be Int
var currency: Double = 5
print(currency)
```

Declare a constant with the `let` keyword.
```swift
// cmd + ctrl + space to get emojis
let emoji = "😬"     // The String type is built from Unicode scalar values
emoji = "🤪" // Cannot assign to value: 'emoji' is a 'let' constant
```

Yay! no semicolons

## Control Flow
Let’s talk about control flow: Starting with loops
You use the `for-in` loop to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string.
```swift
for character in "The Great British Baking Show 🍰" {
    print(character)
}
```

You can also use `for-in` loops with numeric ranges. 
In this example we use the closed range operator (...) to iterate from 1 to 5 inclusive.
```swift
for index in 1...5 { // Equivalent to for(index = 1; index <= 5; index++)
    print("\(index) times 5 is \(index * 5)")
}
```
**String interpolation** is a way to construct a new `String` value from a mix of constants, variables, literals, and expressions by including their values inside a string literal.
Use the half-open range operator (..<) to include the lower bound but not the upper bound.

Next we’ll use conditionals.
```swift
let temperature = 40
if temperature <= 32 {
    print("It's freezing!")
} else {
    print ("It's not that cold")
}
```

Yay! no parenthesis. Swift syntax is pretty light.

## Functions
Use the `func` keyword and indicate the function’s return type with the **return arrow**->
```swift
func greet(person: String) -> String {
    return "Hello, \(person)"
}

print(greet(person: "John"))
```
Notice the argument label for each parameter. 
Each function parameter has both an *argument label* and a *parameter name*. The argument label is used when calling the function; each argument is written in the function call with its argument label before it. You can also omit the argument label by passing in an underscore `_` instead of an explicit label for that parameter. 
```swift
func greet(_ person: String, from hometown: String) -> String {
    return "Hello, \(person)! Glad you could visit from \(hometown)."
}

print(greet("Chris", from: "El Paso"))
```

Argument labels can allow a function to be called in an expressive, sentence-like manner, while still providing a function body that is readable and clear in intent.

### Closures
Functions in Swift are actually special types of closures, self-contained blocks of code that can be called later. Closures can be invoked similar to functions: 

```swift
let genericGreeting = {
    return "Hello!"
}
print(genericGreeting())

// closures can have parameters and return types
let customGreeting: (String) -> (String) = { person in 
    return "Hello, \(person)"
}
print(customGreeting("Newton"))

// more complicated
let strings = ["x", "z", "d", "f", "a"]
strings.sorted(by: <)
// same as
strings.sorted(by: { name1, name2 in
    return name1 < name2
})
```

## Optionals
You use *optionals* in situations where a value may be absent. An optional represents two possibilities: Either there *is* a value, and you can unwrap the optional to access that value, or there *isn’t* a value at all.
```swift
// Typical situation in java...
var newStr: String = "hello"
if newStr != nil {
    print(newStr)
}
```

In Swift we declare a property that is optional with the `?`  operator after the type declaration.
```swift
var optionalString: String? = "hello"
```

You use *optional binding* to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable.
```swift
if let actualString = optionalString {
    print(actualString)
}
```
Think of an optional as a wrapper type. It’s like a gift box which wraps the value inside, and like a real-life box, the optional can either contain something or be empty.

Another example:
```swift
let possibleNumber = "123"  // What if this wasn't a number?
let convertedNumber = Int(possibleNumber)
print(convertedNumber)

if let convertedNumber = Int(possibleNumber) {
    print(convertedNumber)
}
```
Because the initializer might fail, it returns an *optional* Int, rather than an Int.

`guard` statements are similar to `if let` but can allow you to provide an early return when optionals are `nil`.
```swift
func getPaid(amount: Int?) -> String {
    guard let amount = amount else {
        return "No money 😭"
    }
    return "I got paid $\(amount)"
}

print(getPaid(amount: nil))
```

## Classes vs Structs
```swift
class Note {
    var content: String?
    let dateCreated = Date()
    
    init() {}
}

var firstNote = Note()
firstNote.content = "first note"
var secondNote = firstNote
secondNote.content = "second note"
print(firstNote.content)
```

Now change the class to struct. What happens? Pass by value! Passing by value is way safer than having multiple references to the same instance.

### Protocols
Same idea as interfaces in java. They define a blueprint of methods, properties, and other requirements and can be adopted by classes, structs, and enums. Properties declared in protocols must always be variable (var), and can either be gettable { get }, or gettable AND settable { get set }. Getters and setters can be defined to retrieve and set other properties and values indirectly.

```swift
protocol Shape {
    var sides: Int { get }
    var area: Double { get set }
}

struct Circle: Shape {
    var sides: Int
    var area: Double {
        get {
            Double.pi * pow(Double(radius), 2)
        }
        set {
            radius = pow((newValue / Double.pi), 0.5)
        }
    }
    var radius: Double

    init(radius: Double) {
        self.radius = radius
        sides = 0
    }

}

var circle = Circle(radius: 5)
print(circle.area)
circle.area = 50
print(circle.radius)
```

< add a section about enum/static property dot syntax here >