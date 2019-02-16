
# Makefiles with symlink dependencies

I wasn't sure if my complex Makefile was following symlinks to the
actual file dependencies. This minimal test seems to show that
symlinks are only followed if the file that the symlink leads to
exists.

Given a simple dependency of:

imp1 <- der1a <- s-der1a (symlink to der1a) <- der1b

imp1 <- der2a <- der2b

```bash
TODO
```

