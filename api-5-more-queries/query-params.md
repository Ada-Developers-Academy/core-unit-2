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

How can we build a query that filters by partial title? From our endpoint that retrieves a single book, we've seen that we can use the `where()` method to restrict the results of a query to a matching value. What if we take a similar approach here?

```python
    if title_param:
        query = db.select(Book).where(Book.title == title_param).order_by(Book.id)
```

But if we try to send a request looking for `apple` in the title, `GET` `/books?title=apple`, we won't get any results. This is because the `==` operator is looking for an exact match, and none of our titles are exactly `apple`. We need to keep looking for a way to match a partial title.

If we know what we're trying to do, but not how, we can try searching for the answer. We can try searching for something like `SQLAlchemy filter by partial string` and see what we find. Among the results, we might learn that we can use the [`like()`](https://docs.sqlalchemy.org/en/20/core/sqlelement.html#sqlalchemy.sql.expression.ColumnElement.like) method to filter by a partial string. We might also encounter results describing the [`contains()`](https://docs.sqlalchemy.org/en/20/core/sqlelement.html#sqlalchemy.sql.expression.ColumnElement.contains) method, which works similarly. We'll stick with `like()`, because it resembles a standard operator in SQL called [`LIKE`](https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-LIKE), which is commonly used for this purpose.

SQLAlchemy assumes that developers using it have some familiarity with SQL, so it provides methods that are similar to SQL operators. The more we practice SQL in general, the better we'll be able to ask questions about how to use SQLAlchemy.

IN SQL, the query we're trying to write would resemble:

```sql
SELECT * FROM book WHERE title LIKE '%apple%' ORDER BY id;
```

In the pattern given to the `LIKE` operator, `%` is a wildcard character that matches any number of characters. So the pattern `%apple%` will match any title that contains `apple` anywhere in the title.

We can build an equivalent query using SqlAlchemy with the following code:

```python
    if title_param:
        query = db.select(Book).where(Book.title.like(f"%{title_param}%")).order_by(Book.id)
```

We can almost read this code as a plain English sentence! We want to select the books, where the title of the book is like the title parameter, and we want to order the results by the book's ID. Breaking it down, the code that builds our query has the following parts.

<!-- prettier-ignore-start -->
| <div style="min-width:250px;"> Piece of Code </div> | Notes |
| - | - |
| `db.select(Book)` | Start by creating a `Select` object on the `book` table (where `Book` instances live) with no further restrictions. If we ran this object, we would get back all books in whatever order the table happened to store them. |
| `.where(...)` | Calls the `.where()` method on the previous `Select` object (the one returned by `db.select()`), returning a new `Select` object with the conditions in the `where` applied. If we ran this object, we would get back all books matching the conditions in whatever order the table happened to store them. |
| `Book.title.like(...)` | Specifies that we are using the `title` column of the `Book` model in the condition. Specifically, we want to look for records whose `title` is `like()` the supplied pattern. |
| `f"%{title_param}%"` | Use an f-string to specify the pattern, placing the supplied `title_param` between `%%` so that anything is allowed before the `title_param`, and anything is allowed after it. The result is we look for the `title_param` anywhere in the title of each book. |
| `.order_by(Book.id)` | Calls the `order_by()` method on the previous `Select` object (now the one returned by `where()`), returning a new `Select` object with the ordering criteria applied. If we ran this object, we would get back all books matching the `.where()` conditions, ordered by their `id`. |
<!-- prettier-ignore-end -->

Running this code (or the previous SQL query) gives us... Nothing?

It turns out, `LIKE`, `like()`, and even the `contains()` method we didn't look at, are case-sensitive. If we're looking for `apple`, but the title is `Apple`, we won't get a match. Fortunately, PostgreSQL provides the `ILIKE` operator, which is case-insensitive. We can use this operator in SQLAlchemy by calling the [`ilike()`](https://docs.sqlalchemy.org/en/20/core/sqlelement.html#sqlalchemy.sql.expression.ColumnElement.ilike) method instead of `like()`.

```python
    if title_param:
        query = db.select(Book).where(Book.title.ilike(f"%{title_param}%")).order_by(Book.id)
```

### Manually Testing in Postman

We can use the Browser and/or Postman to manually test our endpoint.

