from interfaces import DynamicSequence
from dynamic_array import DynamicArray
from test import Test, CTest
from test_static_sequence import TestStaticSequence


def TestDynamicSequence(
    tested: DynamicSequence,
    ideal: DynamicSequence | None = None,
):
    TestStaticSequence(tested, ideal)

    if ideal is None:
        ideal = DynamicArray()

    tests = [
        CTest(DynamicSequence.build, []),
        CTest(DynamicSequence.delete_at, 0),
        CTest(DynamicSequence.delete_last),
        CTest(DynamicSequence.delete_first),
        CTest(DynamicSequence.delete_first),
        CTest(DynamicSequence.build, [0, 1, 2, 3, 4, 5, 6]),
        CTest(DynamicSequence.insert_at, 3, 50),
        CTest(DynamicSequence.delete_at, 3),
        CTest(DynamicSequence.insert_last, 7),
        CTest(DynamicSequence.delete_last),
        CTest(DynamicSequence.insert_first, -1),
        CTest(DynamicSequence.delete_first),
    ]
    Test(tested, ideal, tests)
