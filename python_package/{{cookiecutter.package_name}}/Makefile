all: install

.PHONY: install
install:
	pip install -e .

.PHONY: build
build:
	rm -rf dist
	python -m build

.PHONY: test-pypi
test-pypi:
	python -m twine upload --repository testpypi dist/*

.PHONY: test
test:
	pytest
	cd docs ;\
		make doctest

.PHONY: docs
docs:
	cd docs ;\
	make html

.PHONY: autodoc
autodoc:
	sphinx-autobuild docs/source docs/build --watch {{cookiecutter.slug}}
