# D.R.Ying Our Routes

## Goals

Our goals for this lesson are to:
* Reduce repeated or similar code in our route files
* Separate common model actions from route-specific business logic

We will follow our refactoring best practices to:
* Move code that creates and returns a JSON representation of a model to a new function named `create_model` in route_utilities.py
* Move code that queries, filters, and returns a JSON representation of model records to a new function named `get_models_with_filters` in route_utilities.py

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`08b-nested-routes` |`08c-route-utilities-refactors`|

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined that contains the instance method `to_dict` and class method `from_dict`
- An `author` table defined
- An `Author` model defined that contains the instance method `to_dict` and class method `from_dict`

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
- `author_id` (model only)
- `author` (model only)

The `Author` model and table should have the following columns:
- `id`
- `name`
- `books` (model only)

`route_utilities.py` should contain:
- The function `validate_model()` that can retrieve a model of any type

</details>
</br>

## Identifying Refactors

We've done this before in pt. 7 of the Building an API series, so let's practice the skills we've built to take a critical lens to our route files `author_routes.py` and `book_routes.py`.

### Comparing `create` functions

Let's start from the top and analyze our `create_author` route in `author_routes.py` and our `create_book` route in `book_routes.py`.

```py
# author_routes.py
@bp.post("")
def create_author():
    request_body = request.get_json()

    try:
        new_author = Author.from_dict(request_body)
        
    except KeyError as error:
        response = {"message": f"Invalid request: missing {error.args[0]}"}
        abort(make_response(response, 400))
    
    db.session.add(new_author)
    db.session.commit()

    return make_response(new_author.to_dict(), 201)
```

```py
# book_routes.py
@bp.post("")
def create_book():
    request_body = request.get_json()

    try:
        new_book = Book.from_dict(request_body)

    except KeyError as error:
        response = {"message": f"Invalid request: missing {error.args[0]}"}
        abort(make_response(response, 400))

    db.session.add(new_book)
    db.session.commit()

    return new_book.to_dict(), 201
```

If we look across these two functions, the significant differences are:
* The function names: `create_author` and `create_book`
* The name of the new model variable: `new_author` and `new_book`
* The name of the class which calls `from_dict`: `Author` and `Book`

All of our other actions are the same:
1. We store the request body in a variable named `request_body`
2. We try to create a model, and if it raises an exception we share the same error
3. We add and commit the new model
4. We call `to_dict` on the new model and return the dictionary of data and a 201 status code

We are repeating a lot of the same steps in these two functions! This should signal to us that we could refactor most of the work to a single shared function. We'll address refactoring `create_author` and `create_book` shortly, but let's continue to examine our route files for further routes we could D.R.Y. up.

### Comparing `get_all` functions

We have another couple routes with similar names to take a look at: `get_all_books` and  `get_all_authors`. We have removed the comments in `get_all_books` below to make it a little easier to compare just the code of the two functions.

```py
# author_routes.py
@bp.get("")
def get_all_authors():
    query = db.select(Author)

    name_param = request.args.get("name")
    if name_param:
        query = query.where(Author.name.ilike(f"%{name_param}%"))

    authors = db.session.scalars(query.order_by(Author.id))
    authors_response = [author.to_dict() for author in authors]

    return authors_response
```

```py
# book_routes.py
@bp.get("")
def get_all_books():
    query = db.select(Book)

    title_param = request.args.get("title")
    if title_param:
        query = query.where(Book.title.ilike(f"%{title_param}%"))

    description_param = request.args.get("description")
    if description_param:
        query = query.where(Book.description.ilike(f"%{description_param}%"))

    books = db.session.scalars(query.order_by(Book.id))
    books_response = []
    for book in books:
        books_response.append(book.to_dict())

    return books_response
```

These functions both perform similar actions. They:
1. Create a variable `query` by calling `db.select` on a model
2. Check the `request.args` dictionary for certain filter names
3. Update the `query` variable to apply a `where` clause for each filter value 
4. Use `db.session.scalars` to fetch the models that match our `query`
5. Call `to_dict` on each fetched model to create a list of dictionaries for our response
6. Return the response

Here, our significant differences are:
* The name of the class used to identify an attribute in the where clauses
* The number of filters each function applies
* The names of the list variables for the models and their dictionary representations
* The name of the class which calls `to_dict`
* The syntax used to create the list variable which holds the dictionary representations

This refactor is going to take a little more work than the `create` refactor even though both functions are performing the same basic steps. We can addresses most of the differences by writing a new function that accepts a class as a parameter, updating the variable naming to be more generic, and using list comprehension syntax to make our response list, but how do we support a varying numbers of filters? 

So far we have been using `get` on the `request.args` dictionary to check for specific filters, but what if we iterated over the keys of the dictionary and applied whatever filters were valid for the model? We will look at this option to address filtering arbitrary models further in the lesson.

## Model Creation Refactors

We have identified the code that we want to refactor, starting with our `create_author` and `create_book` routes. Our goal is to create a new function `create_model` in our `route_utilities.py` file which handles all of the repeated steps and that we can call from our existing routes. 