We can compare our original feature which gets all books, to filtering by title.

```
GET localhost:5000/books
GET localhost:5000/books?title=apple
```

Our actual results will vary, depending on the contents of our databases. The first request will return all the books in our database. For the second, if we haven't created any `Book`s with "apple" in the title, then it will return an empty list! But if we add the books mentioned earlier, we should get back at least two books: `10,000 Apples` and `An Apple a Day`.

We should practice trying to predict the results of a test before running it to check our understanding. But we must take into account what records exist in our database, since this will affect our tests and results.

## Extending Our Filters: Filter by Description

Consider this feature:

> As a client, I want to send a request to get a list of books, restricted to those with a match in the description, so that I can find a book by a partial description. I should be able to combine the effects of filtering by the title and description in order to filter results by multiple properties at once.

### Planning HTTP Requests, Responses

We can extend our existing `/books` endpoint to filter by description in a similar way to how we filtered by title. We'll add a `description` query param to the endpoint, and use it to filter the results by the description of the book.

| HTTP Method | Example Endpoint            |
| ----------- | --------------------------- |
| `GET`       | `/books?description=orange` |

As before, this request takes no request body.

Let's add some descriptions to our previous sample books.

<!-- prettier-ignore-start -->
| `title`  | `description` |
| - | - |
| `10,000 Apples` | `When all you need is an orange... Now isn't that ironic? Don't you think?` |
| `It's Not Easy Being an Orange` | `Limes and apples aren't the only ones with problems, you know!` |
| `An Apple a Day` | `When Shay fell for a doctor, would a love of apples spell disaster for their happiness?` |
<!-- prettier-ignore-end -->

In response to our request, the endpoint should return success for the status code, with a list of the books that matches the filters. With a `description` value of `apple`, we'd get back the books `It's Not Easy Being an Orange` and `An Apple a Day`, but not `10,000 Apples`. If we also filter the `title` with a value of `apple`, we should get back only `An Apple a Day`. We'll still return `200 OK` for a successful response status code, and the JSON response body will be provided by the list of books.

Refer to the title filtering example to review the response body structure.

### Logic

It's tempting to follow a pattern similar to the title filtering, but as the number of filters we want to check increases, our code would become more and more complex. Right now, or logic is structured like this:

1. If we have a `title` query param, filter by title
2. Otherwise, get all books

If we add a `description` query param, we would need to add another conditional branch to check for the `description` query param. But because we want to filter by both title and description, we would need to consider all possible combinations of the presence of the `title` and `description` query params. This would lead to four branches in our conditional.

1. If we have a `title` query param and a `description` query param, filter by both
2. If we have a `title` query param but not a `description` query param, filter by title
3. If we have a `description` query param but not a `title` query param, filter by description
4. If we have neither a `title` query param nor a `description` query param, get all books

If we had another filter (maybe the year published) we would need to consider eight branches, because there are 8 possible ways to turn on or off 3 filters. Add an author filter and we're up to sixteen branches. Our code is growing exponentially! This is not a sustainable way to write code!

What would be great is if there were a way to build up a query in parts, adding conditions as we need them, and then executing the query at the end. This way, we could build a query that filters by title, then add a condition to filter by description, and then execute the query to get the results. Then our logical steps would look like this:

1. Start with a query to get all books
2. If we have a `title` query param, add a condition to filter by title
3. If we have a `description` query param, add a condition to filter by description
4. Execute the query to get the results

If both the `title` and `description` query params are present, we would filter by both. If only one is present, we would filter by that one. If neither is present, we would get all books. This is a much more manageable way to structure our code, and SqlAlchemy provides a way to do this!

### Code

Here's the conditional code that we wrote for the title filtering:

```python
    title_param = request.args.get("title")
    if title_param:
        query = db.select(Book).where(Book.title.ilike(f"%{title_param}%")).order_by(Book.id)
    else:
        query = db.select(Book).order_by(Book.id)
```

Let's reorganize this code to follow the new structure we've outlined.

```python
    query = db.select(Book)

    title_param = request.args.get("title")
    if title_param:
        query = query.where(Book.title.ilike(f"%{title_param}%"))

    query = query.order_by(Book.id)
