import numpy as np

def GradientDescent(
    df, #
    *,
    step,
    start,
    count_iterations: int = 1000,
    step_limit: float | None = None,
    metric = None
):
    cur = start

    for _ in range(count_iterations):
        new_step = -step * df(cur)
        cur += new_step
        if metric is not None and metric(0, new_step) < step_limit:
            break

    return cur
