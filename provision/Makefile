
AG=apt-get
AGFLAG=-y

AGI=apt-get install -y

# Это комментарий, который говорит, что переменная CC указывает компилятор, используемый для сборки
CC=g++
#Это еще один комментарий. Он поясняет, что в переменной CFLAGS лежат флаги, которые передаются компилятору
CFLAGS=-c -Wall

all: hello

hello: main.o factorial.o hello.o
    $(CC) main.o factorial.o hello.o -o hello

main.o: main.cpp
    $(CC) $(CFLAGS) main.cpp

factorial.o: factorial.cpp
    $(CC) $(CFLAGS) factorial.cpp

hello.o: hello.cpp
    $(CC) $(CFLAGS) hello.cpp

clean:
    rm -rf *.o hello


update:
	$(AG) update -y
	$(AG) upgrade -y --no-install-recommends

install-sys:
	$(AGL) dnsmasq exim4 
	$(AGL) man 
	$(AGL) git 
	$(AGL) vim 
	$(AGL) curl mc make zip	