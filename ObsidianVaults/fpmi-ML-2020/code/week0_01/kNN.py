from scipy import stats
from typing import Any, Callable
import numpy as np

import matplotlib.pyplot as plt

from metrics import E22


class kNN:
    def __init__(self, *, k=10, distance=None):
        # hyperparameters
        self.k = k
        self.distance = distance or E22

    def fit(self, X, y, weights=None):
        self.data = X
        self.targets = y
        self.unique_targets = np.unique(self.targets)
        if weights is None:
            self.weights = np.ones_like(self.targets)

    def predict(self, x):
        # find closest
        closest = np.argsort([self.distance(x, y) for y in self.data])
        kclosest = closest[: self.k]

        best_target = None
        max_target_fit = None

        for t in self.unique_targets:
            target_fit = np.sum(
                [self.weights[i] * (self.targets[i] == t) for i in kclosest]
            )
            if max_target_fit is None or target_fit > max_target_fit:
                max_target_fit = target_fit
                best_target = t

        return best_target


def Test_kNN(dataset, **kwargs):
    from dataset import Test, Divergence

    knn = kNN(**kwargs)
    print(f"{kwargs}: {TestRandom(dataset, knn, loss_function=Divergence):.1%}")


if __name__ == "__main__":
    from dataset import iris_dataset

    Test_kNN(iris_dataset, k=3)
    Test_kNN(iris_dataset, k=5)
    Test_kNN(iris_dataset, k=8)
    Test_kNN(iris_dataset, k=10)
    Test_kNN(iris_dataset, k=20)
    Test_kNN(iris_dataset, k=30)
