import numpy as np
from typing import Any, Iterable
from sklearn.neighbors import KernelDensity


class HistDistr:
    name = "HistDistr"

    fit_bins: int | Any = 10

    def __init__(self, values, bins) -> None:
        self.values = values
        self.bins = bins
        self.area = np.sum(np.diff(self.bins) * self.values)
        self.pdf_values = self.values / self.area

    @staticmethod
    def fit(data):
        return np.histogram(data, bins=HistDistr.fit_bins)

    def pdf(self, x):
        if isinstance(x, Iterable):
            return np.array([self.pdf(xv) for xv in x])
        if x < self.bins[0] or x >= self.bins[-1]:
            return 0.0
        idx = np.searchsorted(self.bins, x, side="right") - 1
        return self.pdf_values[idx]


class WindowDistr:
    name = "WindowDistr"

    fit_bins: int | Any = 10

    def __init__(self, data, window_length) -> None:
        self.data = data
        self.window_length = window_length

    @staticmethod
    def fit(data):
        return data, (np.max(data) - np.min(data)) / WindowDistr.fit_bins

    def pdf(self, x):
        if isinstance(x, Iterable):
            return np.array([self.pdf(xv) for xv in x])
        window = np.logical_and(
            self.data > x - self.window_length / 2,
            self.data < x + self.window_length / 2,
        )
        return len(self.data[window])


def KDE_factory(*, kernel="gaussian", **kde_kwargs):
    class KDE:
        name = f"KDE-{kernel}"

        def __init__(self, kde):
            self.kde = kde

        @staticmethod
        def fit(data):
            kwargs = {
                "bandwidth": ( np.max(data) - np.min(data) ) / 10
            } | kde_kwargs
            kde = KernelDensity(kernel=kernel, **kwargs)
            kde.fit(data.reshape((-1, 1)))
            return (kde,)

        def logpdf(self, x):
            return self.kde.score_samples(x.reshape((-1, 1)))

        def pdf(self, value):
            return np.exp(self.logpdf(value))

    return KDE
