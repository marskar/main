# Relative import in top level __main__.py
import sys
from src.pkg.main import print_name_and_file

if __name__ == "__main__":
    print_name_and_file()
    print(sys.argv)
