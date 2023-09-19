all: install

install:
	pip install -e .

clean:
	rm -rf src/*.o src/*.so

test:
	python -m unittest discover

document:
	sphinx-apidoc -o docs/source {{cookiecutter.package_name}} ;\
	cd docs ;\
	make html pdf
	


