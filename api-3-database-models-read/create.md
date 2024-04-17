# Create

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=b0546829-5d82-43d0-be51-adb90189026d&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Goals

Our goal for this lesson is to implement a route that creates a new data record using the `Book` model.

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

Finally, the most appropriate successful response status code ids `201 Created`, indicating the resource had been successfully created. The response body could take several forms, ranging from an empty body, up to a JSON document representing the created resource (useful for communicating back the `id` that was assigned), or anything in between. We will choose to return a JSON document with the same format we used for our hardcoded objects, a dictionary with the keys:
- id
- title
- description

<table>
  <tr>
    <th>Response Status</th>
    <th>Example Response Body</th>
  </tr>
  <tr>
    <td><code>201 Created</code></td>
    <td><pre style="margin:0px;"><code>{
    "id": 1,
    "title": "Fictional Book Title",
    "description": "A fantasy novel set in an imaginary world"
}</code></pre>
    </td>
  </tr>
</table>

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Read the new book data from the HTTP request
2. Create a new `Book` model with the new book data stored inside of it
3. Save the new `Book` into the database
4. Send back a response

### Dependencies

To make this feature, we'll work with the following objects, types, and functions:

- `request`
- `Response`
- `make_response`

#### Working with `request` from Flask

Our code will begin by importing a module named `request` from `flask`.

```python
from flask import request
```

Flask, the framework, provides all sorts of tools to us. One of those tools is the `request` object. The imported `request` object represents the current HTTP request. For now, we should focus on a few useful patterns for using `request`, but for future reference, we can get more details about the `request` object by referring to:

