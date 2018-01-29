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
let showImage = 
    REST.loadImage(urlString:) >=>
    lift(toFuture: UIImageView.init) >=>
    lift(toFuture: { PlaygroundPage.current.liveView = $0 }, performOn: .main)

showImage("https://s.gravatar.com/avatar/787c39ba729f1e3fffd6352e415037c6?s=80")

```



# Good practice

Break your algorithms down in to small steps and create functions for each, then combine your functions using arrows.

# What's so *"functional"* about `Result`, `Deferred`, and `Future`?

`Result`, `Deferred`, and `Future` are special types that all exhibit the same behaviour.  In fact, they exhibit the same behaviour as `Optional` and `Sequence` from the standard library.  All these types have three commonalities:  they "wrap" a value and provide functions to manipulate that value. Specifically  they provide a `map` and a `flatMap` method.

To simplify, we'll refer to any type that has a `map` method as <img src="http://latex.codecogs.com/svg.latex?F">, and any type that has a `flatMap` method as <img src="http://latex.codecogs.com/svg.latex?M">.

# Working with functions

Once your code has been broken down to single responsibility functions, you can compose them together to make a greater, more complex algorithm.

With the function <img src="http://latex.codecogs.com/svg.latex?f%20\colon%20(A)%20\to%20B">, we call <img src="http://latex.codecogs.com/svg.latex?A"> the function's *domain*, and <img src="http://latex.codecogs.com/svg.latex?B"> the function's *co-domain*.  To properly compose two functions we must first ensure that the first function's co-domain is the same as the second function's domain.  

For example, these functions cannot be composed: <img src="http://latex.codecogs.com/svg.latex?f%20\colon%20A%20\to%20B"> and <img src="http://latex.codecogs.com/svg.latex?g%20\colon%20C%20\to%20D">

## Composition

Given these compatible functions: <img src="http://latex.codecogs.com/svg.latex?f%20\colon%20A%20\to%20B"> and <img src="http://latex.codecogs.com/svg.latex?g%20\colon%20B%20\to%20C">, you can use the composition operator (`>>>`) to create a new function that includes both computations: 

<p align=center><img src="http://latex.codecogs.com/svg.latex?f%20\,%20\textgreater\textgreater\textgreater%20\,%20g%20\colon%20A%20\to%20C"></p>


#### What if my functions return an `Optional`, `Result`, `Deferred`, or `Future`?

Given the functions <img src="http://latex.codecogs.com/svg.latex?f%20\colon%20A%20\to%20M%20B"> and <img src="http://latex.codecogs.com/svg.latex?g%20\colon%20B%20\to%20M%20C">, clearly the first function's co-domain ($M B$) doesn't match that of the second function's domain ($B$), but the value inside of the co-domain's $M$ is compatible.  We just have to unwrap that value.

As long as both functions use the same <img src="http://latex.codecogs.com/svg.latex?M"> type then they can easily be composed.  Given the functions <img src="http://latex.codecogs.com/svg.latex?f%20\colon%20A%20\to%20M%20B"> and <img src="http://latex.codecogs.com/svg.latex?g%20\colon%20B%20\to%20M%20C">, you can use the kleisli composition operator (`>=>`):

<p align=center><img src="http://latex.codecogs.com/svg.latex?f%20\,%20\text{\textgreater=\textgreater}%20\,%20g%20\colon%20A%20\to%20M%20C"></p>


#### What if I want to compose a regular function with a function that returns an `Optional`, `Result`, `Deferred`, or `Future`?

Both functions that you want to compose have to be at the same "level."  Given the function <img src="http://latex.codecogs.com/svg.latex?f%20\colon%20A%20\to%20B">, you can lift <img src="http://latex.codecogs.com/svg.latex?f"> into the context of <img src="http://latex.codecogs.com/svg.latex?M">:

<p align=center><img src="http://latex.codecogs.com/svg.latex?\text{lift}(f)%20\colon%20A%20\to%20M%20\,%20B"></p>

And given <img src="http://latex.codecogs.com/svg.latex?g%20\colon%20B%20\to%20M%20\,%20C">, you can then use the kleisli composition operator (`>=>`).

<p align=center><img src="http://latex.codecogs.com/svg.latex?\text{lift}(f)%20\,%20\text{\textgreater=\textgreater}%20\,%20g%20\colon%20A%20\to%20M%20\,%20C"></p>

# Why use FuncKit instead of library <img src="http://latex.codecogs.com/svg.latex?x" width="20pt">?

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