#!/usr/bin/env python

""" Compile one D source into an executable, reproducing the Makefile's
`ldc2 -O3 <input> -of=<output>`. Invoked by the generator as
ldc2_build.py <input.d> <output.elf>. The .o intermediate goes to a temporary
directory (-od), so only the executable lands in the tree. """

import os
import subprocess
import sys
import tempfile


def main():
    """ main entry point """
    source, output = sys.argv[1], sys.argv[2]
    os.makedirs(os.path.dirname(output), exist_ok=True)
    with tempfile.TemporaryDirectory() as objdir:
        sys.exit(subprocess.call(
            ["ldc2", "-O3", "-od=" + objdir, source, "-of=" + output]))


if __name__ == "__main__":
    main()
