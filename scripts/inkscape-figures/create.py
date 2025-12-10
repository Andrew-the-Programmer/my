#!/usr/bin/env python3

import argparse
import pathlib as pl
import shutil

import sys
from constants import TEMPLATE_FIGURE


def Create(path: pl.Path) -> None:
    shutil.copy(TEMPLATE_FIGURE, path)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-name",
        help="Name of new figure (f.e. fig1)",
        type=str,
    )
    parser.add_argument(
        "-path",
        help="Path to new figure (f.e. ./fig1.svg)",
        type=pl.Path,
    )
    args = parser.parse_args()

    name = args.name
    path = args.path

    if name is not None and path is None:
        if not name.endswith(".svg"):
            name = name + ".svg"
        path = pl.Path.cwd() / name

    if path is None:
        parser.print_help()
        sys.exit(1)

    Create(path)


if __name__ == "__main__":
    main()
