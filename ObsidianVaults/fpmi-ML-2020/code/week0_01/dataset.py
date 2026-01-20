from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import numpy as np

iris_dataset = datasets.load_iris()


def Divergence(target, prediction):
    return np.sum(target != prediction) / len(target)


def Test(fit_model, *, testing_data, testing_target, loss_function):
    prediction = [fit_model.predict(x) for x in testing_data]
    return loss_function(testing_target, prediction)


def Fit(model, learning_dataset):
    model.fit(learning_dataset.data, learning_dataset.target)


def Validate(
    model_cls, *, learning_dataset, validation_dataset, hyperparameters, loss_function
):
    losses = []

    for hp in hyperparameters:
        model = model_cls(*hp)
        model.fit(learning_dataset.data, learning_dataset.target)
        loss = Test(
            model, testing_dataset=validation_dataset, loss_function=loss_function
        )
        losses.append(loss)

    return losses


def ValidationCurve(
    model_cls,
    *,
    ax,
    learning_dataset,
    validation_dataset,
    hyperparameters,
    loss_function,
):
    losses = Validate(model_cls, learning_dataset=learning_dataset)

    for hp in hyperparameters:
        model = model_cls(*hp)
        model.fit(learning_dataset.data, learning_dataset.target)
        loss = Test(
            model, testing_dataset=validation_dataset, loss_function=loss_function
        )
        losses.append(loss)

    return losses


def TestRandom(dataset, model, *, loss_function, test_size=0.5):
    data_learn, data_test, target_learn, target = train_test_split(
        dataset.data, dataset.target, test_size=test_size
    )
    model.fit(data_learn, target_learn)
    prediction = [model.predict(x) for x in data_test]

    return (
        loss_function(target, prediction),  #
        data_learn,
        data_test,
        target_learn,
        target,
    )


def TestRes(*args, **kwargs):
    res = TestRandom(*args, **kwargs)
    print(f"{res[0]:.1%}")
