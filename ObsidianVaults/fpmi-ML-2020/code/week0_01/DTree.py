# DTree

import heapq
import itertools
from dataclasses import dataclass
from typing import Callable

import numpy as np


def GetP(y):
    n = len(y)
    p = np.array([len(y[y == c]) / n for c in np.unique(y)])
    return p


def MisclassificationCriteria(y):
    if len(y) == 0:
        return 0
    p = GetP(y)
    return 1 - np.max(p)


def ShannonEntropy(y):
    if len(y) == 0:
        return 0
    p = GetP(y)
    return -np.mean(p * np.log(p))


def GiniImpurity(y):
    if len(y) == 0:
        return 0
    p = GetP(y)
    return 1 - np.sum(p**2)


def L2(y):
    if len(y) == 0:
        return 0
    return np.linalg.norm(y)


def MostCommon(y):
    if len(y) == 0:
        return 0
    p = GetP(y)
    mc = np.argmax(p)
    return np.unique(y)[mc]

@dataclass
class BinaryTreeNode:
    value: Any = None
    left: Any = None
    right: Any = None

    def set_left(self, l):
        self.left = l

    def set_right(self, r):
        self.right = r


@dataclass
class Filter:
    feature: int
    threshold: float

    def get_mask(self, X):
        return X[:, self.feature] <= self.threshold

    def filter(self, X):
        return X[self.get_mask(X)]


def select_filter(self, X, y) -> Filter:
    for x in range(X.shape[1]):
        ls = np.linspace(np.min(X[:, x]), np.max(X[:, x]), X.shape[0] // 10)[1:-1]
        for t in ls:
            yield Filter(x, t)


def select_filter_all(self, X, y) -> Filter:
    for x in range(X.shape[1]):
        ls = np.sort(np.unique(X[:, x]))
        for t in ls:
            yield Filter(x, t)

@dataclass
class DTree:
    entropy_fn: Callable
    decision_fn: Callable
    node_cls = BinaryTreeNode
    node_root = None
    filter_selector = select_filter_all
    max_nodes: int = None
    max_depth: int = None

    def entropy_w(self, y, w): ...

    def decision_w(self, y, w): ...

    def fit(self, X, y, sample_weight=None):
        self.C0 = self.decision_fn(y)
        node_id = 0
        node_depth = 1

        if sample_weight is None:
            sample_weight = np.ones_like(y, dtype=np.float64)
        else:
            sample_weight = np.asarray(sample_weight, dtype=np.float64)
            sample_weight = sample_weight / np.sum(sample_weight)

        # Get biggest first
        heap = [
            (
                -self.entropy_fn(y),
                node_id,
                node_depth,
                None,
                None,
                np.ones_like(y, dtype=bool),
            )
        ]

        while heap:
            H, sort_index, curr_depth, parent, isleft, curr_mask = heapq.heappop(heap)
            H = -H
            X_curr = X[curr_mask]
            y_curr = y[curr_mask]
            n = len(y_curr)

            if self.max_nodes is not None and node_id > self.max_nodes:
                continue
            if self.max_depth is not None and curr_depth > self.max_depth:
                continue
            if H == 0:
                continue

            filters = list(self.filter_selector(X_curr, y_curr))
            masks = list(f.get_mask(X_curr) for f in filters)
            valid_masks = [0 < np.sum(m) < n for m in masks]
            masks = list(itertools.compress(masks, valid_masks))
            filters = list(itertools.compress(filters, valid_masks))

            if len(masks) == 0:
                continue

            L = [y_curr[m] for m in masks]
            R = [y_curr[~m] for m in masks]
            Hl = [len(l) / n * self.entropy_fn(l) for l in L]
            Hr = [len(r) / n * self.entropy_fn(r) for r in R]
            Hm = np.array(Hl) + np.array(Hr)

            best_indx = np.argmin(Hm)
            best_filter = filters[best_indx]
            best_mask = masks[best_indx]
            yl = y_curr[best_mask]
            yr = y_curr[~best_mask]
            new_node = self.node_cls(
                value=(best_filter, self.decision_fn(yl), self.decision_fn(yr))
            )
            node_id += 1
            if parent is not None:
                if isleft:
                    parent.set_left(new_node)
                else:
                    parent.set_right(new_node)
            else:
                self.node_root = new_node

            left_mask = np.full_like(curr_mask, False)
            left_mask[curr_mask] = best_mask
            right_mask = np.full_like(curr_mask, False)
            right_mask[curr_mask] = ~best_mask

            heapq.heappush(
                heap,
                (
                    -self.entropy_fn(yl),
                    node_id,
                    curr_depth + 1,
                    new_node,
                    True,
                    left_mask,
                ),
            )
            heapq.heappush(
                heap,
                (
                    -self.entropy_fn(yr),
                    -node_id,
                    curr_depth + 1,
                    new_node,
                    False,
                    right_mask,
                ),
            )

    def go(self, X, C, node):
        if node is None:
            return np.full(X.shape[0], C)
        f, Cl, Cr = node.value
        left_mask = f.get_mask(X)
        res_l = self.go(X[left_mask], Cl, node.left)
        res_r = self.go(X[~left_mask], Cr, node.right)
        res = np.empty(X.shape[0])
        res[left_mask] = res_l
        res[~left_mask] = res_r
        return res

    def predict(self, X):
        return self.go(X, self.C0, self.node_root)
