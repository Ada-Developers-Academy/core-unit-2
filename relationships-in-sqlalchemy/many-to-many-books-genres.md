# Many-to-Many: Books and Genres

## Goals

Our goal for this lesson is to connect the `Book` and `Genre` models to create a many-to-many relationship.

This lesson should be used as a reference in conjuction with [SQLAlchemy's documentation](https://docs.sqlalchemy.org/en/14/orm/basic_relationships.html).

This lesson covers:

- Creating a `BookGenre` association model / join table.
- Adding a relationship attrbiute `genres` to the `Book` model.
- Creating a `PATCH` `/books/<book_id>/assign_genres` custom route to associate genres with a book.
- Creating a `Book` instance method `to_dict` that will return json with `author` and `genres` keys.

### Before This Lesson

This lesson uses the Hello Books API.

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

The `Author` model and table should have the following columns:

- `id`
- `name`

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
      __tablename__ = "books_genres"
      book_id = db.Column(db.Integer, db.ForeignKey('book.id'), primary_key=True,nullable=False)
      genre_id = db.Column(db.Integer, db.ForeignKey('genre.id'), primary_key=True,nullable=False)

  ```
</details>

In order to easily see the `genres` associate with a particular book, we can add a relationship attribute to the `Book` model: 
- `genres = db.relationship("Genre", secondary="books_genres", backref="books")` 

By using the `backref` keyword, we also add a `books` attribute to the `Genre` model. 
In summary, by adding the `genres` attribute to the `Book` model:
- `book.genres` returns a list of `Genre` instances associated with the `Book` instance named `book`.
- `genre.books` returns a list of `Book` istances associated with the `Genre` instance named `genre`.


<details>
  <summary>Click here to see the complete <code>Book</code> model.</summary>

  ``` python
  # app/models/book.py

  class Book(db.Model):
      id = db.Column(db.Integer, primary_key=True, autoincrement=True)
      title = db.Column(db.String)
      description = db.Column(db.String)
      author_id = db.Column(db.Integer, db.ForeignKey('author.id'))
      author = db.relationship("Author", backref="books")
      genres = db.relationship("Genre", secondary="books_genres", backref="books")

  ```
</details>

### Don't Forget to Generate Migrations

Great! We've got a new model. Sounds like it's time for another migration! We can refer back to [Models Setup](../building-an-api/models-setup.md) to review the terminal commands for migration.

In addition, remember to import the `BookGenre` model in `app/__init__.py` with `from app.models.book_genre import BookGenre`.

## `PATCH` `/books/<book_id>/assign_genres` route

Now that we have established our models to create a many-to-many relationships between `Book`s and `Genre`s, we can write a custom endpoint to assign `Genre`s to `Book`s in our database. 

|Verb|Endpoint|Request Body|
|--|--|--|
|`PATCH`|`/books/<book_id>/assign_genres`|`{"genres": [1, 2, 3]}`|

Note that the request body contains a list of `genre_ids` to indicate which genres to assign to the book with `book_id`.

In our route function we will need to 
- Query the `Book` table to get the book with `book_id`
- Query the `Genre` table to get the genres with the `genre_id` is the request body
- Assign the `genre`s from the request body.

<br/>

<details>
  <summary>Give this function a try and then click here to see the complete route.</summary>

  ```python

  @books_bp.route("/<book_id>/assign_genres", methods=["PATCH"])
  def assign_genres(book_id):
      book = Book.query.get(book_id)

      if book is None:
          return make_response(f"Book #{book.id} not found", 404)
    
      request_body = request.get_json()

      for id in request_body["genres"]:
          book.genres.append(Genre.query.get(id))
    
      db.session.commit()

      return make_response("Genres successfully added", 200)
  ```
</details>

Note: This custom route is one way to create a relationship between `Book` and `Genre` instances. Consider how else we might create these relationships, for instance with a `POST` `/genres/<genre_id>/books` route. Refer back to our [nested route for creating `Book`s by a specifict `Author`](../relationships-in-sqlalchemy/nested-routes-in-flask.md)

## Displaying relationships in `Book` JSON

Let's refactor our `GET` `\books\<book_id>` route. Currently this route returns JSON with the keys `"id"`, `"title"`, and `"description"`. Now that we've establishing a relationship between `Book`s and `Author`s and `Book`s and `Genre`s, let's add the keys `author` and `genres` to the JSON in our response body.

To do this work, let's create a instance method `to_dict` on the `Book` class that returns the json we are looking for. 

<br/>

<details>
    <summary>Give it a try and then click here for one implementation.</summary>

    ```python
    # app/models/book.py

    ...

    def to_dict(self):
        genres = []
        for genre in self.genres:
            genres.append(genre.name)

        if self.author:
            author = self.author.name
        else:
            author = None

        return {
                    "id": self.id,
                    "title": self.title,
                    "description": self.description,
                    "genres": genres,
                    "author": author
               }
    ```
</details>

In `routes.py` refactor the `GET` `/books` and `GET` `/books/<book_id>` to use the instance method `to_dict`.

## Manual Testing in Postman

Now that we have established a relationship between the `Genre` and `Book` models, we can test our changes using Postman.

View the genres in the database and the books in the database with a `GET` to `/genres` and a `GET` to `/books`.

Assign one or more genres to a book in the database with a `PATCH` to `/books/<book_id>/assign_genres`.

Verify the genres have been added to the book with a `GET` to `/books/<book_id>`. 

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: 11e5a57b-a8f5-41aa-92ea-887c1ec01f6c
* title: Many-to-Many: Books and Genres
##### !question

Check off all the features you've written and tested.

##### !end-question
##### !options

* Create `BookGenre` model
* Import `BookGenre` in `__init__.py`
* Add `genres` attribute to `Book` model
* Create `PATCH` `/book/<books_id>/assign_genres` route
* Refactor `GET` `/books` routes to use `to_dict` instance method.

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->

