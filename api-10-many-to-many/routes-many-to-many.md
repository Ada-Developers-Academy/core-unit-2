# Many-to-Many: Nested Routes

## Goals

Our goals for this lesson are to:
* Implement endpoints with nested routes that connect two models with a many-to-many relationship
* Utilize documentation and problem solving to learn how to implement new features

This lesson covers:

- Creating a `POST` `/genres/<genre_id>/books` RESTful route to create a book of a specific genre.
- Creating a `Book` instance method to display `genres` in response body
- Creating a `GET` `/genres/<genre_id>/books` RESTful route to read all books of a specific genre.

| Starting Branch | Ending Branch|
|--|--|
|`10b-books-genres` |`10c-nested-routes`|

<br/>

<details>
    <summary>
        Before beginning this lesson, the Hello Books API should have the following.
    </summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined
- An `author` table defined
- A `Author` model defined
- Endpoints defined for these RESTful routes:
- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`
- `POST` to `/authors`
- `GET` to `authors/<author_id>/books`
- `POST` to `authors/<author_id>/books`
- `GET` to `/genres`
- `POST` to `/genres`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`
- `author` (model only)
- `genres` (model only)

The `Author` model and table should have the following columns:

- `id`
- `name`
- `books` (model only)

The `Genre` model and table should have the following columns:

- `id`
- `name`

The `BookGenre` model and table should have the following columns:
- `book_id`
- `genre_id`

</details>

## `POST` `/genres/<genre_id>/books`

Now that we have established our models to create a many-to-many relationships between `book`s and `genre`s, we can write a RESTful route to create a book of a specific genre. 

|Verb|Endpoint|Example Request Body|
|--|--|--|
|`POST`|`/genres/<genre_id>/books`|`{"title": "book title", "description": "creative description", "author_id": 1`|

Our route function we will need to 
- Query the `Genre` table to get the `genre` with `genre_id`
- Create a new book instance with data from the request_body and the `genre`
- Commit our new book from the database

<br/>

<details>
  <summary>Give this function a try and then click here to see the complete <code>POST /genres/&#60;genre_id&#62;/books</code> route.</summary>

```python
from app.book_routes import validate_model

@genres_bp.route("/<genre_id>/books", methods=["POST"])

def create_book(genre_id):

    genre = validate_model(Genre, genre_id)

    request_body = request.get_json()
    new_book = Book(
        title=request_body["title"],
        description=request_body["description"],
        author_id=request_body["author_id"],
        genres=[genre]
    )
    db.session.add(new_book)
    db.session.commit()
    return make_response(jsonify(f"Book {new_book.title} by {new_book.author.name} successfully created"), 201)
```

</details>

Note: This RESTful route is one way to create a relationship between `Book` and `Genre` instances. Consider how else we might create these relationships. Refer back to our [nested route for creating `Book`s by a specifict `Author`](../api-8-relationships-in-sqlalchemy/nested-routes-in-flask.md)

## Displaying relationships in `Book` JSON

Let's refactor our `GET` `/books/<book_id>` route. Currently this route returns JSON with the keys `"id"`, `"title"`, and `"description"`. Now that we've establishing a relationship between `Book`s and `Author`s and `Book`s and `Genre`s, let's add the keys `author` and `genres` to the JSON in our response body.

To do this, let's modify the instance method `to_dict` on the `Book` class which returns the json we are looking for. 

<br/>

<details>
    <summary>Give it a try and then click here for one updated implementation of the <code>to_dict</code> method.</summary>

```python
# app/models/book.py

...

def to_dict(self):
    book_dict = {
        "id": self.id,
        "title": self.title,
        "description": self.description
    }
    if self.author:
        book_dict["author"] = self.author.name

    if self.genres:
        genre_names = [genre.name for genre in self.genres]
        book_dict["genres"] = genre_names

    return book_dict
```
</details>

## `GET` `/genres/<genre_id>/books`

Finally, let's create a route to get all books by a specific genre.

Our route function we will need to 
- Query the `Genre` table to get the `genre` with `genre_id`
- Iterate through the `book`s with that `genre` 
- Return a response as a list of dictionaries with information for each `book` in the specified `genre`.

</br>

<details>
    <summary>Give it a try and then click here for one implementation of the <code>GET /genres/&#60;genre_id&#62;/books</code> route.</summary>

```python
@genres_bp.route("/<genre_id>/books", methods=["GET"])
def read_all_books(genre_id):
    
    genre = validate_model(Genre, genre_id)

    books_response = []
    for book in genre.books:
        books_response.append(
            book.to_dict()
        )
    return jsonify(books_response)
```

</details>


## Manual Testing in Postman

Now that we have established a relationship between the `Genre` and `Book` models, we can test our changes using Postman.

View the genres in the database and the books in the database with a `GET` request to `/genres` and a `GET` to `/books`.

Create a `book` of a specific `genre` with a `POST` request to `/genres/<genre_id>/books`.

Verify the `genre`s have been added to the book with a `GET` request to `/books/<book_id>`. 

View all `book`s of a specific `genre` with a `GET` request to `/genres/<genre_id/books`.

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: c717888a-5e1a-4891-8d14-a79353f45163
* title: Many-to-Many: Nested Routes
##### !question

Check off all the features you've written and tested.

##### !end-question
##### !options

* Create `POST` `/genres/<genre_id/books` route.
* Add `Book` instance method `to_dict`
* Create `GET` `/genres/<genre_id/books` route.

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->
