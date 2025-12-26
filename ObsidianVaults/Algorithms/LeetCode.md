# Heap

```python
import heapq

heap = [1, 2, 3, 4, 5]
heapq.heapify(heap)
heapq.heappush(heap, 6)
heapq.heappop(heap)
```

# Deque

```python
from collections import deque

d = deque([1, 2, 3, 4, 5])
d.append(6)
d.appendleft(0)
d.pop()
d.popleft()
```

# Defaultdict

```python
from collections import defaultdict

dd = defaultdict(list)
dd["hello"] -> []
```

# Counter

```python
from collections import Counter

c = Counter("aaabbc")
c.update("cccc")
c = Counter("aaabbc")
c.update("cccc")
c.subtract("bb")

c -> Counter({'c': 5, 'a': 3, 'b': 0})
```
