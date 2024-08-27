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
- A `Book` model defined that contains the instance method `to_dict` and class method `from_dict`
- An `author` table defined
- An `Author` model defined that contains the instance method `to_dict` and class method `from_dict`

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

`route_utilities.py` should contain:
- The function `validate_model()` that can retrieve a model of any type

</details>


## `POST`ing a Book to an Author

Let's consider this feature:

> As a client, I want to send a request to create a new book and connect it to an author already found in the database.

What information do we need to accomplish this? We need to know _which_ author, and the new book's `title` and `description`. To specify the `author`, we can use the author's `id`. This will refer to one and only one author, even if there are multiple authors with the same name.

### !callout-info

## More Than One Right Answer

There's more than one way to implement the relationship between our `Book` and `Author` models in our routes. For our curriculum, we will stick with RESTful routing naming conventions and implement a *nested route* to describe this relationship.

### !end-callout

### Nested Routes

Nested routes (also called nested resources) describe the parent-child relationship between (at least) two models in our API. By nesting resources in a single route, the client can retrieve only the data they require. For example, we can read all `book`s (`GET`) or create (`POST`) a `book` by a specific `author`.

![A diagram of a nested route: '/author/author_id/books'](../assets/nested-routes-in-flask_route-diagram.png)  
*Fig.  A diagram of a nested route*

The nested route starts with the _parent_ model. In this case, `authors`. Then we specify the appropriate author record's `id` we want our new _child_ model record to belong to, indicated by the `<author_id>` parameter. Finally, we list the name of the child collection, in this case, `books`.

### Creating Our Endpoint

Our nested route `POST` `/authors/<author_id>/books` will use the `bp` blueprint in `author_routes.py`. We want our `POST` endpoint to return a new `Book` record, so we should also consider adjusting the convenience functions we created for the `Book` model, `to_dict` and `from_dict`, to handle an optional `Author`. 

Here is an example of how we might start to implement the nested `POST` route:

```python
# app/routes/author_routes.py
@bp.post("/<author_id>/books")
def create_book_with_author(author_id):

    # refer to prior examples or the documentation 
    # and try completing this endpoint yourself

    db.session.add(new_book)
    db.session.commit()

    return make_response(new_book.to_dict(), 201) 
```

Try completing this route function by referencing the [Flask-SQLAlchemy documentation](https://flask-sqlalchemy.palletsprojects.com/en/3.1.x/quickstart/#query-the-data), then check out our solution below. Remember, there is more than one way to do this! 

<br/>

<details>
    <summary>Complete <code>POST</code> <code>/authors/&lt;author_id&gt;/books</code> endpoint example and updated <code>book.py</code></summary>

``` python
# app/routes/author_routes.py
@bp.post("/<author_id>/books")
def create_book_with_author(author_id):
    author = validate_model(Author, author_id)
    
    request_body = request.get_json()
    request_body["author_id"] = author.id

    try:
        new_book = Book.from_dict(request_body)

    except KeyError as error:
        response = {"message": f"Invalid request: missing {error.args[0]}"}
        abort(make_response(response, 400))
        
    db.session.add(new_book)
    db.session.commit()

    return make_response(new_book.to_dict(), 201)
```

``` python
# app/models/book.py
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy import ForeignKey
from typing import Optional
from ..db import db

class Book(db.Model):
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    title: Mapped[str]
    description: Mapped[str]
    author_id: Mapped[Optional[int]] = mapped_column(ForeignKey("author.id"))
    author: Mapped[Optional["Author"]] = relationship(back_populates="books")

    def to_dict(self):
        book_as_dict = {}
        book_as_dict["id"] = self.id
        book_as_dict["title"] = self.title
        book_as_dict["description"] = self.description

        if self.author:
            book_as_dict["author"] = self.author.name

        return book_as_dict
    
    @classmethod
    def from_dict(cls, book_data):
        # Use get() to fetch values that could be undefined to avoid raising an error
        author_id = book_data.get("author_id")

        new_book = cls(
            title=book_data["title"],
            description=book_data["description"],
            author_id=author_id
        )

        return new_book
```

</details>

## `GET`ting All Books from an Author

Let's consider this feature:

> As a client, I want to send a request to read all books by a particular author in the database.

How do we access the `books` from the `author` record and add them to our response body? Try working through this on your own, with the help of the documentation and a search engine. Then check out our solution below. _Hint: `print` statements will still appear in the terminal output, so they can be helpful to use during our investigation._

<br/>

<details>
    <summary>Complete <code>GET</code> <code>/authors/&lt;author_id&gt;/books</code> endpoint example</summary>

``` python
@authors_bp.route("/<author_id>/books", methods=["GET"])

def read_books(author_id):

    author = validate_model(Author, author_id)

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

## Extra Practice: `update_book()`

Now that we have the `Author` relationship implemented and have updated the methods on our `Book` model to handle author information, this is a good time to reflect on our existing routes and if there are further changes that would be helpful. 

- `CREATE`ing a book: We could choose to change our `create_book` route to account for `Author` information, but there is no need to since we made a design decision for this project to create a nested route to represent creating a book with an author.

- `GET`ting books: By updating our `Book` convenience methods, our routes `get_all_books` and `get_one_book` already account for `Author` information, which is great! 

- `UPDATE`ing a book: Our `update_book` route will only set the `title` and `description` of a book currently. What about if the author information is missing or incorrect? We have a great opportunity to update this route and improve the functionality of our API! 

- `DELETE`ing a book: Our `delete_book` route will work to remove the book record, whether or not is has `Author` information attached.

We have not implemented changes to the `update_book()` route to account for `Author` information in the `hello-books` repo, but have left it as an exercise for folks to try out independently. See what you come up with and feel free to share and discuss your improvements in Slack!

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: b4eb362c-cfb1-41b1-9fbb-f83d2cd3c228
* title: One-to-Many: Nested Routes
##### !question

Select all options below which are true about nested routes.

##### !end-question
##### !options

a| They describe a parent-child relationship between two or more models.
b| A nested route starts with the child collection.
c| The parent resource's id is not identified in a nested route.
d| By nesting resources in a single route, the client can retrieve only the data they require.
e| A nested route ends with the child collection.

##### !end-options
##### !answer

a|
d|
e|

##### !end-answer
##### !explanation

* True.
* False, A nested route starts with the parent collection.
* False, The parent resource's id is typically the second item in a nested route.
* True.
* True.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->