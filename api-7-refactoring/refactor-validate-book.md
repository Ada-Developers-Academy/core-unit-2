# Refactoring for Future Features

## Goals

Our goals are to:
- Refactor our blueprint name to follow common usage patterns.
- Refactor the function `validate_book` into a more flexible function `validate_model`, which can be used for any model class.

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`07b-from-dict-refactor` |`07c-validate-book-refactor`|

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

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

The `Book` class should have the following functions:
- `to_dict`
- `from_dict`

Our test folder should have 2 files: 
- `test_book_routes.py`
- `test_book_model.py`

</details>
</br>

## Why should we make these changes?

Planning ahead for work to come is another great reason we refactor. Here, we have the opportunity to make our code more flexible for future code changes. Right now our project has a single model `Book`, with the attributes `title` and `description`, but what other data is helpful when tracking books? If we're building this to share with other folks, we know that we're likely to add other models that represent authors or genres as we build out the functionality.

Before we start building out new features, we want to take stock of our project and see where we can more closely follow conventions or better follow D.R.Y. principles. We save time by getting our code into a more maintainable state now, over making changes later when we have more files that would need to be touched for the same updates.

## Refactoring the Blueprint name

A significant reason that we have coding conventions is that they make our code easier for other folks to understand and use. We chose the name `books_bp` for our blueprint in `book_routes.py`, and while this isn't a bad name–it is clear about its purpose–it doesn't follow the naming conventions we would see in most Flask projects. 

Typically a blueprint is called `bp`, rather than having a qualifying prefix in the name like `books_`. By breaking conventions, and thus the expectations readers are likely to have when looking at our project, there's an extra bit of thinking readers need to do when ramping up on the code. We can alleviate this cognitive load some by updating our blueprint name!

### Planning the Refactor

Our first task in this lesson is to follow the refactor process to rename `books_bp` to `bp` and handle any complications that may come with our changes. We won't be changing many lines of code, but we'll still benefit from following the steps we've established for planning and executing our refactor.

#### Check Dependencies

Our first stop is to find out, who is actually using `books_bp`? Take a moment to search the project, then compare your findings to ours in the drop-down below.

<details>
   <summary>Expand to the the dependencies we found.</summary>

Dependencies:
- All route functions in `book_routes.py`
- `create_app()` in `__init__.py`

</details>
</br>

#### Check for Tests

We previously wrote tests for the routes `create_book`, `get_all_books`, and `get_one_book`, so we can feel good about their test coverage. We are missing tests for the routes `update_book` and `delete_book` though, so let's pause and think through nominal and edge cases for `update_book` `delete_book`. We want to list out what test cases are missing that we'll need to write so that we can catch any potential regressions that might get introduced during the refactoring process.

<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 43d9c16k
* title: Identify Missing Test Cases
* 
##### !question
Take a few minutes to look over the functions `update_book` and `delete_book`, as well as the existing tests in `test_book_routes.py`. Make a list of missing nominal and edge cases for each function that would help confirm the functions' behavior. Enter those missing scenarios below, and when you're done, check out the explanation to see what test cases we identified. 
##### !end-question

##### !placeholder
The test cases I identified are...
##### !end-placeholder

##### !explanation
`update_book` Test Cases
- Updating a book successfully 
- Updating a book successfully when there are extra keys in the request
- Failing to update a book whose record `id` is not in the database
- Failing to update a record when the record `id` is invalid (non-integer)

<br>

`delete_book` Test Cases
- Deleting a book successfully
- Failing to delete a book whose record `id` is not in the database
- Failing to delete a record when the record `id` is invalid (non-integer)
##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->

Now that we've outlined what test cases we're missing, we'll go to `test_book_routes.py` and add new tests for the functions `update_book` and `delete_book`. Give writing the tests a try, then check out the tests we included below.

<details>
   <summary>New test cases for <code>update_book</code> and <code>delete_book</code></summary>

