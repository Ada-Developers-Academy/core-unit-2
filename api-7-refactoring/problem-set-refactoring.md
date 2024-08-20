# Problem Set: Refactoring

## Directions

Complete all directions below.

There is no submission for this assignment.

On your machine, keep:

- Your completed repo
- A list of any questions you weren't able to research independently

## Practice

Continue your independent Hello Books API.

Fulfill the following requirements, with the same functionality presented in this topic:

As a developer working on the `hello-books` project, I want to...

1. Find dependencies for creating a `Book` model. 
2. Write nominal and edge case tests for any dependencies identified. 
3. Refactor code that creates a `Book` out of `book_routes.py` and place it in a class function on the `Book` class
4. Confirm all tests are passing again

After this refactor is done, I want to follow the same refactoring steps above to:

1. Refactor code that creates a dictionary representing a `Book` out of the `book_routes.py` file and place it in an instance function of the `Book` class
3. Refactor the naming of the `books_bp` Blueprint object in `book_routes.py` to `bp`.
2. Refactor the function `validate_book` into a more general function `validate_model` and move it to a new file for utilities `route_utilities.py`. This new function will take in a second parameter `cls`, which represents a model class, and will be used to build a query to fetch a record of that type of model.

*The behavior of our routes should stay the same through these refactors. We should not see any changes to the capabilities our routes had in the previous part of the Building an API series*
