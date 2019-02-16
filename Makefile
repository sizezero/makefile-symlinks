
# imp represents imported datasets (the first line of dependencies)
# der represents derived datasets
# s- represents symlinks of various derived and imported datasets

all : der1a der1b der2a der2b

init : clean
	touch imp1 imp2
	ln -s -f s-der1a der1a
	ln -s -f s-der2a der2a

clean :
	-rm imp* der* s-*

# no symlinks

der1a : imp1
	touch der1a

der2a : imp2
	touch der2a

# symlinks

# doesn't work if the file der1a does not exist
der1b : s-der1a
	touch der1b

# works if we reference the actual file not the symlink
der2b : der2a
	touch der2b
