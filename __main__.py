# Relative import in top level __main__.py
from src.pkg.__main__ import print_name_and_file

if __name__ == "__main__":
    print_name_and_file()
