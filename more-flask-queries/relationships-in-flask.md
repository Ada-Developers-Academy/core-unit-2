# One-to-Many Relationships in Flask

## Goals

Our goal for this lesson is to use it as a reference for establishing relationships in Flask with SQLAlchemy.

This lesson covers:

- Connecting two tables together in a one-to-many relationship with SQLAlchemy
- Utilizing documentation and problem solving to find missing information.

### Before This Lesson

This lesson uses the Hello Books API.

<br />

<details style="max-width: 700px; margin: auto;">
    <summary>
        Before beginning this lesson, the Hello Books API should have the following.
    </summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined
- Endpoints defined for these RESTful routes:
- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`

</details>


## Author Model, Blueprint, and Routes

We only have the `Book` model in our Hello Books API, so first we need to define a model for `Author` next in a new file `author.py` inside the `models` folder. An author should have the following attributes: an `id` as the primary key and a `name`.

Give this a try on your own, then check out our solution below.

<br />

<details>
  <summary>Click here for a solution</summary>

  ``` python
  from app import db

  class Author:
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String)
  ```
</details>


Next, we should make a Blueprint that organizes our endpoints together for our `Author` model. Refer back to [Flask Setup](../requests-and-responses-in-flask/flask-hello-books.md) on how to define a blueprint and register it in `create_app`.

Lastly, we should (at the very least) define the following endpoints for our `Author` model for now:
- `GET ` to `/authors/<author_id>`
- `POST` to `/authors`

Again, refer back to [Building an API, Part 1](../building-an-api/read.md) on how to define the `GET` endpoint and the `POST` endpoint.


## Visualizing and Implementing the Relationship

So far we've seen relationships in databases strictly through ERDs and SQL commands. Below is an example of an ERD we might have created to visualize the relationship between `authors` and `books`.

We see that a `book` is connected to the `author` table by the author's `id` as a foreign key. This foreign key is defined as `author_id` in the `book` table. We could call it whatever we wish, just as we decided to add columns `title` and `description`. `author_id` is standard naming convention, however.

![An entity relational diagram describing a one-to-many relationship between books and authors in a SQL database](../assets/one-to-many-relationships-in-flask_erd.png)

( [source](https://draw.io) )

So how do we define this foreign key in our Flask models? Refer to the [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/14/orm/basic_relationships.html#one-to-many) first, then chck out our solution below. There are three ways we _could_ implement a one-to-many relationship in our models. Follow your curiosity and see if you can find out the differences between implementations.

<br />

<details>
  <summary>Check out our solution</summary>

  ``` python
  from app import db

  class Author:
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String)
    author_id = db.Column(db.Integer, db.ForeignKey('author.id'))
    author = db.relationship("Author", backref="books")
  ```
</details>

Now we have our `author_id`, but what is this new `author` attribute? And what in the world does `backref` do? Refer to the [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/14/orm/basic_relationships.html#one-to-many) or your search engine to find an answer.


### Don't Forget to Generate Migrations

Great! We've got a new model and made changes to our previous `Book` model. Sounds like it's time for another migration! Refer back to [Models Setup](../building-an-api/models-setup.md) to find the terminal commands for migration.


### !callout-danger

## Troubleshooting Migration Errors

Sometimes significant changes to models, like adding new not nullable attributes, will make migrating hairy. There's nothing wrong about deleteing the `migrations` folder in your project and trying again.

If you still receive errors, delete your  `migrations` folder, drop your database and then re-create it, and then try again!

### !end-callout

### !callout-danger


We are ready to create books _with_ an author! Let's move to the next lesson to learn how.