from collections import deque
import interfaces as i
from deque import Deque


class Queue(i.Queue):
    q: deque

    def __init__(self, data=None):
        self.q = deque()
        if data is not None:
            self.build(data)

    def build(self, data):
        self.q = deque(data)

    def __len__(self):
        return len(self.q)

    def __iter__(self):
        return iter(self.q)

    def push(self, item):
        self.q.append(item)

    def pop(self):
        return self.q.popleft()
