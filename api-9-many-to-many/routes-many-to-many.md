# Many-to-Many: Nested Routes

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

Note: This custom route is one way to create a relationship between `Book` and `Genre` instances. Consider how else we might create these relationships, for instance with a `POST` `/genres/<genre_id>/books` route. Refer back to our [nested route for creating `Book`s by a specifict `Author`](../api-7-relationships-in-sqlalchemy/nested-routes-in-flask.md)

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
* id: c717888a-5e1a-4891-8d14-a79353f45163
* title: Many-to-Many: Nested Routes
##### !question

Check off all the features you've written and tested.

##### !end-question
##### !options

* Create `PATCH` `/book/<books_id>/assign_genres` route
* Refactor `GET` `/books` routes to use `to_dict` instance method.

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->