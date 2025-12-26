from interfaces import StaticSequence
from static_array import StaticArray
from test import Test, CTest


def TestStaticSequence(
    tested: StaticSequence,
    ideal: StaticSequence | None = None,
):
    if ideal is None:
        ideal = StaticArray()
    tests = [
        CTest(StaticSequence.build, []),
        CTest(StaticSequence.get_at, 0),
        CTest(StaticSequence.set_at, 0),
        CTest(StaticSequence.build, [0, 1, 2, 3, 4, 5, 6]),
        CTest(StaticSequence.get_at, 0),
        CTest(StaticSequence.set_at, 0, -1),
        CTest(StaticSequence.get_at, -1, ignore_fail=True),
        CTest(StaticSequence.set_at, -1),
        CTest(StaticSequence.get_at, 6),
        CTest(StaticSequence.set_at, 6),
    ]
    Test(tested, ideal, tests)
