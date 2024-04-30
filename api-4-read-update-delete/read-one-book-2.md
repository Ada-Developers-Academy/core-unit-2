# Read One Book

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=34c46ceb-7f39-4bc6-bcd5-ae690161fae0&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Goals

Our goals for this lesson are to:
- Practice defining routes that read model records
- Access a database record from the back-end layer

We will build our Hello Books API to fulfill the following feature:

1. As a client, I want to send a request to get one existing book, so that I can see the `id`, `title`, and `description` of the book.

We will refactor the `get_one_book` endpoint we designed in a prior lesson to make use of the data in our postgres database.

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`03c-read-all-books` |`04a-read-one-book`|

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

* A `hello_books_development` database
* A `book` table defined
* A `Book` model defined
* `POST` `/books` route defined
* `GET` `/books` route defined

</details>
<br>

## Getting a Single Book Endpoint: Planning HTTP Requests, Responses, and Logic Review

Let's review the planning work we did previously to retrieve a single hard-coded book record. Once more, we should think about the RESTful HTTP verb and endpoint used for requests that retrieve the data for a particular model record. 

For this feature, we should make a `GET` request to the `/books` path, but we need to include the `id` of the record to retrieve as part of the endpoint. Just like our original `get_one_book` endpoint, our updated route needs a route parameter to represent the `id` of the book we want to retrieve.

| HTTP Method | Endpoint   | Example |
| ----------- | ---------- | ---------- | 
| `GET`       | `/books/<book_id>` | `/books/3` |

`GET` requests do not include a request body, so no additional planning around the request body is needed.

We want to send back a single JSON object (dictionary) with the keys:
* `id` 
* `title`
* `description`

<table>
  <tr>
    <th>Response Status</th>
    <th>Example Response Body</th>
  </tr>
  <tr>
    <td><code>200 OK</code></td>
    <td><pre style="margin:0px;"><code>{
    "id": 1, 
    "title": "Fictional Book", 
    "description": "A fantasy novel set in an imaginary world."
}</code></pre>
    </td>
  </tr>
</table>

Now that we have an idea of what our endpoint should look like, we can turn our attention to how to implement it.

Our endpoint will need to:

1. Read the `book_id` in the request path
2. Retrieve the book with the matching `book_id` from the database
3. Format the book data into the appropriate structure (a single dictionary with `id`, `title`, and `description`)
4. Send back a response

Let's take a look at how our updated route will account for this!

## Getting a Single Book Endpoint: Code

To access a single book with `book_id` in our database, we need to create and execute a query that:
1. selects from the `book` database table 
2. selects only books where the book `id` is the requested `book_id` 

Our query could look like:

```python
query = db.select(Book).where(Book.id == book_id)
```

The `query` variable above is a `Select` object, and we still need to execute the query to get back a `Book` model. When we wanted to read all books in the `get_all_books` function, we used the `db.session` object and called its `scalars` method to get a list of models. In this case, we only want to retrieve a single book record using it's unique identifier `id`. `db.session` has another method we can use, `scalar`, which will only return one result rather than a list. 

```python
book = db.session.scalar(query)
```

Consider how you could refactor the `GET` `/books/<book_id>` route to make use of these pieces of syntax.

<br/>

<details>
    <summary>Give it a try, then click here to review our code.</summary>

```python
# No new import statements...

# No modifications to the other routes...

@books_bp.get("/<book_id>")
def get_one_book(book_id):
    query = db.select(Book).where(Book.id == book_id)
    book = db.session.scalar(query)

    return {
        "id": book.id,
        "title": book.title,
        "description": book.description
    }
```

</details>

| <div style="min-width:250px;"> Piece of Code </div> | Notes |
| --------------------------------------------------- | ----- |
| `@books_bp.get("/<book_id>")`                       | Unchanged from our previous hardcoded route. This decorator indicates that the function below it is a `GET` route that is registered with the `Blueprint` object named `books_bp`. |
| `"/<book_id>"`                                      | Unchanged from our previous hardcoded route. This is the `Blueprint` syntax to indicate a route parameter named `<book_id>`. The `<book_id>` placeholder shows that we are looking for a variable value which we can use in the function as the variable `book_id`. |
| `def get_one_book(book_id):`                        | Unchanged from our previous hardcoded route. This function must have a parameter, `book_id`. This parameter name must match the route parameter in the decorator. It will receive the part of the request path that lines up with the placeholder in the route. |
| `query = ...`                                       | We store the `Select` object which represents our query for a single `Book` instance in the variable `query` |
| `... = db.select(Book) ...`                         | This syntax tells the `SQLAlchemy` object `db` to select all entries for the model `Book`. This method returns a `Select` object that represents the query we are building. |
| `....where(Book.id == book_id)`                     | This is an example of building up a query by adding a where clause onto a `Select` object. We call the `where` method and pass it a comparison `Book.id == book_id` to use for filtering the results of our initial `Select` statement created by `db.select(Book)`. The `where` function will return a new `Select` object that is stored in the variable `query` |
| `book = ...`                                       | We store the single `Book` model in the variable `book` |
| `... = db.session.scalar(query)`                   | This syntax tells the `db.session` object to execute the query we have built up in the `query` variable and return the first result found as a `scalar` (our `Book` model object). This method returns a single instance of `Book`. |
| `return`                                           | As always, we must return a response. Flask will default to returning status `200 OK`. |
| `{ "id": book.id, ... }`                           | We can create a dictionary literal for our HTTP response. |

