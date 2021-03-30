# Update and Delete

## Goals

- Practice defining routes that modify data in an API
- Modify a database record from the back-end layer

## Format

This lesson is a walk-through and syntax explanation for how to build several features inside a Flask API. We **highly recommend** reading or watching through this first fully, before repeating on your own machine.

This lesson has a large amount of new information. It may be better to think about this lesson as a resource to be familiar with, rather than commit all new knowledge to memory at once.

### !callout-danger

## Read-through First, Repeat Second

We **highly suggest** reading or watching through this lesson fully, before repeating on your own machine.

### !end-callout

### !callout-danger

## Prioritize Familiarity

It may be better to think about this lesson as a resource to be familiar with, rather than commit all new knowledge to memory at once.

### !end-callout

## Hello Books API

### Before This Lesson

This lesson uses the Hello Books API. Before beginning this lesson, the Hello Books API should have:

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined
- Endpoints defined for these RESTful routes:
  - `GET` to `/books`
  - `POST` to `/books`
  - `GET` to `/books/<book_id>`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`

### This Lesson's Work

We want to build our Hello Books API to fulfill these features:

1. As a client, I want to send a request with valid book data to update one existing book and get a success response, so that I know the API updated the book data.
1. As a client, I want to send a request to delete one existing book and get a success response, so that I know the API deleted the book data.

## Updating a Book Endpoint: Preparation

Let's consider how to accomplish this feature:

> As a client, I want to send a request with valid book data to update one existing book and get a success response, so that I know the API updated the book data.

### Predict HTTP Requests, Responses, and Logic

Let's consider the endpoint to create a book:

| HTTP Method | Endpoint   |
| ----------- | ---------- |
| `PUT`       | `/books/1` |

Request body:

```json
{
  "title": "Updated Fictional Book Title",
  "description": "This fantasy novel has robots and pirates, too."
}
```

This assumes that there is at least a `book` table with the following row:

| `id` | `title`                | `description`                               |
| ---- | ---------------------- | ------------------------------------------- |
| `1`  | `Fictional Book Title` | `A fantasy novel set in an imaginary world` |

The response we want to send back is:

| Response Status | Response Body                  |
| --------------- | ------------------------------ |
| `200 OK`        | `Book #1 successfully updated` |

During this method, we will need to:

1. Read the new, updated book data from the HTTP request
1. Find the instance of `Book` that has the existing book data
1. Update the instance of `Book` with the new data
1. Save the `Book` in the db
1. Send back a response

## Updating a Book Endpoint: Code

This endpoint uses the same path as an existing one, `"/<book_id>"`. We can refactor and expand on this same function.

Let's look at this example code for our update feature.

```python
@books_bp.route("/<book_id>", methods=["GET", "PUT"])
def book(book_id):
    book = Book.query.get(book_id)

    if request.method == "GET":
        # ... existing code that returned a dictionary
    elif request.method == "PUT":
        form_data = request.get_json()

        book.title = form_data["title"]
        book.description = form_data["description"]

        db.session.commit()

        return Response(f"Book #{book.id} successfully updated", status=200)
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                      |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `methods=["GET", "PUT"]`                            | This route's matching methods now need to be updated to handle `PUT` requests                                                              |
| `book = Book.query.get(book_id)`                    | Both the `GET` and `PUT` actions need to find the `Book` instance based on `book_id`, so we'll declare `book` at the beginning             |
| `if request.method == "GET": ...`                   | We can refactor our existing `GET` functionality into this conditional                                                                     |
| `elif request.method == "PUT":`                     | We can begin our update functionality inside of a conditional for `PUT` requests                                                           |
| `... = request.get_json()`                          | This endpoint relies on reading the HTTP request body. We'll use `request.get_json()` to parse the JSON body into a Python data structure. |
| `form_data`                                         | A local variable to hold the HTTP response.                                                                                                |
| `book.title = form_data["title"]`                   | We'll use our OOP skills to update `book`'s `title` attribute                                                                              |
| `book.description = ...`                            | We'll use our OOP skills to update `book`'s `description` attribute                                                                        |
| `db.session.commit()`                               | Every time a SQLAlchemy model has been updated, and we want to commit the change to the database, we'll execute `db.session.commit()`.     |
| `return Response( ... )`                            | This is one of many ways we can return our appropriate HTTP response                                                                       |

### !callout-info

## Naming `form_data`

We've named the variable that holds our HTTP request body `form_data`. This name helps evoke the story of this endpoint; it's likely that a client makes this request because a user filled out an update form. Other names are appropriate, though, such as `request_body`.

### !end-callout

### Manually Testing with Postman

We can use Postman to check our update functionality.

It may help to first make a request to `GET /books/1` before updating it.

![Screenshot of Postman featuring a request of GET /books/1 and a response of 200 with book data](../assets/update-and-delete/update-and-delete_update-precheck-get.png)

Then, make a request to `PUT /books/1` with our proper JSON request body.

![Screenshot of Postman featuring a request of PUT /books/1 and a response of 200 with a success message](../assets/update-and-delete/update-and-delete_update-request.png)

We can send another request to `GET /books/1` to confirm the updates worked.

![Screenshot of Postman featuring a request of GET /books/1 and a response updated book data](../assets/update-and-delete/update-and-delete_update-confirm-get.png)

### Manually Testing with `psql`

We can also check if our book was updated in the database using `psql`!

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: pe3GBP
* title: Update and Delete, Updating a Book Endpoint
##### !question

Think about the "Updating a Book Endpoint."

Check off all the topics that we've briefly touched on so far.

##### !end-question
##### !options

* Predicted the HTTP response, request, and logic for this endpoint
* Refactored our `"/books/<book_id>"` endpoint to accept `PUT` requests
* Used `Book.query.get(book_id)` to get an instance of `Book` matching `book_id`
* Refactored our code to conditionally check the request's method
* Read the HTTP request body using `request.get_json()`
* Saved the instance of `Book` in the database
* Returned a response
* Tested this request in Postman

##### !end-options
##### !answer

* Predicted the HTTP response, request, and logic for this endpoint
* Refactored our `"/books/<book_id>"` endpoint to accept `PUT` requests
* Used `Book.query.get(book_id)` to get an instance of `Book` matching `book_id`
* Refactored our code to conditionally check the request's method
* Read the HTTP request body using `request.get_json()`
* Saved the instance of `Book` in the database
* Returned a response
* Tested this request in Postman

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

### !callout-warning

## What About Error Handling?

There are many cases that weren't covered in this lesson, even though they are relevant to creating and reading `Book`s. For example, what happens if we make a `GET` request to `/books/this-book-doesnt-exist`? We are intentionally not covering these cases at the moment, to limit this lesson. However, hypothesize and research how to handle erroneous HTTP requests. Follow your curiosity!

### !end-callout

## Deleting a Book Endpoint: Preparation

Let's consider how to accomplish this feature:

> As a client, I want to send a request to delete one existing book and get a success response, so that I know the API deleted the book data.

### Predict HTTP Requests, Responses, and Logic

Let's consider the endpoint to create a book:

| HTTP Method | Endpoint   |
| ----------- | ---------- |
| `DELETE`    | `/books/1` |

No request body.

This assumes that there is at least a `book` table with the following row:

| `id` | `title`                        | `description`                                     |
| ---- | ------------------------------ | ------------------------------------------------- |
| `1`  | `Updated Fictional Book Title` | `This fantasy novel has robots and pirates, too.` |

The response we want to send back is:

| Response Status | Response Body                  |
| --------------- | ------------------------------ |
| `200 OK`        | `Book #1 successfully deleted` |

