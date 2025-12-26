from typing import Iterable
import interfaces


class DynamicArray(interfaces.DynamicSequence):
    data: list

    def __init__(self):
        self.data = []

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

    def insert_at(self, i, x):
        self.data.insert(i, x)

    def delete_at(self, i):
        return self.data.pop(i)

    def insert_last(self, x):
        self.data.append(x)

    def delete_last(self):
        return self.data.pop()

    def insert_first(self, x):
        self.insert_at(0, x)

    def delete_first(self):
        return self.delete_at(0)


if __name__ == "__main__":
    ds = DynamicArray()
