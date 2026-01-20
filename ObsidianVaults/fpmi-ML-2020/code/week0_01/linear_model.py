from abc import abstractmethod
from scipy import stats
from typing import Any, Callable
import numpy as np

import matplotlib.pyplot as plt
from sklearn import metrics

from model import Model
import metrics

from gradient_descent import GradientDescent


from sklearn.linear_model import LinearRegression, Lasso, Ridge, ElasticNet
from sklearn.base import (
    RegressorMixin,
    BaseEstimator,
    ClassifierMixin,
    TransformerMixin,
)

from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import make_pipeline

from sklearn.model_selection import GridSearchCV

from sklearn.metrics import precision_score, recall_score, f1_score, fbeta_score


class Linear(Model, RegressorMixin, BaseEstimator):
    def __init__(self):
        self.w = None

    def predict(self, x):
        return x.dot(self.w)


class LinearL2(Linear):
    def __init__(self, lam=1e-2):
        self.l2 = lam**2

    def fit(self, X, y):
        self.w = (
            np.linalg.inv(X.T.dot(X) - self.l2 * np.eye(X.shape[1])).dot(X.T).dot(y)
        )


class LinearR(LinearL2):
    def __init__(self):
        self.l2 = 0


class LinearGradient(Linear):
    def __init__(
        self,
        step=1e-2,
        start=None,
        step_limit=1e-5,
        metric=metrics.E2,
        count_iterations=1000,
    ):
        self.step = step
        self.start = start
        self.step_limit = step_limit
        self.metric = metric
        self.count_iterations = count_iterations

    def fit(self, X: np.matrix, y: np.ndarray):
        def df(w):
            return 2 * X.T.dot(X.dot(w) - y)

        self.w = GradientDescent(
            df,
            step=self.step / y.shape[0],
            start=self.start or np.random.uniform(-2, 2, X.shape[1]),
            count_iterations=self.count_iterations,
            step_limit=self.step_limit,
            metric=self.metric,
        )


if __name__ == "__main__":
    from dataset import Test, TestRes, Divergence, Validate, TestRandom
    from sklearn.metrics import mean_squared_error
    from sklearn.model_selection import validation_curve
    from dataset import iris_dataset

    dataset = iris_dataset
    loss_function = mean_squared_error

    hp = np.arange(0, 10, 10)

    lam = 1
    res = TestRandom(dataset, LinearL2(lam), loss_function=Divergence)
    print(f"{lam}: {res[0]:.1%}")

    res = TestRandom(dataset, LinearGradient(), loss_function=Divergence)
    print(f"Grad: {res[0]:.1%}")

    res = TestRandom(dataset, LinearR(), loss_function=Divergence)
    print(f"Lin: {res[0]:.1%}")
