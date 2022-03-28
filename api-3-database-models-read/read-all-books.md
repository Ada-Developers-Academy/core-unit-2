# Read All Books

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=13c1312c-7230-4631-9687-adba0000a65e&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goals

Our goal for this lesson is to:
- Practice defining routes that read model records
- Access a database record from the back-end layer

We will build our Hello Books API to fulfill these features:

1. As a client, I want to send a request to get all existing books, so that I can see a list of books, with their `id`, `title`, and `description` of the book.

We will refactor the endpoint we designed in our previous lesson [01) Building and API - Read All Books Endpoint](../api-1-setup-read/read-all-books.md) to make use of the data in our postgres database.

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`03b-create` |`03c-read-all-books`|

## Planning HTTP Requests, Responses, and Logic Review

Let's review the planning work we did in the lesson **Building and API - Part 1: Reading All Books and Endpoint**.

Let's think about the typical HTTP verb and endpoint used for requests that retrieve all records of a particular resource. 

Recall that for requests that read records, it is RESTful to use a `GET` request to the `/books` path. 

| HTTP Method | Endpoint |
| ----------- | -------- |
| `GET`       | `/books` |

`GET` requests do not include a request body, so no additional planning around the request body is needed.

The response we want to send back is a list of JSON objects (dictionaries) with `id`, `title`, and `description`.

The most appropriate successful response status code is `200 OK`.

| Response Status | Response Body                                                                                              |
| --------------- | ---------------------------------------------------------------------------------------------------------- |
| `200 OK`        | `[{"id": 1, "title": "Fictional Book Title", "description": "A fantasy novel set in an imaginary world"}, {"id": 2, "title": "Fictional Book Title", "description": "A fantasy novel set in an imaginary world"}, {"id": 3, "title": "Fictional Book Title", "description": "A fantasy novel set in an imaginary world"}]` |

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Retrieve all of the books data.
1. Format the list of Book instances into the appropriate JSON data structure (list of dictionaries, where each dictionary has `id`, `title`, and `description`)
1. Send back a response

Recall that `jsonify` is a Flask utility function that turns its argument into JSON. We'll use `jsonify` as a way to turn a list of book dictionaries into a `Response` object.

For additional details about `jsonify`, we can refer to:

- [Flask's definition of `jsonify`](https://flask.palletsprojects.com/en/1.1.x/api/#flask.json.jsonify)

## Working with `query` from SQLAlchemy's `Model`

Each Model class (a class that inherits from `db.Model`) has a `query` attribute. The object returned by the `query` attribute has the functions we will use to retrieve model data from the database. This is the object that will do the hard work of querying the database!

There are a lot of ways to use the `query` object. For future reference, we can refer to:

- [SQLAlchemy's quickstart guide to querying records](https://flask-sqlalchemy.palletsprojects.com/en/2.x/queries/#querying-records)
- [SQLAlchemy's definition of `Model`](https://flask-sqlalchemy.palletsprojects.com/en/2.x/api/#flask_sqlalchemy.Model) (which includes `query`)

## Getting All Books Endpoint: Code

Let's update our route function in `routes.py` to include support for retrieving our models.

To access all the books in our database we use the syntax `Book.query.all()`.

Consider how you could refactor the `GET` `/books` route to make use of this *query*.

<details>
    <summary>Give it a try, then click here to review our code.</summary>

```python
from app import db
from app.models.book import Book
from flask import Blueprint, jsonify, make_response, request

books_bp = Blueprint("books", __name__, url_prefix="/books")

@books_bp.route("", methods=["GET", "POST"])
def handle_books():
    if request.method == "GET":
        books = Book.query.all()
        books_response = []
        for book in books:
            books_response.append({
                "id": book.id,
                "title": book.title,
                "description": book.description
            })
        return jsonify(books_response)
    elif request.method == "POST":
        # ... Indent all of the Create Book functionality into this elif
        # request_body = request.get_json()
```

</details>

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                                                                    |
| --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `@books_bp.route("", methods=["GET", "POST"])`      | Add `"GET"` into this list of accepted HTTP methods                                                                                                                                                                                                      |
| `if request.method == "GET":`                       | Separate this functionality from the Create feature by checking the `request`'s HTTP method                                                                                                                                                              |
| `... = Book.query.all()`                            | This SQLAlchemy syntax tells `Book` to `query` for `all()` books. This method returns a _list_ of instances of `Book`.                                                                                                                                   |
| `books = ...`                                       | We store the list of `Book` instances in the variable `books`                                                                                                                                                                                            |
| `for book in books:`                                | We iterate over all books in `books` so we can collect their data and format it into a response                                                                                                                                                          |
| `books_response.append( ... )`                      | We will use the `books_response` list to hold book dictionaries                                                                                                                                                                                          |
| `{ "id": book.id, ... }`                            | This is the format of dictionary we want to send back. We'll insert the values based on the `book` we're iterating on                                                                                                                                    |
| `jsonify(books_response)`                           | `books_response` contains a list of book dictionaries. To turn it into a `Response` object, we pass it into `jsonify()`. This will be our common practice when returning a list of something because the `make_response` function does not handle lists. |
| `return ...`                                        | We must return our response. By default, a response with no specified status code returns `200 OK`                                                                                                                                                       |

### Manually Testing with Postman

Let's test this request:

- Set the method to `GET`
- Keep the request URL at `localhost:5000/books`

![Screenshot of using Postman to send a POST request to create a Book](../assets/building-an-api/create-and-read_get-books-postman.png)

### !callout-info

## Remember to Debug with All of the Tools!

Remember to use all debugging tools:

- Postman
- Server logs
- VS Code
- Peers, classmates, and rubber ducks

### !end-callout

## Refactor using Seperate Route Functions

Finally, let's refactor to create separate route functions for the **create** and **read** features. While Flask allows us to put the functionality for multiple features into a single function, it can enhance readibility and changeability to separate them out into seperate functions. 

<details>
    <summary>Consider how to refactor into seperate route function and then expand the review the code.</summary>

```python
# app/routes.py

from app import db
from app.models.book import Book
from flask import Blueprint, jsonify, make_response, request

books_bp = Blueprint("books_bp", __name__, url_prefix="/books")

@books_bp.route("", methods=["POST"])
def create_book():
    request_body = request.get_json()
    new_book = Book(title=request_body["title"],
                    description=request_body["description"])

    db.session.add(new_book)
    db.session.commit()

    return make_response(f"Book {new_book.title} successfully created", 201)

@books_bp.route("", methods=["GET"])
def read_all_books():
    books_response = []
    books = Book.query.all()
    for book in books:
        books_response.append(
            {
                "id": book.id,
                "title": book.title,
                "description": book.description
            }
        )
    return jsonify(books_response)
```

We should verify that our `GET` `/books` and `CREATE` `/books` route still work the same as before the refactor using Postman and/or the browser.

Soon, we will create unit tests that we can use for this sort of verification. 

</details>

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: 9Lz3nt
* title: Create and Read, Getting All Books Endpoint
##### !question

Think about the "Getting All Books Endpoint."

Check off all the topics that we've briefly touched on so far.

##### !end-question
##### !options

* Planned the HTTP response, request, and logic for this endpoint
* Briefly considered `jsonify`
* Briefly considered `query`
* Updated this endpoint to match `GET` requests, too
* Refactored this endpoint to check `request.method`
* Got a list of `Book` instances using `Book.query.all()`
* Iterated through `books`
* Created a list of Book dictionaries in `books_response`
* Used `jsonify` with `jsonify(books_response)`
* Returned this JSON list with the status code `200 OK`
* Tested this request in Postman
* Refactored to separate route functions for **create** and **read**

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->

