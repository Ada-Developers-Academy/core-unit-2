# Query Params

<!-- FLASK UPDATE -->
<!--
<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=e2005f3f-6788-4a6a-9e14-ae6901827faa&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>
-->

## Goals

Our goals for this lesson are to:

- Explore more query functionality made available by Flask-SQLAlchemy
- Define query strings and query parameters
- Implement accessing query parameters within our `hello-books-api` Flask app.

## Branches

| Starting Branch | Ending Branch      |
| --------------- | ------------------ |
| `04c-delete`    | `05a-query-params` |

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined
- `POST` `/books` route defined
- `GET` `/books` route defined
- `GET` `/books/<book_id>` route defined
- `PUT` `/books/<book_id>` route defined
- `DELETE` `/books/<book_id>` route defined
- Invalid <code>book_id</code> and non-existing `book`s handled with `validate_book` helper function

</details>
<br>

## Query Params in URLs

Let's take a moment to recall what we know about the parts of a URL that we call _query parameters_, usually shortened to _query params_. We first encountered query params in our exploration of URLs used in the HTTP request-response cycle. We looked at some small examples of how query params could be used to tweak the behavior of an endpoint, such as by:

- paginating (splitting into pages of particular sizes) results
- limiting the amount of data that comes back
- sorting results

It's up to the developer to decide how to use query params in their project, but it can make it easier for clients to interact with the API if we restrict our use of query params to cases like these.

One or more query params can be added to the end of a URL in a _query string_. For example:

```
https://my-beautiful.site/search?category=novels
```

Everything after the `?` in this URL is the _query string_. In this case, the query string is `category=novels`. The key and value of a query param are separated by `=`.

| Query Param Key | Query Param Value |
| --------------- | ----------------- |
| `category`      | `novels`          |

We can have multiple query param pairs. We separate them by ampersands `&`, like this:

```
https://my-beautiful.site/search?category=novels&page_size=30&page=3
```

| Query Param Key | Query Param Value |
| --------------- | ----------------- |
| `category`      | `novels`          |
| `page_size`     | `50`              |
| `page`          | `3`               |

### !callout-info

## The Supported Query Params and Their Behavior Is Up to Us

The query params given in these URLs are just examples. It would be up to us to decide which query params we choose to support in our API, and what behavior they should trigger. We could choose to support different query params, or none at all, depending on our project needs. Imagine for yourself what the params shown in the examples above could do in a real project.

<br />

Some frameworks might provide built-in support for certain query params, as long as we follow certain conventions expected by that framework. For example, some frameworks might automatically support query params for sorting results if we follow a particular naming convention. Flask does not provide this kind of built-in support, so we will need to write the code to handle query params ourselves.

### !end-callout

### An Aside: URL Encoding and Query Strings

It would be nice if we could use any arbitrary text as a query param, like this:

```
https://my-beautiful.site/search?name=Hand-crafted exclusive: finest tote bag!
```

