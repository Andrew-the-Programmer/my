from math import dist
from typing import Callable, Iterable
from scipy import stats
from typing import Any
import numpy as np

import matplotlib.pyplot as plt


class NaiveBayes:
    # hyperparameters
    distrs: list | None

    def __init__(self, distrs):
        self.distrs = distrs

    def fit(self, X, y, distrs=None):
        self.rsize = X.shape[0]
        self.csize = X.shape[1]

        if distrs is None:
            distrs = self.distrs or [stats.norm] * self.csize

        self.ut = np.unique(y)

        self.py = {t: np.sum(y == t) / len(y) for t in self.ut}
        self.px = {}

        for t in self.ut:
            self.px[t] = [0] * self.csize
            for c in range(self.csize):
                distr = distrs[c]
                selection = X[y == t, c]
                fit = distr.fit(selection)
                fit_distr = distr(*fit)
                self.px[t][c] = fit_distr

    def predict(self, x):
        best_t = None
        max_fit = None

        for t in self.ut:
            fit = self.py[t] * np.prod(
                [self.px[t][c].pdf(value) for c, value in enumerate(x)]
            )
            if max_fit is None or max_fit < fit:
                max_fit = fit
                best_t = t

        return best_t


def PlotIris(data, distrs):
    fig, axes = plt.subplots(data.shape[1], 1)

    for i, ax in enumerate(axes.flat):
        x = np.sort(data[:, i])
        v, b, _ = ax.hist(x)
        area = np.sum(np.diff(b) * v)
        fit_distr = distrs[i]
        ax.plot(x, fit_distr.pdf(x) * area)


def FitDistrs(data, distrs):
    res = []
    for i in range(data.shape[1]):
        x = np.sort(data[:, i])
        fit_distr = distrs[i]
        fitres = fit_distr.fit(x)
        fit_distr = fit_distr(*fitres)
        res.append(fit_distr)
    return res


def TestNaiveBayes(dataset, distrs, plot=False):
    from dataset import Test

    nb = NaiveBayes(distrs)
    res, dl, dt, tl, t = Test(dataset, nb)

    print(f"{', '.join([d.name for d in distrs])}:\n\t{res:.1%}")

    if plot:
        learn_distrs = FitDistrs(dl, distrs)
        PlotIris(dl, learn_distrs)
        test_distrs = FitDistrs(dt, distrs)
        PlotIris(dt, test_distrs)


if __name__ == "__main__":
    from dataset import iris_dataset
    from distributions import HistDistr, WindowDistr, KDE_factory

    TestNaiveBayes(iris_dataset, [stats.norm] * 4)
    TestNaiveBayes(iris_dataset, [HistDistr] * 4)
    TestNaiveBayes(iris_dataset, [WindowDistr] * 4)
    TestNaiveBayes(iris_dataset, [KDE_factory()] * 4, plot=True)

    plt.show()
