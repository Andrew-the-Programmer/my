from collections import defaultdict

graph = defaultdict(list)  # Each new key automatically gets an empty list
graph["A"].append("B")
graph["B"].append("A")
