# BookGenre Join Table

## Goals

Our goal for this lesson is to connect the `Book` and `Genre` models to create a many-to-many relationship.

This lesson should be used as a reference in conjuction with [SQLAlchemy's documentation](https://docs.sqlalchemy.org/en/14/orm/basic_relationships.html).

This lesson covers:

- Creating a `BookGenre` association model / join table.
- Adding a relationship attribute `genres` to the `Book` model.

| Starting Branch | Ending Branch|
|--|--|
|`09a-genres` |`09b-books-genre`|

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
- `GET` to `/genres`
- `POST` to `/genres`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`
- `author` (model only)

The `Author` model and table should have the following columns:

- `id`
- `name`
- `books` (model only)

The `Genre` model and table should have the following columns:

- `id`
- `name`

</details>

## Visualizing the Many-to-Many Relationship

Let's think about what the relationship looks like between `books` and `genres`. Just like we've done for relationships defined using SQL commands, we can use entity relationship diagrams to visualize the relationships between our models.

![An entity relationship diagram describing a many-to-many relationship between genres and books](../assets/many-to-many.drawio.svg)  

_Fig. ERD describing a many-to-many relationship between books and genres_

We see that a `book` is connected to the `genre` table by a join table `books_genres`. The `books_genres` table has two foreign keys, `book_id` and `genre_id`.

## BookGenre Model

We will create a model `BookGenre` to create the join table that connects `Book`s to `Genre`s. Our `books_genres` table should have the following attributes: a `book_id` as one foreign key and a `genre_id` as the other foreign key. 

Recall the syntax for adding the `author_id` foreign key to the `Book` model. We will use similar syntax for the `BookGenre` model.

You may refer to the [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/14/orm/basic_relationships.html#many-to-many) first, try it out, then check out our solution below. There are several ways we _could_ implement a many-to-many relationship in our models. Follow your curiosity if you're interested in some of the other possible approaches.

<br/>

<details>
  <summary>Click here for one way to implement the <code>BookGenre</code> model.</summary>

  ``` python
# app/models/book_genre.py
from app import db

class BookGenre(db.Model):
    __tablename__ = "book_genre"
    book_id = db.Column(db.Integer, db.ForeignKey('book.id'), primary_key=True,nullable=False)
    genre_id = db.Column(db.Integer, db.ForeignKey('genre.id'), primary_key=True,nullable=False)
```
</details>

In order to easily see the `genres` associate with a particular book, we can add a relationship attribute to the `Book` model: 
- `genres = db.relationship("Genre", secondary="book_genre", backref="books")` 

By using the `backref` keyword, we also add a `books` attribute to the `Genre` model. 
In summary, by adding the `genres` attribute to the `Book` model:
- `book.genres` returns a list of `Genre` instances associated with the `Book` instance named `book`.
- `genre.books` returns a list of `Book` istances associated with the `Genre` instance named `genre`.

<details>
  <summary>Expand to see complete `Book` model code</summary>

``` python
# app/models/book.py

from app import db

class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String)
    description = db.Column(db.String)
    author_id = db.Column(db.Integer, db.ForeignKey('author.id'))
    author = db.relationship("Author", back_populates="books")
    genres = db.relationship("Genre", secondary="book_genre", backref="books")
```

</details>

We will notice that in the provided implementation, the `BookGenre` model table is named `book_genre` and not `books_genres`. Some frameworks may enforce a particular convention. With Flask, we just need to make sure that we are consistent.

### Don't Forget to Generate Migrations

Great! We've got a new model. Sounds like it's time for another migration! We can refer back to [03) Building an API - Models Setup](../api-3-database-models-read/models-setup.md) to review the terminal commands for migration.

In addition, remember to import the `BookGenre` model in `app/__init__.py` with `from app.models.book_genre import BookGenre`.

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: 11e5a57b-a8f5-41aa-92ea-887c1ec01f6c
* title: BookGenre Join Table
##### !question

Check off all the features you've written and tested.

##### !end-question
##### !options

* Create `BookGenre` model
* Import `BookGenre` in `__init__.py`
* Add `genres` attribute to `Book` model

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->

