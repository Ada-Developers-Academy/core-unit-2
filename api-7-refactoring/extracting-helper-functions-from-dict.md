# Extracting Helper Functions Pt. 2

## Goals
Our goal for this lesson is to refactor code for creating a `Book` model from the `create_book` route to a helper function named `from_dict` in the model's class.

To do this we will follow the same steps of planning, then executing our refactor, as outlined on the previous lesson. 

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`07a-to-dict-refactor` |`07b-from-dict-refactor`|

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

The `Book` class should have the following functions:
- `to_dict`

Our test folder should have 2 files: 
- `test_routes.py`
- `test_models.py`

</details>
</br>