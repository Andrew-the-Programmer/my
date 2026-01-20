from matplotlib.axes import Axes
import numpy as np
from model import ClassifierModel

from metrics import TPR, FPR


def ROC(
    binary_classifier: ClassifierModel,
    *,
    test_data,
    test_target,
    ax: Axes | None = None,
):
    for x in test_data:
        print(x)
        break
    prediction = np.array([binary_classifier.predict_proba(x)[0] for x in test_data])
    x = []
    y = []
    for line in np.linspace(0, 1, 100):
        fixed_predictoin = np.where(prediction >= line, 1, 0)
        fpr = FPR(test_target, fixed_predictoin)
        tpr = TPR(test_target, fixed_predictoin)
        x.append(fpr)
        y.append(tpr)

    if ax is not None:
        line = np.linspace(0, 1, 10)
        ax.plot(line, line, "b--")
        ax.set_xlabel("FPR")
        ax.set_ylabel("TPR")

    return x, y
