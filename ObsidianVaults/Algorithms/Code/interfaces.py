from abc import ABC, abstractmethod
from typing import Any, Generator, Generic, Iterable, Iterator, TypeAlias, TypeVar

T = TypeVar("T")


class Container(ABC, Generic[T]):
    @abstractmethod
    def __len__(self) -> int: ...

    @abstractmethod
    def __iter__(self) -> Iterator[T]: ...

    @abstractmethod
    def build(self, data: Iterable[T]) -> None: ...


class Static(ABC, Generic[T]):
    @abstractmethod
    def get_at(self, pos: int) -> T: ...

    @abstractmethod
    def set_at(self, pos: int, item: T) -> None: ...


class Stack(Container[T]):
    @abstractmethod
    def push(self, item: T) -> None: ...

    @abstractmethod
    def pop(self) -> T: ...


class Queue(Container[T]):
    @abstractmethod
    def push(self, item: T) -> None: ...

    @abstractmethod
    def pop(self) -> T: ...


class StaticContainer(Container[T], Static[T]):
    pass


class Dynamic(ABC, Generic[T]):
    @abstractmethod
    def insert_at(self, pos: int, *items: T) -> None: ...

    @abstractmethod
    def delete_at(self, pos: int) -> T: ...

    @abstractmethod
    def insert_last(self, item: T) -> None: ...

    @abstractmethod
    def delete_last(self) -> T: ...

    @abstractmethod
    def insert_first(self, item: T) -> None: ...

    @abstractmethod
    def delete_first(self) -> T: ...


class StaticSequence(Container[T], Static[T]):
    def __str__(self):
        return str(list(self))


class DynamicSequence(StaticSequence[T], Dynamic[T]):
    def insert_last(self, item):
        self.insert_at(len(self), item)

    def delete_last(self):
        return self.delete_at(len(self) - 1)

    def insert_first(self, item):
        self.insert_at(0, item)

    def delete_first(self):
        return self.delete_at(0)

    def __eq__(self, other):
        return list(self) == list(other)


type Node = Any


class Edge(Generic[T]):
    @abstractmethod
    def __init__(self, v: set[T]): ...

    @abstractmethod
    def get_vertcies(self) -> set[T]: ...

    def __str__(self):
        return " <-> ".join(map(str, self.get_vertcies()))


class OrientedEdge(Edge[T]):
    @abstractmethod
    def __init__(self, start: T, end: T): ...

    @abstractmethod
    def get_start(self) -> T: ...

    @abstractmethod
    def get_end(self) -> T: ...

    def get_vertcies(self):
        return set([self.get_start(), self.get_end()])

    def __str__(self):
        return f"{self.get_start()} -> {self.get_end()}"

    def reversed(self):
        return Edge({self.get_end(), self.get_start()})


type Weight = int


class WeightedEdge(OrientedEdge[T]):
    @abstractmethod
    def __init__(self, start: T, end: T, weight: Weight): ...

    @abstractmethod
    def get_weight(self) -> Weight: ...


NodeT = TypeVar("NodeT", bound=Node)
EdgeT = TypeVar("EdgeT", bound=Edge)


class Graph(Generic[NodeT, EdgeT]):
    @abstractmethod
    def add_vertex(self, v: NodeT) -> None: ...

    @abstractmethod
    def add_edge(self, edge: EdgeT) -> None: ...

    @abstractmethod
    def get_edge(self, u: NodeT, v: NodeT) -> EdgeT | None: ...

    def build(self, data: Iterable[EdgeT]):
        for edge in data:
            self.add_edge(edge)

    @abstractmethod
    def get_adj_nodes(self, u: NodeT) -> Iterable[NodeT]: ...

    @abstractmethod
    def get_adj_edges(self, u: NodeT) -> Iterable[EdgeT]: ...

    @abstractmethod
    def get_all_vertices(self) -> Iterable[NodeT]: ...

    @abstractmethod
    def get_all_edges(self) -> Iterable[EdgeT]: ...


class NotOrientedGraph(Graph[NodeT, Edge[NodeT]]):
    pass


class OrientedGraph(Graph[NodeT, OrientedEdge[NodeT]]):
    pass