```python
def test_update_book(client, two_saved_books):
    # Arrange
    test_data = {
        "title": "New Book",
        "description": "The Best!"
    }

    # Act
    response = client.put("/books/1", json=test_data)
    response_body = response.get_json()

    # Assert
    assert response.status_code == 200
    assert response_body == "Book #1 successfully updated"

def test_update_book_with_extra_keys(client, two_saved_books):
    # Arrange
    test_data = {
        "extra": "some stuff",
        "title": "New Book",
        "description": "The Best!",
        "another": "last value"
    }

    # Act
    response = client.put("/books/1", json=test_data)
    response_body = response.get_json()

    # Assert
    assert response.status_code == 200
    assert response_body == "Book #1 successfully updated"

def test_update_book_missing_record(client, two_saved_books):
    # Arrange
    test_data = {
        "title": "New Book",
        "description": "The Best!"
    }

    # Act
    response = client.put("/books/3", json=test_data)
    response_body = response.get_json()

    # Assert
    assert response.status_code == 404
    assert response_body == {"message": "book 3 not found"}

def test_update_book_invalid_id(client, two_saved_books):
    # Arrange
    test_data = {
        "title": "New Book",
        "description": "The Best!"
    }

    # Act
    response = client.put("/books/cat", json=test_data)
    response_body = response.get_json()

    # Assert
    assert response.status_code == 400
    assert response_body == {"message": "book cat invalid"}

def test_delete_book(client, two_saved_books):
    # Act
    response = client.delete("/books/1")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 200
    assert response_body == "Book #1 successfully deleted"

def test_delete_book_missing_record(client, two_saved_books):
    # Act
    response = client.delete("/books/3")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 404
    assert response_body == {"message": "book 3 not found"}

def test_delete_book_invalid_id(client, two_saved_books):
    # Act
    response = client.delete("/books/cat")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 400
    assert response_body == {"message": "book cat invalid"}
```

</details>
</br>

### Executing the Refactor

At this point we should have passing tests for each of our routes and can start our incremental change cycle!

We will begin our changes in `book_routes.py` by updating the name `books_bp` to `bp` where it is declared and at each place it is referenced in the decorators above each route function. Once we've renamed the variable to `bp` where it is declared, we should expect to see issues running our tests until we finish our blueprint renaming refactors. 

We're done in `book_routes.py` once all `books_bp` references are updated to `bp`. Before we jump into the changes we want to make in `__init__.py`, let's talk about potential issues that could arise in the future with this renaming, and how we'll structure our code to avoid them.

#### Importing symbols with conflicting names

For our routes to be accessible, we need to import our blueprints in `__init__.py` and register the blueprints inside of the `create_app` function. In the future we will add new route files with their own blueprints, so if the convention is to name all blueprints `bp`, how do we handle importing multiple symbols with the same name in `__init__.py`?

It turns out that the Python import system is pretty flexible. Though there are more possibilities, we are going to touch on 2 approaches to handle imports with conflicting names, then choose one of them to move forward with through the rest of the project. Feel free to follow your curiosity about further importing patterns!

Our first option to deal with a naming collision is to import just the module name at the top of the file, then use `<module_name>.<symbol_name>` to access a specific symbol from the module. In our `hello-books` project we want to import the module `book_routes` and access the symbol `bp`, so that could look like:

```python
from .routes import book_routes
...

def create_app(config=None):
    ...

    # Register Blueprints here
    app.register_blueprint(book_routes.bp)
```

The second option we're exploring allows us to rename an imported symbol so that we can refer to it however we'd like inside of `__init__.py`. When we import a symbol using its default name, our import often looks like `from <module_name> import <symbol>`. There is a keywords `as` that we can use in our import statements to say that we want to import a symbol `as` some other name. In fact we could import `bp` as `books_bp` if that made sense for our project:

```python
from .routes.book_routes import bp as books_bp

def create_app(config=None):
    ...

    # Register Blueprints here
    app.register_blueprint(books_bp)
```

We feel that it's important to get used to seeing and working with imports renamed with `as`, so this is the importing strategy that we'll move forward with through the project. Just keep in mind that it is not the only valid or correct way to handle our imports! 

Once we have updated the import line in `__init__.py` to use `as`, our changes to rename `books_bp` to `bp` are complete! We should be able to run the test suite and see all tests passing.

