# Query Params

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=d7e5be9b-e964-4f23-b690-ad1b000294a1&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goals

Our goals for this lesson are to:

- Explore more query functionality made available by Flask-SQLAlchemy
- What are query strings and query parameters
- How to access query parameters within our Flask app


## Branches

| Starting Branch | Ending Branch|
|--|--|
|`04c-delete` |`05a-query-params`|

## Contextualizing Query Strings

A query string is a part of an HTTP request URL that contains query params. Recall that query params are key-value pairs which extend an HTTP request. For example:

```
https://my-beautiful.site/search?category=novels
```

Everything after the `?` in this string defines a _query string_. In this case, the query string is `category=novels`. The key and value of a query param is separated by `=`.

| Query Param Key | Query Param Value |
| --------------- | ----------------- |
| `category`      | `novels`          |

We can have multiple query param pairs. We separate them by ampersands `&`, like this:

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

However, some characters, like spaces, colons `:`, or commas `,`, aren't valid in URLs. Other characters, like question marks `?`, equal signs `=`, or ampersands `&`, can be used in URLs, but have special meanings. If we want to use any of these characters as data in our URL, we need to encode them using a process called _URL encoding_, which replaces the invalid characters with valid character combinations.

```
https://my-beautiful.site/search?name=Hand-crafted%20exclusive%3A%20finest%20tote%20bag%21
```

From this example, we can observe:

| Original character | Encoding character |
| ------------------ | ------------------ |
| ` ` (space)        | `%20`              |
| `:`                | `%3A`              |
| `!`                | `%21`              |

If we are using a program like Postman or a web browser to send requests, they will do their best to encode our URLs for us. If we are writing code to contact an endpoint, we may need to encode parts of the URL ourselves, using functionality built into Python.

We will try to avoid characters that require encoding in our URLs and query parameters. However, this knowledge may be helpful when constructing URLs with query strings for testing!

### Typical Use Cases

Query params provide extra information to an HTTP request.

HTTP request bodies, route parameters, and query params are all responsible for adding data to a request, and can accomplish similar things. The exact difference in usage will always depend on your project, context, and needs.

In the style of web API we are building, typically:

- HTTP request bodies contain data that should be uploaded to the server
- Route parameters contain data that identifies a particular record
- Query params contain data that select customized behaviors

Common uses for query params include:

- Sorting and filtering search results
- Limiting the amount of data that comes back

## Reading Query Params From a Request

Within Flask, we can get the value from any query param using the `request.args` object.

```python
query_param_value = request.args.get(query_param_key)
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                  |
| --------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `query_param_value =`                               | A local variable in which we store the looked up value of a query param for later use  |
| `request.args.get(...)`                             | Inside of a route, we can access the value of a query param using this method          |
| `query_param_key`                                   | We should put in the query param key here, either as a variable or as a string literal |

### !callout-warning

## Pro-tip: Check `request` Spelling

The popular package `requests`, used for making HTTP requests, is not the same as the `request` that represents the HTTP request. If we are working on a web API project that also calls external APIs by using the `requests` package, we should be especially careful of whether we have written `request` or `requests`!

### !end-callout

## Using Query Params

The way we choose to use query params will depend on our project needs.

## Finding Books by Title: Preparation

Consider this feature:

> As a client, I want to send a request trying to get a list of books with a matching title, so I know which books have a matching title.

### Planning HTTP Requests, Responses, and Logic

We want to get a list of book results, so the base of our endpoint will look like our usual endpoint to get all records of a particular type. We will use the `GET` verb sent to the `/books` endpoint. But now we'd also like to provide an additional parameter `title` that we can use to filter the results. Since filtering is a customization of the default _get all_ behavior, we can decide to express that as a query param.

| HTTP Method | Example Endpoint      |
| ----------- | --------------------- |
| `GET`       | `/books?title=Apples` |

As usual, we don't need a request body for `GET` requests.

This assumes that there is a `book` table with at least the following rows. (The contents of `id`, and `description` are irrelevant for this feature).

| `title`   |
| --------- |
| `Apples`  |
| `Oranges` |

In response to the request we've discussed, we want the endpoint to return success for the status code, and a list of the books with a matching title. We can use `200 OK` for the response status code, and a JSON response body representing a list of books.

| Response Status | Response Body                                            |
| --------------- | -------------------------------------------------------- |
| `200 OK`        | `[{"id": ..., "title": "Apples", "description": "..."}]` |

Now that we have planned out these changes to our endpoint behavior, we can turn our attention to how to implement them.

Our endpoint will need to:

1. Check if the HTTP method is `GET`
1. Check if we have a query param for `title`
1. If we have a `title` query param, retrieve all of the books from the database that match, otherwise retrieve all books as usual
1. Format the books data into the appropriate structure (list of dictionaries, where each dictionary has `id`, `title`, and `description`)
1. Send back a response

## Finding Books by Title: Code

This endpoint uses the same path as our existing `/books` route that lists books. Recall that the `"/books"` part comes from the blueprint, so our route path is set to `""`.

We can use the method [`filter_by`](https://flask-sqlalchemy.palletsprojects.com/en/2.x/queries/#querying-records) in order to filter our search query.

Consider this example that filters `Book`s by title.

```python
Book.query.filter_by(title="Fictional Book Title")
```

Let's modify our endpoint code to filter the results when a title query param is supplied.

```python
@books_bp.route("", methods=["GET"])
def read_all_books():

    # this code replaces the previous query all code
    title_query = request.args.get("title")
    if title_query:
        books = Book.query.filter_by(title=title_query)
    else:
        books = Book.query.all()
    # end of the new code

    books_response = []
    for book in books:
        books_response.append({
            "id": book.id,
            "title": book.title,
            "description": book.description
        })

    return jsonify(books_response)
