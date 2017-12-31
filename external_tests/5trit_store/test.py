def trit_to_int(t_arr):
    ret = 0

    for i, t in enumerate(t_arr):
        if t == -1:
            ret += -1
        if t == 1:
            ret += 1
        if t == 0:
            ret += 0
        ret *= 3
    return ret // 3

def int_to_trit(i, t_arr):
    #print("i: ", i)
    if i < 0:  # Special case for handling negatives: just flip all the trits in the positive version
        # return [-x for x in int_to_trit(-i, t_arr)]  # the Python way of doing the following:
        # Store the result of running this against a positive number
        negative_result = int_to_trit(-i, t_arr)
        # For each index in the negative_result array,
        for i in range(len(negative_result)):
            negative_result[i] *= -1  # negate the stored value
        return negative_result  # Return the results
    if i == 0:  # Termination case
        # Usually, avoid leading 0's, but I had to add an extra condition for calls of int_to_trit(0, [])
        return t_arr if len(t_arr) > 0 else [0]
    # Python % always returns a positive number; C does not so some logic below will need changed
    r = abs(i % 3)
    print "{} % 3 == {}".format(i, r)  # for debug
    if r == 2:
        # insert(0, x) simply means to append to the beginning of a list in Python. If using an actual array, this could be accomplished by allocating a new array of size n + 1, setting the first value to -1, and copying the array of size n after the -1 value. Alternatively, the C implementation may allocate an array with 5 indices for this method and pass the current index as a parameter.
        t_arr.insert(0, -1)
        # I don't know the best way to describe why we have to do this. Think of the case of 2 though. 2 in ternary is represented as [1, -1]; it's 3 - 1. Since 2 is "1 short" of 3, we need to add one to our accumulator.
        i += 1
    elif r == 1:
        # Theoretically, we could subtract one from i as we did above, but it won't do anything due to floor division.
        t_arr.insert(0, 1)
    else:
        t_arr.insert(0, 0)
    # The // operator in Python emphasizes integer division (floors the result)
    return int_to_trit(i // 3, t_arr)

if __name__ == "__main__":
    for i in range(-121, 122):
        i2 = int_to_trit(i, [])
        i3 = trit_to_int(i2)
        print("i: %d list: %s back to int: %d len: %d" % (i, i2, i3, len(i2)))
