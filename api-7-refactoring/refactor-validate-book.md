# Refactoring `validate_book`

## Goals

Our goal is to refactor the function `validate_book` into a more flexible function `validate_model`, which can be used for any model class.

We will do this by:
- Passing `validate_book` a new parameter `cls`
- Using `cls` in place of `Book`
- Updating naming and return values in the function to reflect that it is no longer specific to the `Book` class

### !callout-info

## Why is the parameter `cls` used here? 

In the previous lesson, we needed to pass `cls` as the first parameter to a class method for the compiler to recognize it as a class method. `cls` is a common variable name when working with references to a class itself. In our case, we will be passing a reference to a model class into our `validate_model` function. Though we could choose to call the parameter something else (like `class_name` or `class_type`) we're going to stick with the convention of calling it `cls`.

### !end-callout

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
- `test_routes.py`
- `test_models.py`

</details>
</br>

## Refactoring for the Future

Planning ahead for work to come is another great reason we refactor. For this lesson's refactor, we're going to be peeking into the future of `Hello Books` a bit. Right now our project has a single model `Book`, with the attributes `title` and `description`, but what other data is helpful when tracking books? If we're building this to share with other folks, we know that we're likely to add other models that represent authors or genres as we build out the functionality.

Taking a look over `routes.py`, we can see that all of the routes that read or alter a model by `id` use the `validate_book` function. This makes sense, we're reusing code to fetch a single `Book` from the database, so that's all good right? Here's where we want to think about our upcoming models. 

The addition of any new model and its associated routes will require a validation function very similar to `validate_book`. For example an added `Author` model needs a `validate_author` function for routes that read, update or delete an `Author` by `id`.  

Because we currently lack a function flexible enough to work for any model, we need a custom validate function for every model we add. In a very small project, this may not be cumbersome, but as a project grows it can become a pain point, especially if there is ever a need to update the pattern for fetching a model.

## Planning the Refactor

Check out the current `validate_book` code below if you'd like a reminder before we get into our planning steps.
<details>
   <summary>Current <code>validate_book</code> code</summary>

```python
def validate_book(book_id):
    try:
        book_id = int(book_id)
    except:
        abort(make_response({"message":f"book {book_id} invalid"}, 400))

    book = Book.query.get(book_id)

    if not book:
        abort(make_response({"message":f"book {book_id} not found"}, 404))

    return book
```

</details>
</br>

### Identify Dependencies

As always, our first stop is our dependencies check. If we search the project for the phrase "`validate_book`", we should see 4 results: 
- The validate_book function definition
- usage in `read_one_book` 
- usage in `update_book`
- usage in `delete_book`

We can see our dependencies are the functions `read_one_book`, `update_book`, and `delete_book`, so let's see what our tests look like for those functions.

### Check for Tests

We previously wrote tests for `read_one_book`, so we can feel good about that function's coverage, but we don't have any tests for the functions `update_book` or `delete_book`. Furthermore, we don't have tests for `validate_book` to confirm its behavior as we make modifications. 

Let's pause and think through nominal and edge cases for the functions `update_book`, `delete_book`, and `validate_book`. We'll add tests for these functions to `test_routes.py`. Give writing the tests a try, then check out the tests we included below.

<details>
   <summary>New test cases for <code>update_book</code>, <code>delete_book</code>, and <code>validate_book</code></summary>

```python
from werkzeug.exceptions import HTTPException
from app.routes import validate_book
import pytest
...

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

## Executing the Refactor

With all of our new and old tests passing, we can start the next step - writing failing tests!

### The Cycle: Update Tests to Fail, Write Code to Make Them Pass

In our previous refactors we created brand new functions and were able to write out our test cases ahead of our implementation code. In this case, we're making several implementation changes to an existing function and renaming it. There are many ways we could approach testing at this point, but we want to take a path that lets us get feedback as we make changes to our existing function rather than when we think we're done. Our recommendation is to start a cycle of making a small change to the `validate_book` tests so that they fail, then updating the code until the tests pass again, until all our changes are complete and all our tests are passing.

Let's review our inputs and outputs for `validate_model` so we can start our improvements. Our function `validate_model` will:
- Have a parameter `cls`, a reference to a model class (like `Book`)
- Have a parameter `model_id`, an integer representing the `id` of an instance of a model
- Return an instance of the model class represented by `cls` with an id of `model_id`, if it exists in the database
- Return a 404 error if `model_id` is an integer but no model with that `id` exists
- Return a 400 error if `model_id` is not an integer

### Incremental Changes: Function Signature

When we change many things at once, it becomes more difficult to know which change caused an issue when an error arises. We'll avoid that by focusing on one alteration at a time. 

The first thing we'll do is update our `validate_book` tests to pass `Book` as the first argument, and an `id` as the second argument when invoking `validate_book`. The updated code for `test_validate_book` is below; we're showing one example, but we are making the same change to all `validate_book` tests.

```python
def test_validate_book(two_saved_books):
    # Act
    # Add `Book` argument to `validate_book` invocation
    result_book = validate_book(Book, 1)

    # Assert
    assert result_book.id == 1
    assert result_book.title == "Ocean Book"
    assert result_book.description == "watr 4evr"
