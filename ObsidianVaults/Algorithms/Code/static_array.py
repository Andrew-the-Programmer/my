from typing import Iterable
import interfaces


class StaticArray(interfaces.StaticSequence):
    data: list

    def build(self, X: Iterable):
        self.data = list(X)

    def __len__(self):
        return len(self.data)

    def iter_seq(self):
        yield from self.data

    def get_at(self, i):
        return self.data[i]

    def set_at(self, i, x):
        self.data[i] = x
