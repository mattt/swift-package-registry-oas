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

.node/node_modules:
	@npm install --prefix .node

$(DISTDIR)/openapi.yml: $(SOURCES) | $(DISTDIR)/ .node/node_modules
	@npm run --prefix .node build

$(DISTDIR)/index.html: $(DISTDIR)/openapi.yml | $(DISTDIR)/ .node/node_modules
	@npx --prefix .node redoc-cli bundle $< --output $@

$(DISTDIR)/:
	@mkdir -p $@

.PHONY: distclean
distclean:
	@rm -rf $(DISTDIR)

.PHONY: clean
clean: distclean
	@rm -rf $(BUILDDIR)
