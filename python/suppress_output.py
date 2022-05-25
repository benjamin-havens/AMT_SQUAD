"""
Provides a method to suppress terminal output. Useful for transmitting.
Should be used as follows:
with suppress_stdout():
    # Do stuff here
"""

from contextlib import contextmanager
import sys, os


@contextmanager
def suppress_stdout():
    with open(os.devnull, "w") as devnull:
        old_stdout = sys.stdout
        sys.stdout = devnull
        try:
            yield
        finally:
            sys.stdout = old_stdout
