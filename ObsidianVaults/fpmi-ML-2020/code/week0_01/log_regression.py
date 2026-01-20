from sklearn.base import BaseEstimator, RegressorMixin
from linear_model import Linear

from gradient_descent import GradientDescent

import torch
import torch.functional as F
import torch.nn as nn

import numpy as np


class LogReg:
    def __init__(self, *, model, opt, batch_size=256, max_iter=1000):
        self.model = model
        self.opt = opt
        self.batch_size = batch_size
        self.max_iter = max_iter

    def fit(self, X: torch.Tensor, y: torch.Tensor):
        for _ in range(self.max_iter):
            if self.batch_size is not None:
                indx_batch = np.random.randint(0, X.shape[0], self.batch_size)
                X_batch = X[indx_batch]
                y_batch = y[indx_batch]
            else:
                X_batch = X
                y_batch = y

            w_predicted: torch.Tensor = model(X_batch)[:, 0]
            loss_fn = nn.BCELoss()
            loss = loss_fn(w_predicted, y_batch)
            loss.backward()
            self.opt.step()
            self.opt.zero_grad()

    def predict(self, x):
        with torch.no_grad():
            predictions = self.model(x)[:, 0]
        return predictions

    def predict_classes(self, x, threshold=0.5):
        """Return binary class predictions"""
        predictions = self.predict(x)
        return (predictions > threshold).float()


if __name__ == "__main__":
    from sklearn.datasets import load_iris
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import euclidean_distances, classification_report, accuracy_score

    X, y = load_iris(return_X_y=True)

    y = y / np.max(y)

    X_learn, X_test, y_learn, y_test = train_test_split(X, y)

    X_learn = torch.tensor(X_learn, dtype=torch.float32)
    X_test = torch.tensor(X_test, dtype=torch.float32)
    y_learn = torch.tensor(y_learn, dtype=torch.float32)
    y_test = torch.tensor(y_test, dtype=torch.float32)


    model = nn.Sequential()
    print(X_learn.shape)
    model.add_module("first", nn.Linear(X_learn.shape[1], 1))
    model.add_module("second", nn.Sigmoid())

    opt = torch.optim.Adam(model.parameters(), lr=1e-3)

    lr = LogReg(model=model, opt=opt)

    lr.fit(X_learn, y_learn)

    y_predict = lr.predict(X_test)

