# Query Params

## Goals

Our goal for this lesson is to expand our skills. We will practice handling more kinds HTTP requests.

We should walk away from this lesson understanding:

- What are query strings and query parameters
- How to access query parameters within our Flask app

## Hello Books API

### Before This Lesson

This lesson uses the Hello Books API.

<details style="max-width: 700px; margin: auto;">
    <summary>
        Before beginning this lesson, the Hello Books API should have the following.
    </summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined

Endpoints defined for these RESTful routes. They handle missing books:

- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`

</details>

## Contextualizing Query Strings

A query string is a part of an HTTP request URL that contains query params. Recall that query params are key-value pairs which extend an HTTP request. For example:

```
https://my-beautiful.site/search?category=novels
```

Everything after the `?` in this string defines a _query string_. In this case, the query string is `category=novels`. The key and value of a query param is separated by `=`.

| Query Param Key | Query Param Value |
| --------------- | ----------------- |
| `category`      | `novels`          |

There can be multiple query param pairs. They are comma-separated. Here's an example:

```
https://my-beautiful.site/search?category=novels&minimum_pages=800&maximum_pages=8000
```

| Query Param Key | Query Param Value |
| --------------- | ----------------- |
| `category`      | `novels`          |
| `minimum_pages` | `800`             |
| `maximum_pages` | `8000`            |

### An Aside: URL Encoding and Query Strings

It would be nice if valid query strings and valid query params could always be straightforward strings.

```
https://my-beautiful.site/search?name=Hand-crafted exclusive: finest tote bag!
```

However, some characters aren't handled very well in URLs, such as spaces, colons, commas, and so on. These characters need to be encoded into a valid URL format, which replaces them.

```
https://my-beautiful.site/search?name=Hand-crafted%20exclusive%3A%20finest%20tote%20bag%21
```

From this example, we can observe:

| Original character | Encoding character |
| ------------------ | ------------------ |
| ` ` (space)        | `%20`              |
| `:`                | `%3A`              |
| `!`                | `%21`              |

Often, the work of encoding happens _through the client_, not through the server. However, this knowledge may be helpful when constructing URLs with query strings for testing!

### Typical Use Cases

Query params provide extra information to an HTTP request.

HTTP response bodies and query params are both responsible for adding data to a request, and can both accomplish similar things. The exact difference in usage will always depend on your project, context, and needs.

However, typically:

- HTTP response bodies contain data that should be uploaded to the server
- Query params contain data that describe the nature of the request

We may often see query params used for:

- Sorting and filtering search results
- Limiting the amount of data that comes back

## Reading Query Params From a Request

Within Flask, we can get the value from any query param using the `request.args` object.

```python
query_param_value = request.args.get(query_param_key)
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                  |
| --------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `query_param_value =`                               | We can make a local variable to represent the value of the param                       |
| `request.args.get(...)`                             | Inside of a route, we can access the value of a query param using this method          |
| `query_param_key`                                   | We should put in the query param key here, either as a variable or as a string literal |

### !callout-warning

## Pro-tip: Check `request` Spelling

The popular package `requests`, used for making HTTP requests, is not the same as the `request` that represents the HTTP request.

### !end-callout

## Using Query Params

How we use query params now depends on our project needs, and using whatever Python strategies we need!

## Finding Books by Title: Preparation

Consider this feature:

> As a client, I want to send a request trying to get a list of books with a matching title, so I know which books have a matching title.

### Predict HTTP Requests, Responses, and Logic

Let's consider the endpoint to get a single book:

| HTTP Method | Endpoint              |
| ----------- | --------------------- |
| `GET`       | `/books?title=Apples` |

No request body.

This assumes that there is at least a `book` table with the following rows. (The contents of `id`, `description`, and `completed_at` are irrelevant for this feature).

| `title`   |
| --------- |
| `Apples`  |
| `Oranges` |

The response we want to send back is:

| Response Status | Response Body                                            |
| --------------- | -------------------------------------------------------- |
| `200 OK`        | `[{"id": ..., "title": "Apples", "description": "..."}]` |

During this method, we will need to:

1. Check if the HTTP method is `GET`
1. Check if we have a query param for `title`
1. If we have a `title` query param, retrieve all of the books from the db that match
1. Format the books data into the appropriate structure (list of dictionaries, where each dictionary has `id`, `title`, and `description`)
1. Send back a response

## Finding Books by Title: Pseudocode

For this feature, we must return to our `GET` `"/books"` endpoint and re-work it.

Let's look at this example pseudocode for one strategy:

```python
@books_bp.route("", methods=["GET", "POST"])
def books():
    if request.method == "GET":
        # Check if the query param "title" exists
        # by using request.args.get("title")
            # Query the db for all matching books
            # Create a response
            # Return it
        # Else if the query param "title" does not exist
            # Query the db for all books...
            # Create a response...
            # Return it...
    # ... no other changes
```

### Manually Testing in Postman

We can use Postman to manually test our database.

We can compare our original feature which gets all books, to filtering by title.

```
GET localhost:5000/books
GET localhost:5000/books?title=Apples
```

Our actual results will vary, depending on the contents of our databases. For example, if we've never created a `Book` with the title "Apple," then we'll never be able to retrieve that record!

Different records on different databases will change our tests and results.

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: K84OQh
* title: Query Params
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
