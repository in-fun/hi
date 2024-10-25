(lang dune 3.16)

(name hi_lang)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "lilac")

(maintainers "lilac")

(license LICENSE)

(documentation https://github.com/lilac/hi-lang)

(package
 (name hi_lang)
 (synopsis "The Hi programming language")
 (description "Modern practical functional programming language")
 (depends ocaml dune menhir malfunction)
 (tags
  (topics "functional programming" "compiler" "programming language"))
)

(using menhir 3.0)

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