- [Flask's definition of the `request` object](https://flask.palletsprojects.com/en/2.3.x/api/#flask.request)
- [Flask's resource on the Request Context](https://flask.palletsprojects.com/en/2.3.x/reqcontext/), which outlines technical details of how `request` exists, and how to use it

## Working with the `Response` Class from Flask

`Response` is a Flask class that represents HTTP responses. To make a response, we can make an instance of the `Response` class.

Flask also provides a helper method `make_response` that is a little bit more flexible than instantiating a `Response` ourselves, so we'll be using `make_response` instead. But we should be aware that it's still creating a `Response` instance internally.

For more information about the `Response` class and creating responses, we can refer to the following reference documents:

- [Flask's definition of `Response`](https://flask.palletsprojects.com/en/2.3.x/api/#response-objects)
- [Flask's quickstart guide on creating responses](https://flask.palletsprojects.com/en/2.3.x/quickstart/#about-responses), which notably does _not_ feature the `Response` class

There are a variety of ways to create `Response` instances, some implicit and some explicit. The previous resource links will provide a good starting point for exploring further!

## Creating a Book Endpoint: Code

Let's look at some example code for our create feature.

### Creating an Endpoint

Let's define the `POST /books` route by adding the following code to our `book_routes.py` file:

```python
from flask import Blueprint, make_response, request
from app.models.book import Book
from ..db import db

books_bp = Blueprint("books_bp", __name__, url_prefix="/books")

@books_bp.post("")
def create_book():
    request_body = request.get_json()
    title = request_body["title"]
    description = request_body["description"]

    new_book = Book(title=title, description=description)
    db.session.add(new_book)
    db.session.commit()

    response = {
        "id": new_book.id,
        "title": new_book.title,
        "description": new_book.description,
    }
    return make_response(response, 201)
```

| <div style="min-width:290px;"> Piece of Code </div>   | Notes                                                                                                                                                                                                                                                                                                       |
| ----------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `from ..db import db`, `from ... import Book`         | We need to import the necessary modules to create our `Book` model and access our database                                                                                                                                                                                                                                             |
| `from flask import Blueprint, make_response, request` | We need to import our Flask dependencies. Python supports comma-separated importing.                                                                                                                                                                                                                              |
| `books_bp = Blueprint("books", __name__, ...)`        | Our `Blueprint` instance. We'll use it to group routes that start with `/books`. `"books_bp"` is the debugging name for this `Blueprint`. `__name__` provides information the blueprint uses for certain aspects of routing.                                                                                   |
| `url_prefix="/books"`                                 | A keyword argument. This `url_prefix` indicates that _every_ endpoint using this Blueprint should be treated like it starts with `/books`. We should use this blueprint for all of our RESTful routes that start with `/books`!                                                                             |
| `@books_bp.post("")`                                  | A decorator that uses the `books_bp` Blueprint to define an endpoint and accepted HTTP method. The following function will execute whenever a matching HTTP request is received.                                                                                                                            |
| `def create_book():`                                  | This function will execute whenever a request that matches the decorator is received. The name of this function doesn't affect how requests are routed to this method. Common choices for a function name could include matching the route path, or using any other clear, descriptive Python function name. |
| `request_body = ...`                                  | We create a local variable `request_body`, which will hold the body contents of the HTTP request in a Python data structure (likely dictionaries, lists, and strings)                                                                                                                                       |
| `... request.get_json()`                              | We use the `request` object to get information about the HTTP request. We want to get the request's JSON body, so we use `request.get_json()`. This method "Pythonifies" the JSON HTTP request body by converting it to a Python dictionary.                                                                |
| `title = request_body["title"]`                       | We access the `request_body` values to get the data for a new `Book` instance                                                                                                                                                                                  |
| `new_book = Book( ... )`                              | We create an instance of `Book` using the data in `request_body`. We assign this new instance to the `new_book` variable.                                                                                                                                                                                   |
| `(title=title, description=description)`              | We use keyword arguments matching our model attributes and use our variables holding data from the `request_body` to create a `Book` instance                                                                                                                                                                                  |
| `db.session.add(new_book)`                            | `db.session` is the database's way of collecting changes that need to be made. Here, we are saying we want the database to add `new_book`.                                                                                                                                                                  |
| `db.session.commit()`                                 | Here, we are saying we want the database to save and commit the collected changes.                                                                                                                                                                                                                          |
| `return`                                              | For each endpoint, we must _return_ a response                                                                                                                                                                                                                                                       |
| `make_response(...)`                                  | This function instantiates a `Response` object. A `Response` object is generally what we want to return from Flask endpoint functions.                                                                                                                                                                      |
| `response, 201`                                       | The first parameter to `make_response()` is the JSON response. We can define the status code of the `Response` by passing an integer as the second argument to `make_response()`. When a second argument isn't specified `200` is always the default value.     

### !callout-info

## Missing error handling in the create route

Folks may have noticed that our new function can crash if any required keys are missing! If you'd like the practice, feel free to add logic to handle the exceptions that could be raised for now. We will address error handling for creating models later in the Building an API series.

### !end-callout

### Blueprints

For this project, **Hello Books**, we are using `Blueprints` to create a group of related routes (endpoints).

Recall that we we have already registered `book_bp` in in `app/__init__.py` inside our `create_app`. function.                                                                                                           |

### !callout-info

## Many Ways to Make a Response

There are dozens of ways to make an HTTP response in Flask. Look forward to seeing and researching many of them!

### !end-callout

### Manually Testing with Postman

Our entire development process throughout this should use Postman heavily, rapidly, and constantly. Configure your Postman in the following ways:

- Set the method to `POST`
- Set the request URL to `localhost:5000/books`
- Configure an HTTP response body to `raw` and `JSON`, and add in the sample request body:

```json
{
  "title": "Fictional Book Title",
  "description": "A fantasy novel set in an imaginary world"
}
```

![Screenshot of using Postman to send a POST request to create a Book](../assets/api-3-database-models-read/create-postman-output.png)
_Fig. Screenshot of using Postman to send a POST request to create a Book. ([Full size image](../assets/api-3-database-models-read/create-postman-output.png))_

Lastly, don't forget to exercise patience! It takes patience to discover how to debug with so many tools, windows, and screens.

### Manually Testing with `psql`

Manually sending a request to our create route with Postman confirms that our route sends back a `Book` record, but does it guarantee that the Book is actually stored in our database? No, it doesn't! 

To be sure that our records are created and exist in the local database, for now we can use `psql`! To do so, we would start up `psql`, connect to our `hello-books-development` database, and run an appropriate query to get the records from the `book` table.

Let's try it out on our own! We can refer back to the Intro to SQL lessons if we need a reminder about how to write a query like this. Later in this series we will look at ways to automate our testing so that we don't need to rely on manually checking each scenario when we make changes.

### Debugging

Recall that our tools for debugging include:

- Using the response that appears in Postman
- Using the server logs
- Using `psql` to check the local database

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: 4de3Ri
* title: Create
##### !question

Assume that we have a `Note` model that contains only `id` and `message` attributes. 

Which entry below describes a route that follows best practices for creating a Note resource?

##### !end-question
##### !options

a| ```python
@notes_bp.post("")
def create_note():
    request_body = request.get_json()
    message = request_body["message"]

    new_note = Note(message=message)
    db.session.add(new_note)
    db.session.commit()

    return {
        "id": new_note.id,
        "message": new_note.message
    }
```
b| ```python
@notes_bp.post("")
def create_note():
    request_body = request.get_json()
    message = request_body["message"]

    new_note = Note(message=message)
    db.session.add(new_note)
    db.session.commit()

    response = {
        "id": new_note.id,
        "message": new_note.message
    }
    return make_response(response, 201)
```
c| ```python
@notes_bp.put("")
def create_note():
    request_body = request.get_json()
    message = request_body["message"]

    new_note = Note(message=message)
    db.session.add(new_note)
    db.session.commit()

    response = {
        "id": new_note.id,
        "message": new_note.message
    }
    return make_response(response, 201)
```
d| ```python
@notes_bp.post("")
def create_note():
    request_body = request.get_json()
    message = request_body["message"]

    new_note = Note(message=message)

    response = {
        "id": new_note.id,
        "message": new_note.message
    }
    return make_response(response, 201)
```

##### !end-options
##### !answer

b|

##### !end-answer
##### !explanation

This is the only option that uses `POST` for the HTTP verb, ensures that `new_note` is added and committed to the database, and sends back `201 Created` as our response status code along with our new `Note` record.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->