To have the information that the function needs to create a new model the `create_model` function will have to take in 2 parameters:
* `cls`, representing the class name of the model we want to create
* `model_data`, a dictionary containing the names of attributes and their values for the model we want to create 

Now we can take a moment to prepare ourselves for the refactor by continuing our refactoring steps to identify and test any dependencies on our routes!

### Identifying Dependencies & Testing

If we search the project, we should only see tests that use the create routes-nothing is independently making a call to the `create_author` or `create_book` functions. Without dependent functions calling the `create_author` and `create_book` functions, we don't need to worry about writing tests for existing functions at this moment. 

When we worked on the `validate_model` refactor, we had an existing function `validate_book` that we wrote tests for and then incrementally updated. We don't have a pre-existing function in this case, so if we're following TDD, this is the time to think about the inputs and outputs of our new `create_model` function should be and how we want to test them. 

<details>
   <summary>Take a moment to brainstorm, then write, nominal and edge cases for the <code>create_model</code> function we've described in <code>test_route_utilities.py</code>. Expand this section when done to see the limited tests we created.</summary>

```py
# test_route_utilities.py
from app.routes.route_utilities import validate_model, create_model
from werkzeug.exceptions import HTTPException
from app.models.book import Book
from app.models.author import Author
import pytest

# We use the `client` fixture because we need an
# application context to work with the database session
def test_create_model_book(client):
    # Arrange
    test_data = {
        "title": "New Book",
        "description": "The Best!"
    }

    # Act
    result = create_model(Book, test_data)

    # Assert
    assert result.status_code == 201
    assert result.get_json() == {
        "id": 1,
        "title": "New Book",
        "description": "The Best!"
    }

def test_create_model_book_missing_data(client):
    # Arrange
    test_data = {
        "description": "The Best!"
    }

    # Act & Assert
    # Calling `create_model` without being invoked by a route will
    # cause an `HTTPException` when an `abort` statement is reached 
    with pytest.raises(HTTPException) as error:
        result_book = create_model(Book, test_data)

    response = error.value.response
    assert response.status == "400 BAD REQUEST"

def test_create_model_author(client):
    # Arrange
    test_data = {
        "name": "New Author"
    }

    # Act
    result = create_model(Author, test_data)

    # Assert
    assert result.status_code == 201
    assert result.get_json() == {
        "id": 1,
        "name": "New Author"
    }
```

</details>
</br>

### Performing the refactor

We have some failing tests for our `create_model` function that doesn't exist yet, so we're ready to begin the refactor work to make our tests pass! Our first step will be to write our more generic function `create_model` and get our tests passing, then we will update the existing routes to use our new function.

Set a timebox to try out moving all the similar steps from `create_author` and `create_book` into a new function `create_model` in `route_utilities.py`. Then, use the arguments we defined for the function to replace specific uses of a class name with `cls` and update any class-specific variable names to be more generic, to better reflect that those variables could hold any new model instance.

<details>
   <summary>When done, expand this section to see how we built the <code>create_model</code> function.</summary>

```py
# route_utilities.py
def create_model(cls, model_data):
    try:
        new_model = cls.from_dict(model_data)
        
    except KeyError as error:
        response = {"message": f"Invalid request: missing {error.args[0]}"}
        abort(make_response(response, 400))
    
    db.session.add(new_model)
    db.session.commit()

    return new_model.to_dict(), 201
```

</details>
</br>

At this point all of our tests including our new ones in `test_route_utilities.py` should be passing! Now, we can start incrementally updating the `create_book` route. When that work is complete and all of the `create_book` tests are passing again, only then should we start making changes to the `create_author` function. The order in which we update these functions isn't important, we could choose to update `create_author` first, but it's vital to only update one function at a time so that we know where issues are coming from if they arise.

<details>
   <summary>Try out changing the <code>create_author</code> and <code>create_book</code> routes to import and use the <code>create_model</code> helper function, then expand this section to see how we finished up the refactor!</summary>

```py
# author_routes.py

# ...
from .route_utilities import create_model, validate_model
# ...

@bp.post("")
def create_author():
    request_body = request.get_json()
    return create_model(Author, request_body)
```

```py
# book_routes.py

# ...
from .route_utilities import create_model, validate_model
# ...

@bp.post("")
def create_book():
    request_body = request.get_json()
    return create_model(Book, request_body)
```
</details>
</br>

As long as our test suite passes...
![Squirrel on a bench, raising its arms with the text "It's done!"](../assets/api-8-one-many/squirrel_its_done.jpg)

## Filtering Models Refactors

### Working with `hasattr` and `getattr`


## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: 3199d93c-25f6-4e29-819b-99fbe4b0b1e6
* title: D.R.Ying Our Routes
##### !question



##### !end-question
##### !options

a| 
b| 
c| 
d| 
e| 

##### !end-options
##### !answer



##### !end-answer
##### !hint



##### !end-hint
##### !explanation



##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->

