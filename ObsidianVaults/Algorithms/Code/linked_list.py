import interfaces


class ListNode:
    def __init__(self, val, next_):
        self.val = val
        self.next = next_


class LinkedList(interfaces.DynamicSequence):
    p: ListNode
    size: int

    def __init__(self):
        self.p = ListNode(None, None)
        self.p.next = self.p
        self.size = 0

    def __len__(self):
        return self.size

    def _get_node(self, i) -> ListNode:
        curr = self.p.next
        while curr.next != self.p and i > 0:
            curr = curr.next
            i -= 1
        return curr

    def insert_at(self, i, x):
        prev = self._get_node(i - 1)
        next = prev.next
        new_node = ListNode(x, next)
        prev.next = new_node
        self.size += 1

    def delete_at(self, i):
        prev = self._get_node(i - 1)
        target = prev.next
        val = target.val
        next = target.next
        prev.next = next
        self.size -= 1
        return val

    def build(self, X):
        self.__init__()
        for x in X:
            self.insert_last(x)

    def iter_seq(self):
        curr = self.p.next
        while curr is not self.p:
            yield curr.val
            curr = curr.next

    def get_at(self, i):
        if not 0 <= i < len(self):
            raise IndexError
        return self._get_node(i).val

    def set_at(self, i, x):
        node = self._get_node(i)
        node.val = x


if __name__ == "__main__":
    from test_static_sequence import TestStaticSequence

    TestStaticSequence(LinkedList())
