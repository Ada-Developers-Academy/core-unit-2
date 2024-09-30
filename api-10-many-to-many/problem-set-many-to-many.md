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
   1. Setup the `Genre` model with the attributes `id` and `name`. Implement `to_dict` and `from_dict` methods, as we did for the `Book` and `Author` models.
   2. Create a migration to add a table for the `Genre` model and then apply it. Confirm that the `genre` table has been created as expected.
   3. Create a join table to connect the `Book` and `Genre` models by creating a `BookGenre` model with 2 foreign key attributes `book_id` and `genre_id`.
   4. Use SQLAlchemy relationship declarations to establish _optional_ attributes on the `Book` and `Genre` models to easily access the associated values from either side of the many-to-many relationship.
   5. Create a migration to add the `book_genre` join table and then apply it. Confirm that the `book_genre` table has been created as expected.
   6. Update the `Book` model's `from_dict` function to use value of the `genres` key from the `book_data` parameter if it exists, otherwise initialize the `genres` attribute as an empty list.
   7. Update the `Book` model's `to_dict` function to include the names of any associated genres, only if such values exist.

2. Create or refactor the following RESTful endpoints, with the same functionality presented in this topic:
   1. As a client, I want to send a request with new valid genre data and get a success response containing the new genre's `id` and `name`, so that I know the API saved the genre data.
   2. As a client, I want to send a request to get all existing genres, so that I can see a list of genres, with their `id` and `name`.
   3. As a client, I want to send a request with new valid book data and have it associated with a specific genre identified in the endpoint, then get a success response containing the new book's `id`, `title`, `description`, and the genre's name, so that I know the API saved the book data.
   4. As a client, I want to send a request to get all books with an existing genre identified in the endpoint, so that I can see a list of books with their `id`, `title`, `description`, and if applicable, the author's name and all genres associated with the book.
