import numpy as np


def EuclideanN(x, y, *, n):
    return np.sum((x - y) ** n)


def Euclidean(x, y, *, n):
    return EuclideanN(x, y, n=n) ** (1 / n)


def E22(x, y):
    return EuclideanN(x, y, n=2)


def E2(x, y):
    return Euclidean(x, y, n=2)


def Accuracy(yt, yp):
    return np.mean(yt == yp)


def BalancedAccuracy(yt, yp):
    return np.mean(
        [
            np.sum(yt == yp == c) / np.sum(yt == c)  #
            for c in np.unique(yt)
        ]
    )


def Precision(yt, yp):
    TP = np.sum(yt == yp == 1)
    FP = np.sum((yt == 0) & (yp == 1))
    return TP / (TP + FP)


def Recall(yt, yp):
    TP = np.sum((yt == 1) & (yp == 1))
    FN = np.sum((yt == 1) & (yp == 0))
    return TP / (TP + FN)


def fbeta_score(yt, yp, *, b=1):
    b2 = b**2
    p = Precision(yt, yp)
    r = Recall(yt, yp)
    return (1 + b2) * p * r / (b2 * p + r)


def FPR(yt, yp):
    FP = np.sum((yt == 0) & (yp == 1))
    TN = np.sum((yt == 0) & (yp == 0))
    return FP / (FP + TN)


def TPR(yt, yp):
    return Recall(yt, yp)


def Sigmoid(z):
    return 1/(1 + np.exp(-z))
