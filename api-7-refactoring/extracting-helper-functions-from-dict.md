# Extracting Helper Functions Pt. 2

## Goals
Our goals for this lesson are to: 
- Define class method syntax
- Create a class method named `from_dict` in `book.py` 
- Refactor the code for creating a `Book` model in the `create_book` route to use `from_dict`

To do this we will follow the same steps of planning then executing a refactor as outlined in the previous lesson. 

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`07a-to-dict-refactor` |`07b-from-dict-refactor`|

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

Our test folder should have 2 files: 
- `test_routes.py`
- `test_models.py`

</details>
</br>

| Vocab | Definition | Synonyms | How to Use in a Sentence |
|--|--|--|--|
| Convenience Initializer | A function that is not the default initializer for a class that allows us to take actions and perform some extra logic when creating an instance of a class | Secondary Constructor | "The network gives us data back as a list, so we created a convenience initializer that takes in a list and returns an instance of our class." |
| Class Method | A function that is part of the class definition that only has access to class-level variables. It must be prefixed with the decorator `@classmethod` and takes `cls` as its first parameter. Class methods can be called by referencing the class name followed by the function name (Ex.  `<Class_Name>.<function_name>()`) | Class Function | "We created a class method that returns a new instance with all the attributes set to 0" |

## Why refactor what isn't repeated?

We know that we have code in the `routes.py` file that creates an instance of a `Book` model from a dictionary, and we plan to refactor it to the `Book` class, but _why_ do we want to do that?

So far we've refactored to reduce repeated code, but there are so many other reasons we might want to refactor! A common reason is improving our code organization. We often want functions that operate directly on a particular class to be bundled with that class's code. We save time by having those functions ship with the class and be easy to find and navigate. 

There are many kinds of functions we package with classes, but let's focus on initializers for a moment. All classes have some kind of initializer, whether it's the default that the language provides or one we write ourselves. **Convenience Initializers** are functions other than the default initializer that let us perform some extra logic or set up defaults to create an instance of a class. Tying it back to `Hello Books`, if we know that we'll frequently have a dictionary and want to create a `Book` from its contents, we might want a convenience initializer bundled with the `Book` class to handle the task.

## Class Methods

We've worked with instance methods, so we know can write functions that are packaged with a class. But instance methods are called on a specific instance of a class that already _exists_ and we're looking at how to write a function that _creates_ a `Book`. How do we associate a method with a class when that method won't have an instance to be called on?

What we need in this case is a class method! To create a class method we need to do 2 things:
- use a new function decorator, `@classmethod` 
- pass `cls` as the first parameter to our function

As an example, if we wanted to write a class method named `create_from_list` that takes in a list as input, its function signature might look like:

```python
@classmethod
def create_from_list(cls, list_data):
   ...
``` 

### What is `cls`?

The `cls` parameter is a reference to the class, and it operates similarly to `self` for instance methods. When we write an instance function, we pass `self` as the first parameter to reference a particular instance and access its attributes and methods that aren't shared with any other instances.

When we pass `cls` as a parameter it acts as a reference to the class itself, granting us the ability to use other class methods and the ability to see and modify class variables - pieces of data held by the class itself and shared by all instances of the class. Since `cls` is a reference to the class, inside a class method we can use `cls` in place of the name of the class. Take a look at the code below; both of the functions will have the same effect of creating a new `Point` instance.

```python
class Point:
   @classmethod
   def create_instance_using_cls(cls):
      return cls()

   @classmethod
   def create_instance_using_class_name(cls):
      return Point()
```

## Planning the Refactor

So far we've set the stage - we know what we want to refactor, why we're doing it, and we have some new tools for writing the code. Let's get into it! 

<details>
   <summary>Expand for a reminder of the current `create_book` route implementation. </summary>

```python
@books_bp.route("", methods=["POST"])
def create_book():
    request_body = request.get_json()
    new_book = Book(title=request_body["title"],
                    description=request_body["description"])

    db.session.add(new_book)
    db.session.commit()

    return make_response(jsonify(f"Book {new_book.title} successfully created"), 201)
```

</details>

### Identify Dependencies

We've flagged the code we want to refactor, next we need to identify our dependencies. 

If we look through the `Hello Books` project, there are several places across `conftest.py` and `test_models.py` where a `Book` model is created. However, in those cases, we're choosing to pass the default constructor specific values for testing. Our changes shouldn't affect these uses of `Book`. 

The only other place we create a `Book` is in the `create_book` route. There we're getting the values from a dictionary. Since `create_book` is the only function that will be affected by our changes, we've completed identifying our dependencies and can move forward by examining our test suite.

### Check for Tests

Let's take a look in `test_routes.py` and see what our test cases look like for `create_book`.

