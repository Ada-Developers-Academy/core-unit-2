## Insertion Sort

The insertion sort algorithm works by inserting each item into its proper place to form the sorted list. The simplest implementation of this requires two list structures - the source list and the list into which sorted items are inserted. One entry is removed at a time and then each is inserted into a sorted part (initially empty). To save memory, most implementations use an in-place sort that works by moving the current item past the already sorted items and repeatedly swapping it with the preceding item until it is in place.

Here's an example:

![Insertion Sort Example](images/insertion-sort.png)

**Example implementation:**

```ruby
def insertion_sort(array, length)
  i = 1
  while i < length
    to_insert = array[i]
    j = i
    # search in the sorted portion of the array
    # for the correct position to insert array[i]
    while j > 0 && array[j-1] > to_insert
      array[j] = array[j-1]
      j -= 1
    end
    array[j] = to_insert
    i += 1
  end
end
```

**Example:** Consider the initial unsorted array [99, 45, 35, 40, 16, 50, 11, 7, 90]. Here's what it looks like before and after each iteration of the outer loop. The sorted sub-array is **bolded**

| Iteration | Array                                   |
| --------- | --------------------------------------- |
| 1.        | [**99**, 45, 35, 40, 16, 50, 11, 7, 90] |
| 2.        | [**45, 99**, 35, 40, 16, 50, 11, 7, 90] |
| 3.        | [**35, 45, 99**, 40, 16, 50, 11, 7, 90] |
| 4.        | [**35, 40, 45, 99**, 16, 50, 11, 7, 90] |
| 5.        | [**16, 35, 40, 45, 99**, 50, 11, 7, 90] |
| 6.        | [**16, 35, 40, 45, 50, 99**, 11, 7, 90] |
| 7.        | [**11, 16, 35, 40, 45, 50, 99**, 7, 90] |
| 8.        | [**7, 11, 16, 35, 40, 45, 50, 99**, 90] |
| 9.        | [**7, 11, 16, 35, 40, 45, 50, 90, 99**] |

**Analysis:** In sorting the most expensive part is a comparison of two elements. Insertion sort algorithm requires

- 0 comparisons to insert the first element
- 1 comparison to insert the second element
- 2 comparisons to insert the third element
- ... and so on
- _n-1_ comparisons (worst case) to insert the last element

Overall, this is _1 + 2 + 3 + ... + (n-1)_ = _O(n<sup>2</sup>)_

The insertion sort has a complexity of O(n<sup>2</sup>). Unlike selection sort, insertion sort has a best case time complexity of O(n) when the items are already sorted. In other words, insertion sort runs in nearly linear time on a nearly sorted list of elements.
