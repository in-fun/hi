## Introduction

Hi is a modern, practical functional programming language designed to be simple, expressive, and efficient. Its name captures the spirit of the language: as simple as saying "hi."

## Why Another Functional Programming Language?

My feelings towards the OCaml language are mixed. On one hand:
- Its syntax is not developer-friendly and can be confusing.
- It lacks some modern language features, such as import/export statements that avoid name conflicts.
- Additionally, its core language, module system, and object system are like different worlds that are not well integrated. These three components do not work well together, forcing developers to choose between them. This explains why its object types are seldom used, despite the popularity of object-oriented programming in other languages.

On the other hand, OCaml has a very solid foundation:
- The language is powerful and expressive.
- The runtime system is efficient and lightweight, implemented in C and assembly.
- It supports an effect system, which is the foundation of concurrent, parallel, and distributed systems.
- It has a good ecosystem of developer tools, libraries, and frameworks.

I want a language that is easy to learn, easy to use, and yet powerful and expressive. Hi is binary compatible with OCaml, allowing existing OCaml libraries to be used directly. The relationship between Hi and OCaml is similar to the relationship between Scala/Kotlin and Java. In other words, Hi is a better OCaml, just as Scala is a better Java.

## Examples

Below is a demonstration of a complete Hi program:

```hi
data List a = Nil | Cons a (List a)
exception Empty

extension for List a {
	fun head = match this with
		| Cons x xs = x
		| Nil -> throw Empty
}

val list = Cons 1 (Cons 2 Nil)
val h = list /. head
// h evaluates to 1
```

## Status

Currently in the proof-of-concept stage.

## Roadmap

- [ ] Develop a robust lexer and parser to ensure the Hi language syntax is well-formed and unambiguous.
- [ ] Implement a type checker to validate expression types.
- [ ] Create a compiler that translates core Hi constructs into OCaml compiler's lambda intermediate representation.
- [ ] Develop a full-fledged compiler that converts Hi source code into native executable binaries. At this stage, language features are limited to core constructs.
- [ ] Enable the import and utilization of existing OCaml libraries.
- [ ] Support advanced language features, including:
  - [ ] Pattern matching
  - [ ] Import and export statements
  - [ ] Extension expressions
  - [ ] Implicit values and arguments
  - [ ] Object system
  - [ ] Traits and dynamic dispatch
- [ ] Implement a standard library.
- [ ] Develop a build system.

## Language Tour

Explore the [features and syntax of the Hi language](./docs/tour.md).

## Credits

- The compiler backend is inspired by [Malfunction](https://github.com/stedolan/malfunction).
- Learn compiler construction from [MiniML](https://github.com/cmaes/miniml) and [MinCaml](https://esumii.github.io/min-caml/index-e.html).
