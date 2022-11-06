# This is a thin wrapper around dune, adding some niceties like the
# ./bin symlink and a familiar user interface.
#
# Build with 'make build', test with 'make test', etc.
# The logic for compiling and recompiling OCaml sources as needed is
# in the 'dune' files.

.PHONY: build
build:
	rm -f bin
	dune build
	ln -s _build/install/default/bin .

.PHONY: test
test:
	dune runtest

.PHONY: clean
clean:
	dune clean
	rm -f bin
