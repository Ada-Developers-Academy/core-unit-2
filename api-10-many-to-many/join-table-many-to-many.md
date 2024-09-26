# BookGenre Join Table

## Goals

Our goal for this lesson is to connect the `Book` and `Genre` models to create a many-to-many relationship.

This lesson should be used as a reference in conjuction with [SQLAlchemy's documentation](https://docs.sqlalchemy.org/en/14/orm/basic_relationships.html).

This lesson covers:

- Creating a `BookGenre` association model / join table.
- Adding a relationship attribute `genres` to the `Book` model.
- Adding a relationship attribute `books` to the `Genre` model.

| Starting Branch | Ending Branch|
|--|--|
|`10a-genres` |`10b-books-genre`|

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
- `GET` to `authors/<author_id>/books`
- `GET` to `/genres`
- `POST` to `/genres`

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

The `Genre` model and table should have the following columns:
- `id`
- `name`

`route_utilities.py` should contain:
- The function `validate_model()` that can retrieve a model of any type
- The function `create_model()` which will call the `from_dict` method on any class passed as the parameter to create a model of any type.
- The function `get_models_with_filters()` that can apply filters from a dictionary parameter to retrieve models of any type. 

</details>

## Visualizing the Many-to-Many Relationship

Let's think about what the relationship looks like between `books` and `genres`. Just like we've done for relationships defined using SQL commands, we can use entity relationship diagrams to visualize the relationships between our models.

![An entity relationship diagram describing a many-to-many relationship between genres and books](../assets/api-10-many-to-many/GenreBookERD_ManyToMany.drawio.svg)  
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
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy import ForeignKey
from ..db import db

class BookGenre(db.Model):
    __tablename__ = "book_genre"

    book_id: Mapped[int] = mapped_column(ForeignKey("book.id"), primary_key=True)
    genre_id: Mapped[int] = mapped_column(ForeignKey("genre.id"), primary_key=True)
```
</details>

### !callout-info

## Specifying the Table Name

In model definitions, if we don't like the default name that SQLAlchemy picks we can specify a different name for the table, using the `__tablename__` property. There is more to research here!

### !end-callout

In order to easily see the `genres` associate with a particular book, or the `books` associated with a specific genre, we can add a relationship attribute to the `Book` and `Genre` models: 
```py
# app/models/book.py
genres: Mapped[list["Genre"]] = relationship(secondary="book_genre", back_populates="books") 

# app/models/genre.py
books: Mapped[list["Book"]] = relationship(secondary="book_genre", back_populates="genres") 
```

In summary:
- By adding the `genres` attribute to the `Book` model, `book.genres` returns a list of `Genre` instances associated with the `Book` instance named `book`.
- By adding the `books` attribute to the `Genre` model, `genre.books` returns a list of `Book` instances associated with the `Genre` instance named `genre`.

<br>
<details>
  <summary>Expand to see complete <code>Book</code> model code</summary>

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
    genres: Mapped[list["Genre"]] = relationship(secondary="book_genre", back_populates="books")
    
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

<details>
  <summary>Expand to see complete <code>Genre</code> model code</summary>

``` python
# app/models/genre.py
from sqlalchemy.orm import Mapped, mapped_column, relationship
from ..db import db

class Genre(db.Model):
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    name: Mapped[str]
    books: Mapped[list["Book"]] = relationship(secondary="book_genre", back_populates="genres")

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

### !callout-info

## `books_genres` vs. `book_genre`

We will notice that in the provided implementation, the `BookGenre` model table is named `book_genre` and not `books_genres`. Some frameworks may enforce a particular convention. With Flask, we just need to make sure that we are consistent.

### !end-callout

### Don't Forget to Generate Migrations

Great! We've got a new model. Sounds like it's time for another migration! We can refer back to [03) Building an API - Models Setup](../api-3-database-models-read/models-setup.md) to review the terminal commands for migration.

In addition, remember to import the `BookGenre` model in `app/__init__.py` with `from .models import book, author, genre, book_genre`.

## Check For Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: 11e5a57b-a8f5-41aa-92ea-887c1ec01f6c
* title: BookGenre Join Table
##### !question

Assume that we have: 
- A `Note` model that contains only `id` and `message` attributes
- A `Tag` model that contains only `id` and `name` attributes
- A `NoteTag` model that contains only `note_id` and `tag_id` foreign keys

We want to form a relationship between the `Note` and `Tag` models so that we can conveniently access notes from a `Tag` object and tags from a `Note` object.

Which entry below describes the code that must be added to the project to form this relationship? Select only one.

##### !end-question
##### !options

a| ```py
# app/models/note.py
tags: Mapped[list["Tag"]] = relationship(back_populates="notes") 

# app/models/tag.py
notes: Mapped[list["Note"]] = relationship(back_populates="tags") 
```
b| ```py
# app/models/note.py
tags: Mapped[list["Tag"]] = relationship(secondary="note_tag", back_populates="notes") 
```
c| ```py
# app/models/note.py
tags: Mapped[list["Tag"]] = relationship(secondary="note_tag", back_populates="notes") 
```
d| ```py
# app/models/note.py
tags: Mapped[list["Tag"]] = relationship(secondary="note_tag", back_populates="notes") 

# app/models/tag.py
notes: Mapped[list["Note"]] = relationship(secondary="note_tag", back_populates="tags") 
```
e| ```py
# app/models/tag.py
notes: Mapped[list["Note"]] = relationship(back_populates="tags") 
```

##### !end-options
##### !answer

d|

##### !end-answer
##### !explanation

This is the only option that shows us defining the relationship on both the `Note` and `Tag` models and when calling `relationship` uses the keyword argument `secondary` to pass the value of `"note_tag"` which ensures that the relationship is using the `note_tag` join table to connect the models.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->

