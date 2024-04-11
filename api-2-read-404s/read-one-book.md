# Read One Book Endpoint

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=781f275a-4b47-454a-a6e1-ae690178b4d2&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Goals

Our goal for this lesson is to learn how to define routes that read a specific data record.

In this lesson we will expand our Hello Books API to fulfill the following feature:

1. As a client, I want to send a request to get one existing book, so that I can see the `id`, `title`, and `description` of the book.

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`01d-read-all-books` |`02a-read-one-book`|

<details>
   <summary>Expand to see the feature <code>Hello Books API</code> should have before this lesson</summary>

The `GET` `/books` route should be defined

</details>
<br>

## Getting a Single Book Endpoint: Preparation

Let's consider how to implement this feature:

> As a client, I want to send a request to get one existing book, so that I can see the `id`, `title`, and `description` of the book.

### Planning HTTP Requests, Responses, and Logic

Once more, we should think about the typical HTTP verbs and endpoints used in RESTful APIs. This time, we're working with a request that retrieves the data for a particular model record. As usual, there are many ways that we _could_ define such a route, but by following common patterns for RESTful APIs, we can make our API more predictable and easier to use.

For this feature, we should therefore make a `GET` request to the `/books` path, and include the `id` of the record to retrieve as part of the endpoint.

| HTTP Method | Endpoint   |Example   |
| ----------- | ---------- |---------- |
| `GET`       | `/books/<book_id>` |`/books/1` |

`GET` requests do not include a request body, so no additional planning around the request body is needed.

We want to send back a single JSON object (dictionary) with `id`, `title`, and `description`:

| Response Status | Response Body                                                                                            |
| --------------- | -------------------------------------------------------------------------------------------------------- |
| `200 OK`        | `{"id": 1, "title": "Fictional Book Title", "description": "A fantasy novel set in an imaginary world"}` |

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Read the `book_id` in the request path
2. Retrieve the book with the matching `book_id` from the database
3. Format the book data into the appropriate structure (a single dictionary with `id`, `title`, and `description`)
4. Send back a response

## Getting a Single Book Endpoint: Code

Our new route needs to read data from the incoming request path. Our existing route doesn't do this, so we'll need to add an entirely new route to our existing `Blueprint`.

Our new route needs a **route parameter**. The route `/books/1` should give us the details for the book with `id` 1. `/books/2` should give us details for book with `id` 2, `/books/3000` should give us details for book 3000, and so on.

Let's take a look at how our new route will account for this!

```python
# No new import statements...

# No modifications to the other route...

@books_bp.route("/<book_id>", methods=["GET"])
def handle_book(book_id):
    book_id = int(book_id)
    for book in books:
        if book.id == book_id:
            return {
                "id": book.id,
                "title": book.title,
                "description": book.description
            }
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                                                                                                                                                                                              |
| --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `@books_bp.route("...", methods=["GET"])`           | We are setting up a new route, so we must use the `Blueprint` decorator to define it                                                                                                                                                                                                                                                                                               |
| `"/<book_id>"`                                      | This is the `Blueprint` syntax to indicate _route parameters_. The `<book_id>` placeholder shows that we are looking for a variable value (could be `1`, `2`, or `3000`). We'll use this value in the function as the variable `book_id`, so we should use a good, descriptive name.                                                                                               |
| `def handle_book(book_id):`                                | This `handle_book` function is called whenever the HTTP request matches the decorator. The name of this function should follow the previously discussed guidelines. We must add a parameter to this method, `book_id`. This parameter name must match the route parameter in the decorator. It will receive the part of the request path that lines up with the placeholder in the route. |
|`book_id = int(book_id)` | We must convert the `book_id` from the url from a string to an int. |
| `for book_data in books...`                               | Iterate through the list of book dictionaries, and find the book dictionary with the `id` equal to `book_id`. |
| `return { "id": book.id, ... }`                            | We can create a dictionary literal for our HTTP response. As always, we must return a response. Flask will default to returning status `200 OK`.                                                                                                                                                                                                                                                                                                                          |

### !callout-warning

## Python Doesn't Know What a `book_id` Is

We named the route parameter `book_id` because we expect it to be an id of a book. But just like regular variable names, Python has no idea what a `book_id` is. All it does is look for whatever part of the URL path follows `/books/` and captures that into the variable `book_id`. A request for `/books/360` would set the value of `book_id` to be `"360"`. A request for `/books/tacocat` would set the value of `book_id` to be `"tacocat"`!

<br />

We should be careful to avoid thinking that Python uses the name of the parameter to do any kind of validation. As usual, the name provides information to us developers, not to Python.

### !end-callout

### !callout-info

## Why Didn't We Call `jsonify()` on the Dictionary?

For reasons that are less important to memorize, Flask will automatically convert a dictionary into an HTTP response body. If we don't want to remember this exception, we can call `jsonify()` with the dictionary as an argument to return the result.

### !end-callout

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: 227efe7d-4177-4a2f-aac8-de188d17f62e
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
* Iterated through `books` to get an instance of `Book` matching `book_id`
* Returned a dictionary literal as our response

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->
