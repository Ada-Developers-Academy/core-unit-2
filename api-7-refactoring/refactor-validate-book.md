# Refactoring `validate_book`

## Goals

Our goal is to refactor the function `validate_book` into a more flexible function `validate_model`, which can be used for any model class.

We will do this by:
- Passing `validate_book` a new parameter `cls`
- Using `cls` in place of `Book`
- Updating naming and return values in the function to reflect that it is no longer specific to the `Book` class

### !callout-info

## Why is the parameter `cls` used here? 

In the previous lesson, we needed to pass `cls` as the first parameter to a class method for it to be understood as a class function. `cls` is a common variable name when working with references to a class itself. In our case, we will be passing a reference to a model class into our `validate_model` function. Though we could choose to call the parameter something else (like `class_name` or `class_type`) we're going to stick with the convention of calling it `cls`.

### !end-callout

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`07b-from-dict-refactor` |`07c-validate-book-refactor`|

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
- `from_dict`

Our test folder should have 2 files: 
- `test_routes.py`
- `test_models.py`

</details>
</br>

## 