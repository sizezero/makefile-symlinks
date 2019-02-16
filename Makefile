
# imp represents imported datasets (the first line of dependencies)
# der represents derived datasets
# s- represents symlinks of various derived and imported datasets

all : f-a3 f-b3

init : clean
	ln -s -f f-b2 s-b2

clean :
	-rm f-* s-*

# dependency chaing with no symlinks

f-a1 :
	touch f-a1

f-a2 : f-a1
	touch f-a2

f-a3 : f-a2
	touch f-a3

# symlinks

f-b1 :
	touch f-b1

f-b2 : f-b1
	touch f-b2

f-b3 : s-b2
	touch f-b3
