SHELL = /bin/bash

prefix ?= /usr/local
bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib
srcdir = Sources

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build
DISTDIR = $(REPODIR)/dist
SOURCES = $(wildcard $(srcdir)/**/*.swift)

.DEFAULT_GOAL = all

.PHONY: all
all: $(DISTDIR)/index.html 

$(DISTDIR)/openapi.yml: $(SOURCES) | $(DISTDIR)/
	@npm run build

$(DISTDIR)/index.html: $(DISTDIR)/openapi.yml | $(DISTDIR)/
	@npx redoc-cli bundle $< --output $@

$(DISTDIR)/:
	mkdir -p $@

.PHONY: distclean
distclean:
	@rm -rf $(DISTDIR)

.PHONY: clean
clean: distclean
	@rm -rf $(BUILDDIR)
