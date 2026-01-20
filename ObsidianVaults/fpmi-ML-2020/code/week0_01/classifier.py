from collections import defaultdict
import copy
import itertools
from typing import Any
from sklearn.base import BaseEstimator, ClassifierMixin, RegressorMixin
import numpy as np
from model import ClassifierModel

from metrics import Sigmoid


class BinaryClassifier(ClassifierModel):
    def __str__(self) -> str:
        return "BinaryClassifier"

    def __init__(self, rmodel) -> None:
        self.rmodel = rmodel

    def fit(self, X, y, classes=None):
        self.classes = classes or np.unique(y)
        self.classes = np.sort(self.classes)
        if len(self.classes) > 2:
            raise ValueError()
        by = np.where(y == self.classes[0], -1, 1)
        self.rmodel.fit(X, by)

    def predict_proba(self, x):
        r = self.rmodel.predict(x)
        p = Sigmoid(r)
        return [p, 1 - p]


class OneVsRest_Classifier(ClassifierModel):
    def __str__(self) -> str:
        return "OneVsRest_Classifier"

    def __init__(self, bc: ClassifierModel) -> None:
        self.bc = bc

    def fit(self, X: np.matrix, y: np.ndarray):
        self.classes = np.unique(y)
        self.binary_classifiers: dict[Any, ClassifierModel] = {}
        for c in self.classes:
            bc = copy.deepcopy(self.bc)
            by = np.where(y == c, 0, 1)
            bc.fit(X, by)
            self.binary_classifiers[c] = bc

    def predict_proba(self, x):
        class_predictions = [
            self.binary_classifiers[c].predict_proba(x)[0]  #
            for c in self.classes
        ]
        return class_predictions / np.sum(class_predictions)


class OneVsOne_Classifier(ClassifierModel):
    def __str__(self) -> str:
        return "OneVsOne_Classifier"

    def __init__(self, bc: ClassifierModel) -> None:
        self.bc = bc

    def fit(self, X: np.matrix, y: np.ndarray):
        self.classes = np.unique(y)
        self.class_indx = {c: indx for indx, c in enumerate(self.classes)}
        self.binary_classifiers: dict[Any, ClassifierModel] = {}
        for c1, c2 in itertools.combinations(self.classes, 2):
            bc = copy.deepcopy(self.bc)
            mask = (y == c1) | (y == c2)
            bc.fit(X[mask], np.where(y[mask] == c1, 0, 1))
            self.binary_classifiers[(c1, c2)] = bc

    def predict_proba(self, x):
        self.proba = np.zeros_like(self.classes, dtype=float)

        for (c1, c2), bc in self.binary_classifiers.items():
            preds = bc.predict_proba(x)
            self.proba[self.class_indx[c1]] += preds[0]
            self.proba[self.class_indx[c2]] += preds[1]

        self.proba /= np.sum(self.proba)
        return self.proba


def ExamClassifier(cmodel, *, data, target, ax):
    from matplotlib import pyplot as plt
    from ROC import ROC
    from sklearn.model_selection import train_test_split
    from dataset import Test
    from sklearn.metrics import f1_score

    data_learn, data_test, target_learn, target = train_test_split(data, target)
    cmodel.fit(data_learn, target_learn)
    a = Test(
        cmodel, testing_data=data_test, testing_target=target, loss_function=f1_score
    )
    print(f"{a:.1%}")
    x, y = ROC(cmodel, test_data=data_test, test_target=target, ax=ax)
    ax.plot(x, y, label=str(cmodel))


if __name__ == "__main__":
    from log_regression import LogReg
    from sklearn.datasets import make_classification
    from sklearn.linear_model import LogisticRegression
    from linear_model import LinearL2
    import matplotlib.pyplot as plt

    data, target = make_classification(
        n_samples=1000,
        n_features=5,
    )

    fig, ax = plt.subplots()

    ExamClassifier(
        BinaryClassifier(LinearL2()),  #
        data=data,
        target=target,
        ax=ax,
    )
    ExamClassifier(
        OneVsOne_Classifier(BinaryClassifier(LinearL2())),  #
        data=data,
        target=target,
        ax=ax,
    )
    ExamClassifier(
        OneVsRest_Classifier(BinaryClassifier(LinearL2())),  #
        data=data,
        target=target,
        ax=ax,
    )

    ax.legend()
    plt.show()
