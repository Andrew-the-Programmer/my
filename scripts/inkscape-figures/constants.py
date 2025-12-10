import pathlib as pl


def Here() -> pl.Path:
    return pl.Path(__file__).parent


CREATE_SCRIPT: pl.Path = Here() / "create.py"
EDIT_SCRIPT: pl.Path = Here() / "edit.py"
EXPORT_SCRIPT: pl.Path = Here() / "export.py"

EDIT_CMD = "inkscape"
EXPORT_CMD = "inkscape"

TEMPLATE_FIGURE = Here() / "template.svg"
