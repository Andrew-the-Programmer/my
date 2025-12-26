from collections import defaultdict
import interfaces as i
from .queue import Queue
from stack import Stack
import heapq


def BFS(graph: i.Graph, start: i.Node):
    visited = set([start])
    queue = Queue([start])

    while queue:
        node = queue.pop()

        for neighbor in graph.get_adj_nodes(node):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.push(neighbor)


def DFS(graph: i.Graph, start: i.Node):
    visited = set([start])
    queue = Stack([start])

    while queue:
        node = queue.pop()

        for oedge in graph.get_adj_nodes(node):
            neighbor = oedge.get_end()

            if neighbor not in visited:
                visited.add(neighbor)
                queue.push(neighbor)


def dfs_explore(grid: list[list[str]], r: int, c: int, visited):
    """DFS on 2D grid with boundary checks."""
    if (
        not (0 <= r < len(grid))
        or not (0 <= c < len(grid[0]))
        or (r, c) in visited
        or grid[r][c] == "#"
    ):
        return False

    visited.add((r, c))

    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    for dr, dc in directions:
        dfs_explore(grid, r + dr, c + dc, visited)

    return True


def has_cycle(graph: i.Graph):
    """Detect cycle in directed graph using DFS colors."""

    color: defaultdict[i.Node, int] = defaultdict(
        lambda: 0
    )  # 0=unvisited, 1=visiting, 2=visited

    def dfs(node: i.Node):
        color[node] = 1  # Visiting

        for neighbor in graph.get_adj_nodes(node):
            if color[neighbor] == 1:  # Back edge found
                return True
            if color[neighbor] == 0:
                if dfs(neighbor):
                    return True

        color[node] = 2  # Visited
        return False

    for node in graph.get_all_vertices():
        if color[node] == 0:
            if dfs(node):
                return True

    return False


def Dijkstra(graph: i.Graph[i.Node, i.WeightedEdge], start: i.Node):
    heap = [(0, start)]
    dists: dict[i.Node, i.Weight] = dict()
    dists[start] = 0

    while heap:
        node_dist, node = heapq.heappop(heap)

        if node_dist > dists[node]:
            continue

        for edge in graph.get_adj_edges(node):
            neighbor = edge.get_end()
            weight = edge.get_weight()

            neighbor_dist = node_dist + weight

            if neighbor not in dists or neighbor_dist < dists[neighbor]:
                dists[neighbor] = neighbor_dist
                heapq.heappush(heap, (neighbor_dist, neighbor))

    return dists
