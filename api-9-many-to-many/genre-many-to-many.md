# Many-to-Many: Genres

## Goals

Our goal for this lesson is to create a `Genre` model and routes in order to create a many-to-many relationship between `Genre`s and `Book`s.

This lesson should be used as a reference for creating the `Genre` model and routes. It does not provide a detailed description of the code.

This lesson covers:

- Creating a `Genre` model.
- Creating a `GET` `/genres` route
- Creating a `POST` `/genres` route

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`08a-deploying-to-heroku` |`09a-genres`|

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

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`

The `Author` model and table should have the following columns:

- `id`
- `name`

</details>

## Genre Model

`Book`s and `genre`s have a many-to-many relationship. A book can belong to many genres, and a genre can have many books.

To establish this relationship in our `hello-books-api` with SQLAlchemy, first we need to define a model for `Genre` in a new file `genre.py` inside the `models` folder. A genre should have the following attributes:
* `id`, integer, primary key
* `name`, string

Give this a try on your own, then check out our solution below.

<br />

<details>
  <summary>Click here for one way to implement the Genre model.</summary>

  ``` python
  # app/models/genre.py
  from app import db

  class Genre(db.Model):
      id = db.Column(db.Integer, primary_key=True, autoincrement=True)
      name = db.Column(db.String)
  ```
</details>

### Don't Forget to Generate Migrations

Great! We've got a new model. Sounds like it's time for another migration! We can refer back to [03)Building an API - Models Setup](../api-3-database-models-read/models-setup.md) to review the terminal commands for migration.

## Genre Blueprint

We should create a Blueprint that groups the endpoints for our `Genre` model. Refer back to [Hello World Routes](../api-1-setup-read/hello-world-routes.md) on how to define a blueprint and register it in `create_app`.

We also need to import the `Genre` model in our `__init__.py` file.

<br/>
<details>
  <summary>Give it a try and then view the blueprint code by clicking here.</summary>


  ``` python
  # app/routes.py

  ...
  genres_bp = Blueprint("genres", __name__, url_prefix="/genres")
  ```

  ``` python
  # app/__init__.py

  ...
  from app.models.genre import Genre

  ...
  # Register Blueprints here
  from .routes import books_bp, authors_bp, genres_bp
  app.register_blueprint(books_bp)
  app.register_blueprint(authors_bp)
  app.register_blueprint(genres_bp)

  ```
</details>

## Genre Routes
Finally we will create the following endpoints for our `Genre` model:
- `GET ` to `/genres`
- `POST` to `/genres`

Refer back to [03) Building an API - Read All Books](../api-3-database-models-read/read-all-books.md) for how to define the `GET` endpoint and the `POST` endpoints.

<br/>

<details>
  <summary>Give it a try and then view one implementation of these routes here.</summary>

```python
@genres_bp.route("", methods=["POST"])
def create_genre():
    request_body = request.get_json()
    new_genre = Genre(name=request_body["name"],)

    db.session.add(new_genre)
    db.session.commit()

    return make_response(jsonify(f"Genre {new_genre.name} successfully created"), 201)

@genres_bp.route("", methods=["GET"])
def read_all_genres():
    
    genres = Genre.query.all()

    genres_response = []
    for genre in genres:
        genres_response.append(
            {
                "name": genre.name
            }
        )
    return jsonify(genres_response)
```
</details>

## Manual Testing in Postman

Now that we have a `Genre` model and routes, we can test our changes using Postman.

Create a new genre with `POST` to `/genres` and a response body such as `{"name": "Non-fiction"}`.

Verify that the genre has been added to the database with a `GET` to `/genres`.

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: cf50ab1e-478e-42af-8b8d-6f877e093cf7
* title: Genre
##### !question

Check off all the features you wrote and tested.

##### !end-question
##### !options

* Create `Genre` model
* Create `genres_bp`
* Register genres_bp in `__init__.py`
* Import `Genre` in `__init__.py`
* Create `GET` `\genres` route
* Create `POST` `\genres` route

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->

