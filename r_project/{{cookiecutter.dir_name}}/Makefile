DELETE  := rm -rf
PKGNAME := $(shell sed -n "s/Package: *\([^ ]*\)/\1/p" {{cookiecutter.package_name}}/DESCRIPTION)
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" {{cookiecutter.package_name}}/DESCRIPTION)

all: install

clean:
	$(DELETE) src/*.o src/*.so

document: 
	Rscript -e 'devtools::document({{cookiecutter.package_name}}, roclets = c("rd", "collate", "namespace"))'

compile-attributes: 
	Rscript -e 'Rcpp::compileAttributes({{cookiecutter.package_name}})'

build: document compile-attributes
	R CMD build --no-manual {{cookiecutter.package_name}}

build-cran: compile-attributes
	R CMD build {{cookiecutter.package_name}}

install: compile-attributes
	cd ..;\
	R CMD INSTALL --no-multiarch --with-keep.source {{cookiecutter.package_name}}

clean-install: compile-attributes
	R CMD INSTALL --preclean --no-multiarch --with-keep.source {{cookiecutter.package_name}}

check: compile-attributes
	Rscript -e 'devtools::check({{cookiecutter.package_name}})'

test: compile-attributes
	Rscript -e 'devtools::test({{cookiecutter.package_name}})'

vignettes:
	Rscript -e 'devtools::build_vignettes({{cookiecutter.package_name}})'


