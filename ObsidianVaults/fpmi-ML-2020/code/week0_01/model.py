from abc import abstractmethod
import numpy as np

from typing import Any, Iterable

from sklearn.base import BaseEstimator, ClassifierMixin, RegressorMixin


class Model(BaseEstimator):
    @abstractmethod
    def fit(self, X: np.matrix, y: np.ndarray): ...

    @abstractmethod
    def predict(self, x) -> Any: ...

    @abstractmethod
    def __str__(self) -> str: ...


class ClassifierModel(Model, ClassifierMixin):
    @abstractmethod
    def predict_proba(self, x) -> Any: ...

    def predict(self, x) -> Any:
        proba = self.predict_proba(x)
        indx = np.argmax(proba)
        return self.classes[indx]


class RegressionModel(Model, RegressorMixin):
    @abstractmethod
    def predict(self, x) -> float: ...
