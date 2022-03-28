# Problem Set: Building an API

## Directions

Complete all directions below.

There is no submission for this assignment.

On your machine, keep:

- Your completed repo
- A list of any questions you weren't able to research independently

## Practice

1. If you haven't already, fork and clone the [Hello Books API](https://github.com/AdaGold/hello-books-api) repo.
1. Recreate the following steps of the Hello Books repo:
   1. Create a virtual environment
   1. Install the dependencies
   1. Create the database `hello_books_development`
   1. Setup the `Book` model with the attributes `id`, `title`, and `description`
   1. Create a migration to add a table for the `Book` model and then apply it. Confirm that the `book` table has been created as expected.

1. Create or refactor the following RESTful endpoints, with the same functionality presented in this topic:
   1. As a client, I want to send a request with new valid book data and get a success response, so that I know the API saved the book data
   1. As a client, I want to send a request to get all existing books, so that I can see a list of books, with their `id`, `title`, and `description` of the book.