During this method, we will need to:

1. Read the new, updated book data from the HTTP request
1. Find the instance of `Book` that has the existing book data
1. Delete this instance of `Book`
1. Save this change in the db
1. Send back a response

## Deleting a Book Endpoint: Code

Let's expand our `book` endpoint.

Let's look at this example code for our delete feature.

```python
@books_bp.route("/<book_id>", methods=["GET", "PUT", "DELETE"])
def book(book_id):
    book = Book.query.get(book_id)

    if request.method == "GET":
        # ... existing code for getting a single book
    elif request.method == "PUT":
        # ... existing code for updating a single book
    elif request.method == "DELETE":
        db.session.delete(book)
        db.session.commit()
        return Response(f"Book #{book.id} successfully deleted", status=200)
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                 |
| --------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `methods=["GET", "PUT", "DELETE"]`                  | We must update this endpoint so it accepts `DELETE` requests                                                                                          |
| `book = Book.query.get(book_id)`                    | This feature will need to find our matching `Book` instance, so we still need to use `book`                                                           |
| `elif request.method == "DELETE":`                  | We can add a new conditional branch for `DELETE` requests                                                                                             |
| `db.session.delete(book)`                           | We can use SQLAlchemy's functions to delete our `book` with `db.session.delete(book)`                                                                 |
| `db.session.commit()`                               | We use this function to actually apply our database changes                                                                                           |
| `return Response(...)`                              | This is one of many ways to return an HTTP response                                                                                                   |
| `f"Book #{book.id} successfully deleted"`           | We can still access `book.id` because the variable itself is still in scope in our app, even if the `book` _was_ successfully deleted in the database |

### Manually Testing in Postman

After writing this code, we can use Postman to test our delete functionality.

First, let's make a `GET` request to `/books/1` to confirm that a book with ID 1 exists.

![Screenshot of Postman featuring a request of GET to /books/1 and a response of 200 with book data](../assets/update-and-delete/update-and-delete_delete-get-book.png)

Then, let's make our `DELETE` request to `/books/1` and check the response.

![Screenshot of Postman featuring a request of DELETE to /books/1 and a response of 200 with a success message](../assets/update-and-delete/update-and-delete_delete-request.png)

Afterwards, let's even make a `GET` request to `/books`. We see that there are no more books that exist! Our book was successfully deleted.

![Screenshot of Postman featuring a request of GET to /books and a response of 200 with an empty array](../assets/update-and-delete/update-and-delete_delete-get-books-empty.png)

We could also use `psql` to check this, too.

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: wYm5yT
* title: Update and Delete, Deleting a Book Endpoint
##### !question

Think about the "Deleting a Book Endpoint."

Check off all the topics that we've briefly touched on so far.

##### !end-question
##### !options

* Predicted the HTTP response, request, and logic for this endpoint
* Refactored our `"/books/<book_id>"` endpoint to accept `DELETE` requests
* Used `Book.query.get(book_id)` to get an instance of `Book` matching `book_id`
* Refactored our code to conditionally check the request's method
* Deleted the `book` from the database
* Committed these changes in the database
* Returned a response
* Tested this request in Postman

##### !end-options
##### !answer

* Predicted the HTTP response, request, and logic for this endpoint
* Refactored our `"/books/<book_id>"` endpoint to accept `DELETE` requests
* Used `Book.query.get(book_id)` to get an instance of `Book` matching `book_id`
* Refactored our code to conditionally check the request's method
* Deleted the `book` from the database
* Committed these changes in the database
* Returned a response
* Tested this request in Postman

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: dZYkxW
* title: Update and Delete
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
