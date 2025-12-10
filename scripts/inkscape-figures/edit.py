#!/usr/bin/env python3

import argparse
import pathlib as pl
import subprocess
import sys

from constants import EDIT_CMD


def Edit(path: pl.Path, args: list[str] = None) -> None:
    if args is None:
        args = []
    subprocess.run([EDIT_CMD, *args, path], check=True)


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
    args, unknown_args = parser.parse_known_args()

    name = args.name
    path = args.path

    if name is not None and path is None:
        if not name.endswith(".svg"):
            name = name + ".svg"
        path = pl.Path.cwd() / name

    if path is None:
        parser.print_help()
        sys.exit(1)

    Edit(path, unknown_args)


if __name__ == "__main__":
    main()
