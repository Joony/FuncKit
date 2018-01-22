# FuncKit

![badge-pod] ![badge-platforms] ![badge-languages] ![badge-mit] 

# Quick Start

FuncKit 1 supports Xcode 9+; Swift 4.0; iOS; CocoaPods.

## CocoaPods

Add the following to your Podfile:

```ruby
use_frameworks!

target "<your_target>" do
  pod "FuncKit", "~> 1.0.0"
end
```

## Hello World

```swift



```

# Good practice

Break your algorithms down in to small steps and create functions for each, then combine your functions using arrows.


# Why use this instead of library <img src="http://latex.codecogs.com/svg.latex?x" width="20pt"> 

FuncKit, unlike other libraries, is firmly grounded in mathematics. A lot of the concepts used in FuncKit are based on [Category Theory] and their implementation influenced by functional languages like Haskell. This has proven to make the implementation much simpler. Most other libraries out there suffer from unnecessary [feature creep].  FuncKit has no dependancies and doesn't have an opinion on which libraries you prefer.

Some other libraries have based their implementation on JavaScripts Promise/A+ specification.  The fundamental principles and concepts behind Promises are founded in Category Theory, but the Promise/A+ specification hides those principles and concepts and uses naming which hides any association with the mathematics behind it.

We were very careful to implement FuncKit in a way that respects Swifts approach to functional programming.  That is why we chose names like `map` and `flatMap` that you already know from [Optional] and [Sequence].

# Arrows

> One of the distinguishing features of functional programming is the widespread use of *combinators* to construct programs.[^1]

Such combinators allow the construction of complex algorithms from much smaller parts that are easier to reason about.  

# Curry

Given the function <img src="http://latex.codecogs.com/svg.latex?f\colon%20(A,%20B)\to%20C">, then currying will produce a sequence of single argument functions.

<p align=center><img src="http://latex.codecogs.com/svg.latex?\text{curry}(f)\colon%20(A)\to%20((B)\to%20C)"></p>

```swift
let addition: (Int, Int) -> Int = (+)
let curriedAddition: (Int) -> ((Int) -> Int) = curry(addition)
let partialAddition: (Int) -> Int = curriedAddition(100)
let resultOfAddition: Int = partialAddition(1) // 101
```
You may also reverse the order of the arguments using `curryr`, for example: 

<p align=center><img src="http://latex.codecogs.com/svg.latex?\text{curryr}(f)\colon%20(B)\to%20((A)\to%20C)"></p>

`curry` and `curryr` are implemented for functions of arity up to five.


# Partial Application

Given the function <img src="http://latex.codecogs.com/svg.latex?f\colon%20(A,%20B,%20C)\to%20D">, then partially applying values will produce a function that takes the remainder of arguments (or none if you "partially" apply all of them). 

<p align=center><img src="http://latex.codecogs.com/svg.latex?\text{papply}(a,%20f)\colon%20(B,%20C)\to%20D"></p>

<p align=center><img src="http://latex.codecogs.com/svg.latex?\text{papply}(a,%20b,%20f)\colon%20(C)\to%20D"></p>

<p align=center><img src="http://latex.codecogs.com/svg.latex?\text{papply}(a,%20b,%20c,%20f)\colon%20()\to%20D"></p>

```swift

```

You may also provide arguments from the right side of the argument list, for example:

<p align=center><img src="http://latex.codecogs.com/svg.latex?\text{papplyr}(c,%20f)\colon%20(A,%20B)\to%20D"></p>

`papply` and `papplyr` are implemented for functions of arity up to five.

# Result

Like `Optional` but with a reason for not having a value.  There are many implementations of `Result` out there.  We chose a single typed `Result<Wrapped>` instead of the popular two typed `Result<Wrapped, Error>` in order to ease composition of functions that return a `Result`.

```swift
enum IntError: Error {
    case invalidCharacters
}

func parse(string: String) -> Result<Int> {
    guard let int = Int(string) else {
        return .failure(IntError.invalidCharacters)
    }
    return .success(int)
}
```

# Future/Promise

Useful for abstracting the complexity of handling long running or asynchronous operations that may fail.

```swift
let f = User.login >=> Post.load
f.onFailure { error in
    switch error {
    default:
        // handle error
    }
}
```

# Deferred

A simpler version of Future/Promise for use when a value is guaranteed, eventually.

# Support

Ask your question on [stackoverflow] or on our [bug tracker].

[^1]: John Hughes, [*Generalising Monads to Arrows*](https://www.sciencedirect.com/science/article/pii/S0167642399000234), in *Science of Computer Programming* 37, pp67-111, May 2000.

[badge-pod]: https://img.shields.io/cocoapods/v/FuncKit.svg?label=version
[badge-languages]: https://img.shields.io/badge/languages-Swift-orange.svg
[badge-platforms]: https://img.shields.io/badge/platforms-iOS-lightgrey.svg
[badge-mit]: https://img.shields.io/badge/license-MIT-blue.svg
[bug tracker]: https://github.com/Joony/FuncKit/issues/new
[stackoverflow]: https://stackoverflow.com/search?q=funckit

[Optional]: https://developer.apple.com/documentation/swift/optional/1540500-flatmap
[Sequence]: https://developer.apple.com/documentation/swift/sequence/2905332-flatmap

[Category Theory]: https://en.wikipedia.org/wiki/Category_theory
[feature creep]: https://en.wikipedia.org/wiki/Feature_creep