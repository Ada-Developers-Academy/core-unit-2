# One-to-Many: Nested Routes

## Goals

Our goals for this lesson are to:
* Implement a new endpoint with a nested route that connects a parent model to its child model instances
* Utilize documentation and problem solving to learn how to implement new features

We will implement the following routes:
* `POST` `/authors/<author_id>/books`
* `GET` `/authors/<author_id>/books`

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`08a-author-model` |`08b-nested-routes`|

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined
- An `author` table defined
- An `Author` model defined

- Endpoints defined for these RESTful routes:
  - `GET` to `/books`
  - `POST` to `/books`
  - `GET` to `/books/<book_id>`
  - `PUT` to `/books/<book_id>`
  - `DELETE` to `/books/<book_id>`
  - `GET` to `/authors`
  - `POST` to `/authors`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`
- `author_id`
- `author` (model only)

The `Author` model and table should have the following columns:

- `id`
- `name`
- `books` (model only)

</details>


## `POST`ing a Book to an Author

Let's consider this feature:

> As a client, I want to send a request to create a new book and connect it to an author already found in the database.

What information do we need to accomplish this? We need to know _which_ author, and the new book's `title` and `description`. To specify the `author`, we can use the author's `id`. This will refer to one and only one author, even if there are multiple authors with the same name.

### !callout-info

## More Than One Right Answer

There's more than one way to implement the relationship between our `book` and `author`. For our curriculum, we will stick with RESTful routing naming conventions and implement a *nested route* to describe this relationship.

### !end-callout


### Nested Routes

Nested routes (also called nested resources) describe the parent-child relationship between (at least) two models in our API. By nesting resources in a single route, the client can retrieve only the data they require. For example, we can read all `book`s (`GET`) or create (`POST`) a `book` by a specific `author`.


![A diagram of a nested route: '/author/author_id/books'](../assets/nested-routes-in-flask_route-diagram.png)  
*Fig.  A diagram of a nested route*

The nested route starts with the _parent_ model. In this case, `authors`. Then we specify the appropriate author record's `id` we want our new _child_ model record to belong to, indicated by the `<author_id>` parameter. Finally, we list the name of the child collection, in this case, `books`.

### Creating Our Endpoint

Our nested route `POST` `/authors/<author_id>/books` will use the `authors_bp` blueprint. Here is an example of how we might start to implement this:

```python
#app/author_routes.py
@authors_bp.route("/<author_id>/books", methods=["POST"])
def create_book(author_id):

    # refer to the documentation and try
    # completing this endpoint yourself

    db.session.add(new_book)
    db.session.commit()

    return make_response(jsonify(f"Book {new_book.title} by {new_book.author.name} successfully created"), 201)
```

Try completing this route function by referencing the [Flask-SQLAlchemy documentation](https://flask-sqlalchemy.palletsprojects.com/en/2.x/quickstart/#simple-relationships), then check out our solution below. Remember, there is more than one way to do this! 

<br/>

<details>
    <summary>Complete <code>POST</code> <code>/authors/<author_id>/books</code> endpoint example</summary>

``` python
#app/author_routes.py
def validate_author(author_id):
    try:
        author_id = int(author_id)
    except:
        abort(make_response({"message":f"author {author_id} invalid"}, 400))

    author = Author.query.get(author_id)

    if not author:
        abort(make_response({"message":f"author {author_id} not found"}, 404))

    return author

@authors_bp.route("/<author_id>/books", methods=["POST"])
def create_book(author_id):

    author = validate_author(author_id)

    request_body = request.get_json()
    new_book = Book(
        title=request_body["title"],
        description=request_body["description"],
        author=author
    )
    db.session.add(new_book)
    db.session.commit()
    return make_response(jsonify(f"Book {new_book.title} by {new_book.author.name} successfully created"), 201)
```
</details>


## `GET`ting All Books from an Author

Let's consider this feature:

> As a client, I want to send a request to read all books by a particular author in the database.

How do we access the `books` from the `author` record and add them to our response body? Try working through this on your own, with the help of the documentation and a search engine. Then check out our solution below. _Hint: `print` statements will still appear in the terminal output, so they can be helpful to use during our investigation._

<br/>

<details>
    <summary>Complete <code>GET</code> <code>/authors/<author_id>/books</code> endpoint example</summary>

``` python
@authors_bp.route("/<author_id>/books", methods=["GET"])
def read_books(author_id):

    author = validate_author(author_id)

    books_response = []
    for book in author.books:
        books_response.append(
            {
            "id": book.id,
            "title": book.title,
            "description": book.description
            }
        )
    return jsonify(books_response)
```
</details>

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: b4eb362c-cfb1-41b1-9fbb-f83d2cd3c228
* title: Nested Routes
##### !question

Think about the Nested Routes lesson.

Check off all the topics that we've touched on so far.

##### !end-question
##### !options

* Considered the parts of a nested endpoint 
* Implemented the `POST` `/authors/<author_id>/books` route
* Implemented the `GET` `/authors/<author_id>/books` route

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->