# Hi Programming Language

## Introduction

Hi is a modern programming language that is as intuitive as saying "hi."

Below is a Hi program that prints "Hello, world!":

```ocaml
println "Hello, world!"
```

The syntax of the Hi language is primarily inspired by OCaml, Scala, Kotlin, Rust, [Gluon](https://gluon-lang.org/), and others.

## Language Tour

Explore the features and syntax of the Hi language.

### Values

Values can be either immutable or mutable.

Use `val` to create an immutable value (also known as a constant):

```ocaml
val i = 1
val b = false
```

Use `var` to declare a mutable value (also known as a variable):

```kotlin
var s = "hi"

// Mutate a variable
do s <- "nice"
```

The type of a constant or variable can be automatically inferred by the compiler if you initialize it with a value. However, you can also specify the type explicitly, for example:

```ocaml
val a: List Int = [1, 2]
```

Tuples and records are also supported as first-class values:

```ocaml
val t = (1, "abc", true)
val base = (x = 1, y = 0, name = "origin")
```

There is a special syntax for functional updates of records, similar to [Rust's](https://doc.rust-lang.org/reference/expressions/struct-expr.html#functional-update-syntax):

```kotlin
// Update record
val updated = (..base, name = "changed")
```

### Comments

Comments follow the same syntax as in other popular languages like C and Java:

- `//` starts a line comment, which ends at the newline.
- `/*` starts a block comment, which ends with `*/`.

### Statements

A statement is a declaration of something. We've seen examples of statements in the previous section.

```kotlin
// Declare and initialize a constant
val a = 1
// Initialize a variable
var s = "hi"
// Perform an action for a side effect
val _ = println "hi"
```

A `do` statement is syntactic sugar specifically for side effects:

```kotlin
do println "hi"
// is the same as
val _ = println "hi"
```

All expressions that start with a keyword can also be used as statements.

### Expressions

Expressions are the building blocks of the language.

```ocaml
val x = 1 + 2
val y = 1.1 * 2

val equal = x == y
val notEq = x /= y

val and = x && y
val or = x || y
val negation = not x && y
```

#### Conditional Expression

Like most functional programming languages, `if-else` is an expression instead of a statement.

```ocaml
val str = if x > 1 then true else false

// With else if
val order = if a > b then 1
	else if a == b then 0
	else -1
```

#### Sequence Expression

A sequence of expressions separated by semicolons forms a sequence expression, and the last expression is the final value.

```kotlin
val _ = println "Hello "; println "world"
```

#### Block Expression

A block expression is either a sequence of statements or a sequence of expressions.

```ocaml
{
	val x = 1
	val y = 2
	val r = x + y
	do println "x + y = $r"
	return r
}
// Block of sequence expressions
{
	println "hi";
	println x
}
```

#### Functions

An anonymous function is like a block expression but with some arguments.

```kotlin
val add = { x y ->
	x + y
}
// Types are inferred
val add: Int -> Int -> Int
```

There is a shorthand for defining a function. The syntax is similar to [Standard ML's](https://saityi.github.io/sml-tour/tour/01-05-fun.html):

```kotlin
fun add (x: Int) (y: Int): Int = x + y
// Equivalent to
val add = { (x: Int) (y: Int): Int -> x + y }
```

#### Call Expression

Like most functional programming languages, function calls are concise, and parentheses are not necessary.

```kotlin
fun double x = x * 2
double 1 // Evaluates to 2
```

The call syntax natively supports **variable arguments** (varargs).

```scala
type List a = Nil | Cons a (List a)

fun size list = match list with
	| Cons x xs -> 1 + size xs
	| Nil -> 0

val l = [1, 2, 3]
val s = size l
val t = size [1, 2]
```

The language features a method call operator `/.` that facilitates the chaining of method calls. This operator draws inspiration from JavaScript's [optional chaining operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Optional_chaining) (`?.`).

```ocaml
extension IntOps for Int {
	val neg = - this
	fun add x = this + x
	fun times x = this * x
}

val x = 3 /. add 4 /. times 5 /. neg
// equivalent to
val x = ((3.add 4).times 5).neg
```

#### While Expression

```kotlin
var i = 0
while i < 10 do {
	println i;
	i <- i + 1
}
```

#### For Expression

For loops are also expressions.

```kotlin
val names = ["Alice", "Bob"]
// For loop for side effects
for name in names do println name
// Yield another value
val sizes = for name in names yield name /. size
```

#### Match Expression

Pattern matching makes code more intuitive than using if-else branches.

```ocaml
fun isEmpty a = match a with
	| Some x -> false
	| None -> true
```

#### Try Expression

The `try` expression resembles the `match` expression.

```ocaml
fun div x y = try
	x / y;
	println "division"
with
	| Division_by_zero -> println "/ by 0"
	| Error e -> println e
```

### Types

Type names must start with an uppercase letter, and type variables start with a lowercase letter.

#### Basic Types

```kotlin
val b: Bool = true
val c: Char = 'a'
val i: Int = 1
val f: Float = 1.0
val d: Double = 2.0
val s: String = "hi"
```

#### Records

Compose basic types into structural types using records or tuples.

```scala
type Tuple = (String, Int)
type Person = (name: String, age: Int)
// Type alias
type P = Person

val alice: P = (name = "Alice", age = 10)
val age = alice.age
```

In fact, a tuple type is just a specially named record type, so tuples can be accessed the same way as records.

```kotlin
type tuple = (String, Int)
// It's the same as
type tuple = (_1: String, _2: Int)
```

#### Type Alias

Type aliases can be defined using the `type` keyword.

```ocaml
type Id = Int
val id: Id = 1
```

Type aliases can be parameterized with type variables to create generic types. For example, here's a type alias for an equality interface.

```ocaml
type Eq a = (
	eq : a -> a -> Bool
)
```

#### Intersection Types

Intersection types are a powerful tool for combining existing record types. They are defined using the `&` operator.

Here's an example of defining an intersection type `Combined` that combines two record types with fields `a` of type `Int` and `b` of type `String`:

```ocaml
type Combined = (a: Int) & (b: String)
// This is equivalent to defining a record type with both fields:
type Combined = (a: Int, b: String)
```

However, attempting to define an intersection type `Conflicting` with two fields named `a` of different types `Int` and `String` will result in a compilation error, as these types cannot be unified:

```ocaml
type Conflicting = (a: Int) & (a: String)
```

Intersection types can also be used to define generic types, such as `Ord a`, which combines the `Eq a` type with an additional field `compare` that takes two `a` values and returns an `Int`:

```ocaml
type Ord a = Eq a & (
	compare: a -> a -> Int
)
```

#### Algebraic Data Type

Algebraic data types can be declared using the `data` keyword.

```kotlin
data Color = Red | Green | Blue
data Option a = Some a | None
data List a = Nil | Cons a (List a)
data Result a b = Ok a | Error b
```

#### Object Type

Object-oriented programming is also supported with object types. An object type is similar to a record type, but has a name and supports [subtyping](https://en.wikipedia.org/wiki/Subtyping).

```scala
class Container(left: Int, right: Int, top: Int, bottom: Int)
// Inherit from a superclass
class Button(text: String) <: Container

val args = (left = 0, right = 100, top = 0, bottom = 100)
// The class name also serves as a constructor function
val container = Container args
val button = Button (..container, text = "OK")
```

Can we have type variables in object types?

#### Exception Type

Like OCaml, you can declare exception types.

```ocaml
// Simple exception
exception Overflow
// With extra info
type ErrorType = Critical | Warning
exception Error (String, ErrorType)
```

Use `throw` instead of `raise` to throw an exception, as `throw` is more widely used in popular languages.

```ocaml
fun div x y = if y == 0 then throw Error ("division by zero", Critical) else x / y
```

#### Effect Type

Algebraic effects are similar to exceptions but can return a value.

```kotlin
effect Fork(f: Unit -> Unit): Unit
effect Yield: Unit
effect Raise(e: Exn): Unit
```

### Advanced Features

#### Modular Programming

Values can be imported from other modules.

```ocaml
import Map from "core/map"

val empty_map = Map.empty
val map = Map.create [(1, "abc"), (2, "def")]
val v = map /. get 1
do map /. put 3 "hi"
```

Make a value public using `export`.

```ocaml
export fun id x = x
export type Option a = Some a | None
```

#### Default Argument

Function arguments can be marked as optional by providing a default value.

```kotlin
fun call (debug: Bool = false) f x = {
	val res = f x
	if debug then print "f($x) = $res"
}
// Call it
call () double 2
// Specify argument
call true double 2
```

#### Generic Function

A simple generic function.

```ocaml
fun twice f a = (f a, f a)
// Signature of twice inferred as below
val twice: forall a b . (a -> b) -> a -> (b, b)
```

Generic functions can also be restricted with constraints.

```ocaml
type Adder a = (
	add : a -> a -> a
)
fun double ?(num: Adder a) (x: a): a = num.add x
// val double: forall a. [Adder a] -> a -> a

val x = double 2 // Evaluates to 4
```

The `num` is prefixed with a `?`, indicating that it’s an implicit argument.

#### Implicit Argument

When calling a function, implicit arguments can be omitted, and the compiler will find an appropriate value in the current scope at compile time.

You can also pass implicit arguments explicitly by adding a `?` prefix to argument names.

```scala
// Create a different adder
val adder = (add = { x -> x * x })
val x = double 3 // Evaluates to 6
val y = double ?adder 3 // Evaluates to 9
```

#### Extensions

Extensions allow adding methods to existing types. It’s similar to the class body in OOP languages. Inside an extension, `this` refers to the value being extended.

For example, let’s add some methods to the built-in integer type.

```scala
extension IntOps for Int {
	val neg = - this
	fun add x = this + x
}

val x = 3 /. neg
// x evaluates to -3
```

An extension can be anonymous. Let’s look at an extension for a newly defined type.

```scala
data List a = Nil | Cons a (List a)
exception Empty

extension for List a {
	fun head = match this with
		| Cons x xs -> x
		| Nil -> throw Empty
}

val list = Cons 1 (Cons 2 Nil)
val h = list /. head
// h evaluates to 1
```

#### Trait

A trait is an abstract type used for dynamic dispatch or method overloading.

```scala
trait ToString {
	val toString: String
}
```

Extensions can declare conformity to traits.

```scala
extension IntToString for Int <: ToString {
	val toString = Int.toString this
}
```

Extension functions are dispatched **statically**, but a value can be cast to a [trait object](https://doc.rust-lang.org/book/ch17-02-trait-objects.html) for dynamic dispatch. The syntax for type casting follows [OCaml's](https://ocaml.org/docs/objects#inheritance-and-coercions).

```scala
val objects: List ToString = [1 :> ToString, true :> ToString]

for o in objects do println (o /. toString)
```

## Comprehensive Example
Here's a program that showcases a wide range of the language's features and capabilities.

```ocaml
type Ordering = Less | Equal | Greater
type Ord a = (
	compare : a -> a -> Ordering
)

data List a = Nil | Cons a (List a)
exception Empty

extension ListOps for List a {
	fun head = match this with
		| Cons x xs -> x
		| Nil -> throw Empty
	fun concat ys = math this with
		| Nil -> ys
		| Cons x xs -> Cons x (xs/.concat ys)
}

// Integers are orderable
extension OrdInt <: Ord Int {
	fun compare x y = if x < y then Less
		else if x == y then Equal
		else Greater
}

extension SortList ?(ord: Ord a) for List a {
	type This = List a

	fun scan (compare: a -> Ordering) (xs: This) (less: This) (equal: This) (greater: This) = match xs with
	| Nil -> (less, equal, greater)
	| Cons y ys -> match compare y with
		| Less -> scan compare (Cons y less) equal greater
		| Equal -> scan compare less (Cons y equal) greater
		| Greater -> scan compare less equal (Cons y greater)

	fun sort = match this with
	| Nil -> Nil
	| Cons pivot ys -> {
		val (less, equal, greater) = scan {x -> ord.compare x pivot} ys Nil (Cons pivot Nil) Nil
		sort less /. concat equal /. concat (sort greater)
	}
}

// Create a list of [2, 1, 4, 3].
val numbers = Cons 2 (Cons 1 (Cons 4 (Cons 3 Nil)))
val sorted = numbers /. sort
// Evaluate to Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil))), representing [1, 2, 3, 4].

// Specify comparison function explicitly.
fun reverse order = match order with
	| Less -> Greater
	| Equal -> Equal
	| Greater -> Less

val descOrd: Ord Int = (
	compare = {a b ->
		reverse (OrdInt.compare a b)
	}
)
val descSort = (SortList ?descOrd).sort
val descNumbers = descSort numbers
// Evaluate to Cons 4 (Cons 3 (Cons 2 (Cons 1 Nil))), representing [4, 3, 2, 1].
```
