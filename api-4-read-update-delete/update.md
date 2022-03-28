# Update

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=9a0d6a0c-1927-44b7-944b-ad1d01798fed&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goals
Our goals for this lesson are to:
- Practice defining routes that modify data in an API
- Modify a database record from the back-end layer

We will build our Hello Books API to fulfill the following feature:

1. As a client, I want to send a request with valid book data to update one existing book and get a success response, so that I know the API updated the book data.

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`04a-read-one-book` |`04b-udpate`|

## Updating a Book Endpoint: Planning HTTP Requests, Responses, and Logic

As we did for our create and read endpoints, we should think about the typical HTTP verb and endpoint used to replace the data for a particular model record.

For this feature, we should make a `PUT` request to the `/books` path. We also need to include the `id` of the record to replace as part of the endpoint, as we did when _reading_ a particular record.

| HTTP Method | Endpoint   |
| ----------- | ---------- |
| `PUT`       | `/books/1` |

We are replacing the data associated with the specified record. As a result, the request body will consist of a JSON document with all the same fields as were required to create the resource in the first place. For our `Book` model, an example request body would be:

```json
{
  "title": "Updated Fictional Book Title",
  "description": "This fantasy novel has robots and pirates, too."
}
```

This assumes that there is a `book` table with at least the following row:

| <div style="min-width:40px;">`id`</div> | `title`                | `description`                               |
| ---- | ---------------------- | ------------------------------------------- |
| `1`  | `Fictional Book Title` | `A fantasy novel set in an imaginary world` |

When the record is successfully updated, we should return the appropriate status code, which is `200 OK`. As with other endpoints, we may choose our response body from a variety of possibilities, but for simplicity, we will return a brief status message.

| Response Status | Response Body                  |
| --------------- | ------------------------------ |
| `200 OK`        | `Book #1 successfully updated` |

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Read the `book_id` in the request path
1. Retrieve the `Book` instance with the matching `book_id` from the database
1. Read the new, updated book data from the HTTP request
1. Update the instance of `Book` with the new data
1. Save the updated `Book` in the database
1. Send back a response

## Updating a Book Endpoint: Code

This endpoint uses the same path as our existing route for reading a `Book` record, `"/<book_id>"`. We could refactor and expand on this same function. However, just as we did with `create` and `read` for the `/books` route, we'll create a seperate route function fo the update functionality. 

```python
@books_bp.route("/<book_id>", methods=["PUT"])
def update_book(book_id):
    book = validate_book(book_id)

    request_body = request.get_json()

    book.title = request_body["title"]
    book.description = request_body["description"]

    db.session.commit()

    return make_response(f"Book #{book.id} successfully updated")
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                      |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `methods=["PUT"]`                            | This route's matching methods now need to handle `PUT` requests                                                              |
| `book = validate_book(book_id)`                    | The update feature can also use the `validate_book` helper method for error handling                                                                     |
| `... = request.get_json()`                          | This endpoint relies on reading the HTTP request body. We'll use `request.get_json()` to parse the JSON body into a Python dictionary. |
| `request_body`                                         | A local variable to hold the body of the HTTP request.                                                                                                 |
| `book.title = form_data["title"]`                   | We'll use our OOP skills to update `book`'s `title` attribute                                                                              |
| `book.description = ...`                            | We'll use our OOP skills to update `book`'s `description` attribute                                                                        |
| `db.session.commit()`                               | Every time a SQLAlchemy model has been updated, and we want to commit the change to the database, we'll execute `db.session.commit()`.     |
| `return make_response( ... )`                            | This is one of many ways we can return our appropriate HTTP response. Since we didn't supply a status code, Flask will default to `200 OK`.                                                                      |

### Manually Testing with Postman

We can use Postman to check our update functionality.

It may help to first make a request to `GET /books/1` before updating it.

![Screenshot of Postman featuring a request of GET /books/1 and a response of 200 with book data](../assets/api-4-read-update-delete/api-4-read-update-delete_update-precheck-get.png)

Then, make a request to `PUT /books/1` with our proper JSON request body.

![Screenshot of Postman featuring a request of PUT /books/1 and a response of 200 with a success message](../assets/api-4-read-update-delete/api-4-read-update-delete_update-request.png)

We can send another request to `GET /books/1` to confirm the updates worked.

![Screenshot of Postman featuring a request of GET /books/1 and a response updated book data](../assets/api-4-read-update-delete/api-4-read-update-delete_update-confirm-get.png)

We should also verify the error handling from the `validate_error` helper function behaves as expected for invalid `book_id` and non-existing `book`s.

### Manually Testing with `psql`

We can also check if our book was updated in the database using `psql`, just as we did when creating new records!

Let's try it out on our own! We can refer back to the Intro to SQL lessons if we need a reminder about how to write a query like this.

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: pe3GBP
* title: Update and Delete, Updating a Book Endpoint
##### !question

Think about the "Updating a Book Endpoint."

Check off all the topics that we've briefly touched on so far.

##### !end-question
##### !options

* Planned the HTTP response, request, and logic for this endpoint
* Refactored our `"/books/<book_id>"` endpoint to accept `PUT` requests
* Used `Book.query.get(book_id)` to get an instance of `Book` matching `book_id`
* Refactored our code to conditionally check the request's method
* Read the HTTP request body using `request.get_json()`
* Updated the instance of `Book` in the database
* Returned a response
* Tested this request in Postman
* Verified invalid `book_id`s and non-existing `book`s are handled

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->