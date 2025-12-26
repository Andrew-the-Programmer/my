from typing import Iterable

import interfaces
from dynamic_array import DynamicArray


class Path(interfaces.DynamicSequence[interfaces.OrientedEdge]):
    data: interfaces.DynamicSequence[interfaces.OrientedEdge]

    def __init__(
        self, data: Iterable[interfaces.OrientedEdge], DynamicSequence=DynamicArray
    ):
        if not issubclass(DynamicSequence, interfaces.DynamicSequence):
            raise TypeError
        self.data = DynamicSequence()
        self.build(data)

    def __len__(self):
        return len(self.data)

    def build(self, data):
        prev = None
        for new in data:
            if prev is not None and prev.get_end() != new.get_start():
                raise ValueError
            self.data.insert_last(new)
            prev = new

    def __iter__(self):
        return iter(self.data)

    def get_vertex_list(self):
        res = []
        if len(self) > 0:
            res.append(self.get_at(0).get_start())
        res = [e.get_end() for e in self]
        return res

    def insert_path(self, other, pos: int):
        if not isinstance(other, Path):
            raise TypeError

        if len(self) == 0:
            self = other
            return

        if len(other) == 0:
            return

        # Check for correctness
        if (
            pos != len(self)
            and self.get_at(pos).get_start() != other.get_at(-1).get_end()
        ):
            raise ValueError

        if pos != 0 and self.get_at(pos - 1).get_end() != other.get_at(0).get_start():
            raise ValueError

        # Insert
        self.data.insert_at(pos, *other)

    def get_at(self, pos):
        return self.data.get_at(pos)

    def set_at(self, pos, item):
        self.data.set_at(pos, item)

    def insert_at(self, pos, *items):
        return self.insert_path(other=Path(items), pos=pos)

    def delete_at(self, pos):
        return self.data.delete_at(pos)

    def prepend(self, other):
        self.insert_path(other, 0)

    def append(self, other):
        self.insert_path(other, len(self.data))

    def __str__(self):
        if len(self.data) == 0:
            return "[]"

        res = f"{self.get_at(0).get_start()}"
        for e in self:
            res += f" -> {e.get_end()}"

        return res
