## Selection Sort

The selection sort works by selecting the smallest unsorted item in the list and swapping it with index 0, then finding the next smallest and placing it into index 1 and so on.

The selection sort works as follows: you look through the entire array for the smallest element. Once you find it, you swap this smallest element found with the first element of the array. Then you look for the smallest element in the remaining array (the sub-array without the first element) and swap this element found with the second element. Then you look for the smallest element in the remaining array (the sub-array without the first and second elements) and swap that element with the third element, and so on.

Here's an example:

![Selection Sort Example](images/selection-sort.png)

**Example implementation:**

```ruby
def selection_sort(array, length)
  i = 0
  while i < length-1
    min_index = i
    j = i+1
    while j < length
      if array[j] < array[min_index]
        min_index = j
      end
      j += 1
    end
    if min_index != i
      temp = array[min_index]
      array[min_index] = array[i]
      array[i] = temp
    end
    i += 1
  end
end
```

**Example:** Consider the initial unsorted array [99, 45, 35, 40, 16, 50, 11, 7, 90]. Here's what it looks like before and after each iteration of the outer loop.

| Iteration | Array                                       | i                  | min_index     |
| --------- | ------------------------------------------- | ------------------ | ------------- |
| 1.        | [**99**, 45, 35, 40, 16, 50, 11, **7**, 90] | _i=0_              | _min_index=7_ |
| 2.        | [7, **45**, 35, 40, 16, 50, **11**, 99, 90] | _i=1_              | min_index=6\* |
| 3.        | [7, 11, **35**, 40, **16**, 50, 45, 99, 90] | _i=2_              | _min_index=4_ |
| 4.        | [7, 11, 16, **40**, **35**, 50, 45, 99, 90] | _i=3_              | _min_index=4_ |
| 5.        | [7, 11, 16, 35, **40**, 50, 45, 99, 90]     | _i=4_              | _min_index=4_ |
| 6.        | [7, 11, 16, 35, 40, **50**, **45**, 99, 90] | _i=5_              | _min_index=6_ |
| 7.        | [7, 11, 16, 35, 40, 45, **50**, 99, 90]     | _i=6_              | _min_index=6_ |
| 8.        | [7, 11, 16, 35, 40, 45, 50, **99**, **90**] | _i=7_              | _min_index=8_ |
| 9.        | [7, 11, 16, 35, 40, 45, 50, 90, 99]         | _sorting complete_ |               |

**Analysis:** The time complexity of Selection sort is _O(n<sup>2</sup>)_. Each of the nested loops has an upper bound defined by the count of elements, _n_ in the list to be sorted.