![Happy seal with the text Green Checkmark Not Red X](../assets/api-7-refactoring/future-refactors_green-checkmark.jpg)  
*Fig. Happy Seal is excited to see our tests pass*

## Refactoring `validate_book`

Next up, we're going to examine how we can improve `validate_book`. Looking over `book_routes.py`, we can see that all of the routes which read or alter a model by `id` use the `validate_book` function. This makes sense, we're reusing code to fetch a single `Book` from the database, so that's all good right? Here's where we want to think about our upcoming work and new models. 

The `validate_book` function only works for our `Book` model–it isn't flexible enough to work for any model. If we keep up this pattern, every new model and its associated routes will require a validation function very similar to `validate_book`. For example, an new `Author` model would need a `validate_author` function for routes that read, update or delete an `Author` by `id`.

In a very small project this may not be cumbersome. But as a project and our number of models grows, it can become a pain point to maintain many versions of functions that perform the same general task. To combat replicating similar code through our project, we're going to refactor `validate_book` into a more flexible function `validate_model`.

We will do this by:
- Passing `validate_book` a new parameter `cls`
- Using `cls` in place of `Book`
- Updating naming and return values in the function to reflect that it is no longer specific to the `Book` class
- Moving `validate_model` to a new file `route_utilities.py` 

### !callout-info

## Why is the parameter `cls` used here? 

In a previous lesson, we needed to pass `cls` as the first parameter to a class method for the compiler to recognize it as a class method. `cls` is a common variable name when working with references to a class itself. In our case, we will be passing a reference to a model class into our `validate_model` function. Though we could choose to call the parameter something else (like `class_name` or `class_type`) we're going to stick with the convention of calling it `cls`.

### !end-callout

### Planning the Refactor

Check out the current `validate_book` code below if you'd like a reminder before we get into our planning steps.
<details>
   <summary>Current <code>validate_book</code> code in <code>book_routes.py</code></summary>

```python
def validate_book(book_id):
    try:
        book_id = int(book_id)
    except:
        response = {"message": f"book {book_id} invalid"}
        abort(make_response(response , 400))

    query = db.select(Book).where(Book.id == book_id)
    book = db.session.scalar(query)

    if not book:
        response = {"message": f"book {book_id} not found"}
        abort(make_response(response, 404))

    return book
```

</details>
</br>

#### Identify Dependencies

Let's find our `validate_book` dependencies! If we search the project for the phrase "`validate_book`", we should see 4 results: 
- The `validate_book` function definition
- usage in `read_one_book` 
- usage in `update_book`
- usage in `delete_book`

We can see our dependencies are the functions `read_one_book`, `update_book`, and `delete_book`, so let's remind ourselves of what the tests look like for those functions.

#### Check for Tests

From our previous work, we have unit tests for each of the route functions. However, we do not have tests for `validate_book` to confirm its behavior as we make modifications. Let's pause again and think through nominal and edge cases, this time for `validate_book`. 

<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 43d9c16j
* title: Identify Missing Test Cases
* 
##### !question
Take a few minutes to look over the function `validate_book` and the existing tests in `test_book_routes.py`. Make a list of missing nominal and edge cases for `validate_book` that would help confirm its behavior. Enter those missing scenarios below and when you're done, check out the explanation to see what test cases we identified. 
##### !end-question

##### !placeholder
The test cases I identified are...
##### !end-placeholder

##### !explanation
`validate_book` Test Cases
- Validating a book successfully
- Failing to validate a book whose record `id` is not in the database
- Failing to validate a record when the record `id` is invalid (non-integer)
##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->

We know what test cases we want to write now, but rather than moving back to `test_book_routes.py`, we're going to create a new test file `test_route_utilities.py` since we'll be writing `validate_model` in the new `route_utilities.py` file. This new file will hold tests for `validate_model` and any future helper functions we write that assist us with our routes, but aren't tied to a specific set of routes. 

Try out writing the `validate_book` tests, then check out the tests we included below.

<details>
   <summary>New test cases for <code>update_book</code>, <code>delete_book</code>, and <code>validate_book</code></summary>

