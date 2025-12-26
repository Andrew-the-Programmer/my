from typing import Callable


class CTest:
    func: Callable
    args: tuple
    kwargs: dict
    ignore_fail: bool

    def __init__(self, func, *args, ignore_fail=False, **kwargs):
        self.func = func
        self.args = args
        self.kwargs = kwargs
        self.ignore_fail = ignore_fail

    def args_str(self):
        return ", ".join(map(str, self.args))

    def kwargs_str(self):
        return ", ".join([f"{key} = {value}" for key, value in self.kwargs.items()])

    def all_args_str(self):
        return ", ".join(filter(None, [self.args_str(), self.kwargs_str()]))

    def __str__(self):
        return f"{self.func.__name__}({self.all_args_str()})"


def TestOperation(*, tested, ideal, ctest: CTest):
    print(f"TEST: {ctest}: ", end="")

    op_name = ctest.func.__name__

    op1 = getattr(tested, op_name)
    op2 = getattr(ideal, op_name)

    try:
        val1 = op1(*ctest.args, **ctest.kwargs)
    except Exception as e:
        val1 = e

    try:
        val2 = op2(*ctest.args, **ctest.kwargs)
    except Exception as e:
        val2 = e

    if isinstance(val1, Exception) and not isinstance(val2, Exception):
        print("FAIL: ", end="")
        raise val1

    if tested != ideal:
        print("FAIL: ", end="")
        raise AssertionError(f"{tested} != {ideal}")

    if val1 == val2:
        print("OK")
    elif isinstance(val1, Exception) and isinstance(val2, Exception):
        print("OK(exception)")
    else:
        print("FAIL")
        raise AssertionError(f"{val1} != {val2}")


def Test(tested, ideal, tests: list[CTest]):
    for ctest in tests:
        try:
            TestOperation(tested=tested, ideal=ideal, ctest=ctest)
        except Exception as e:
            if not ctest.ignore_fail:
                raise e
            else:
                print("IGNORED")
