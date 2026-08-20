#!/usr/bin/env python

""" Compile one D source into an executable, reproducing the Makefile's
`ldc2 -O3 <input> -of=<output>`. Invoked by the generator as
ldc2_build.py <input.d> <output.elf>. The .o intermediate goes to the output
dir (-od) instead of the source tree. """

import os
import subprocess
import sys


def main():
    """ main entry point """
    source, output = sys.argv[1], sys.argv[2]
    outdir = os.path.dirname(output)
    os.makedirs(outdir, exist_ok=True)
    sys.exit(subprocess.call(
        ["ldc2", "-O3", "-od=" + outdir, source, "-of=" + output]))


if __name__ == "__main__":
    main()