```python
from werkzeug.exceptions import HTTPException
from app.routes import validate_book
import pytest
...

def test_validate_book(two_saved_books):
    # Act
    result_book = validate_book(1)

    # Assert
    assert result_book.id == 1
    assert result_book.title == "Ocean Book"
    assert result_book.description == "watr 4evr"

def test_validate_book_missing_record(two_saved_books):
    # Act & Assert
    # Calling `validate_book` without being invoked by a route will
    # cause an `HTTPException` when an `abort` statement is reached 
    with pytest.raises(HTTPException):
        result_book = validate_book("3")
    
def test_validate_book_invalid_id(two_saved_books):
    # Act & Assert
    # Calling `validate_book` without being invoked by a route will
    # cause an `HTTPException` when an `abort` statement is reached 
    with pytest.raises(HTTPException):
        result_book = validate_book("cat")
```

</details>
</br>

### Executing the Refactor

![Racoon rubbing hands with the text Time to Execute My Master Plan!](../assets/api-7-refactoring/future-refactors_execute_master_plan.jpeg)  
*Fig. Rowdy Raccoon is ready for refactors*

With all of our new and old tests passing, we can start the next step - writing failing tests!

#### The Cycle: Update Tests to Fail, Write Code to Make Them Pass

In our previous lessons' refactors we created brand new functions and were able to write out our test cases ahead of our implementation code. In this case, we're making several implementation changes to an existing function and renaming it. There are many ways we could approach testing at this point. We want to take a path that provides us with feedback as we make changes to our existing function. Taking this approach enables us to write code that meets our specified requirements, rather than writing code until we _think_ we’re done. Our recommendation is to start a cycle of making a small change to the `validate_book` tests so that they fail, then updating the code until the tests pass again, until all our changes are complete and all our tests are passing.

Let's review our inputs and outputs for `validate_model` so we can start our improvements. Our function `validate_model` will:
- Have a parameter `cls`, a reference to a model class (like `Book`)
- Have a parameter `model_id`, an integer representing the `id` of an instance of a model
- Return an instance of the model class represented by `cls` with an id of `model_id`, if it exists in the database
- Return a 404 error if `model_id` is an integer but no model with that `id` exists
- Return a 400 error if `model_id` is not an integer

#### Incremental Changes: Function Signature

When we change many things at once, it becomes more difficult to know which change caused an issue when an error arises. We'll avoid that by focusing on one alteration at a time. 

The first thing we'll do is update our `validate_book` tests to pass `Book` as the first argument, and an `id` as the second argument when invoking `validate_book`. To get access to the `Book` class in our test file, we'll need to import `Book` with the line `from app.models.book import Book`. The updated code for `test_validate_book` is below; we're showing one example, but we are making the same change to all `validate_book` tests.

```python
from app.models.book import Book
...

def test_validate_book(two_saved_books):
    # Act
    # Add `Book` argument to `validate_book` invocation
    result_book = validate_book(Book, 1)

    # Assert
    assert result_book.id == 1
    assert result_book.title == "Ocean Book"
    assert result_book.description == "watr 4evr"
```

We should immediately see the `validate_book` tests failing and can move over to `book_routes.py` and make the corresponding change to `validate_book`. We'll add `cls` as the first parameter to `validate_book` and our function signature should look like:

```python
def validate_book(cls, book_id):
    ...
```
As soon as we do this, `book = Book.query.get(book_id)`'s tests will pass and the tests for our dependent routes will start to fail – No worries, this is expected! We'll get the dependent route tests back to passing by looking for where `validate_book` is invoked, and adding `Book` as our first argument: `validate_book(Book, book_id)`. Check out the updated code for `read_one_book` below as an example.

```python
@bp.get("/<book_id>")
def get_one_book(book_id):
    book = validate_book(Book, book_id)
    return book.to_dict()
```

Our tests should all be passing again at this point 🎉. Now let's make use of that new `cls` parameter! In `validate_book` we have the line:

```python
query = db.select(Book).where(Book.id == book_id)
```

We want to replace the use of `Book` here with our `cls` parameter:

```python
query = db.select(cls).where(cls.id == model_id)
```

