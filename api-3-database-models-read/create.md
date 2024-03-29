# Create

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=b0546829-5d82-43d0-be51-adb90189026d&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goals

Our goal for this lesson is to implement a route that creates model records.

We will add to our Hello Books API to fulfill the following feature:

1. As a client, I want to send a request with new valid book data and get a success response, so that I know the API saved the book data.

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`03a-models-setup` |`03b-create`|

<details>
   <summary>Expand to see the model and database features <code>Hello Books API</code> should have before this lesson</summary>

* A `hello_books_development` database
* A `book` table defined
* A `Book` model defined

The model and table should have the following columns:

* `id`
* `title`
* `description`

</details>
<br>

## Creating a Book Endpoint: Preparation

Let's consider how to accomplish this feature:

> As a client, I want to send a request with new valid book data and get a success response, so that I know the API saved the book data.

### Planning HTTP Requests, Responses, and Logic

Recall that for requests that create records, it's typical to use the `POST` verb to receive requests sent to an endpoint which is the plural form of the resource to create. So we pick the following HTTP method and endpoint.

| HTTP Method | Endpoint |
| ----------- | -------- |
| `POST`      | `/books` |

The request body will consist of a JSON document with all the fields required to create the resource. For our `Book` model, an example request body would be:

```json
{
  "title": "Fictional Book Title",
  "description": "A fantasy novel set in an imaginary world"
}
```

Finally, the most appropriate successful response status code ids `201 Created`, indicating the resource had been successfully created. The response body could take several forms, ranging from an empty body, up to a JSON document representing the created resource (useful for communicating back the `id` that was assigned), or anything in between.

Let's start by returning a status message, and we'll return to the idea of returning a JSON document for some of our other endpoints.

| Response Status | Response Body                                    |
| --------------- | ------------------------------------------------ |
| `201 Created`   | `Book Fictional Book Title successfully created` |

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Read the new book data from the HTTP request
1. Create a new `Book` model with the new book data stored inside of it
1. Save the new `Book` into the database
1. Send back a response

### Dependencies

To make this feature, we'll work with the following objects, types, and functions:

- `request`
- `Response`
- `make_response`

#### Working with `request` from Flask

Our code will begin by importing something named `request` from `flask`.

```python
from flask import request
```

Flask, the framework, will provide all sorts of things to us. One of those things is the `request` object. The imported `request` object represents the current HTTP request. For now, we should focus on a few useful patterns for using `request`, but for future reference, we can get more details about the `request` object by referring to:

- [Flask's definition of the `request` object](https://flask.palletsprojects.com/en/1.1.x/api/#flask.request)
- [Flask's resource on the Request Context](https://flask.palletsprojects.com/en/1.1.x/reqcontext/), which outlines technical details of how `request` exists, and how to use it

## Working with the `Response` Class from Flask

`Response` is a Flask class that represents HTTP responses. To make a response, we can make an instance of the `Response` class.

Flask also provides a helper method `make_response` that is a little bit more flexible than instantiating a `Response` ourselves, so we'll be using `make_response` instead. But we should be aware that it's still creating a `Response` instance internally.

For more information about the `Response` class we can refer to the following reference documents.

- [Flask's definition of `Response`](https://flask.palletsprojects.com/en/1.1.x/api/#response-objects)
- [Flask's quickstart guide on creating responses](https://flask.palletsprojects.com/en/1.1.x/quickstart/#about-responses), which notably does _not_ feature the `Response` class

There are a variety of ways to create `Response` instances, some implicit and some explicit. The previous resource links will provide a good starting point for exploring further!

## Creating a Book Endpoint: Code

Let's look at some example code for our create feature.

### Creating an Endpoint

Let's define the `POST /books` route by adding the following code to our `routes.py` file.

```python
from app import db
from app.models.book import Book
from flask import Blueprint, jsonify, make_response, request

books_bp = Blueprint("books", __name__, url_prefix="/books")

@books_bp.route("", methods=["POST"])
def handle_books():
    request_body = request.get_json()
    new_book = Book(title=request_body["title"],
                    description=request_body["description"])

    db.session.add(new_book)
    db.session.commit()

    return make_response(f"Book {new_book.title} successfully created", 201)

```

| <div style="min-width:290px;"> Piece of Code </div>   | Notes                                                                                                                                                                                                                                                                                                       |
| ----------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `from app import db`, `from ... import Book`          | We need to import the necessary modules for our `Book` model                                                                                                                                                                                                                                                |
| `from flask import Blueprint, jsonify, make_response, request` | We need to import our dependencies. Python supports comma-separated importing.                                                                                                                                                                                                                              |
| `books_bp = Blueprint("books", __name__, ...)`        | Our `Blueprint` instance. We'll use it to group routes that start with `/books`. `"books"` is the debugging name for this `Blueprint`. `__name__` provides information the blueprint uses for certain aspects of routing.                                                                                   |
| `url_prefix="/books"`                                 | A keyword argument. This `url_prefix` indicates that _every_ endpoint using this Blueprint should be treated like it starts with `/books`. We should use this blueprint for all of our RESTful routes that start with `/books`!                                                                             |
| `@books_bp.route("", methods=["POST"])`               | A decorator that uses the `books_bp` Blueprint to define an endpoint and accepted HTTP method. The following function will execute whenever a matching HTTP request is received.                                                                                                                            |
| `def handle_books():`                                 | This function will execute whenever a request that matches the decorator is received. The name of this function doesn't affect how requests are routed to this method. Common choices for a function name could include matching the route path, or using any other good, descriptive Python function name. |
| `request_body = ...`                                  | We create a local variable `request_body`, which will hold the body contents of the HTTP request in a Python data structure (likely dictionaries, lists, and strings)                                                                                                                                       |
| `... request.get_json()`                              | We use the `request` object to get information about the HTTP request. We want to get the request's JSON body, so we use `request.get_json()`. This method "Pythonifies" the JSON HTTP request body by converting it to a Python dictionary.                                                                |
| `new_book = Book( ... )`                              | We create an instance of `Book` using the data in `request_body`. We assign this new instance to the `new_book` variable.                                                                                                                                                                                   |
| `title=request_body["title"], ...`                    | We use keyword arguments matching our model attributes, and access the `request_body` values to create the `Book` instance                                                                                                                                                                                  |
| `db.session.add(new_book)`                            | `db.session` is the database's way of collecting changes that need to be made. Here, we are saying we want the database to add `new_book`.                                                                                                                                                                  |
| `db.session.commit()`                                 | Here, we are saying we want the database to save and commit the collected changes.                                                                                                                                                                                                                          |
| `return`                                              | For each endpoint, we must _return_ the HTTP response                                                                                                                                                                                                                                                       |
| `make_response(...)`                                  | This function instantiates a `Response` object. A `Response` object is generally what we want to return from Flask endpoint functions.                                                                                                                                                                      |
| `f"Book {new_book.title} successfully created"`       | The first parameter to `make_response()` is the HTTP response body. Until we have more specific requirements, we will send back a string.                                                                                                                                                                   |
| `201`                                                 | We can define the status code of the `Response` by passing an integer as the second argument to `make_response()`. When a second argument isn't specified `200` is always the default value.     

### Blueprints

For this project, **Hello Books**, we are using `Blueprints` to create a group of related routes (endpoints).

Recall that we we have already registered `book_bp` in in `app/__init__.py` inside our `create_app`. function.                                                                                                           |

### !callout-info

## `Blueprint`s and Routes are Sensitive to `/`

Be sure to specify that this endpoint is `""`. When combined with the `book_bp`'s `url_prefix`, `"/books"`, we see this endpoint is a `POST` to `/books`. URIs are sensitive to the use of `/` and Flask will throw an error if we define this route as `"/"` but try to access it as `/books`. A URI ending in `/` is different from a URI that _doesn't_ end in `/`, so we should use `""`.

<br/>

<details>

<summary>Is there a way to declare "/" as valid a route path?</summary>

For a little more flexibility, we _could_ choose to use `"/"` as the route path and include the keyword argument `strict_slashes=False`. This tells the route to treat a URI the same whether or not it ends in `/`. Accepting either variation can make using our API a little easier for our clients.

</details>

### !end-callout

### !callout-info

## Many Ways to Make a Response

There are dozens of ways to make an HTTP response in Flask. Look forward to seeing and researching many of them!

### !end-callout

### Manually Testing with Postman

Our entire development process throughout this should use Postman heavily, rapidly, and constantly. Configure your Postman in the following ways:

- Set the method to `POST`
- Set the request URL to `localhost:5000/books`
- Configure an HTTP response body to `raw` and `JSON`, and add in the sample request body

![Screenshot of using Postman to send a POST request to create a Book](../assets/building-an-api/create-and-read_create-postman.png)

Lastly, don't forget to exercise patience! It takes patience to discover how to debug with so many tools, windows, and screens.

### Manually Testing with `psql`

We could also check that our book was saved in the database using `psql`! To do so, we would start up `psql`, connect to our database, and run an appropriate query to get the records from the `book` table.

Let's try it out on our own! We can refer back to the Intro to SQL lessons if we need a reminder about how to write a query like this.

### Debugging

Recall that our tools for debugging include:

- Using the response that appears in Postman
- Using the server logs

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: 4de3Ri
* title: Creating a Book Endpoint
##### !question

Think about the "Creating a Book Endpoint."

Check off all the topics that we've briefly touched on so far.

##### !end-question
##### !options

* Planned the HTTP response, request, and logic for this endpoint
* Briefly considered `request`
* Briefly considered `Blueprint`
* Briefly considered `Response`
* Created a new endpoint that catches requests going to `""` (assumed `"/books"`) with the HTTP method `POST`
* Read the HTTP request body using `request.get_json()`
* Created a new instance of `Book`
* Saved the instance of `Book` in the database
* Returned an instance of `Response` with the status code `201 Created`
* Tested this request in Postman

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->