```

<!-- prettier-ignore-start -->
| <div style="min-width:250px;"> Piece of Code </div> | Notes |
| - | - |
| `query = db.select(Book)` | Start by creating a `Select` object on the `book` table. |
| `if title_param:` | Only run the block code if a title filter was supplied. |
| `query = query.where(...)` | Calls the `.where()` method on the previous `Select` object (the one returned by `db.select()`), returning a new `Select` object with the conditions in the `where` applied. Update the `query` variable to refer to this new, restricted query. If the title filter was not supplied, this code would not run, and `query` would still refer to the unrestricted `Select` object from `db.select(Book)`. |
| `query = query.order_by(Book.id)` | Whichever query the `query` variable refers to (the unrestricted `Book` query, or the updated query that includes the title filter), update it to order the results by the book IDs. |
<!-- prettier-ignore-end -->

Basically, we pealed off the shared part at the start of both queries, added a condition to filter by title if the `title` query param is present, and then ordered the results by the book's ID. This code is equivalent to the previous code, but it's structured in a way that will make it easier to add more filters in the future.

Let's add the description filter in a similar way. Try adding it yourself before clicking below to reveal one approach.

<br />

<details>
   <summary>Click to reveal the code after adding filtering by description</summary>

```python
    query = db.select(Book)

    title_param = request.args.get("title")
    if title_param:
        query = query.where(Book.title.ilike(f"%{title_param}%"))

    description_param = request.args.get("description")
    if description_param:
        query = query.where(Book.description.ilike(f"%{description_param}%"))

    query = query.order_by(Book.id)
```

There's one slight difference between this code and the version in GitHub. Here, we explicitly updated the query stored in the `query` variable with the order clause. In the version in GitHub, the `order_by()` method is called on the `query` object on the same line that executes the query.

Compare

```python
    query = query.order_by(Book.id)
    books = db.session.scalars(query)
```

with

```python
    books = db.session.scalars(query.order_by(Book.id))
```

Both approaches are equivalent, so we can use either depending on how much emphasis we want to place of the ordering clause. The GitHub version also includes comments capturing the intermediate approaches we tried earlier when filtering by title.

</details>

### Manually Testing in Postman

Let's test out our endpoint either using the Browser or Postman.

We can compare our original feature which gets all books, to filtering by combinations of title and description.

```
GET localhost:5000/books
GET localhost:5000/books?title=apple
GET localhost:5000/books?description=apple
GET localhost:5000/books?title=apple&description=apple
```

As before, our actual results will vary depending on the data in our database. If we have the sample books we've been using, we should get back the following results:

- `GET localhost:5000/books` should return all books
- `GET localhost:5000/books?title=apple` should return `10,000 Apples` and `An Apple a Day`
- `GET localhost:5000/books?description=apple` should return `It's Not Easy Being an Orange` and `An Apple a Day`
- `GET localhost:5000/books?title=apple&description=apple` should return only `An Apple a Day`

## More to Explore with Query Params and Filtering

There's way more to explore in filtering than we can go into here. For example, we could filter by multiple titles, or by multiple descriptions, or by various combinations of titles and descriptions. If we had the data to support it, we could filter by a range of years, or by a range of prices. We could filter by a combination of all of these things! Later in the Building an API series, we'll look at how we might generalize some of our filtering code to handle arbitrary columns on various models.

Beyond filtering, we could sort the results by the number of pages, or by the author's name. We could paginate the results, or limit the number of results that come back. If we can imagine some query param behavior, we can try to build it!

