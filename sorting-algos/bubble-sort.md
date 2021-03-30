## Bubble Sort

The bubble sort algorithm is a simple sorting algorithm that repeatedly steps through the list to be sorted, compares each pair of adjacent items and swaps them if they are in the wrong order. As the algorithm proceeds, the largest element gets bubbled to the top of the array after each iteration through the outer loop. The algorithm repeats this process until it makes a pass all the way through the list.

**Example implementation:**

```python
def bubble_sort(array):
    i = 0
    while i < len(array) - 1:
        j = 0
        while j < (len(array) - i - 1):
            if array[j] > array[j+1]:
                temp = array[j]
                array[j] = array[j+1]
                array[j + 1] = temp
            j += 1
        i += 1
    return array
```

```ruby
def bubble_sort(array, length)
  i = 0
  while i < length-1 # outer loop
    j = 0
    while j < length-i-1 # inner loop
      if array[j] > array[j+1] # swap
        temp = array[j]
        array[j] = array[j+1]
        array[j+1] = temp
      end
      j += 1
    end
    i += 1
  end
end
```

**Example:** Consider the initial unsorted array [99, 45, 35, 40, 16, 50, 11, 7, 90]. Here's one iteration through the outer loop of the algorithm (i.e. while _i_ is _0_ and _j_ ranges from _0_ to _8_).

| Iteration | Array                                   |
| --------- | --------------------------------------- |
| 1.        | [**99, 45**, 35, 40, 16, 50, 11, 7, 90] |
| 2.        | [45, **99, 35**, 40, 16, 50, 11, 7, 90] |
| 3.        | [45, 35, **99, 40**, 16, 50, 11, 7, 90] |
| 4.        | [45, 35, 40, **99, 16**, 50, 11, 7, 90] |
| 5.        | [45, 35, 40, 16, **99, 50**, 11, 7, 90] |
| 6.        | [45, 35, 40, 16, 50, **99, 11**, 7, 90] |
| 7.        | [45, 35, 40, 16, 50, 11, **99, 7**, 90] |
| 8.        | [45, 35, 40, 16, 50, 11, 7, **99, 90**] |
| 9.        | [45, 35, 40, 16, 50, 11, 7, 90, 99]     |

As you can see, the largest element, 99 gets bubbled to the top. In subsequent iterations through the outer loop, the next largest values will get bubbled to the top the next i.e. _n-i-1_ position with increasing values of _i_.

**Analysis:** The time complexity of Bubble sort is _O(n<sup>2</sup>)_

- The inner most swap conditional statement is _O(1)_
- The inner loop runs _i_ times i.e. _O(i)_ time complexity
- The outer loop runs from _i_ = _0_ to _n_

Overall, the inner loop runs _n-1_ times during the first iteration of the outer loop, _n-2_ times during the second iteration through the outer loop, and so on. i.e. _n-1 + n-2 + n-3 + ... + 3 + 2 + 1_ = _n(n-1)/2_ = _O(n<sup>2</sup>)_

- **Note 1**: The mathematical proof is out of scope for our discussion. For those curious, see [step 4 on wikihow](http://www.wikihow.com/Sum-the-Integers-from-1-to-N)</br>
- **Note 2**: The best case time complexity for Bubble sort can be improved to be _O(n)_ (for already sorted arrays) by optimizing this algorithm as below.

```python
def bubble_sort(array):
    i = 0
    while i < len(array) - 1:
        j = 0
        while j < (len(array) - i - 1):
            if array[j] > array[j+1]:
                temp = array[j]
                array[j] = array[j+1]
                array[j + 1] = temp
            j += 1
        i += 1
    return array
```

```ruby
def bubble_sort(array, length)
  i = 0
  # If the inner loop runs with no swaps, exit
  swapped = true
  while i < length-1 && swapped # outer loop
    j = 0
    # Assume you won't have to make a swap
    swapped = false
    while j < length-i-1 # inner loop
      if array[j] > array[j+1] # swap
        temp = array[j]
        array[j] = array[j+1]
        array[j+1] = temp
        # Since we just made a swap, set swapped to true
        swapped = true
      end
      j += 1
    end
    i += 1
  end
end
```

This version of Bubble Sort will stop if the inner loop traverses the array without making any swaps. So if the array is already sorted the inner loop will execute only 1 time before the method stops. Read further on [GeeksForGeeks: Bubble Sort](http://www.geeksforgeeks.org/bubble-sort/)