According to the Internet standard for URLs ([RFC 1738](https://datatracker.ietf.org/doc/html/rfc1738)), some characters, including spaces, colons `:`, or commas `,`, aren't valid in URLs. Other characters, like question marks `?`, equal signs `=`, or ampersands `&`, have special meanings when used in a URL. If we need to use any of these characters as data in our URL, we need to encode them using a process called _URL encoding_, which replaces the invalid characters with valid character combinations.

```
https://my-beautiful.site/search?name=Hand-crafted%20exclusive%3A%20finest%20tote%20bag%21
```

From this example, we can observe:

| Original character | Encoding character |
| ------------------ | ------------------ |
| ` ` (space)        | `%20`              |
| `:`                | `%3A`              |
| `!`                | `%21`              |

### !callout-info

## URL Encoding Uses ASCII Values

While the encoding characters used may seem arbitrary, each is actually the value of the particular character according to the [ASCII](https://en.wikipedia.org/wiki/ASCII) standard, written in the _hexadecimal_ numbering system. The `%` sign in a URL is used to indicate that the following two characters are a hexadecimal number. Because of this special meaning, if we ever needed to include an actual `%` sign in a URL, we would encode it as `%25`, using its own ASCII value!

### !end-callout

If we are using a program like Postman or a web browser to send requests, they will do their best to encode our URLs for us. If we are writing code to contact an endpoint, we may need to encode parts of the URL ourselves, using functionality built into Python.

We will try to avoid characters that require encoding in our URLs and query parameters. However, this knowledge may be helpful when constructing URLs with query strings for testing!

### Query Params in RESTful APIs

HTTP request bodies, route parameters, and query params are all responsible for supplying the data needed for a request, and can all accomplish similar things. The exact difference in usage will always depend on our project, context, and needs.

Since we are learning to build RESTful APIs, some decisions around which HTTP features to use for certain kinds of data are more common than others. Typically:

- HTTP request bodies contain data that should be uploaded to the server to create or update a record
- Route parameters contain data that identifies a particular record
- Query params contain data that customize the behaviors of a route

Earlier, we noted some possible uses for query params:

- paginating results
- limiting the amount of data that comes back
- sorting results

Another common use for query params is to:

- filter results based on certain criteria

Let's take a look at how we can use query params in our Flask app to filter the endpoint results.

## Reading Query Params From a Request

Within Flask, the object that represents the current request, `request`, also provides access to the query params through the `request.args` property. The object it returns is a dictionary-like object (an object that acts very much like a Python `dict`, but which is actually a different type) that we can use to look up the value of a query param by its key. For example:

```python
query_param_value = request.args.get("query_param_key")
```

<!-- prettier-ignore-start -->
| <div style="min-width:250px;"> Piece of Code </div> | Notes |
| - | - |
| `query_param_value =` | A local variable in which we store the looked up value of a query param for later use. |
| `request.args.get(...)` | Inside of a route, we access the query params collection as `request.args`. This dictionary-like object has a `get` method, just like a regular `dict`. The `get` method retrieves the value of a key if the key is present, otherwise returning a default value. If an explicit default is not supplied, `None` is assumed. |
| `"query_param_key"` | The name of the query param to lookup. Query param keys and values are strings (even when they look numeric), so the key name should be a string, or a variable or expression producing a string name. |
<!-- prettier-ignore-end -->

### !callout-warning

## Pro-tip: Check `request` Spelling

The popular package `requests`, used for making HTTP requests, is not the same as the `request` that represents the HTTP request. If we are working on a web API project that also calls external APIs by using the `requests` package, we should be especially careful of whether we have written `request` or `requests`. It's very easy to accept the wrong one from an autosuggest!

### !end-callout

## Finding Books by Title

Consider this feature:

> As a client, I want to send a request to get a list of books, restricted to those with a match in the title, so that I can find a book by a partial title.

### Planning HTTP Requests, Responses

Our result should be a list of books, so we'll start with our usual endpoint to get all records of a particular type. We will use the `GET` verb sent to the `/books` endpoint. But now we'd also like to provide an additional parameter `title` that we can use to filter the results. Since filtering is a customization of the default _get all_ behavior, a query param is a suitable way to pass the title filtering data.

| HTTP Method | Example Endpoint     |
| ----------- | -------------------- |
| `GET`       | `/books?title=apple` |

As usual, we don't supply a request body for `GET` requests, since HTTP `GET` requests are not expected to send them.

Lets assume that our `book` table has at least the following data. (The contents of `id`, and `description` are irrelevant for this feature).

| `title`                         |
| ------------------------------- |
| `10,000 Apples`                 |
| `It's Not Easy Being an Orange` |
| `An Apple a Day`                |

In response to our request, the endpoint should return success for the status code, with a list of the books that contained our `title` parameter. With a `title` value of `apple`, we would get back `10,000 Apples` and `An Apple a Day`, but not `It's Not Easy Being an Orange`. A read request that completes successfully uses `200 OK` for the response status code, and we'll return a JSON response body representing the list of books.

<table>
  <tr>
    <th>Response Status</th>
    <th>Example Response Body</th>
  </tr>
  <tr>
    <td><code>200 OK</code></td>
    <td><pre style="margin:0px;"><code>[
    {
        "id": ..., 
        "title": "10,000 Apples", 
        "description": ...
    }, {
        "id": ...,
        "title": "An Apple a Day", 
        "description": ...
    }
]</code></pre>
    </td>
  </tr>
</table>

### Logic

Now that we have planned out these changes to our endpoint behavior, we can turn our attention to how to implement them.

Our endpoint will need to:

1. Run when receiving a `GET` request to the `/books` endpoint
2. Check whether we have a `title` query param
3. If we have a `title` query param, retrieve all of the books that match from the database, otherwise retrieve all books as usual
4. Format the books data into the appropriate structure (list of dictionaries, where each dictionary has `id`, `title`, and `description`)
5. Send back a response

This plan covers both the case where we should filter by title and the case where we should not. Compared to our existing code, we're adding an additional step to check for the query param and filter the results accordingly, but otherwise, everything should be the same.

### Code

Before we start making changes, let's review the code for our `/books` endpoint.

```python
@books_bp.get("")
def get_all_books():
    query = db.select(Book).order_by(Book.id)
    books = db.session.scalars(query)

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

This endpoint is already registered to run when the server receives a `GET` request to the `/books` endpoint. Recall that the `/books` part comes from the blueprint, so our route path is set to `""`.

The only part of the code related to specifying which books to retrieve is the first line

```python
    query = db.select(Book).order_by(Book.id)
```

which builds a query to get all books ordered by their ID, storing the query (not yet the result of the query) in the `query` variable.

The second line

```python
    books = db.session.scalars(query)
```

executes `query` and stores the results in the `books` variable. The rest of the code formats the results into a list of dictionaries and returns them. So if we add logic to build a different query based on whether the `title` query param is present, the rest of the code should work as before.

The first thing we need to check is whether the `title` query param is present. We can do this by using the `request.args.get()` method to look up the value of the `title` key in the `request.args` object. If the `title` query param is present, we will use it to filter the results of our query. If it is not present, we will get all books as before.

Adding this check into our code looks like this.

```python
@books_bp.get("")
def get_all_books():
    title_param = request.args.get("title")
    if title_param:
        query = ... # code that builds a query to filter by title
    else:
        query = db.select(Book).order_by(Book.id)

    # remaining code as before
```

We check for `title` in the query params. If it's not present, the `get()` call will return `None`, a falsy value. We check whether `title_param` is truthy to decide which branch of the conditional to take. Truthy indicates we got a value for the `title` query param, so we should filter by it. Falsy indicates we did not get a value, so we should get all books as before.

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

### More to Explore with Querying

There's way more to explore in filtering than is covered in this curriculum.
<br>
<br>
More generally speaking, [there's more to explore with querying](https://flask-sqlalchemy.palletsprojects.com/en/2.x/queries/#querying-records)! Follow your curiousity.
<br>
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

* Reviewed query strings and query params
* Planned the HTTP request for filtering by title
* Refactored our code to check for a query param 
* Used `request.args.get("title")` to get the query param
* Used `Book.query.filter_by(title=title_query)` to filter by the query param
* Tested our refactored route
* Considered other query methods

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->