Running our test suite again, we should still see everything passing.

#### Incremental Changes: Error Messages

Now that we're using the `cls` parameter for the query, we want ensure that our `abort` messages will make sense no matter what model class is passed into `cls`. Right now those messages are hard coded to start with "book", but what we'd like to do is to get a user-friendly name from the `cls` parameter to use instead. We can do this by calling `__name__` on a class reference, for example:

```python
# Prints the string "Book"
print(Book.__name__)
```

If we take a look across our test suite, we have test cases that cover expected error messages for our dependent routes. Similar to our most recent change, we want our behavior to be exactly the same before and after, so let's try using `cls.__name__` in our `abort` messages. Give it a try, then check out our updated code below:

<details>
   <summary>Updated abort messages for <code>validate_book</code> function example</summary>

```python
def validate_book(cls, book_id):
    try:
        book_id = int(book_id)
    except:
        response = {"message": f"{cls.__name__} {model_id} invalid"}
        abort(make_response(response , 400))

    query = db.select(cls).where(cls.id == book_id)
    book = db.session.scalar(query)

    if not book:
        response = {"message": f"{cls.__name__} {model_id} not found"}
        abort(make_response(response, 404))

    return book
```

</details>
</br>

Running our tests, we expect them to all be passing...but they're not! Our tests that check `abort` messages for `read_one_book`, `update_book`, and `delete_book` are now failing. If we take a look at one of the failing tests, we should see an error similar to what's shown below:

```
Failed: [undefined]AssertionError: assert {'message': '... 3 not found'} == {'message': '... 3 not found'}
  Differing items:
  {'message': 'Book 3 not found'} != {'message': 'book 3 not found'}
```

Taking this line-by-line, we can see that we have an `AssertionError` around the `message` returned. The test was expecting `{'message': 'book 3 not found'}`, but it got a response with different capitalization: `{'message': 'Book 3 not found'}`. Our change `cls.__name__` gives us the exact name of our class, which is capitalized, so the string is different from what our tests expect! 

We could change our `validate_book` code to lowercase the result of `cls.__name__` so our tests pass again, but in this case we're going to choose to update our tests and keep the new capitalization; either choice is valid for `hello_books`. In the industry, and generally when working with other people, we would consult with folks who are invested in the project before changing user-facing messages. Once we've gone through and updated the expected messages for our failing tests, we should see everything passing again.

#### Incremental Changes: Update Function and Variable Names

We're nearing the end of our refactor! All the practical changes have been made for `validate_book` to use a class reference in place of hard coding `Book`, but the purpose of our function no longer matches the naming. Furthermore, our variable names and the `book_id` parameter don't accurately reflect what they hold. 

Let's do another cycle of tests followed by code changes to make our code easier to read and understand. We'll start out by updating our `validate_book` tests to fail by changing both the test names and our invocation of the function to use the new name `validate_model`. Try out making those updates, then check out our updated tests below when ready.

<details>
   <summary>Updated <code>validate_model</code> tests example</summary>

```python
from app.routes import validate_model
...

def test_validate_model(two_saved_books):
    # Act
    result_book = validate_model(Book, 1)

    # Assert
    assert result_book.id == 1
    assert result_book.title == "Ocean Book"
    assert result_book.description == "watr 4evr"

def test_validate_model_missing_record(two_saved_books):
    # Act & Assert
    # Calling `validate_model` without being invoked by a route will
    # cause an `HTTPException` when an `abort` statement is reached 
    with pytest.raises(HTTPException):
        result_book = validate_model(Book, "3")
    
def test_validate_model_invalid_id(two_saved_books):
    # Act & Assert
    # Calling `validate_model` without being invoked by a route will
    # cause an `HTTPException` when an `abort` statement is reached 
    with pytest.raises(HTTPException):
        result_book = validate_model(Book, "cat")
```

</details>
</br>

Once we update the `import` at the top of the file that brings `validate_model` into `test_book_routes.py`, we'll likely get a test discovery error since `validate_model` doesn't exist yet. We'll address that issue first by changing the function name in `book_routes.py` from `validate_book` over to `validate_model`. 

