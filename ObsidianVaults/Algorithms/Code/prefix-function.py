def prefix_function(s: str):
    pi = [0] * len(s)

    for i in range(1, len(s)):
        j = pi[i - 1]
        while j > 0 and s[i] != s[j]:
            j = pi[j - 1]
        pi[i] = j + 1 if s[i] == s[j] else j

    return pi
