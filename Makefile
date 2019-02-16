
all : der1 der2 der3 der4

init :
	touch imp1 imp2
	ln -s imp1 s-imp1
	ln -s imp2 s-imp2

# no symlinks

der1 : imp1 imp2
	touch der1

der2 : imp1
	touch der2

# symlinks

der3 : s-imp1 s-imp2
	touch der3

der4 : s-imp1
	touch der4
