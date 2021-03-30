# Bubble Sort

## Learning Goals

- Describe bubble sort and its efficiency

## Overview

The bubble sort algorithm might look like how a lot of people sort things.

Bubble sort...

- Repeatedly steps through the list to be sorted
- Compares each pair of adjacent items in the list
  - Swaps the adjacent items if they are in the wrong order

As the algorithm proceeds, the largest element gets _bubbled_ to the top of the array after each iteration through the outer loop.

The algorithm repeats this process until it makes a pass all the way through the list.

### Detailed Explanation

Here is a more detailed explanation of the bubble sort algorithm:

- Start a variable `i` at `0`
- Create an outer loop that loops while `i` is smaller than the length of the array - 1
  - Start a variable `j` at `0`
  - Create an inner loop that loops while `j` is smaller than `len(array) - i - 1`
    - Compare the items at index `j` and `j+1`. If they're out of order:
      - Swap the items at `array[j]` and `array[j+1]` using a temporary variable, `temp`
    - Increment `j`
  - Increment `i`

## Example

Consider the initial unsorted array `[99, 45, 35, 40, 16, 50, 11, 7, 90]`.

This table demonstrates how the bubble sort algorithm works.

| Iteration | <div style="min-width:400px;">Array</div> | What is happening?                                                                                                         |
| --------- | ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| 1.        | [**99, 45**, 35, 40, 16, 50, 11, 7, 90]   | The pair of adjacent items is **99** and **45**. The algorithm compares them. 99 is larger, and should be placed after 45. |
| 2.        | [45, **99, 35**, 40, 16, 50, 11, 7, 90]   | The adjacent items are **99** and **35**. The algorithm compares them. 99 is larger, and should be placed after 35.        |
| 3.        | [45, 35, **99, 40**, 16, 50, 11, 7, 90]   | The algorithm compares **99** and **40**, and swaps their positions.                                                       |
| 4.        | [45, 35, 40, **99, 16**, 50, 11, 7, 90]   | The algorithm compares **99** and **16**, and swaps their positions.                                                       |
| 5.        | [45, 35, 40, 16, **99, 50**, 11, 7, 90]   | The algorithm compares **99** and **50**, and swaps their positions.                                                       |
| 6.        | [45, 35, 40, 16, 50, **99, 11**, 7, 90]   | The algorithm compares and swaps **99** and **11**.                                                                        |
| 7.        | [45, 35, 40, 16, 50, 11, **99, 7**, 90]   | The algorithm compares and swaps **99** and **7**.                                                                         |
| 8.        | [45, 35, 40, 16, 50, 11, 7, **99, 90**]   | The algorithm compares and swaps **99** and **90**.                                                                        |

As you can see, the largest element, 99 gets bubbled to the top.

The bubble sort algorithm continues:

| Iteration | <div style="min-width:350px;">Array</div>   | What is happening?                                                                                         |
| --------- | ------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| 9.        | [**45**, **35**, 40, 16, 50, 11, 7, 90, 99] | 45 and 35 are compared, and must swap.                                                                     |
| 10.       | [35, **45**, **40**, 16, 50, 11, 7, 90, 99] |
| 11.       | [35, 40, **45**, **16**, 50, 11, 7, 90, 99] |
| 12.       | [35, 40, 16, **45**, **50**, 11, 7, 90, 99] | 45 and 50 are compared, and don't swap.                                                                    |
| 13.       | [35, 40, 16, 45, **50**, **11**, 7, 90, 99] |
| 14.       | [35, 40, 16, 45, 11, **50**, **7**, 90, 99] |
| 15.       | [35, 40, 16, 45, 11, 7, **50**, **90**, 99] | 50 and 90 are compared, and don't swap.                                                                    |
| -         | -                                           | We do not compare 90 and 99,. In the bubble sort algorithm, the range of items to check shrinks each loop. |

We can describe even one more whole loop:

| Iteration | Array                                       |
| --------- | ------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| 16.       | [**35**, **40**, 16, 45, 11, 7, 50, 90, 99] |
| 17.       | [35, **40**, **16**, 45, 11, 7, 50, 90, 99] |
| 18.       | [35, 16, **40**, **45**, 11, 7, 50, 90, 99] |
| 19.       | [35, 16, 40, **45**, **11**, 7, 50, 90, 99] |
| 20.       | [35, 16, 40, 11, **45**, **7**, 50, 90, 99] |
| 22.       | [35, 16, 40, 11, 7, **45**, **50**, 90, 99] |
| -         | -                                           | We do not compare 50 and 90. In the bubble sort algorithm, the range of items to check shrinks each loop. |

The algorithm continues!

## Big(O) Complexity

The time complexity of Bubble sort is _O(n<sup>2</sup>)_. We can conclude this by considering:

- The inner most swap conditional statement is _O(1)_
- The inner loop runs _i_ times i.e. _O(i)_ time complexity
- The outer loop runs from _i_ = _0_ to _n_

Overall, the inner loop runs _n-1_ times during the first iteration of the outer loop, _n-2_ times during the second iteration through the outer loop, and so on. i.e. _n-1 + n-2 + n-3 + ... + 3 + 2 + 1_ = _n(n-1)/2_ = _O(n<sup>2</sup>)_

### !callout-info

## Mathematical Proofs Out of Scope

The mathematical proof is out of scope for our discussion. However, there are great resources online that explain the math in-depth!

### !end-callout

## Example Implementation

Consider this example implementation of bubble sort.

```python
def bubble_sort(array):
    i = 0
    # Begin the outer loop
    while i < len(array) - 1:
        j = 0
        # Begin the inner loop
        while j < (len(array) - i - 1):
            # Compare two adjacent items
            if array[j] > array[j+1]:
                # Swap
                temp = array[j]
                array[j] = array[j+1]
                array[j + 1] = temp
            j += 1
        i += 1
    return array
```

We should compare this code with our detailed explanation:

- Start a variable `i` at `0`
- Create an outer loop that loops while `i` is smaller than the length of the array - 1
  - Start a variable `j` at `0`
  - Create an inner loop that loops while `j` is smaller than `len(array) - i - 1`
    - Compare the items at index `j` and `j+1`. If they're out of order:
      - Swap the items at `array[j]` and `array[j+1]` using a temporary variable, `temp`
    - Increment `j`
  - Increment `i`

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: Ym2Y2e
* title: Bubble Sort
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
