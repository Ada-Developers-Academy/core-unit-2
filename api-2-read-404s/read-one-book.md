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

| HTTP Method | Endpoint   | Example   |
| ----------- | ---------- | ---------- |
| `GET`       | `/books/<book_id>` | `/books/1` |

### !callout-info

## Placeholder Syntax in Documentation Can Vary

Notice that in the endpoint example shown above, we used the syntax `<book_id>` to indicate a placeholder for the actual ID of the book that we want to retrieve. This syntax was chosen intentionally, as we'll see in just a moment when we implement the route. Another common method of seeing placeholders indicated in route documentation is with a colon, like `/books/:book_id`.

### !end-callout

`GET` requests do not include a request body, so no additional planning around the request body is needed.

For the response, our feature asks that we send back information about a single book, made up of three pieces of data. We can express this as a single JSON object (roughly equivalent to a Python `dict`) with `id`, `title`, and `description` keys, sent in the response body. To indicate that we are successfully responding to a request for data, the response status should be `200 OK`.

| Response Status | Response Body                                                                                            |
| --------------- | -------------------------------------------------------------------------------------------------------- |
| `200 OK`        | `{"id": 1, "title": "Fictional Book Title", "description": "A fantasy novel set in an imaginary world"}` |

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Read the `book_id` from the request path
2. Retrieve the book object with the matching `book_id` from the "database" (currently our list of books)
3. Convert the book object so that it can be sent back through Flask with the appropriate structure (a single dictionary with `id`, `title`, and `description` keys)
4. Send back the response

## Getting a Single Book Endpoint: Code

Our new route needs to read data from the incoming request path. Our existing route doesn't do this, so we'll need to add an entirely new route to our existing `Blueprint`.

Our new route needs a **route parameter**. The route `/books/1` should give us the details for the book with `id` 1. `/books/2` should give us details for book with `id` 2, `/books/3000` should give us details for book 3000, and so on.

Let's take a look at how our new route will account for this!

```python
# No new import statements...

# No modifications to the other route...

@books_bp.get("/<book_id>")
def get_one_book(book_id):
    book_id = int(book_id)
    for book in books:
        if book.id == book_id:
            return {
                "id": book.id,
                "title": book.title,
                "description": book.description,
            }
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                                                                                                                                                                                              |
| --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `@books_bp.get("...")`           | We are setting up a new GET route, so we must use the `get` method on our `books_bp` `Blueprint` decorator to define it. Remember that any routes we register on this `Blueprint` will automatically begin with the path we set as its `url_prefix`. In this case, we previously used the value `"/books"`                                                                                                                                                                                                                                                                                          |
| `"/<book_id>"`                                      | This is the `Blueprint` path syntax to indicate _route parameters_. Flask won't literally look for `/<book_id>` in the path. Instead, it will treat the `<book_id>` as a placeholder that will receive the value of whatever follows `/books/`. As described in the note below, we'll need to be a little careful of how we use this value. Flask uses the name of the placeholder to pass the value into our route function _by name_ as a keyword argument. So the name we use here should be descriptive, and must match the parameter name we use to receive the value in our route function.                                                                                               |
| `def get_one_book(`&#8203;`book_id):`                                | This `get_one_book` function is called whenever an HTTP request matches its route decorator. The name of the function should describe the purpose of the route, but otherwise has no real requirements. Because our route includes a route parameter, we must include a function parameter in this method to receive the matched value, and its name must be the same as the route parameter placeholder name. Since we used `book_id` as our placeholder, the function parameter must also be called `book_id`. |
|`book_id = int(book_id)` | We must convert the `book_id` matched in the URL from a string to an int. Otherwise, it won't be possible for it to compare equal to any of our book's ID values, since they are stored as integers. URLs are strings, and any placeholder value will also be a string by default. There are ways to hint at the expected type for a placeholder that you may wish to investigate on your own. |
| `for book_data in books:`                               | Iterate through the list of book objects so that we can find the book whose `id` is equal to the value of `book_id`. |
| `return { "id": book.id, ... }`                            | Create a dictionary literal for our HTTP response, setting the keys appropriately. Flask knows how to convert dictionaries to JSON in the response, but not instances of the original `Book` type. `return` this dictionary back to Flask. Flask will default to reporting status `200 OK`.                                                                                                                                                                                                                                                                                                                          |

### !callout-warning

## Python Doesn't Know What a `book_id` Is

We named the route parameter `book_id` because we expect it to be an ID of a book. But just like regular variable names, Python has no idea what a `book_id` is. All it does is look for whatever part of the URL path follows `/books/` and captures that into the variable `book_id`. A request for `/books/360` would set the value of `book_id` to be `"360"`. A request for `/books/tacocat` would set the value of `book_id` to be `"tacocat"`!

<br />

We should be careful to avoid thinking that Python uses the name of the parameter to do any kind of validation. The name provides information to us developers, not to Python. Flask does provide a way to specify a [converter](https://flask.palletsprojects.com/en/3.0.x/api/#url-route-registrations) for route parameters that can help with validation, but we won't cover that in this curriculum.

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
