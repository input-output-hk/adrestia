# Haskell Program Coverage - Makefile
#
#   This Makefile contains a few top-level build commands for easily making
#   code coverage reports using stack and hpc. It is typically used in two
#   ways:
#
#   a) Locally, to construct an coverage overlay template to purposely ignore
#   some part of the source code in the coverage reports.
#
#   b) In a continuous integration setup, to generate reports possibly using the
#   overlay generated in a).
#
#
# Usage:
#
#     a) WORKDIR=.coverage make draft
#
#     This will compile and test an existing Haskell project with stack, and create a draft
#     overlay report in $WORKDIR. This overlay provides 100% coverage for files tested in the
#     Haskell package.
#     One would typically use the draft as a baseline and produce a `template.overlay` from it
#     to discard some part of the source code from the coverage report. In particular, one may
#     discard automatically generated instances (like `Show` or `Eq`) or, terms that never get
#     evaluated to WHNF (like `Proxy`) because they only carry information at the type-level.
#
#     b) DESTDIR=dist/coverage WORKDIR=.coverage make report
#
#     Generates an HPC report for the project, using '$WORKDIR/template.overlay' as a coverage
#     overlay. Fails if the file doesn't exists. The report is generated as HTML in $DESTDIR.
#
#     b) DESTDIR=dist/coverage make badge
#
#     Generates an SVG badge from a given coverage report. The badge can be hosted and shown
#     on a project front README and is made using the average coverage between top-level definitions,
#     expressions and alternatives.

SHELL = bash

UPSTREAM ?= https://raw.githubusercontent.com/input-output-hk/adrestia/master/.haskell/coverage/Makefile

WORKDIR ?= .coverage
DESTDIR ?= dist/coverage

HPC_DIR  = $(shell stack path --dist-dir)/hpc
HPC_ROOT = $(shell stack path --local-hpc-root)
SRC_DIR  = .

.PHONY: badge clean draft report upgrade

### Phony

badge: $(DESTDIR)/badge.svg
	@echo -e "Coverage badge generated at: $<"

clean:
	stack clean
	rm -rf $(WORKDIR)/{draft.overlay,overlay.tix}
	rm -rf $(HPC_ROOT)/*

draft: $(WORKDIR)/draft.overlay
	@echo -e "Draft overlay generated at: $<"

report: $(DESTDIR)/hpc_index.html
	@echo -e "Report generated at: $<"

upgrade:
	$(eval TMP := $(shell mktemp))
	wget $(UPSTREAM) -O $(TMP)
	@mkdir -p .old
	@cp Makefile .old/Makefile
	@mv $(TMP) Makefile
	@echo "Up-to-date. Old Makefile saved in '.old/Makefile'."

### Recipes
COLOR_RED = \033[0;31m
COLOR_DEFAULT = \033[0m

$(DESTDIR)/badge.svg: $(DESTDIR)/hpc_index.html
	$(eval COVERAGE := $(shell cat $< | tr '\n' ' ' | sed "s/.*Program Coverage Total.*>\([0-9]\{1,3\}\)%.*>\([0-9]\{1,3\}\)%.*>\([0-9]\{1,3\}\)%.*/\1 \2 \3/"))
	$(eval COVERAGE := $(shell echo $(COVERAGE) | awk '{s+=$$1}END{print s/NR}' RS=' '))
	$(eval COVERAGE := $(shell LC_NUMERIC=C printf "%.0f" $(COVERAGE)))
	$(eval COLOR := $(shell { \
	if (( $(COVERAGE) > 80 )); then \
		echo "2ecc71"; \
	elif (( $(COVERAGE) > 70 )); then \
		echo "f1c40f"; \
	elif (( $(COVERAGE) > 60 )); then \
		echo "e67e22"; \
	else \
		echo "e74c3c"; \
	fi \
	}))
	@echo '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="144" height="28">' > $@
	@echo '<g shape-rendering="crispEdges">' >> $@
	@echo '<path fill="#555" d="M0 0h93v28H0z"/>' >> $@
	@echo '<path fill="#$(COLOR)" d="M93 0h51v28H93z"/>' >> $@
	@echo '</g>' >> $@
	@echo '<g fill="#fff" text-anchor="middle" font-family="DejaVu Sans,Verdana,Geneva,sans-serif" font-size="100">' >> $@
	@echo '<text x="465" y="175" transform="scale(.1)" textLength="690">COVERAGE</text>' >> $@
	@echo '<text x="1185" y="175" font-weight="bold" transform="scale(.1)" textLength="270">$(COVERAGE)%</text>' >> $@
	@echo '</g>' >> $@
	@echo '</svg>' >> $@

$(DESTDIR)/hpc_index.html: $(WORKDIR)/overlay.tix
	stack hpc report --all --destdir $(DESTDIR) *.tix $<

$(WORKDIR)/template.overlay:
	@echo -e "$(COLOR_RED)"
	@echo -e "No overlay template found."
	@echo -e "Make sure to create an overlay template at: $(COLOR_DEFAULT)$@ $(COLOR_RED)"
	@echo -e "See also $(COLOR_DEFAULT)'make draft'$(COLOR_RED) as an example of overlay with 100%$(WORKDIR)."
	@echo -e "$(COLOR_DEFAULT)"
	exit 1

$(WORKDIR)/overlay.tix: $(WORKDIR)/template.overlay $(HPC_ROOT)/combined/custom/custom.tix
	$(eval PKG_NAME := $(shell cat *.cabal | grep "name:" | sed "s/name:\s*\(.*\)/\1/"))
	$(eval PKG_HASH := $(shell ls $(HPC_DIR) | grep $(PKG_NAME) | sed "s/$(PKG_NAME)-[0-9]*-\([0-9A-Za-z]*\)/\1/g"))
	$(eval TMP := $(shell mktemp))
	cat $< | sed "s/module \"/module \"$(PKG_HASH)\//g" > $(TMP)
	stack exec hpc -- overlay --hpcdir=$(HPC_DIR) --srcdir=$(SRC_DIR) $(TMP) > $@
	@rm -rf $(TMP)

$(WORKDIR)/draft.overlay: $(HPC_ROOT)/combined/custom/custom.tix
	mkdir -p $(WORKDIR)
	stack exec hpc -- draft --hpcdir=$(HPC_DIR) --srcdir=$(SRC_DIR) $< | sed "s/module \".*:/module \"/g" > $@

$(HPC_ROOT)/combined/custom/custom.tix:
	stack clean && rm -f *.tix
	stack test --no-terminal --coverage
	stack hpc report --all *.tix
