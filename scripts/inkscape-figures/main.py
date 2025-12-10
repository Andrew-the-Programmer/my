#!/usr/bin/env python3

import argparse
import subprocess
import sys

from constants import CREATE_SCRIPT, EDIT_SCRIPT, EXPORT_SCRIPT


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-create",
        action="store_true",
        help="Create a new figure",
    )
    parser.add_argument(
        "-edit",
        action="store_true",
        help="Edit an existing figure",
    )
    parser.add_argument(
        "-export",
        action="store_true",
        help="Export an existing figure",
    )

    args, unknown_args = parser.parse_known_args()
    success = False

    if args.create:
        subprocess.run([CREATE_SCRIPT, *unknown_args], check=True)
        success = True
    if args.edit:
        subprocess.run([EDIT_SCRIPT, *unknown_args], check=True)
        success = True
    if args.export:
        subprocess.run([EXPORT_SCRIPT, *unknown_args], check=True)
        success = True
    if not success:
        parser.print_help()
        sys.exit(1)


if __name__ == "__main__":
    main()
