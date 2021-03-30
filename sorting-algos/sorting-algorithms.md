# Sorting Algorithms

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=a4668a63-9fb8-4778-b0a4-aaca006b34c8&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Learning Goals

- Describe bubble sort and its efficiency
- Describe selection sort and its efficiency
- Describe insertion sort and its efficiency
- Describe merge sort and its efficiency

## Vocabulary and Synonyms

| Vocab            | Definition                                                                               | Synonyms         | How to Use in a Sentence |
| ---------------- | ---------------------------------------------------------------------------------------- | ---------------- | ------------------------ |
| Sorting          | Organizing a collection of elements into order                                           | -                |
| Internal Sorting | Sorting an entire array in memory                                                        | in-place sorting |
| External Sorting | Sorting an array with part of the array on external storage, rather than internal memory | -                |

## Video Lesson & Slides

- [Video Lesson](https://adaacademy.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=a4668a63-9fb8-4778-b0a4-aaca006b34c8)
- [Slide Deck](https://docs.google.com/presentation/d/1GkYP84Cbg3I5KS_wIfRN8Gn-5tQ_46vV5zWt1dTZn14/edit?usp=sharing)
- [Sorting Exercise](https://github.com/Ada-c14/string-manipulation-practice)

## Introduction

In our last lesson on [Arrays](https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/04-cs-fundamentals/classroom/Arrays.md), we saw how having the data set sorted improved the algorithms we could use. e.g. **Finding an element with minimum or maximum value** went from a _O(n)_ algorithm for unsorted array to an _O(1)_ algorithm for a sorted array. Similarly, **binary search** which is possible on sorted data set is an _O(log n)_ algorithm as compared to _O(n)_ **linear search** algorithm. There are also other everday examples where we expect the data set to be sorted e.g. last names sorted from 'a' through 'z', words in a dictionary, test scores sorted in descending order, employee ids sorted in ascending order etc.

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
