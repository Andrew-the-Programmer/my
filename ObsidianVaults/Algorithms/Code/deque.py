import interfaces
from dynamic_array import DynamicArray
from typing import Iterable


class Deque(interfaces.DynamicSequence):
    left: interfaces.DynamicSequence
    right: interfaces.DynamicSequence

    def __init__(self, T=DynamicArray):
        if not issubclass(T, interfaces.DynamicSequence):
            raise TypeError("T must be a subclass of DynamicSequence")
        self.left = T()
        self.right = T()

    def __len__(self):
        return len(self.left) + len(self.right)

    def get_at(self, pos):
        if pos < len(self.left):
            return self.left.get_at(len(self.left) - pos - 1)
        else:
            return self.right.get_at(pos - len(self.left))

    def set_at(self, i, x):
        if i < len(self.left):
            self.left.set_at(len(self.left) - i - 1, x)
        else:
            self.right.set_at(i - len(self.left), x)

    def iter_seq(self):
        for x in list(self.left.iter_seq())[::-1]:
            yield x
        for x in self.right.iter_seq():
            yield x

    def insert_at(self, i, x):
        if i < len(self.left):
            self.left.insert_at(len(self.left) - i, x)
        else:
            self.right.insert_at(i - len(self.left), x)

    def move_half_to_right(self):
        for _ in range(len(self.left) // 2):
            self.right.insert_last(self.left.delete_last())

    def move_half_to_left(self):
        for _ in range(len(self.right) // 2):
            self.left.insert_last(self.right.delete_last())

    def delete_at(self, i):
        if i < len(self.left):
            if len(self.right) == 0 and i == len(self.left) - 1:
                self.move_half_to_right()
            val = self.left.delete_at(len(self.left) - i - 1)
        else:
            if len(self.left) == 0 and i == 0:
                self.move_half_to_left()
            val = self.right.delete_at(i - len(self.left))
        return val

    def build(self, X: Iterable) -> None:
        list_X = list(X)
        n = len(list_X)
        left_list = list_X[: n // 2][::-1]
        right_list = list_X[n // 2 :]
        self.left.build(left_list)
        self.right.build(right_list)


if __name__ == "__main__":
    from test_dynamic_sequence import TestDynamicSequence

    TestDynamicSequence(Deque())
