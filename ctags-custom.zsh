#!/usr/bin/env zsh

# Generate ctags for python external libraries (site-packages)
gectags() {
	ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./.git/external-tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))") 
}

