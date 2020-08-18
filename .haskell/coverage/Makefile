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

SHELL = bash

UPSTREAM ?= https://raw.githubusercontent.com/input-output-hk/adrestia/master/.haskell/coverage/Makefile

WORKDIR ?= .coverage
DESTDIR ?= dist/coverage

PKGS = $(shell stack query locals | sed "s@^\s\s.*@@" | sed "s@:@@" | tr '\n' ' ' | sed "s@\s\+@ @g")
OVERLAYS = $(shell echo $(PKGS) | sed "s@\([^ ]*\)@$(WORKDIR)/\1.overlay@g")

HPC_DIR  = $(shell stack path --dist-dir)/hpc
HPC_ROOT = $(shell stack path --local-hpc-root)

.PHONY: badge clean report upgrade

### Phony

badge: $(DESTDIR)/badge.svg
	@echo -e "Coverage badge generated at: $<"

report: $(DESTDIR)/hpc_index.html
	@echo -e "Report generated at: $<"

clean:
	stack clean
	find . -name *.tix -delete
	rm -rf $(HPC_ROOT)/combined/custom/custom.tix
	rm -rf $(DESTDIR)/{hpc_index.html,badge.svg}

upgrade:
	$(eval TMP := $(shell mktemp))
	wget $(UPSTREAM) -O $(TMP)
	@mkdir -p .old
	@cp Makefile .old/Makefile
	@mv $(TMP) Makefile
	@echo "Up-to-date. Old Makefile saved in '.old/Makefile'."

### Recipes

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

$(DESTDIR)/hpc_index.html: $(HPC_ROOT)/combined/custom/custom.tix
	$(eval TMP := $(shell mktemp -d))
	for PKG in $(PKGS); do \
		OVERLAY=$(WORKDIR)/$$PKG.overlay; \
		if [ -f $$OVERLAY ]; then \
			HPC=$$(find $(HPC_ROOT)/combined/custom/* -type d -regex ".*$$PKG-[0-9.]+-.*"); \
			CABAL=$$(find . -name $$PKG.cabal); \
			PKG_HASH=$$(basename $$HPC); \
			PKG_SRC=$$(dirname $$CABAL); \
			cat $$OVERLAY | sed "s/module \"/module \"$$PKG_HASH\//g" > $(TMP)/$$PKG.overlay; \
			stack exec hpc -- overlay --hpcdir=$(HPC_DIR) --srcdir=$$PKG_SRC $(TMP)/$$PKG.overlay > $(WORKDIR)/$$PKG.overlay.tix; \
		fi; \
	done
	@rm -r $(TMP)
	stack hpc report --all --destdir $(DESTDIR) $(WORKDIR)/*.tix $<

$(HPC_ROOT)/combined/custom/custom.tix:
	stack test --no-terminal --coverage
	for PKG in $(PKGS); do \
		CABAL=$$(find . -name $$PKG.cabal); \
		PKG_SRC=$$(dirname $$CABAL); \
		[ ! -f $$PKG_SRC/*.tix ] || mv $$PKG_SRC/*.tix $(WORKDIR); \
	done
	stack hpc report --all $(WORKDIR)/*.tix
