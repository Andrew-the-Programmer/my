from typing import LiteralString

operations_history: list[str] = []


def ParseArgs(args: str) -> list[str]:
    return args.split(",")


def Perp(prefix: str, args: str = None) -> str:
    return IndexD(prefix, r"\perp")


def Parallel(prefix: str, args: str = None) -> str:
    return IndexD(prefix, r"\parallel")


def Index(
    operation: LiteralString["_", "^"],
    prefix: str,
    index: str,
    isolate_prefix: bool = None,
    isolate_index: bool = None,
) -> str:
    def Isolate(s: str) -> str:
        return "{" + s + "}"

    if isolate_prefix is not None and isolate_index is not None:
        if isolate_prefix:
            prefix = Isolate(prefix)
        if isolate_index:
            index = Isolate(index)
        return f"{prefix}{operation}{index}"
    if isolate_prefix is None:
        if len(prefix) == 1:
            isolate_prefix = False
        else:
            opposite_operation = "_" if operation == "^" else "^"
            prev_operation = (
                operations_history[-2] if len(operations_history) > 1 else None
            )
            if prev_operation == opposite_operation:
                isolate_prefix = False
            else:
                isolate_prefix = True
    if isolate_index is None:
        if len(index) == 1:
            isolate_index = False
        else:
            isolate_index = True
    return Index(operation, prefix, index, isolate_prefix, isolate_index)


def IndexD(prefix: str, index: str) -> str:
    return Index("_", prefix, index)


def IndexU(prefix: str, index: str) -> str:
    return Index("^", prefix, index)


def Stroke(prefix: str, args: str = None) -> str:
    n = 1
    if len(args) == 1:
        n = int(args)
    return IndexU(prefix, "'" * n)


def addFunc(prefix: str, func: str) -> str:
    return f"\\{func}{{{prefix}}}"


def Vec(prefix: str, args: str = None) -> str:
    return addFunc(prefix, "vec")


def Dot(prefix: str, args: str = None) -> str:
    n = 1
    if len(args) == 1:
        n = int(args)
    return addFunc(prefix, "d" * n + "ot")


def Overline(prefix: str, args: str = None) -> str:
    return addFunc(prefix, "overline")


def Underline(prefix: str, args: str = None) -> str:
    return addFunc(prefix, "underline")


def Abs(prefix: str, args: str = None) -> str:
    return addFunc(prefix, "abs")


def Dv(prefix: str, args: str = None) -> str:
    return addFunc(prefix, f"Dv{{{args}}}")


def dv(prefix: str, args: str = None) -> str:
    return addFunc(prefix, f"dv{{{args}}}")


def SimpleDv(prefix: str, args: str = None) -> str:
    return IndexU(prefix, f"({args})")


getFunc: dict[str] = {
    "^": IndexU,
    "_": IndexD,
    "v": Vec,
    "d": dv,
    "D": Dv,
    "o": Overline,
    "u": Underline,
    "a": Abs,
    "p": Perp,
    "P": Parallel,
    "s": Stroke,
    "t": Dot,
    "T": SimpleDv,
}


def ParseCommand(cmd: str) -> tuple:
    command = cmd[0]
    args = cmd[1:]
    operations_history.append(command)
    return getFunc[command], args


def ExecCommand(prefix: str, command: str):
    func, args = ParseCommand(command)
    s = func(prefix, args)
    return s


def main() -> str:
    INPUT = match[1]
    MATCH = r"(\\?[A-Za-z0-9]+)(\..*)+"
    m = re.match(MATCH, INPUT)
    prefix = m[1]
    commands = m[2]
    list_commands = commands.split(".")[1:]

    for c in list_commands:
        prefix = ExecCommand(prefix, c)

    return prefix


snip.rv = main()