Building our desired filtering behaviors is a matter of understanding the data we have, and the data we want to get back. We can use the SQLAlchemy documentation to find the methods we need to build the queries we want. In addition to the already mentioned documentation on [Using SELECT Statements](https://docs.sqlalchemy.org/en/20/tutorial/data_select.html), we can also look at the library documentation for [SELECT and Related Constructs](https://docs.sqlalchemy.org/en/20/core/selectable.html) as well as for [Column Elements and Expressions](https://docs.sqlalchemy.org/en/20/core/sqlelement.html).

The SELECT documentation can point us towards other methods that have close SQL equivalents, such as `limit()`, `offset()`, `distinct()`, `group_by()`, `having()`, and more. The column methods documentation can give us ideas for how to add more complex conditions to our queries. Continuing to practice our SQL directly will also help us to understand how to build more complex queries in SQLAlchemy.

In fact, when building a complex query for an endpoint, it can often be easiest to interactively build a raw SQL query in a database tool, and then translate that query into SQLAlchemy code. So keep building, and follow your curiosity!

<!-- prettier-ignore-start -->
### !challenge

* type: ordering
* id: 785e009a-e375-43af-8417-92954e75414f
* title: Query Params

##### !question

Place the following responsibilities in order so that they correspond to the following list of the sources of data in a request.
- Request body
- Route parameters
- Query parameters

##### !end-question

##### !answer

1. Contains data that should be uploaded to the server to create or update a record
1. Contains data that identifies a particular record
1. Contains data that customizes the behaviors of a route

##### !end-answer

### !end-challenge
<!-- prettier-ignore-end -->

<!-- prettier-ignore-start -->
### !challenge

* type: multiple-choice
* id: 7cab0a7c-d54a-4a1f-885d-6d77bc3294fe
* title: Query Params

##### !question

Which of the following URLs follows RESTful conventions for filtering books by title?

##### !end-question

##### !options

a| https://bookworm.adadev.org/?resource=book&title=analytical%20engine
b| https://bookworm.adadev.org/books&title?analytical%20engine
c| https://bookworm.adadev.org/titles?analytical%20engine
d| https://bookworm.adadev.org/books?title=analytical%20engine
e| https://bookworm.adadev.org/books?analytical%20engine=title

##### !end-options

##### !answer

d|

##### !end-answer

##### !explanation

- The name of the resource collection is `books`, so the path of this URL should start with `/books` rather than listing the resource type as a query param.
- This URL makes mistakes in the separation characters. `&` is used to separate multiple query params in the query string. `?` separates the path from the query string. `=` separates the key from the value.
- Although we are filtering by title, the resource collection should be `books`, not `titles`.
- This example follows RESTful conventions for filtering books by title. The path is `/books`, and the query string contains a `title` query param.
- The query param in this URL is backwards, reversing the key and the value.

<br />

All these examples use the text `analytical%20engine` as the filter. Recall that `%20` is the URL encoded value for a space character, so we are looking for a title containing the words `analytical engine`. It was in her notes about the Analytical Engine that Ada Lovelace described how this machine could function as a programmable computer, even describing what is widely considered to be the first computer program. 

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->

<!-- prettier-ignore-start -->
### !challenge

* type: checkbox
* id: 993dd96f-0493-4471-bca5-9f638eaf4bb8
* title: Query Params

##### !question

Why is it important to update the value to which `query` refers in the following snippet?
```python
    query = db.select(Book)

    title_param = request.args.get("title")
    if title_param:
        # Why do we update the value of `query` here?
        query = query.where(Book.title.ilike(f"%{title_param}%"))

    books = db.session.scalars(query.order_by(Book.id))
```

##### !end-question

##### !options

a| This would allow us to add more conditions to the query later, without losing the previous conditions.
b| `where()` returns a new `Select` object with the conditions in the `where()` applied. It does not modify the original `Select` object.
c| Calling `where()` without an assignment is a syntax error.
d| If we didn't, `books` would end up with _all_ books, not just the filtered ones.

##### !end-options

##### !answer

a|
b|
d|

##### !end-answer

##### !hint

- How did we support filtering both by `title` and `description`?
- If `where()` doesn't modify the original `Select` object, how can we use the updated `Select` later on?
- For other Python functions that return values, does calling them without an assignment cause an error?
- If we call `query.where()` without updating `query`, what would `query` refer to when we try to use it later?

##### !end-hint

##### !explanation

- By updating `query` here, if we later add more conditions to the query, the later use will include the effects of the earlier conditions. If we didn't update `query`, the later use would ignore the earlier conditions.
- It's true that `where()` returns a new `Select` object, so we would either need to use that value immediately (such as by calling another query method on it, or passing it directly to `db.session.scalars()`), or store it in a variable for later use.
- There is no syntax error here. Python allows us to ignore return values. However, this would probably result in a logical error!
- Failing to update `query` means that `query` would refer to the original `Select` object, which would not have the conditions applied by the `where()` method. This would result in `books` always containing all books, not just the filtered ones.

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->
