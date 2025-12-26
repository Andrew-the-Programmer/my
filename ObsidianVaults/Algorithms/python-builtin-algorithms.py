import heapq

heap = [1, 2, 3, 4, 5]
heapq.heapify(heap)
heapq.heappush(heap, 6)
heapq.heappop(heap)

from collections import deque

d = deque
d = deque([1, 2, 3, 4, 5])
d.append(6)
d.appendleft(0)
d.pop()
d.popleft()

from collections import defaultdict

dd = defaultdict(list)
dd["hello"]

from collections import Counter

c = Counter("aaabbc")
c.update("cccc")
c.subtract("bb")

print(c)
