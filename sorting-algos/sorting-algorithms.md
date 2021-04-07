# Sorting Algorithms

## Goals

The goal for this lesson is to introduce sorting algorithms.

Sorting algorithms:

- improve our algorithmic problem-solving skills
- improve our code reading skills
- practice our ability to think abstractly
- practice our ability to explain algorithms

## Vocabulary and Synonyms

| Vocab            | Definition                                                                               | Synonyms         | How to Use in a Sentence |
| ---------------- | ---------------------------------------------------------------------------------------- | ---------------- | ------------------------ |
| Sorting          | Organizing a collection of elements into order                                           | -                |
| Internal Sorting | Sorting an entire array in memory                                                        | in-place sorting |
| External Sorting | Sorting an array with part of the array on external storage, rather than internal memory | -                |

## Introduction

Imagine a stack of index cards, where each index card has the numbers 1 through 100. Imagine that these cards are shuffled in a random, unknowable order.

If you're given the task to sort these index cards in ascending order, what would you do?

Picture yourself. Do you scan through the pile over and over again, slowly changing the order until it's all sorted? Do you use a table and make two separate piles? Do you compare the card you're looking at always to the next card in the pile?

If you take two people and ask them to sort the same pile of cards, they will likely have different methods.

Machines need to think through these questions too, but with less index cards and more variables. The strategy to sort an array of values is a _sorting algorithm_.

## Sorting Algorithms

Often, sorting will be part of an application feature we build, such as:

- Sorting last names alphabetically
- Listing sports game scores in descending order
- Sorting employees by ID in an ascending order

Also, various algorithms improve when working with a sorted array! Recall these examples:

- Finding an element with a minimum or maximum value
    - Unsorted array: O(n)
    - Sorted array: O(1)
- Searching for an element in an array
    - Unsorted array with linear search: O(n)
    - Sorted array with binary search: O(log n)

For each sorting algorithm, we should:

1. Define and describe the sorting strategy
1. Visualize at least one example of this algorithm
1. Learn the Big(O) complexity of this algorithm
1. Practice reading the code of an example implementation

Sorting is ordering a list of elements. We can distinguish two types of sorting. If the number of elements is small enough to fit in the main memory, sorting is called _internal sorting_. There are times when the number of elements is larger than can fit in the main memory, some of them will stay in the external storage while the sorting algorithm works and is called _external sorting_. We'll scope our conversation to a few internal sorting algorithms.

## O(n<sup>2</sup>) Algorithms

The sorting algorithms above have a time complexity of O(n<sup>2</sup>). These algorithms are fine when the array length, _n_, is small, but quickly cease to be useful as the size of the array increases. They **do** have the advantage of being relatively easy to implement and bubble sort and insertion sort can perform well in the best case, but they do not scale well. This brings in an overview of our first fairly performant sorting algorithm **Merge Sort**.

## Summary

- There are several sorting algorithms available. Whilst we reviewed four of them, you can learn more about the others on [geeksforgeeks.org/sorting-algorithms/](http://www.geeksforgeeks.org/sorting-algorithms/)
- Not all sorting algorithms are created equal. If the array size is relatively small, insertion sort works faster in practice than merge sort. For larger values of _n_, merge sort does much better than the other sorting algorithms we looked at. Watch this [sorting algorithms' comparison demo](https://www.youtube.com/watch?v=ZZuD6iUe3Pc) and this [visualization](https://www.cs.usfca.edu/~galles/visualization/ComparisonSort.html)

## Resources

- [Selection sort on Khan Academy](https://www.khanacademy.org/computing/computer-science/algorithms/sorting-algorithms/a/sorting)
- [Insertion sort on Khan Academy](https://www.khanacademy.org/computing/computer-science/algorithms/insertion-sort/a/insertion-sort)
- [Merge sort on Khan Academy](https://www.khanacademy.org/computing/computer-science/algorithms/merge-sort/a/divide-and-conquer-algorithms)
- [Merge Sort Visual Analysis](https://www.youtube.com/watch?v=w4LRRn7GgqU)
- [Eugene Wang's blog post on "Not all sort algorithms are created equal"](http://eewang.github.io/blog/2013/04/22/sort-algorithms/)
- [Ruby - The Spaceship Operator 101](https://medium.com/@albert.s.chun/ruby-the-spaceship-operator-101-717b42566971)
- [MIT Open Courseware on MergeSort](https://www.youtube.com/watch?v=g1AwUYauqgg)
- [Why is Merge Sort O(n log(n)? The **really** long answer)](https://www.youtube.com/watch?v=alJswNJ4P3U)
