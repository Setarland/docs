# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= poetry run sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Open locally build docs in a web browser
browser-docs-macos:
	open build/html/index.html

# Get Webpack tool chain to build Furo theme
install-furo:
	(cd deps/furo && npm install)

# Rebuild furo.css
rebuild-furo:
	(cd deps/furo && npm run build)
	cp deps/furo/src/furo/theme/furo/static/styles/furo.css source/_static/styles/

# Clean problematic autosummary leftovers from local tree
clean-autosummary:
	-find . -iname "_autosummary" -exec rm -rf {} \; 2>/dev/null

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
