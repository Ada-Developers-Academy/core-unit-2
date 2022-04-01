# One-to-Many Relationships

## Goals

Our goal for this lesson is to use it as a reference for establishing relationships in Flask with SQLAlchemy.

Our goals for this lesson are to:
* Connect two tables in a one-to-many relationship with SQLAlchemy
* Utilize documentation and problem solving to find missing information

We will:
* Create an Author model
* Connect the Author model to the Book Model
    * One-to-many relationship: An author can have many books.

### !callout-info

### Independent Research

This lesson asks us to do more independent research than the previous **Building an API** topics.

### !end-calout

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`06e-post-books-test` |`07a-author-model`|

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>
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
</br>

## Author Model, Blueprint, and Routes

Currently, we have the `Book` model in our Hello Books API database. Our first step to building the one-to-many relationship between books and authors is to define an `Author` model in a new file `author.py` inside the `models` folder. 

An `author` should have the following attributes with the specified types: 
  * `id`, integer, primary key
  * `name`, string.

<br />

<details>
  <summary>Give this a try on your own, then expand to see our solution.</summary>

  ``` python
  from app import db

  class Author:
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String)
  ```
</details>
</br>

Next, we will make a Blueprint that groups the endpoints for our `Author` model. Refer back to [01) Building an API - Hello World Routes](../api-1-setup-read/hello-world-routes.md) on how to define a blueprint and register it in `create_app`.

The last thing we'll do is create the following endpoints for our `Author` model:
- `GET ` to `/authors`
- `POST` to `/authors`

Refer back to [03) Building an API - Read All Books](../api-3-database-models-read/read-all-books.md) for how to define the `GET` endpoint and the `POST` endpoint.

<details>
  <summary>Give this a try on your own, then expand to see our solution.</summary>

We can add the `author` routes to our original `routes.py` file. Alternatively,  we can refactor our code into separate route files: `book_routes.py` and `author_routes.py`.

```python
# app/author_routes.py
from app import db
from app.models.author import Author
from flask import Blueprint, jsonify, abort, make_response, request

authors_bp = Blueprint("authors_bp", __name__, url_prefix="/authors")

@authors_bp.route("", methods=["POST"])
def create_author():
    request_body = request.get_json()
    new_author = Author(name=request_body["name"],)

    db.session.add(new_author)
    db.session.commit()

    return make_response(jsonify(f"Author {new_author.name} successfully created"), 201)

@authors_bp.route("", methods=["GET"])
def read_all_authors():
    
    authors = Author.query.all()

    authors_response = []
    for author in authors:
        authors_response.append(
            {
                "name": author.name
            }
        )
    return jsonify(authors_response)
```

</details>

## Visualizing and Implementing the Relationship

Let's visualize the relationship between `book`s and `author`s. Just like we did when we built relationships in SQL, we will use an **entity relationship diagram** to visualize the relationship between `book`s and `author`s.

![An entity relationship diagram describing a one-to-many relationship between authors and books](../assets/one-to-many-relationships-in-flask_erd.png)  

_Fig. ERD describing a one-to-many relationship between authors and books_

We can see that a `book` is connected to the `author` table by the author's `id` as a foreign key. This foreign key is defined as `author_id` in the `book` table. While we could call it whatever we wish, naming it `author_id` follows a standard convention for naming foreign keys.

How do we define this foreign key in our Flask models? Refer to the [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/14/orm/basic_relationships.html#one-to-many), try it out, then check out our solution below. There are several ways we _could_ implement a one-to-many relationship in our models. Follow your curiosity if you are interested in some of the other possible approaches. (For example, what is the difference between `back_populates` and `backref`? Is one more efficient?)

<br />

<details>
  <summary>Updated <code>Author</code> model</summary>

  ```python
  from app import db

  class Author(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String)
    books = db.relationship("Book", back_populates="author")
  ```
</details>

<br/>

<details>
  <summary>Updated <code>Book</code> model</summary>

  ```python
  from app import db

  class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String)
    description = db.Column(db.String)
    author_id = db.Column(db.Integer, db.ForeignKey('author.id'))
    author = db.relationship("Author", back_populates="books")
  ```
</details>

Now we have our `author_id` in the `Book` model, but what is the new `books` attribute in `Author`? And what purpose does `backref` serve? Refer to the [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/14/orm/basic_relationships.html#one-to-many) or your favorite search engine to find an answer.

### Don't Forget to Generate Migrations

Great! We've got a new model and made changes to our previous `Book` model. Sounds like it's time for another migration! We can refer back to [Models Setup](../api-3-database-models-read/models-setup.md) to review the terminal commands for migration.

### !callout-danger

## Troubleshooting Migration Errors

The tools that detect model changes aren't perfect. When we make changes to existing models, sometimes the state of our data combined with the model changes can make migrating difficult. As we gain more experience working with migrations, we'll learn how to troubleshoot those difficulties, but for now, there's nothing wrong with deleting our migrations history and the existing database, then trying again.

<br/>

First, delete the `migrations` folder in the project, and drop the project database. Next, recreate the project database, and reinitialize the flask database setup. Then rerun the migration detection and upgrade steps.

### !end-callout

We are ready to create books _with_ an author! Let's move to the next lesson to learn how.

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: fea7f5a1-c411-4145-9a92-959b24f180f7
* title: One-to-Many Relationships in Flask
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