```python
def test_create_one_book(client):
    # Act
    response = client.post("/books", json={
        "title": "New Book",
        "description": "The Best!"
    })
    response_body = response.get_json()

    # Assert
    assert response.status_code == 201
    assert response_body == "Book New Book successfully created"
```

We have a solid nominal case, but we're missing tests for edge cases. Take some time to think about what edge cases would be useful, and try writing the tests. When you're done, check out the cases we added below.

<details>
   <summary>New test cases for <code>create_book</code></summary>

```python
import pytest
...

def test_create_one_book_no_title(client):
    # Arrange
    test_data = {"description": "The Best!"}

    # Act & Assert
    with pytest.raises(KeyError, match='title'):
        response = client.post("/books", json=test_data)

def test_create_one_book_no_description(client):
    # Arrange
    test_data = {"title": "New Book"}

    # Act & Assert
    with pytest.raises(KeyError, match = 'description'):
        response = client.post("/books", json=test_data)

def test_create_one_book_with_extra_keys(client, two_saved_books):
    # Arrange
    test_data = {
        "extra": "some stuff",
        "title": "New Book",
        "description": "The Best!",
        "another": "last value"
    }

    # Act
    response = client.post("/books", json=test_data)
    response_body = response.get_json()

    # Assert
    assert response.status_code == 201
    assert response_body == "Book New Book successfully created"
```

</details>
</br>

If we run our tests, everything should still be green and we can start on the implementation!

## Executing the Refactor

As it stands we know:
- our existing tests are pretty solid
- we're writing a function named `from_dict` 
- `from_dict` will take in a dictionary and return a new `Book` instance
- `from_dict` will be a class method that we invoke from the `Book` class (Ex. `Book.from_dict(<some_dictionary>)`)

We'll start the implementation as we often do, by... 

### Writing Failing Tests!

Our first stop for this new function is to write some failing tests in `test_models.py`. Let's pause and come up with a list of cases that would be helpful to confirm `from_dict`'s behavior. After you're done, take a look at our new test cases below.

<details>
   <summary>New tests for <code>from_dict</code> in <code>test_models.py</code></summary>

```python
from app.models.book import Book
import pytest
...

def test_from_dict_returns_book():
    # Arrange
    book_data = {
        "title": "New Book",
        "description": "The Best!"
    }

    # Act
    new_book = Book.from_dict(book_data)

    # Assert
    assert new_book.title == "New Book"
    assert new_book.description == "The Best!"

def test_from_dict_with_no_title():
    # Arrange
    book_data = {
        "description": "The Best!"
    }

    # Act & Assert
    with pytest.raises(KeyError, match = 'title'):
        new_book = Book.from_dict(book_data)

def test_from_dict_with_no_description():
    # Arrange
    book_data = {
        "title": "New Book"
    }

    # Act & Assert
    with pytest.raises(KeyError, match = 'description'):
        new_book = Book.from_dict(book_data)

def test_from_dict_with_extra_keys():
    # Arrange
    book_data = {
        "extra": "some stuff",
        "title": "New Book",
        "description": "The Best!",
        "another": "last value"
    }
    
    # Act
    new_book = Book.from_dict(book_data)

    # Assert
    assert new_book.title == "New Book"
    assert new_book.description == "The Best!"
```

</details>
</br>

If we run our test suite and see only these new tests are failing, we can start implementing!

### Write the `from_dict` function

Our next step is to write out our pseudocode. We'll leave that as an exercise for you to try out and move on to writing our function definition. 

For Python to recognize our new function as a class method, we'll need to use the new syntax discussed above, the `@classmethod` decorator and `cls` parameter:

```python  
@classmethod
def from_dict(cls, book_data):
   pass
```

Our tests in `test_models.py` for `from_dict` should still be failing at this point. If they are, we can start changing our pseudocode into Python code. Try out writing the function, then take a look at our implementation below.

<details>
   <summary>Complete <code>from_dict</code> function example</summary>

```python
@classmethod
def from_dict(cls, book_data):
    new_book = Book(title=book_data["title"],
                    description=book_data["description"])
    return new_book
```

</details>
</br>

At this point, we should see all our tests passing!

### Replace the Code in `routes.py`

Now that we're replacing the original code in `routes.py`, the first thing we want to do is remove the code in `create_book` we intend to replace and see those tests fail. Once we see the tests failing, replace the line with a call to `Book`'s new class method. If we run our tests one last time, we should see green tests all the way! 

Try out replacing the code yourself, then take a look at our updated `create_book` below. 

<details>
   <summary>Updated <code>create_book</code> function example</summary>

```python
@books_bp.route("", methods=["POST"])
def create_book():
    request_body = request.get_json()
    new_book = Book.from_dict(request_body)

    db.session.add(new_book)
    db.session.commit()

    return make_response(jsonify(f"Book {new_book.title} successfully created"), 201)
```

</details>
</br>

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 43d9c16f
* title: Refactoring
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->