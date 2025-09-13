# To build staticly with musl glibc uncomment the following lines.
#CC = ./musl/bin/gcc
#CFLAGS = -static -Wall -Wextra -Werror -Wpedantic

# This tells make that the all, binaries, and clean targets not actual files on disk.
.PHONY: all binaries clean

# If no compiler is set then fallback to gcc.
CC ?= gcc

# If the user passed DEBUG=yes on the command line then change CFLAGS to add debug info and disable optimizations.
DEBUG ?= no
ifeq ($(DEBUG),yes)
    CFLAGS += -g -O0
endif

# Define paths to build related directories.
SRCDIR = ./src
BINDIR = ./bin
OBJDIR = ./obj

# Default build target that makes everything.
all: $(BINDIR)/chntpw $(BINDIR)/reged $(BINDIR)/samusrgrp $(BINDIR)/sampasswd

# This build target creates the ./bin and ./obj folders if they are missing.
$(BINDIR) $(OBJDIR):
	mkdir -p $@

# This build target compiles all the .c files into .o files.
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# These next few build targets build binaries from the .o files.
$(BINDIR)/chntpw: $(OBJDIR)/chntpw.o $(OBJDIR)/ntreg.o $(OBJDIR)/edlib.o $(OBJDIR)/libsam.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^ -lssl -lcrypto

$(BINDIR)/reged: $(OBJDIR)/reged.o $(OBJDIR)/ntreg.o $(OBJDIR)/edlib.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BINDIR)/samusrgrp: $(OBJDIR)/samusrgrp.o $(OBJDIR)/ntreg.o $(OBJDIR)/libsam.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BINDIR)/sampasswd: $(OBJDIR)/sampasswd.o $(OBJDIR)/ntreg.o $(OBJDIR)/libsam.o | $(BINDIR)
	$(CC) $(CFLAGS) -o $@ $^

# This build target deletes the ./bin and ./obj folders and their contents entirely.
clean:
	rm -rf $(OBJDIR) $(BINDIR)