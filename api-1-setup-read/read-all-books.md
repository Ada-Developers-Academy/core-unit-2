# Read All Books Endpoint

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=a2eab4ad-e56b-4d32-8f1b-ae690173abc5&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Goals

Our goal for this lesson is to learn how to define a route that reads all the data for a model.

In this lesson we will build our Hello Books API to fulfill the following feature:

1. As a client, I want to send a request to get all existing books, so that I can see a list of books, with their `id`, `title`, and `description` of the book.

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`01c-hello-world` |`01d-read-all-books`|

## Cleaning Up Our Hello World Routes

In our previous lesson "Hello World Routes" we created our first blueprint and wrote our first routes. Now that we have had a chance to get familiar with Flask, we can clean up the work we just did on our local `main` branch since we will not need it for the rest of our Hello Books API. 

We can reference the changes on the `01c-hello-world` branch from the GitHub web interface to see what we need to clean up. We should either delete or comment out the following pieces of code to prepare for writing our first Hello Books API route:

- Line 2 in `app/__init__.py`: The import statement that imports the `hello_world_bp` blueprint 
- Line 8 in `app/__init__.py`: Remove the code that registers `hello_world_bp` with `app`
- The entire file `app/routes/hello_world_routes.py`

## Getting All Books Endpoint: Preparation

Now that our Hello Books API repository is cleaned up, let's consider how to implement this feature:

> As a client, I want to send a request to get all existing books, so that I can see a list of books, with their `id`, `title`, and `description` of the book.

### Data

