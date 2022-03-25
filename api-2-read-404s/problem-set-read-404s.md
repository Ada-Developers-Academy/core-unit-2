# Problem Set: Read One Book, 400 and 404s

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
   1. Create a class `Book` with the attributes `id`, `title`, and `descrition`.
   1. Create a list of `Book` instances.

1. Create the following endpoint, with the same functionality presented in this topic:
   1. As a client, I want to send a request to get one existing book, so that I can see the `id`, `title`, and `description` of the book.
        * The API should return a `404` for a non-existing `book`.
        * The API should return a `400` for an invalid `book_id`.
