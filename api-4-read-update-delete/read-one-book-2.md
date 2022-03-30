# Read One Book

## Goals

Our goals for this lesson are to:
- Practice defining routes that read model records
- Access a database record from the back-end layer

We will build our Hello Books API to fulfill the following feature:

1. As a client, I want to send a request to get one existing book, so that I can see the `id`, `title`, and `description` of the book.

We will refactor the endpoint we designed in our previous lesson [02) Building and API - Read One Book Endpoint](../api-2-read-404s/read-one-book.md) to make use of the data in our postgres database.

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`03c-read-all-books` |`04a-read-one-book`|

## Getting a Single Book Endpoint: Planning HTTP Requests, Responses, and Logic Review

Let's review the planning work we did in the lesson [02) Building and API - Read One Book Endpoint](../api-2-read-404s/read-one-book.md).

Once more, we should think about the RESTful HTTP verb and endpoint used for requests that retrieve the data for a particular model record.

For this feature, we should make a `GET` request to the `/books` path, but we need to include the `id` of the record to retrieve as part of the endpoint.

| HTTP Method | Endpoint   | Example |
| ----------- | ---------- | ---------- | 
| `GET`       | `/books/<book_id>` | `/books/3` |

`GET` requests do not include a request body, so no additional planning around the request body is needed.

We want to send back a single JSON object (dictionary) with `id`, `title`, and `description`:

| Response Status | Sample Response Body                                                                                            |
| --------------- | -------------------------------------------------------------------------------------------------------- |
| `200 OK`        | `{"id": 1, "title": "Fictional Book Title", "description": "A fantasy novel set in an imaginary world"}` |

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Read the `book_id` in the request path
1. Retrieve the book with the matching `book_id` from the database
1. Format the book data into the appropriate structure (a single dictionary with `id`, `title`, and `description`)
1. Send back a response

Our new route needs to read data from the incoming request path. Our existing route doesn't do this, so we'll need to add an entirely new route to our existing `Blueprint`.

Our new route needs a **route parameter**. The route `/books/1` should give us the details for the book with `id` 1. `/books/2` should give us details for book with `id` 2, `/books/3000` should give us details for book 3000, and so on.

Let's take a look at how our new route will account for this!

## Getting a Single Book Endpoint: Code

To access a single book with `book_id` in our database we use the syntax `Book.query.get(book_id)`.

Consider how you could refactor the `GET` `/books/<book_id>` route to make use of this *query*.

<details>
    <summary>Give it a try, then click here to review our code.</summary>

```python
# No new import statements...

# No modifications to the other route...

@books_bp.route("/<book_id>", methods=["GET"])
def handle_book(book_id):
    book = Book.query.get(book_id)

    return {
        "id": book.id,
        "title": book.title,
        "description": book.description
    }
```

</details>

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                                                                                                                                                                                              |
| --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `@books_bp.route("...", methods=["GET"])`           | We are setting up a new route, so we must use the `Blueprint` decorator to define it                                                                                                                                                                                                                                                                                               |
| `"/<book_id>"`                                      | This is the `Blueprint` syntax to indicate _route parameters_. The `<book_id>` placeholder shows that we are looking for a variable value (could be `1`, `2`, or `3000`). We'll use this value in the function as the variable `book_id`, so we should use a good, descriptive name.                                                                                               |
| `def handle_book(book_id):`                                | This `handle_book` function is called whenever the HTTP request matches the decorator. The name of this function should follow the previously discussed guidelines. We must add a parameter to this method, `book_id`. This parameter name must match the route parameter in the decorator. It will receive the part of the request path that lines up with the placeholder in the route. |
| `Book.query.get(...)`                               | This is the SQLAlchemy syntax to query for one `Book` resource. This method returns an instance of `Book`.                                                                                                                                                                                                                                                                         |
| `Book.query.get(book_id)`                           | We must pass in the primary key of a book here. The primary key of the book we're looking for was provided in the route parameter, `book_id`.                                                                                                                                                                                                                                      |
| `{ "id": book.id, ... }`                            | We can create a dictionary literal for our HTTP response.                                                                                                                                                                                                                                                                                                                          |
| `return`                                            | As always, we must return a response. Flask will default to returning status `200 OK`.                                                                                                                                                                                                                                                                                             |

### !callout-warning

## Python Doesn't Know What a `book_id` Is

We named the route parameter `book_id` because we expect it to be an id of a book. But just like regular variable names, Python has no idea what a `book_id` is. All it does is look for whatever part of the URL path follows `/books/` and captures that into the variable `book_id`. A request for `/books/360` would set the value of `book_id` to be `"360"`. A request for `/books/tacocat` would set the value of `book_id` to be `"tacocat"`!

<br />

We should be careful to avoid thinking that Python uses the name of the parameter to do any kind of validation. As usual, the name provides information to us developers, not to Python.

### !end-callout

### !callout-info

## Why Didn't We Call `jsonify()` or `make_response()` on the Dictionary?

For reasons that are less important to memorize, Flask will automatically convert a dictionary into an HTTP response body. If we don't want to remember this exception, we can call `jsonify()` or `make_response()` with the dictionary as an argument to return the result.

### !end-callout

## Error Handling

Recall the `validate_book` function that handles an invalid `book_id` or a non-existing book by returning a `400` or `404` response. 

<details>
    <summary>Expland to view validate_book function.</summary>

```python
def validate_book(book_id):
    try:
        book_id = int(book_id)
    except:
        abort(make_response({"message":f"book {book_id} invalid"}, 400))

    for book in books:
        if book.id == book_id:
            return book_id

    abort(make_response({"message":f"book {book_id} not found"}, 404))
```
</details>

Let's refactor `validate_book` so that it gets the correct `book` instance from the database, and returns this `book`. 

We've been retrieving our `Book` instance with the line `Book.query.get(book_id)`. What does this method do when there is no matching book?

When `Model.query.get(primary_key)` doesn't find a matching record, it returns `None`!

We can use this refactoring opportunity to rename `handle_book` to something more descriptive like `read_one_book`.

<details>
    <summary>Give it a try, then click here to review our code.</summary>

```python
def validate_book(book_id):
    try:
        book_id = int(book_id)
    except:
        abort(make_response({"message":f"book {book_id} invalid"}, 400))

    book = Book.query.get(book_id)

    if not book:
        abort(make_response({"message":f"book {book_id} not found"}, 404))

    return book

@books_bp.route("/<book_id>", methods=["GET"])
def read_one_book(book_id):
    book = validate_book(book_id)
    return {
            "id": book.id,
            "title": book.title,
            "description": book.description
        }
```

</details>



<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: ECXaUI
* title: Getting a Single Book Endpoint
##### !question

Think about the "Getting a Single Book Endpoint."

Check off all the topics that we've briefly touched on so far.

##### !end-question
##### !options

* Planned the HTTP response, request, and logic for this endpoint
* Considered route parameters, and how we need the book ID in the route
* Created a new endpoint that matches on `GET` requests to `"/<book_id>"`
* Defined this endpoint with the function signature `def book(book_id):`
* Used `Book.query.get(book_id)` to get an instance of `Book` matching `book_id`
* Returned a dictionary literal as our response
* Handled `400` and `404` responses

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->