![Getting all the data (https://media.makeameme.org/created/the-data-all.jpg)](../assets/building-an-api/flask-hello-books-all-the-data.png)  

Soon we will create and manipulate data in a SQL database. We will then learn how to create and manipulate this data through a connection with our API built in Flask. Until then, we will hard code data in our app using data structures we have already learned about.

Let's represent our data as a list of Book instances. The Book class should have the attributes `id`, `title`, and `description`.

We need to make a `Book` class, and then instantiate multiple instances.

Let's create the a file `app/models/book.py` with the command `touch app/models/book.py` and write our code in it. 

Give it a try, then review our code below.

```python
# book.py

class Book:
    def __init__(self, id, title, description):
        self.id = id
        self.title = title
        self.description = description

books = [
    Book(1, "Fictional Book", "A fantasy novel set in an imaginary world."),
    Book(2, "Wheel of Time", "A fantasy novel set in an imaginary world."),
    Book(3, "Fictional Book Title", "A fantasy novel set in an imaginary world.")
]
```

| <div style="min-width:290px;"> Piece of Code </div>   | Notes                                                                                                                                                                                                                                                                                                       |
| ----------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
| `class Book ...`   | Book class to represent book data which we will hardcode for now |
| `books = [...]`   | List of hardcoded Book instances which acts as our stored data for now |


### Planning HTTP Requests, Responses, and Logic

Let's think about the typical HTTP verbs and endpoints used in RESTful APIs. We will write a request that retrieves all records of a particular resource. Recall that for requests that read records, it is typical to use a `GET` request to the `/books` path. 

| HTTP Method | Endpoint |
| ----------- | -------- |
| `GET`       | `/books` |

`GET` requests do not include a request body, so no additional planning around the request body is needed.

The response we want to send back is a list of JSON objects (somewhat like Python dictionaries) with `id`, `title`, and `description`.

To indicate a successful response from our API, we will send back the status code `200 OK`.

| Response Status | Response Body                                                                                              |
| --------------- | ---------------------------------------------------------------------------------------------------------- |
| `200 OK`        | `[{"id": 1, "title": "Fictional Book", "description": "A fantasy novel set in an imaginary world."}, {"id": 2, "title": "Wheel of Time", "description": "A fantasy novel set in an imaginary world."}, {"id": 3, "title": "Fictional Book Title", "description": "A fantasy novel set in an imaginary world."}]` |

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Retrieve all of the books data.
2. Convert the list of Book instances into a list of dictionaries, where each dictionary has `id`, `title`, and `description` keys. Flask will convert each dictionary into a JSON object.
3. Send back a response

### Dependencies

To make this feature, we'll work with the following object:

- `Blueprint`

#### Revisiting `Blueprint` from Flask

We will continue to use `Blueprint`. We will use Blueprints to create a group of related routes (endpoints). In our example, we'll create a group of related `Book` routes. `Blueprint` provides an optional parameter `url_prefix`. By setting the `url_prefix` value to `"/books"`, all endpoints that use the `books_bp` Blueprint will start with `/books`. 

In the `app/routes` directory, in addition to the empty `__init__.py` file, we will also need to create a file called `book_routes.py`. We will write all of our routes related to the `Book` model in this file. 

In `book_routes.py` we will:
1. Import the `Blueprint` class from `Flask`
2. Import the `books` list (data from our "database") from `book.py`
3. Create an instance of `Blueprint` for our routes related to the `Book` model
4. Register our blueprint with our `app`
5. Write a route to get all the book records from our "database"

Here we write the code for steps 1 and 2 from above.

```python
# book_routes.py

from flask import Blueprint

books_bp = Blueprint("books_bp", __name__, url_prefix="/books")
```

| <div style="min-width:290px;"> Piece of Code </div>   | Notes                                                                                                                                                                                                                                                                                                       |
| ----------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
| `books_bp = Blueprint("books_bp", __name__, url_prefix="/books")`        | Our `Blueprint` instance. We'll use it to group routes that start with `/books`. `"books"` is the debugging name for this `Blueprint`. `__name__` provides information the blueprint uses for certain aspects of routing. We should use this blueprint for all of our RESTful routes that start with `/books`! 

### Registering a Blueprint

Now that we have defined our `books_bp` blueprint, Flask requires us to "register the blueprint" with our `app`.

Let's return to the code in `app/__init__.py`. Taking a look at our imports, we brought in `Flask` in a previous lesson, and now we need to import our new `books_bp` blueprint. Next, we register `books_bp` inside the `create_app` function, as shown below.

```python
# __init__.py

from flask import Flask
from .routes.book_routes import books_bp

def create_app():
    app = Flask(__name__)

    # Register Blueprints here
    app.register_blueprint(books_bp)

    return app
```

Again, these lines make it so that our `Blueprint` is recognized by our Flask `app`. We need to do this step each time we make a new `Blueprint`.

Note that we can add new routes to an existing `Blueprint` without further changes to our `app`. Once a `Blueprint` has been registered, all routes added to that `Blueprint` will be recognized.

## Getting All Books Endpoint: Code

Let's create a route function `get_all_books` in `book_routes.py` to retrieve all of our book data.

```python
# book_routes.py

from flask import Blueprint
from app.models.book import books

books_bp = Blueprint("books_bp", __name__, url_prefix="/books")

@books_bp.get("")
def get_all_books():
    books_response = []
    for book in books:
        books_response.append(
            {
                "id": book.id,
                "title": book.title,
                "description": book.description
            }
        )
    return books_response
```

| <div style="min-width:290px;"> Piece of Code </div>   | Notes                                                                                                                                                                                                                                                                                                       |
| ----------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
| `from app.models.book import books`               | An import statement that imports the list `books` from a module called `book` in the `app/models` directory. Recall that Python modules are files with the `.py` extension so the `book` module references the `book.py` file.                                                                                                                             |
| `@books_bp.get("")`               | A decorator that uses the `books_bp` Blueprint to define an endpoint and the accepted HTTP method. The following function will execute whenever a matching HTTP request is received.                                                                                                                            |
| `def get_all_books():`                                 | This function will execute whenever a request that matches the decorator is received. The name of this function doesn't affect how requests are routed to this method. Common choices for a function name could include matching the route path, or using any other clear, descriptive Python function name. |
| `books_response = []`                                       | We create an empty list called `books_response` that will eventually hold book dictionaries and be returned to the client that made the request. |
| `for book in books:`                                | We iterate over each `book` in `books` so we can collect their data and format it into a response                                                                                                                                                          |
| `books_response.append( ... )`                      | We append book dictionaries to the list to build up our response                                                                                                                                                                                         |
| `{ "id": book["id"], ... }`                            | This is the format of dictionary we want to send back. We'll insert the values based on the `book` we're iterating on.                                                                                                    |
| `return books_response`                                        | We must return a response from our route functions. By default, a response with no specified status code returns `200 OK`                                                                                                                                                       |

## What Kind of Data Should We Return to the Client?

What kind of data should route functions return? A list? A dictionary? It depends.

For the `get_all_books` route, we returned a list of book dictionaries representing book data from each of the books in our "database". In the future we'll see an example of a client sending a request for a single book's data; in that case it would be appropriate to return a single book dictionary instead of a list of book dictionaries. 

When building an API, it's considered a best practice to be consistent about what kind of data a user can expect our endpoints to return. This makes it easier for users to know what to expect, and users can often write less code because they don't need to detect and handle multiple formats from the response.

Generally speaking, the APIs we write through this curriculum will accept requests and return responses with JSON as the format for the request body and response body, respectively. Flask conveniently converts list and dictionary data types into JSON responses when they are returned from a route, so we will be focusing on using these data types for our responses.

If we return other objects, Flask may not be able to convert the object into a JSON formatted response body, or it might make incorrect assumptions about which format to use when sending a response body back to the client. Therefore, we should convert an instance of an object into a dictionary which we can return on its own–or append to a list of objects that have been converted into dictionaries to return–as a response.

### !callout-info

## `Blueprint`s and Routes are Sensitive to `/`

Be sure to specify that this endpoint is `""`. When combined with the `book_bp`'s `url_prefix`, `"/books"`, we see this endpoint is a `GET` to `/books`. URIs are sensitive to the use of `/` and Flask will throw an error if we define this route as `"/"` but try to access it as `/books`. A URI ending in `/` is different from a URI that _doesn't_ end in `/`, so we should use `""`.

<br/>

<details>

<summary>Is there a way to declare "/" as a valid route path?</summary>
<br/>
For a little more flexibility, we _could_ choose to use `"/"` as the route path and include the keyword argument `strict_slashes=False`. This tells the route to treat a URI the same whether or not it ends in `/`. Accepting either variation can make using our API a little easier for our clients.

</details>

### !end-callout

### Manually Testing with Postman

Let's test this request:

- Set the method to `GET`
- Keep the request URL as `localhost:5000/books`

![Screenshot of using Postman to send a GET request to get all book data](../assets/building-an-api/create-and-read_get-books-postman.png)  
_Fig. Screenshot of using Postman to send a GET request to get all book data. ([Full size image](../assets/building-an-api/create-and-read_get-books-postman.png))_

### !callout-info

## Remember to Debug with All of the Tools!

Remember to use all debugging tools:

- Postman
- VS Code
- Checking the Flask Server logs in Terminal
- Peers, classmates, and rubber ducks

### !end-callout

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: 7GgQrh
* title: Read All Books Endpoint
##### !question

Arrange the options below so that they reflect what our `get_all_books` route does:

##### !end-question
##### !answer

1. Use the `books_bp` blueprint with a decorator to define a `GET` request endpoint
1. Loop through all the books to convert them into dictionaries and append them to the `books_response` list
1. Return `books_response`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: juUzv5
* title: Read All Books Endpoint
  
##### !question
What kind of data can a client expect in the response body when sending a `GET` request to `/books`

##### !end-question
##### !options
* A list of book objects
* A list of book dictionaries representing book objects
* A book dictionary
##### !end-options

##### !answer
* A list of book dictionaries representing book objects
##### !end-answer

#### !explanation 
Flask will convert lists and dictionaries into JSON response objects. For a `GET` request to `/books` we need to send a list of book dictionaries so that Flask can convert the response into the correct JSON format. If we returned a list of book objects, Flask will not be able to correctly convert them into JSON format. If we returned a single book dictionary, we would not be returning **all** the requested data. 
#### !end-explanation 
### !end-challenge
<!-- prettier-ignore-end -->