```

We should immediately see the `validate_book` tests failing and can move over to `routes.py` and make a corresponding change to `validate_book`. We'll add `cls` as the first parameter to `validate_book` and our function signature should look like:

```python
def validate_book(cls, book_id):
    ...
```
As soon as we do this, `book = Book.query.get(book_id)`'s tests will pass and the tests for our dependent routes will start to fail – No worries, this is expected! We'll get the dependent route tests back to passing by looking for where `validate_book` is invoked, and adding `Book` as our first argument: `validate_book(Book, book_id)`. Check out the updated code for `read_one_book` below as an example.

```python
@books_bp.route("/<book_id>", methods=["GET"])
def read_one_book(book_id):
    book = validate_book(Book, book_id)
    return book.to_dict()
```

Our tests should all be passing again at this point 🎉. Now let's make use of that `cls` parameter! In `validate_book` we have the line:

```python
book = Book.query.get(book_id)
```

We want to replace the use of `Book` here with our `cls` parameter:

```python
book = cls.query.get(book_id)
```

Running our test suite again, we should still see everything passing.

### Incremental Changes: Error Messages

Now that we're using the `cls` parameter for the query, we want ensure that our `abort` messages will make sense no matter what model class is passed into `cls`. Right now those messages are hard coded to start with "book", but what we'd like to do is to get a user-friendly name from the `cls` parameter to use instead. We can do this by calling `__name__` on a class reference, for example:

```python
# Prints the string "Book"
print(Book.__name__)
```

If we take a look across our test suite, we have test cases that cover expected error messages for our dependent routes. Similar to our most recent change, we want our behavior to be exactly the same before and after, so let's try using `cls.__name__` in our `abort` messages. Give it a try then check out our updated code below:

<details>
   <summary>Updated abort messages for <code>validate_book</code> function example</summary>

```python
def validate_book(cls, book_id):
    try:
        book_id = int(book_id)
    except:
        abort(make_response({"message":f"{cls.__name__} {book_id} invalid"}, 400))

    book = Book.query.get(book_id)

    if not book:
        abort(make_response({"message":f"{cls.__name__} {book_id} not found"}, 404))

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

We could change our `validate_book` code to lowercase the result of `cls.__name__` so our tests pass again, but in this case we're going to choose to update our tests and keep the new capitalization. Once we've gone through and updated the expected messages for our failing tests, we should see everything passing again.

### Final Touches: Update Function and Variable Names

We're nearing the end of our refactor! All the practical changes have been made for `validate_book` to use a class reference in place of hard coding `Book`, but the purpose of our function no longer matches the naming. Furthermore, our variable names and the `book_id` parameter don't accurately reflect what they hold. 

Let's do one more cycle of tests followed by code changes to make our code easier to read and understand. We'll start out by updating our `validate_book` tests to fail by changing both the test names and our invocation of the function to use the new name `validate_model`. Try out making those updates, then check out our updated tests below when you're ready.

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

Once we update the `import` at the top of the file that brings `validate_model` into `test_routes.py`, we'll likely get a test discovery error since `validate_model` doesn't exist yet. We'll address that issue first by changing the function name in `routes.py` from `validate_book` over to `validate_model`. 

```python
def validate_model(cls, book_id):
    ...
```

Once that's done, we can view our tests again, and see that the tests for our dependent functions are failing again. We'll go through and update `read_one_book`, `update_book`, and `delete_book` to use the new function name `validate_model`, and we should see everything passing again.

For our finishing touches, we'll rename our parameter `book_id` and variable names to use `model` in place of `book`. When we've completed our work, our whole test suite should remain passing, and our refactor is complete! 

```python
def validate_model(cls, model_id):
    try:
        model_id = int(model_id)
    except:
        abort(make_response({"message":f"{cls.__name__} {model_id} invalid"}, 400))

    model = cls.query.get(model_id)

    if not model:
        abort(make_response({"message":f"{cls.__name__} {model_id} not found"}, 404))

    return model
```

We now have a function flexible enough to use with any model class we add to our project in the future, and we did it in a way that let us isolate changes and confirm behavior each step of the way!

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 43d9c16g
* title: Refactoring
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->