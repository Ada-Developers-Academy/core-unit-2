# Problem Set: Many-to-Many Relationships

## Directions

Complete all directions below.

There is no submission for this assignment.

On your machine, keep:

- Your completed repo
- A list of any questions you weren't able to research independently

## Practice

Continue your independent Hello Books API.

Fulfill the following requirements, with the same functionality presented in this topic:

1. Recreate the following steps of the Hello Books repo:
   1. Setup the `Author` model with the attributes `id` and `name`. Implement `to_dict` and `from_dict` methods, as we did for the `Book` model.
   2. Create a migration to add a table for the `Author` model and then apply it. Confirm that the `author` table has been created as expected.
   3. Use a foreign key to establish an _optional_ one-to-many relationship between the `Author` and `Book` models.
   4. Update the `Book` model's `to_dict` function to include the name of the associated author, only if such a value exists.
   5. Create a migration to update the `book` table and then apply it. Confirm that the `book` table has been updated as expected.

2. Create or refactor the following RESTful endpoints, with the same functionality presented in this topic:
   1. As a client, I want to send a request with new valid author data and get a success response containing the new author's `id` and `name`, so that I know the API saved the author data.
   2. As a client, I want to send a request to get all existing authors, so that I can see a list of authors, with their `id` and `name`.
   3. As a client, I want to send a request with new valid book data and have it associated with a specific author identified in the endpoint, then get a success response containing the new book's `id`, `title`, `description`, and the author's name, so that I know the API saved the book data.
   4. As a client, I want to send a request to get all books by an existing author identified in the endpoint, so that I can see a list of books, with their `id`, `title`, `description`, and the author's name.

3. After the routes above are complete, I want to follow our refactoring processes to:
   1. Examine my route files and look for routes that repeat code or perform very similar actions.
   2. Ensure tests are written for any dependencies or new functions that need to be created.
   3. Refactor code that creates a model and returns a dictionary representation of the new model out of the `book_routes.py` and `author_routes.py` files and place that logic in a helper function named `create_model` in `route_utilities.py`.
   4. Update all routes that create models to use the new function `create_model`.
   5. Refactor code that filters and retrieves models out of the `book_routes.py` and `author_routes.py` files and place that logic in a helper function named `get_models_with_filters` in `route_utilities.py`.
   6. Update all routes that fetch models to use the new function `get_models_with_filters`.

*The behavior of our routes should stay the same through these refactors. We should not see any changes to the capabilities our routes had after completing the refactors*
