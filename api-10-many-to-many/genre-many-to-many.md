# Many-to-Many: Genres

## Goals

Our goal for this lesson is to create a `Genre` model and routes in preparation to create a many-to-many relationship between `Genre`s and `Book`s.

This lesson should be used as a reference for creating the `Genre` model and routes. It does not provide a detailed description of the code.

This lesson covers:

- Creating a `Genre` model.
- Creating a `GET` `/genres` route
- Creating a `POST` `/genres` route

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`09a-deploying-to-heroku` |`10a-genres`|

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

Endpoints defined for these RESTful routes:
- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`
- `POST` to `/authors`
- `GET` to `/authors`
- `POST` to `/authors/<author_id>/books`
- `GET` to `authors/<author_id>/books`

The `Book` model and table should have the following columns:
- `id`
- `title`
- `description`
- `author_id` (foreign key)
- `author` (model only)

The `Author` model and table should have the following columns:
- `id`
- `name`
- `books` (model only)

`route_utilities.py` should contain:
- The function `validate_model()` that can retrieve a model of any type
- The function `create_model()` which will call the `from_dict` method on any class passed as the parameter to create a model of any type.
- The function `get_models_with_filters()` that can apply filters from a dictionary parameter to retrieve models of any type. 

</details>

## Genre Model

`Book`s and `Genre`s have a many-to-many relationship. A book can belong to many genres, and a genre can have many books.

To establish this relationship in our `hello-books-api` with SQLAlchemy, we first need to define a model for `Genre` in a new file `genre.py` inside the `models` folder. A genre should have the following attributes:
* `id`, integer, primary key
* `name`, string

If we want to use the same utility functions that the `Book` and `Author` routes take advantage of, we should write `to_dict` and `from_dict` methods for `Genre` as well.

Give this a try on your own, then check out our solution below.

<br />

<details>
    <summary>Click here for one way to implement the Genre model.</summary>

```py
# app/models/genre.py
from sqlalchemy.orm import Mapped, mapped_column
from ..db import db

class Genre(db.Model):
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    name: Mapped[str]

    def to_dict(self):
        genre_as_dict = {}
        genre_as_dict["id"] = self.id
        genre_as_dict["name"] = self.name

        return genre_as_dict

    @classmethod
    def from_dict(cls, genre_data):
        new_genre = cls(name=genre_data["name"])
        return new_genre
```
</details>

### Don't Forget to Generate Migrations

Great! We've got a new model. Sounds like it's time for another migration! We can refer back to [03) Building an API - Models Setup](../api-3-database-models-read/models-setup.md) to review the terminal commands for migration.

## Genre Blueprint

We should create a Blueprint that groups the endpoints for our `Genre` model, which means we need a new file for our `Genre` routes `app/routes/genre_routes.py`. Refer back to [Hello World Routes](../api-1-setup-read/hello-world-routes.md) on how to define a blueprint and register it in `create_app`.

We also need to import the `Genre` model in our `__init__.py` file.

<br/>
<details>
  <summary>Give it a try and then view the blueprint code by clicking here.</summary>

```py
# app/routes/genre_routes.py
from flask import Blueprint


bp = Blueprint("genres_bp", __name__, url_prefix="/genres")
```

```py
# app/__init__.py

...
from .models import book, author, genre
from .routes.genre_routes import bp as genres_bp

...
# Register Blueprints here
app.register_blueprint(books_bp)
app.register_blueprint(authors_bp)
app.register_blueprint(genres_bp)

```
</details>

## Genre Routes
Finally we will create the following endpoints for our `Genre` model in `genre_routes.py`:
- `GET ` to `/genres`
- `POST` to `/genres`

Refer back to [03) Building an API - Read All Books](../api-3-database-models-read/read-all-books.md) for how to define the `GET` endpoint and the `POST` endpoints.

<br/>

<details>
  <summary>Give it a try and then view one implementation of these routes here.</summary>

```py
# app/routes/genre_routes.py
from flask import Blueprint, request
from app.models.genre import Genre
from .route_utilities import create_model, get_models_with_filters

bp = Blueprint("genres_bp", __name__, url_prefix="/genres")

@bp.post("")
def create_genre():
    request_body = request.get_json()
    return create_model(Genre, request_body)

@bp.get("")
def get_all_genres():
    return get_models_with_filters(Genre, request.args)
```
</details>

## Testing

Writing unit tests for the Genre model is left as an exercise for readers. 

### Manual Testing in Postman

Now that we have a `Genre` model and routes, we can test our changes using Postman.

Create a new genre with `POST` to `/genres` and a response body such as `{"name": "Non-fiction"}`.

Verify that the genre has been added to the database with a `GET` to `/genres`.

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: cf50ab1e-478e-42af-8b8d-6f877e093cf7
* title: Many-to-Many: Genres
##### !question

Which of the following options are benefits of implementing `to_dict` and `from_dict` functions in the `Genre` model? 

Select all options below which apply.

##### !end-question
##### !options

a| `Genre` routes can use the `create_model` and `get_models_with_filters` functions from `route_utilities.py`.
b| We can re-use the route functions for `Book` and `Author` models
c| Code related to creating Genre models and transforming model data into a dictionary is packaged with the model class.
d| By moving model-specific code out of `genre_routes.py`, the file contents are shorter.
e| By moving model-specific code out of `genre_routes.py` the `Genre` route functions only contain business logic specific to each route's requirements.

##### !end-options
##### !answer

a|
c|
e| 

##### !end-answer
##### !hint

What have we learned about encapsulation and packaging related code together?

##### !end-hint
##### !hint

What code is able to be reused by `Genre`'s routes?

##### !end-hint
##### !hint

Is shorter code necessarily better code?

##### !end-hint
##### !explanation

a| We can D.R.Y. our `Genre` routes by reusing our helper functions in `route_utilities.py`
b| We cannot reuse the `Book` and `Author` route functions, their business logic is too specific to the kinds of data they operate on.
c| We make it easier to find and understand code that works with specific models by packaging those functions as part of the model class.
d| A file being shorter is not a metric of quality all on it's own. If something is very short but very hard to understand, it is often less valuable than something which is a bit longer but easier to maintain.
e| Our route functions being very focused and single purpose is valuable for reducing the number of places where we could have bugs and making our code easier to understand.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->

