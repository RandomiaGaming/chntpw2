.PHONY: all clean clean_all

CC = ./musl/bin/gcc
CFLAGS = -static # -Wall -Wextra -Werror -Wpedantic

DEBUG ?= no
ifeq ($(DEBUG),yes)
    CFLAGS += -g -O0
endif

SRCDIR = ./src
BINDIR = ./bin
OBJDIR = ./obj
MUSLDIR = ./musl

all: $(BINDIR)/chntpw

# This build target creates the ./bin and ./obj folders if they are missing.
$(BINDIR) $(OBJDIR):
	mkdir -p $@

# This build target compiles all the .c files into .o files.
$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR) $(MUSLDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Build chntpw from all of the .o files
$(BINDIR)/chntpw: $(OBJDIR)/chntpw.o $(OBJDIR)/ntreg.o $(OBJDIR)/edlib.o $(OBJDIR)/libsam.o | $(BINDIR) $(MUSLDIR)
	$(CC) $(CFLAGS) -o $@ $^

$(MUSLDIR):
	@echo Downloading Musl...
	@curl https://musl.cc/x86_64-linux-musl-native.tgz -o ./musl.tgz --progress-bar
	@echo Extracting Musl...
	@tar -xvf ./musl.tgz 1>/dev/null 2>&1
	@rm ./musl.tgz
	@mv ./x86_64-linux-musl-native ./musl

clean:
	rm -rf $(OBJDIR)
	rm -rf $(BINDIR)

clean_all:
	rm -rf $(MUSLDIR)
	@$(MAKE) clean --no-print-directory