```python
def validate_model(cls, book_id):
    ...
```

Once that's done, we can run our tests again, and see that the tests for our dependent functions are failing again. We'll go through and update `read_one_book`, `update_book`, and `delete_book` to use the new function name `validate_model`, and we should see everything passing again.

To get our variable names back in alignment with what they represent, we'll rename our parameter `book_id` and variable names to use `model` in place of `book`. When we've completed our work, our whole test suite should remain passing! 

```python
def validate_model(cls, model_id):
    try:
        model_id = int(model_id)
    except:
        response = {"message": f"{cls.__name__} {model_id} invalid"}
        abort(make_response(response , 400))

    query = db.select(cls).where(cls.id == model_id)
    model = db.session.scalar(query)
    
    if not model:
        response = {"message": f"{cls.__name__} {model_id} not found"}
        abort(make_response(response, 404))
    
    return model
```

We now have a function flexible enough to use with any model class we add to our project in the future, and we refactored in a way that let us isolate changes and confirm behavior each step of the way! 

#### Final touches: Moving `validate_model`

Our finishing touch is to move `validate_model` out of `book_routes.py` and into a new file inside of the `routes` folder named `route_utilities.py`. By moving `validate_model` out of `book_routes.py` we ensure that future route files don't need to know about each other to import and use the `validate_model` function. 

Let's jump into our last cycle of making our tests fail, then updating our code to make them pass!

First we'll update `test_route_utilities.py` to change where we're importing `validate_model` from. We know we'll be creating a file named `route_utilities.py` inside of `routes`, so our import should look like:

```python
from app.routes.route_utilities import validate_model
```

Once we update our import, we should see a test discovery error because `route_utilities.py` doesn't exist yet. Let's fix those errors by creating our new file with: 

```python
touch app/routes/route_utilities.py
``` 

Then we can copy & paste `validate_model` into `route_utilities.py` and delete it from `book_routes.py`. For `validate_model` to work, `route_utilities.py` will also need to bring in imports for the database and flask utilities it references. Try making these changes, then take a look at our completed `route_utilities.py` file below.

<details>
   <summary>Finished code in <code>route_utilities.py</code></summary>

```python
from flask import abort, make_response
from ..db import db

def validate_model(cls, model_id):
    try:
        model_id = int(model_id)
    except:
        response = {"message": f"{cls.__name__} {model_id} invalid"}
        abort(make_response(response , 400))

    query = db.select(cls).where(cls.id == model_id)
    model = db.session.scalar(query)
    
    if not model:
        response = {"message": f"{cls.__name__} {model_id} not found"}
        abort(make_response(response, 404))
    
    return model
```

</details>
</br>

At this point we should still have an issue running our tests. In theory our tests in `test_route_utilities.py` should be passing, but since we've removed `validate_model` from `book_routes.py`, our dependent routes can't find the function and all of their tests should be failing. 

Our last change is to add a new import to `book_routes.py` to bring in `validate_model` from its new location:

```python
from .route_utilities import validate_model
```

Once we add this import, our changes are done! We should be able to run our full test suite and see everything in `test_book_routes.py` and `test_route_utilities.py` passing 🎉. 

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: 43d9c16g
* title: Refactoring for Future Features
##### !question

Select all of the options below that are valid reasons to move `validate_model` out of `book_routes.py` and place it in a new file `route_utilities.py`.

##### !end-question
##### !options

a| `validate_model` isn't tied to a specific route or set of routes, so we don't want to package it with route functions.
b| We want `book_routes.py` to only be responsible for `Book` route functions so that our file has a single purpose.
c| `book_routes.py` is getting long and we want to keep our files shorter.
d| When we add route files in the future, they shouldn't need to know about each other to use utilities like `validate_model`.

##### !end-options
##### !answer

a|
b|
d|

##### !end-answer
##### !hint

Can the Single Responsibility Principle apply to files as well as functions? Is a long file necessarily a bad thing?

##### !end-hint
##### !explanation

1. Correct
2. Correct
3. It is okay if a file is getting long if we are following best practices like reducing repetition and only keeping highly related code co-located. 
4. Correct

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->