```

| <div style="min-width:270px;"> Piece of Code </div> | Notes                                                                                                                                                           |
| --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `title_query = ...`                                 | Store the result of looking for the `title` query param in the variable `title_query`                                                                           |
| `... = request.args.get("title")`                   | Try to get a query param called `title` from the `request`. This returns the value of the query param if it was set, or `None` if the query param is not found. |
| `if title_query:`                                   | Decide which conditional branch to take by checking whether we got a query param with which to filter                                                           |
| `books = ...`                                       | Store the results of our query in the `books` variable.                                                                                                         |
| `... = Book.query.filter_by( ... )`                 | If we got a query param, we will make a `filter_by` call to filter the results.                                                                                 |
| `title=title_query`                                 | Filter the book query results to those whose titles match the query param                                                                                       |
| `... = Book.query.all()`                            | If we didn't get a query param, get all the books as before.                                                                                                    |

The remainder of the code is the same as it was previously.

To summarize, we looked up whether the `title` query param was provided. We used that to decide which query we should run, and we stored the result in `books`. Then we converted `books` into JSON as before and returned the result.

### Manually Testing in Postman

We can use the Browser and/or Postman to manually test our database.

We can compare our original feature which gets all books, to filtering by title.

```
GET localhost:5000/books
GET localhost:5000/books?title=Apples
```

Our actual results will vary, depending on the contents of our databases. For example, if we haven't created any `Book`s with the title "Apple," then the second test will always return an empty list!

We should practice trying to predict the results of a test before running it to check our understanding. But we must take into account what records exist in our database, since this will affect our tests and results.

### !callout-info

### More to Explore with Filtering

There's way more to explore in filtering than is covered in this curriculum, so drive your own learning!

### !end-callout

### !callout-info

### More to Explore with Querying

[There's more to explore with querying](https://flask-sqlalchemy.palletsprojects.com/en/2.x/queries/#querying-records)! Follow your curiousity.
<br>
Here's one more query method to consider. This is the syntax for limiting the number of `Book` records:

```python
Book.query.limit(100).all()
```

### !end-callout

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: 14ef34fa
* title: Query Params
##### !question

Think about Query Params and Filtering Books by Title.

Check off all the topics that we've briefly touched on so far.

##### !end-question
##### !options

* Reviewed query strings
* Planned the HTTP request
* Refactored our code to check for a query param 
* Used `request.args.get("title")` to get the query param
* Used `Book.query.filter_by(title=title_query)` to filter by the query param
* Tested our refactored route
* Considered other query methods

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->
