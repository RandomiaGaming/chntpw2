.PHONY: all clean

# DOCRYPTO
# DOCRYPT
# __FreeBSD__
# LSADATA
# ADDBIN_DEBUG
# LOAD_DEBUG
# GETLINE_DEBUG
# AKDEBUG
# DKDEBUG
# DOCORE
# O_BINARY

CC=gcc
CFLAGS = -DLINUX
BUILD ?= release
ifeq ($(BUILD),debug)
    CFLAGS += -g -O0
endif
ifeq ($(BUILD),release)
    CFLAGS += -O2
endif

SRCDIR=./src
OBJDIR=./obj
BINDIR=./bin

all: $(BINDIR)/chntpw $(BINDIR)/cpnt $(BINDIR)/reged $(BINDIR)/samusrgrp $(BINDIR)/sampasswd

$(BINDIR)/chntpw: $(OBJDIR)/chntpw.o $(OBJDIR)/ntreg.o $(OBJDIR)/edlib.o $(OBJDIR)/libsam.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BINDIR)/cpnt: $(OBJDIR)/cpnt.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BINDIR)/reged: $(OBJDIR)/reged.o $(OBJDIR)/ntreg.o $(OBJDIR)/edlib.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BINDIR)/samusrgrp: $(OBJDIR)/samusrgrp.o $(OBJDIR)/ntreg.o $(OBJDIR)/libsam.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BINDIR)/sampasswd: $(OBJDIR)/sampasswd.o $(OBJDIR)/ntreg.o $(OBJDIR)/libsam.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BINDIR) $(OBJDIR):
	mkdir -p $@

clean:
	rm -rf $(OBJDIR) $(BINDIR)