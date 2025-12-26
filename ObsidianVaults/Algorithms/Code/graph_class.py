class Graph:
    data: dict[Any, list[Edge]]

    def add_vertex(self, v):
        if v not in self.data:
            self.data[v] = []

    def add_edge(self, e: Edge):
        self.add_vertex(e.start)
        self.add_vertex(e.end)
        self.data[e.start].append(e)
        self.data[e.end].append(e.reverse())

    def __init__(self, N):
        self.data = dict()
        for i in range(N):
            self.add_vertex(i)

    def get_size(self):
        return len(self.data)

    def get_adj_list(self, u):
        return self.data[u]

    def find_edge(self, u, v):
        for e in self.get_adj_list(u):
            if e.end == v:
                yield e

    def input_adj_list(self, M, *, vertex_factory=int, edge_data_factory=int):
        for _ in range(M):
            stdin = input().strip().split(" ")
            u, v = map(vertex_factory, stdin[:2])
            t = edge_data_factory(stdin[2])
            self.add_edge(Edge(u, v, t))

    def __str__(self):
        res = ""
        for u in self.data.keys():
            for e in self.get_adj_list(u):
                res += str(Path([e])) + "\n"
        return res