## Error Handling

Recall the `validate_book` helper function that handles an invalid `book_id` or a non-existing book by returning a `400` or `404` response. 

<br/>

<details>
    <summary>Expand to view the original <code>validate_book</code> function.</summary>

```python
def validate_book(book_id):
    try:
        book_id = int(book_id)
    except:
        response = {"message": f"book {book_id} invalid"}
        abort(make_response(response , 400))

    for book in books:
        if book.id == book_id:
            return book

    response = {"message": f"book {book_id} not found"}
    abort(make_response(response, 404))
```
</details>

Let's refactor `validate_book` so it can retrieve a specific `Book` instance from the database, then return that `Book` object. 

We've been retrieving a `Book` instance with the lines: 

```python
query = db.select(Book).where(Book.id == book_id)
book = db.session.scalar(query)
```

For our error handling, we need to know: what happens when there is no matching book? What is returned when you execute a query that isn't selecting any records?

It turns out that when we execute a query which selects no book records `db.session.scalar(query)` returns `None`! This is handy since we can look at if the result of executing our query is truthy or falsy, and act accordingly.

<br/>

<details>
    <summary>Give the <code>validate_book</code> refactor a try, then click here to review our updated helper function and <code>get_one_book</code> route.</summary>

```python
@books_bp.get("/<book_id>")
def get_one_book(book_id):
    book = validate_book(book_id)

    return {
        "id": book.id,
        "title": book.title,
        "description": book.description,
    }

def validate_book(book_id):
    try:
        book_id = int(book_id)
    except:
        response = {"message": f"book {book_id} invalid"}
        abort(make_response(response , 400))

    query = db.select(Book).where(Book.id == book_id)
    book = db.session.scalar(query)
    
    if not book:
        response = {"message": f"book {book_id} not found"}
        abort(make_response(response, 404))

    return book
```

</details>

## Manually Testing the Get One Book Endpoint

As with our previous routes, we should practice using all the tools at our disposal to test our endpoints and investigate issues should they arise.

- Postman
- Flask Server logs
- `psql` interface
- VS Code
- Peers, classmates, and rubber ducks

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: ECXaUI
* title: Read One Book
##### !question

Assume that we have a `Note` model that contains only `id` and `message` attributes.

Which of the options below would retrieve a single Note record with an `id` of 1 and store it in a variable named `note`?

##### !end-question
##### !options

a| ```python
query = db.select(Note).order_by(Note.id)
note = db.session.scalar(query)
```
b| ```python
query = db.select(Note).where(Note.id)
note = db.session.scalar(query)
```
c| ```python
query = db.select(Note).where(Note.id == 1)
notes = db.session.scalars(query)
```
d| ```python
query = db.select(Note).where(Note.id == 1)
note = db.session.scalar(query)
```

##### !end-options
##### !answer

d|

##### !end-answer
##### !explanation

This is the only answer that:
1. Selects the Note table
2. Uses the `where` function to add filtering to our base query 
3. Provides the `where` function with the necessary parameter to find a Note record with an `id` of 1
4. Uses `scalar` to retrieve a single record as a Note model 

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: 7bbc9131-cd92-4eb5-b712-55471daf1cd4
* title: Read One Book
##### !question

Select all of the options below which are valid reasons for refactoring and using the helper function `validate_book`.

##### !end-question
##### !options

a| Having a function with the single responsibility of checking if a book's `id` is valid then retrieving the record.
b| Moving data validation and fetching out of the function `get_one_book`, so that `get_one_book` is focused on the unique work for the route.
c| Knowing we will create further routes which will need to look up a book record by id. 

##### !end-options
##### !answer

a|
b|
c|

##### !end-answer
##### !explanation

Each of these is a valid reason for separating out our code into helper functions! This change helps our functions to better align with the 'single responsibility principle' and helps to reduce repeated code across a project, making a project easier to maintain over time.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->