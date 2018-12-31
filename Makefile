# If ENV is pipenv, run export PIPENV_VENV_IN_PROJECT=1
# Otherwise, .venv will not be in the current project.

ENV = virtualenv
PYTHON = .venv/bin/python3
LINTER = black
DOCS = $(wildcard docs/*.rst docs/*.md docs/*.ipynb)
TESTS = $(wildcard tests/*.py)
SRC = $(wildcard src/*/*.py)


env: .venv/bin/activate
docs: docs/_build/html/index.html

.venv/bin/activate: setup.py
ifneq ($(ENV), $(filter $(ENV),conda venv))
	pip install $(ENV)
endif
ifeq ($(ENV), $(filter $(ENV),virtualenv venv))
	test -d .venv || python -m $(ENV) .venv
endif
ifeq ($(ENV), conda)
	test -d .venv || conda create -yp .venv python=3
endif
ifeq ($(ENV), pipenv)
	test -d .venv || pipenv --three
	pipenv install pip
	pipenv install --editable .
else
	${PYTHON} -m pip install --upgrade pip
	${PYTHON} -m pip install --editable .
endif
	touch .venv/bin/activate

test: env
ifeq ($(ENV), pipenv)
	pipenv install pytest-mypy
else
	${PYTHON} -m pip install pytest-mypy
endif
	${PYTHON} -m pytest src tests

lint: env
ifeq ($(ENV), pipenv)
	pipenv install $(LINTER)
else
	${PYTHON} -m pip install $(LINTER)
endif
	${PYTHON} -m $(LINTER) src tests

docs/_build/html/index.html: $(DOCS) $(TESTS) $(SRC)
	sphinx-build -M html docs/ docs/_build

git: .git/

.git/:
	curl --user 'marskar' https://api.github.com/user/repos --data '{"name":"main","description":"Run a project, even when zipped."}'
	test -f README.rst || echo "Main" >> README.rst
	git init
	git add --all
	git commit --message "First commit"
	git remote add origin https://github.com/marskar/main.git
	git push --set-upstream origin master

clean:
	rm -rf build/
	rm -rf dist/
	rm -rf .eggs/
	find . -name '*.egg-info' -exec rm -rf {} +
	find . -name '*.egg' -exec rm -f {} +

commit:
	git add --all
	[ -z "`git status --porcelain`" ] || git commit --message "Edit version `python setup.py --version`"
	git push

patch: commit
	bumpversion --current-version `python setup.py --version` patch setup.py
	git commit --all --message "Bump version to `python setup.py --version`"
	git push

minor: commit
	bumpversion --current-version `python setup.py --version` minor setup.py
	git commit --all --message "Bump version to `python setup.py --version`"
	git push

major: commit
	bumpversion --current-version `python setup.py --version` major setup.py
	git commit --all --message "Bump version to `python setup.py --version`"
	git push

dist: clean
	python setup.py sdist bdist_wheel

release: dist
	twine upload dist/*

.PHONY: env test lint clean commit patch minor major dist release