COMP=g++

medias: plantilla.c
	$(COMP) -o $@ $^$(LIBS)

plantilla.c: plantilla.l
	flex++ -o $@ $^

# Ejecutamos make ejemplo para probar un ejemplo
ejemplo:
	./medias Datos/notas.txt
clean:
	rm -f medias plantilla.c
