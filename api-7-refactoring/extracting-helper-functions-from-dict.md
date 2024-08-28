# Extracting Helper Functions Pt. 1

## Goals
Our goals for this lesson are to: 
- Define class method syntax
- Create a class method named `from_dict` in `book.py` 
- Refactor the code for creating a `Book` model in the `create_book` route to use `from_dict`

To do this we will:
- Plan our refactor by 
  - identifying what code we will refactor  
  - identifying dependencies on the code being refactored
  - ensuring we have strong test coverage
- Execute our refactor by 
  - writing new, reusable, helper functions
  - replacing the existing code with our new functions
  - frequently running our tests as we work to ensure our code's behavior remains the same

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`06e-post-books-test` |`07a-from-dict-refactor`|

<details>
   <summary>Expand to see the features <code>Hello Books API</code> should have before this lesson</summary>

- A `hello_books_development` database
- A `book` table defined
- A `Book` model defined

Endpoints defined for these RESTful routes:
- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`

The `Book` model and table should have the following columns:
- `id`
- `title`
- `description`

Our test suite should have 3 tests: 
- `test_get_all_books_with_no_records`
- `test_get_one_book`
- `test_create_one_book`

</details>
</br>

| Vocab | Definition | Synonyms | How to Use in a Sentence |
|--|--|--|--|
| Convenience Initializer | A function that is not the default initializer for a class that allows us to take actions and perform some extra logic when creating an instance of a class | Secondary Constructor | "The network gives us data back as a list, so we created a convenience initializer that takes in a list and returns an instance of our class." |
| Class Method | A function that is part of the class definition that only has access to class-level variables. It must be prefixed with the decorator `@classmethod` and takes `cls` as its first parameter. Class methods can be called by referencing the class name followed by the function name (Ex.  `<Class_Name>.<function_name>()`) | Class Function | "We created a class method that returns a new instance with all the attributes set to 0" |

## Planning the Refactor

### Identifying Code to Refactor

Our first step in refactoring is taking a critical look at our code to identify what we want to refactor. It's possible that we might notice things we'd like to refactor as we work on other parts of our codebase. As we continue to gain coding experience, we'll have more experience to draw from and will more easily be able to identify areas that could be improved.

To help us organize our thoughts, we might look through our code:
- Function by function, in the order they happen to appear in a file
- By feature, looking at all the code that relates to a particular feature
- Considering the data lifecycle, looking at code in the order data is created, read, updated, and deleted

Going function by function is a bit arbitrary, since functions can be added to a file in any order, but as our project code is still relatively small, it's as good a place as any to start. In larger projects, we might find it more helpful to think through a particular feature, or the lifecycle of a particular piece of data, to help us organize our thinking.

As we look through our functions, we should keep an eye out for several kinds of code that might be good candidates for refactoring:
- Code that is repeated in multiple places
- Code that "knows" more than it needs to about another part of the codebase
- Code that is difficult to understand
- Code that is difficult to test

## Reasons to Refactor

It's not always cut and dried what will make for a good refactor. Many refactoring decisions are made with an eye towards the future. How we weigh refactoring decisions often comes from experience working on longer-lived projects and seeing what went well and what didn't. As we have the opportunity to work on more projects, we should keep an eye out for what makes code easier to work with and maintain. Notice any patterns used across the code base, and ask about why they're being used. That will help us build our own intuition about how to refactor code to address some of the common issues we see.

### Repeated Code

Repeated code is a problem because it makes our code harder to maintain. If we need to change the behavior of the code, we have to change it in multiple places. If we forget to change it in one place, we can introduce bugs from the inconsistency.

When we see repeated code, we should ask ourselves if there's a way to write the code once and use it in multiple places. Most commonly, we'll extract the repeated code into a function and call that function from the places where the code was repeated.

### Code That "Knows" Too Much

Code that "knows" too much is code that has to be changed whenever another part of the codebase changes. This is a problem because it makes our code brittle. If we change one part of the codebase, we have to change another part of the codebase, and we can introduce bugs if we forget to make the change in both places.

When we see code that "knows" too much, we should ask ourselves if there's a way to make the code more flexible. Most commonly, we'll extract the code that "knows" too much into a function and pass in the information it needs as arguments.

Notice this is more or less another way to phrase thinking about the Separation of Concerns, or the Single Responsibility Principle.

### Code That Is Difficult to Understand

Code that is difficult to understand is a problem because it makes our code harder to work with. If we need to change the behavior of the code, we have to understand it first. If we misunderstand the code, we can introduce bugs when we try to make changes.

When we see code that is difficult to understand, we should ask ourselves if there's a way to make the code clearer. Most commonly, we'll extract the code that is difficult to understand into a function and give that function a clear name that describes what the code does. This helps separate the "what" from the "how" of the code. While it's still true that to make changes within the extracted function we'll need to understand the code, we can at least understand the code in isolation, and we can test the code in isolation.

### Code That Is Difficult to Test

Code that is difficult to test is a problem because it makes our code harder to maintain. If we need to change the behavior of the code, we have to test it first. If we can't test the code, we can't be sure that our changes won't introduce bugs.

When we see code that is difficult to test, we should ask ourselves if there's a way to make the code easier to test. Most commonly, we'll extract the code that is difficult to test into a function or class that we can call directly from a test. Sometimes, we'll need to change how data or other logic required by the code is managed to make the code easier to test.

### General Maintainability

General maintainability tends to be the driving force behind most of our refactoring decisions.

We want our code to be easy to work with, easy to understand, easy to test, and easy to change. We want to be able to make changes to our codebase quickly and confidently. We want to be able to add new features to our codebase without breaking existing features. We want to be able to fix bugs in our codebase without introducing new bugs. We want to be able to refactor our codebase without breaking existing features. We want to be able to delete code from our codebase without breaking existing features. We want to be able to move code from one part of our codebase to another part of our codebase without breaking existing features.

In short, we want to be able to work on our codebase without being afraid of breaking existing features.

## Refactors in Our Codebase

Let's look through our code, keeping an eye out for some of the common reasons we might want to refactor. Most of the code that isn't focused on starting up the application in is `book_routes.py`, so let's start there.

The first function is `create_book`. This function creates a new `Book` instance by
1. getting a dictionary representing the request body
2. extracting values for the `title` and `description` keys from the dictionary
3. passing those values by name to the `Book` constructor

After storing the new `Book` instance in the database, the function returns a response consisting of a dictionary with string keys, whose values are filled with data from the saved `Book` instance. 

At this point, we might not see much to refactor, so let's keep looking.

The next function is `get_all_books`. This function retrieves all the `Book` instances from the database, applying a number of optional filters, then creates a list of dictionaries, each representing a `Book` instance. The function returns the list of dictionaries as the response body.

This code is definitely more complicated than the `create_book` function. Maybe there's some way we can simplify all that filtering code? It would be great if it could be reused for any other model types that we add to the project! For the moment, let's put a pin in that idea, since there's another possible refactor in this function that we can tackle a little more directly.

`get_all_books` needs to return a collection of `Book` models as a list of dictionaries. Each `Book` model is used to build a dictionary in the response. We can see that the code to build a dictionary from a `Book` model is repeated in the `create_book` function. Taking a quick glance at the next function, `get_one_book`, we can see that it also builds a dictionary from a `Book` model.

Our routes currently have code in three different places that builds a dictionary from a `Book` model. This repetition makes it a great candidate for refactoring! It's also potentially a good candidate for refactoring because it's code that "knows" too much. Why does the route logic need to know how to build a dictionary from a `Book` model? Why does the route logic need to know the names of all the fields in the `Book` model, and all the key names in the dictionary? If the `Book` model knew how to build a dictionary from itself, the route logic wouldn't need to know any of that! All the route would need to know is how to ask a `Book` instance to build a dictionary from itself.

Alright, we've identified the logic that builds a dictionary from a `Book` model as a good candidate for refactoring. But we also just saw another chunk of code related to `Book` models and dictionaries. The `create_book` function takes a dictionary and uses it to create a `Book` model. While not repeated, this logic is similar in functionality to the logic that builds a dictionary from a `Book` model. It's effectively the inverse operation. From that perspective, it's also code that "knows" too much. The route logic wouldn't need to know how to create a `Book` model from a dictionary if the `Book` model knew how to create itself from a dictionary!

That makes two good candidates for refactoring:
1. the logic that builds a dictionary from a `Book` model, and
2. the logic that creates a `Book` model from a dictionary

Though we identified the logic that builds a dictionary from a `Book` model as a refactoring candidate first, we'll start by refactoring the logic that creates a `Book` model from a dictionary. Without getting into too much detail here, starting with the dictionary-to-model logic will let us write tests that both reflect our desired behavior and actually pass at the end of this lesson. If we started with the model-to-dictionary logic, then writing tests that pass would require us to write tests that don't reflect our desired behavior.

If we were doing this in a real project, we would probably do all of this more or less together, avoiding the issue of having an arbitrary checkpoint (the end of a lesson). But since we need to start *somewhere*, we'll start with the case that won't force us to compromise our tests: the dictionary-to-model logic.

## Why refactor what isn't repeated?

We know that we have code in the `routes.py` file that creates an instance of a `Book` model from a dictionary, and we plan to refactor it to the `Book` class, but _why_ do we want to do that?

So far we've refactored to reduce repeated code, but there are so many other reasons we might want to refactor! A common reason is improving our code organization. We often want functions that operate directly on a particular class to be bundled with that class's code. We save time by having those functions ship with the class and be easy to find and navigate. 

There are many kinds of functions we package with classes, but let's focus on initializers for a moment. All classes have some kind of initializer, whether it's the default that the language provides or one we write ourselves. **Convenience Initializers** are functions other than the default initializer that let us perform some extra logic or set up defaults to create an instance of a class. Tying it back to `Hello Books`, if we know that we'll frequently have a dictionary and want to create a `Book` from its contents, we might want a convenience initializer bundled with the `Book` class to handle the task.

## Class Methods

We've worked with instance methods, so we know we can write functions that are packaged with a class. But instance methods are called on a specific instance of a class that already _exists_ and we're looking at how to write a function that _creates_ a `Book`. How do we associate a method with a class when that method won't have an instance to be called on?

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
