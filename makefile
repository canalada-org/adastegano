all:
	gnatmake -O2 -gnatp src/adastegano.adb -bargs -shared -largs -s
clean:
	rm *.o
	rm *.ali
	rm adastegano
install: adastegano
	install adastegano /usr/local/bin