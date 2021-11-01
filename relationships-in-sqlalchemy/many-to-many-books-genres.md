# Many-to-Many: Books and Genres

## BookGenre Model

Next, we will establish another model for the join table that connects `Books` to `Genres`. 

Our `books_genres` table should have the following attributes: a `book_id` as one foreign key and a `genre_id` as the other foreign key. 

<br/>

<details>
  <summary>Click here for one way to implement the BookGenre model.</summary>

  ``` python
  # app/models/book_genre.py
  from app import db

  class BookGenre(db.Model):
    __tablename__ = "books_genres"
    book_id = db.Column(db.Integer, db.ForeignKey('book.id'), primary_key=True,nullable=False)
    genre_id = db.Column(db.Integer, db.ForeignKey('genre.id'), primary_key=True,nullable=False)

  ```
</details>

