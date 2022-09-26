# Extracting Helper Functions

## Goals
Our goals for this lesson are to:
- Refactor code that converts a `Book` to a `Dictionary` into a reusable function
- Refactor code for creating a model from the routes file to the model's class

To do this we will:
- Plan our refactor by 
  - identifying what code we will refactor  
  - ensuring we have strong test coverage
- Execute our refactor by 
  - writing new, reusable, helper functions, 
  - replacing the existing code with our new functions
  - frequently running our tests as we work to ensure our code's behavior remained the same

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`06e-post-books-test` |`07a-to-dict-refactor`|

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined
- Endpoints defined for these RESTful routes:
- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`

Our test suite should have 3 tests: 
- `test_get_all_books_with_no_records`
- `test_get_one_book`
- `test_create_one_book`

</details>
</br>

## Refactoring