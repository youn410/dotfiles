.PHONY: setup test

setup:
	./setup.sh
	ls -la ~/

test:
	./test/setup.test.sh
