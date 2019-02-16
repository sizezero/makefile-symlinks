
# Makefiles with symlink dependencies

I wasn't sure if my complex Makefile was following symlinks to the
actual file dependencies. This minimal test seems to show that there
are problems using symlinks in makefiles if other rules are needed to
the files referenced by those symlinks.


Given a simple dependency of:

f-a1 <- f-a2 <- f-a3

This works as expected:

```bash
$ make init
rm f-* s-*
rm: cannot remove 'f-*': No such file or directory
rm: cannot remove 's-*': No such file or directory
make: [Makefile:12: clean] Error 1 (ignored)
ln -s -f f-b2 s-b2
$ make f-a3
touch f-a1
touch f-a2
touch f-a3
$ make f-a3
make: 'f-a3' is up to date.
$ make f-a1
make: 'f-a1' is up to date.
$ touch f-a1
$ make f-a3
touch f-a2
touch f-a3
$ make f-a3
make: 'f-a3' is up to date.
```

If we replace one of the later dependencies with a symlink to the
dependency then things fall apart.

f-b1 <- f-b2 <- s-b2 (this is not a make rule but a symlink) <- f-b3 (this depends on the symlink)

```bash
$ make init
rm f-* s-*
ln -s -f f-b2 s-b2
$ make f-b3
make: *** No rule to make target 's-b2', needed by 'f-b3'.  Stop.
```

The above rule fails because the file referenced by the symlink does
not exist. Make does not appear to trace through the symlink to the
actual file which would allow it to find the rule that would allow it
to build `f-b2`.

```bash
$ make f-b2
touch f-b1
touch f-b2
$ make f-b3
touch f-b3
```

If the file pointed to by the symlink is created then the rule appears to work.

```bash
$ touch f-b1
$ make f-b3
make: 'f-b3' is up to date.
```

...but it doesn't really work The above shows that that later rule is
not linked to the earliere rules. Updating an ancestor does not fire
the final rule and make the final target rebuild.
