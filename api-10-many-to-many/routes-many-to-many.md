# Many-to-Many: Nested Routes

## Goals

Our goals for this lesson are to:
* Implement endpoints with nested routes that connect two models with a many-to-many relationship
* Utilize documentation and problem solving to learn how to implement new features

This lesson covers:

- Creating a `POST` `/genres/<genre_id>/books` RESTful route to create a book of a specific genre.
- Update a `Book` instance method to display `genres` in response body
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
- A `Book` model defined that contains the instance method `to_dict` and class method `from_dict`
- An `author` table defined
- A `Author` model defined that contains the instance method `to_dict` and class method `from_dict`
- A `genre` table defined
- A `Genre` model defined that contains the instance method `to_dict` and class method `from_dict`

Endpoints defined for these RESTful routes:
- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`
- `POST` to `/authors`
- `GET` to `/authors`
- `POST` to `/authors/<author_id>/books`
- `GET` to `/authors/<author_id>/books`
- `GET` to `/genres`
- `POST` to `/genres`

The `Book` model and table should have the following columns:
- `id`
- `title`
- `description`
- `author_id` (foreign key)
- `author` (model only)
- `genres` (model only)

The `Author` model and table should have the following columns:
- `id`
- `name`
- `books` (model only)

The `Genre` model and table should have the following columns:
- `id`
- `name`
- `books` (model only)

The `BookGenre` model and table should have the following columns:
- `book_id`
- `genre_id`

`route_utilities.py` should contain:
- The function `validate_model()` that can retrieve a model of any type
- The function `create_model()` which will call the `from_dict` method on any class passed as the parameter to create a model of any type.
- The function `get_models_with_filters()` that can apply filters from a dictionary parameter to retrieve models of any type. 
</details>

## `POST` `/genres/<genre_id>/books`

Now that we have established our models to create a many-to-many relationships between `book`s and `genre`s, we can write a RESTful route to create a book of a specific genre. 

|Verb|Endpoint|Example Request Body|
|--|--|--|
|`POST`|`/genres/<genre_id>/books`|`{"title": "book title", "description": "creative description", "genre_id": 1`|

Our route function will need to 
- Query the `Genre` table to get the `genre` with `genre_id`
- Create a new book instance with data from the request_body and the `genre`
- Commit our new book from the database

If we want to re-use our `Book`'s `from_dict` class method with the `create_model()` helper function in `route_utilities.py`, we would also need to update `Book`'s `from_dict` function to account for an optional `genre` being passed. 

<br/>

<details>
  <summary>Give this function a try and then click here to see the complete <code>POST /genres/&#60;genre_id&#62;/books</code> route and updated <code>Book</code>'s <code>from_dict</code> class method</summary>

```python
# app/routes/genre_routes.py
from .route_utilities import create_model, get_models_with_filters, validate_model

...

@bp.post("/<genre_id>/books")
def create_book_with_genre(genre_id):
    genre = validate_model(Genre, genre_id)

    request_body = request.get_json()
    request_body["genres"] = [genre]
    return create_model(Book, request_body)
```

```python
# app/models/book.py
...

@classmethod
def from_dict(cls, book_data):
    # Use get() to fetch values that could be undefined to avoid raising an error
    author_id = book_data.get("author_id")
    genres = book_data.get("genres", [])

    new_book = cls(
        title=book_data["title"],
        description=book_data["description"],
        author_id=author_id,
        genres=genres
    )

    return new_book
```

</details>

Note: This RESTful route is one way to create a relationship between `Book` and `Genre` instances. Consider how else we might create these relationships. Refer back to our [nested route for creating `Book`s by a specific `Author`](../api-8-relationships-in-sqlalchemy/nested-routes-in-flask.md)

## Displaying the `Genre` relationship in `Book` JSON

Let's refactor our `GET` `/books/<book_id>` route. Currently this route returns JSON with the keys: 
- `"id"`, 
- `"title"`, 
- `"description"`, 
- `"author"`, if a value for `author` exists. 

Now that we've established a relationship between `Book`s and `Genre`s, let's add the key `genres` to the JSON in our response body. To do this, let's modify the instance method `to_dict` on the `Book` class which returns the json we are looking for. 

<br/>

<details>
    <summary>Give it a try and then click here for one updated implementation of the <code>to_dict</code> method.</summary>

```python
# app/models/book.py

...

def to_dict(self):
    book_as_dict = {}
    book_as_dict["id"] = self.id
    book_as_dict["title"] = self.title
    book_as_dict["description"] = self.description

    if self.author:
        book_as_dict["author"] = self.author.name

    if self.genres:
        book_as_dict["genres"] = [genre.name for genre in self.genres]

    return book_as_dict
```
</details>

## `GET` `/genres/<genre_id>/books`

Finally, let's create a route to get all books by a specific genre.

Our route function we will need to 
- Query the `Genre` table to get the `genre` with `genre_id`
- Iterate through the `book`s associated with that `genre` 
- Return a response as a list of dictionaries with information for each `book` in the specified `genre`.

</br>

<details>
    <summary>Give it a try and then click here for one implementation of the <code>GET /genres/&#60;genre_id&#62;/books</code> route.</summary>

```python
# app/routes/genre_route.py
...

@bp.get("/<genre_id>/books")
def get_books_by_genre(genre_id):
    genre = validate_model(Genre, genre_id)
    response = [book.to_dict() for book in genre.books]
    return response
```

</details>

## Testing

Updating the unit test suite for the new `Genre` routes and changes to `Book`'s `from_dict` and `to_dict` methods is left as an exercise for readers.

### Manual Testing in Postman

Now that we have established a relationship between the `Genre` and `Book` models, we can test our changes using Postman.

View the genres in the database and the books in the database with a `GET` request to `/genres` and a `GET` to `/books`.

Create a `book` of a specific `genre` with a `POST` request to `/genres/<genre_id>/books`.

Verify the `genre`s have been added to the book with a `GET` request to `/books/<book_id>`. 

View all `book`s of a specific `genre` with a `GET` request to `/genres/<genre_id/books`.

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: c717888a-5e1a-4891-8d14-a79353f45163
* title: Many-to-Many: Nested Routes
##### !question

We have routes to create a new `Book` record with a specific `Genre`, but we don’t have a route that supports updating an _existing_ `book` to add a `Genre`.

Which of the options below: 
- follows Python and Flask best practices 
- follows patterns we’ve established in the `hello-books-api` project
- enables us to update an existing Book record with a Genre? 

Select one option.

##### !end-question
##### !options

a| Update the existing `PUT` `Book` route `/books/<book_id>` by adding behavior to: 
* Check if there is a `genre_id` in the request body JSON. 
* If there is a `genre_id`, confirm if the genre exists and if it does, add it to the list of `genres` held by the `book` instance. 
* Commit any changes to the database.

b| Create an `update_book` instance method in the `Book` class that takes in a dictionary and updates the book’s attributes for valid keys. 

Create a `PUT` nested route at the path `/books/<book_id>/genres/<genre_id>`. This route:
* Confirms if the genre and book passed in the path exists. 
* If they both exist, the genre with `genre_id` is added to the list of `genres` held by the `book` instance. 

c| Create an `update_book` instance method in the Book class that takes in a dictionary and updates the book’s attributes for valid keys. 

Create a `PUT` nested route  at the path `/genres/<genre_id>/books/<book_id>`. This route: 
* Confirms if the genre and book passed in the path exists. 
* If they both exist, the genre with `genre_id` is added to the list of `genres` held by the `book` instance. 
* Commits any changes to the database.

d| Create a `PUT` nested route at the path `/genres/<genre_id>/books/<book_id>`. This route: 
* Confirms if the genre and book passed in the path exists. 
* If they both exist, the genre with `genre_id` is added to the list of `genres` held by the `book` instance. 
* Commits any changes to the database.

##### !end-options
##### !answer

c|

##### !end-answer
##### !explanation

1. We could update the existing `Book` `PUT` route, but adding a check to see if a Genre exists requires us to import the `Genre` class. This forces the `book_routes.py` file to require more knowledge about other models to operate. The fact that we're trying to access a specific `Genre` resource is also obfuscated by being a value in the request body rather than being stated as part of the URL we're accessing.

2. Creating a `Book` instance function to handle reading valid keys to update attributes is a solid idea to keep code that alters a book's contents all in one place. However, creating the function described requires importing `Genre` into `book_routes.py` and the actions for the new route do not include committing our book record changes after updating a book's `genre` list.

3. By creating a `Book` instance method to handle changing the values of a book's attributes, our new route in `genre_routes.py` doesn't need to know about or handle setting specific attributes on a `Book` instance. All the new route needs to know is that the `Book` class exists, and has an `update_book` method we can call and pass a dictionary of values to handle the attribute changes.

4. We could absolutely make our changes to the book instance directly in the nested route function. However, through the `hello-books-api` project we have been following a pattern of moving code that operates directly on a model's attributes into methods of the model classes. This keeps code that requires knowledge of the specific attributes of a model packaged with the model itself, and keeps our route files (particularly `author_routes.py` and `genre_routes.py`) from requiring their functions to be tied to the specific attributes of other models.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->
