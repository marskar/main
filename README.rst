========================
Main
========================

Run a project, even when zipped.

Package Organization
--------------------

::

    main
    ├── README.rst            <- The top-level README that describes this project
    │
    ├── docs                  <- A default Sphinx project; see sphinx-doc.org for details
    │   ├── Makefile          <- An automation file for GNU Make
    │   ├── conf.py           <- The main Sphinx configuration file
    │   ├── index.rst         <- The main ReStructuredText file
    │   ├── jupyter.ipynb     <- An example of including a jupyter notebook in sphinx docs
    │   ├── make.bat          <- An automation file for Windows
    │   ├── readme.rst        <- A link to include the top-level README in the sphinx docs
    │   ├── rmarkdown.Rmd     <- An example of including an R markdown file in sphinx docs
    │   ├── rmd.md            <- The output of the R markdown file that will be included
    │   ├── rmd_files         <- Local files used by the R markdown output file rmd.md
    │   │   └── figure-markdown_strict
    │   │       └── pressure-1.png
    │   ├── main.rst
    │   └── tests.rst         <- A link to include the tests in the sphinx docs
    │
    ├── requirements.txt      <- The requirements file for reproducing the analysis environment
    │
    ├── setup.py              <- Make this project pip installable with `pip install -e .`
    │
    └── src                   <- Source code for use in this project
        └── main
            ├── __init__.py   <- Makes Main a Python package
            └── main.py

Project based on the `Cookiecutter Data Science project template <https://drivendata.github.io/cookiecutter-data-science>`__.
