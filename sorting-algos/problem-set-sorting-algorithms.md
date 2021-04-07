# Problem Set: Sorting Algorithms

## Directions

Complete all questions below.

## Practice

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: QIPeo7
* title: Sorting Algorithms
##### !question

Consider this example implementation of a sorting algorithm.

```python
def mystery_sort(array):
    i = 0
    while i < len(array) - 1:
        min_index = i
        j = i + 1
        while j < len(array):
            if array[j] < array[min_index]:
                min_index = j
            j += 1
        if min_index != i:
            temp = array[min_index]
            array[min_index] = array[i]
            array[i] = temp
        i += 1
    return array
```

Read through the code. Which of these kinds of sorts does this function implement?

##### !end-question
##### !options

* Bubble Sort
* Selection Sort
* Insertion Sort
* Merge Sort

##### !end-options
##### !answer

* Selection Sort

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: ZcDOYz
* title: Sorting Algorithms
##### !question

Consider this example implementation of a sorting algorithm.

```python
def mystery_sort(array):
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

Read through the code. Which of these kinds of sorts does this function implement?

##### !end-question
##### !options

* Bubble Sort
* Selection Sort
* Insertion Sort
* Merge Sort

##### !end-options
##### !answer

* Bubble Sort

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 3 -->
<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: n5d5zh
* title: Sorting Algorithms
##### !question

Consider this example implementation of a sorting algorithm.

```python
def mystery_sort(array):
    i = 1
    while i < len(array):
        to_insert = array[i]
        j = i
        while j > 0 and array[j - 1] > to_insert:
            array[j] = array[j - 1]
            j -= 1
        array[j] = to_insert
        i += 1
    return array
```

Read through the code. Which of these kinds of sorts does this function implement?

##### !end-question
##### !options

* Bubble Sort
* Selection Sort
* Insertion Sort
* Merge Sort

##### !end-options
##### !answer

* Insertion Sort

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 4 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: rNnJPu
* title: Sorting Algorithms
##### !question

Describe the algorithm for Bubble Sort in your own words. Make sure to touch on:

- What makes this algorithm unique?
- What is its time and space complexity?
- What factors contribute to its time complexity?
- What factors contribute to its space complexity?

Answer in 3-6 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

The bubble sort algorithm is unique because...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 5 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: ZjpcQX
* title: Sorting Algorithms
##### !question

Describe the algorithm for Selection Sort in your own words. Make sure to touch on:

- What makes this algorithm unique?
- What is its time and space complexity?
- What factors contribute to its time complexity?
- What factors contribute to its space complexity?

Answer in 3-6 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

The selection sort algorithm is unique because...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 6 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: fN9PLJ
* title: Sorting Algorithms
##### !question

Describe the algorithm for Insertion Sort in your own words. Make sure to touch on:

- What makes this algorithm unique?
- What is its time and space complexity?
- What factors contribute to its time complexity?
- What factors contribute to its space complexity?

Answer in 3-6 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

The insertion sort algorithm is unique because...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 7 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: oIbAq4
* title: Sorting Algorithms
##### !question

Describe the algorithm for Merge Sort in your own words. Make sure to touch on:

- What makes this algorithm unique?
- What is its time and space complexity?
- What factors contribute to its time complexity?
- What factors contribute to its space complexity?

Answer in 3-6 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

The merge sort algorithm is unique because...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->

## Wave 1 - Sort by Length

In this method you will take a string as a parameter. The method will return an array of words in the string, sorted by length. Solve the problem without using the ruby `.sort` method. When words are tied for length, maintain the order they appeared in the original string.

## Wave 2 - Reverse Sentence

In this assignment, you'll design and implement one of the well-known string manipulation methods.
Remember that a string is an array of characters. Algorithms that worked on restricted arrays will work on strings as well.

## Optional Exercise

- Design and implement a method to reverse the words in a sentence _in place_. The string of words to be reversed in passed in as the input parameter to the method.
  - Your algorithm should strive to optimize the space complexity as much as possible.
- For example, if the method is called with input parameter of "Yoda&nbsp;&nbsp;&nbsp;is&nbsp;&nbsp;&nbsp;&nbsp;awesome", then the method should update the input string object to have the value "awesome&nbsp;&nbsp;&nbsp;&nbsp;is&nbsp;&nbsp;&nbsp;Yoda".
  - Note that the count of white spaces between words is preserved.
- Share and explain the time and space complexities for your solution in the comments above the method.
  - If the complexity is shared in terms of _n_, your explanation must explain what _n_ stands for.

**Notes:**
_ Do not use Ruby provided functionality for `.reverse` and `.reverse!`.
_ You may use `.length` method available in the String class.

https://github.com/Ada-C14/string-manipulation-practice/tree/master/test
