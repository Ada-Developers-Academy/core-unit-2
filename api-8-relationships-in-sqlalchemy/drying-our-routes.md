# D.R.Y.ing Our Routes

## Goals

Our goals for this lesson are to:
* Reduce repeated or similar code in our route files
* Separate common model actions from route-specific business logic

We will follow our refactoring best practices to:
* Move code that creates and returns a JSON representation of a model to a new function named `create_model` in `route_utilities.py`
* Move code that queries, filters, and returns a JSON representation of model records to a new function named `get_models_with_filters` in `route_utilities.py`

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
- `author_id` (foreign key)
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

Let's start from the top and analyze our `create_author` and `create_book_with_author` routes in `author_routes.py` and our `create_book` route in `book_routes.py`.

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

@bp.post("/<author_id>/books")
def create_book_with_author(author_id):
    author = validate_model(Author, author_id)
    
    request_body = request.get_json()
    request_body["author_id"] = author.id

    try:
        new_book = Book.from_dict(request_body)

    except KeyError as error:
        response = {"message": f"Invalid request: missing {error.args[0]}"}
        abort(make_response(response, 400))
        
    db.session.add(new_book)
    db.session.commit()

    return make_response(new_book.to_dict(), 201) 
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

If we look across these functions, the significant differences are:
* The function names: `create_author`, `create_book_with_author` and `create_book`
* The name of the new model variables: `new_author` and `new_book`
* The name of the class which calls `from_dict`: `Author` and `Book`
* The `create_book_with_author` route adds an `author_id` to the dictionary passed to `Book.from_dict`

All of our other actions are the same:
1. We store the request body in a variable named `request_body`
2. We try to create a model, and if it raises an exception we share the same error
3. We add and commit the new model to the database
4. We call `to_dict` on the new model and return the dictionary of model data and a 201 status code

We are repeating a lot of the same steps in these functions! This should signal to us that we could refactor most of the work to a single shared function. We'll address refactoring these three functions shortly, but let's continue to examine our route files for further routes we could D.R.Y. up.

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

## Model Creation Refactor

We have identified the code that we want to refactor, starting with our `create_author`, `create_book_with_author`, and `create_book` routes. Our goal is to create a new function `create_model` in our `route_utilities.py` file which handles all of the repeated steps and that we can call from our existing routes. 

To have the information that the function needs to create a new model, the `create_model` function will have to take in 2 parameters:
* `cls`, representing the class name of the model we want to create
* `model_data`, a dictionary containing the names of attributes and their values for the model we want to create 

Now we can take a moment to prepare ourselves for the refactor by continuing our refactoring steps to identify and test any dependencies on our routes!

### Identifying Dependencies & Testing

If we search the project, we should only see tests that use the create routes-nothing is independently making a call to the `create_author`, `create_book_with_author` or `create_book` functions. Without dependent functions calling these routes, we don't need to worry about writing tests for existing functions at this moment. 

When we worked on the `validate_model` refactor, we had an existing function `validate_book` that we wrote tests for and then incrementally updated. We don't have a pre-existing function in this case, so if we're following TDD, this is the time to think about what the inputs and outputs of our new `create_model` function should be, and how we want to test them. 

<br>
<details>
   <summary>Take a moment to brainstorm then write nominal and edge cases for the <code>create_model</code> function we've described in <code>test_route_utilities.py</code>. Expand this section when done to see the limited tests we created.</summary>

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

Set a timebox to try out moving all the similar steps from `create_author`, `create_book_with_author` and `create_book` into a new function `create_model` in `route_utilities.py`. Then, use the arguments we defined for the function to:
- replace specific uses of a class name with `cls`
- update any class-specific variable names to be more generic, to better reflect that those variables could hold any new model instance

<br>
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

At this point all of our tests including our new ones in `test_route_utilities.py` should be passing! 

Now, we can start incrementally updating the `create_book` route. Our `create_book` tests are expected to fail until the changes are finished. When that work is complete and all of the `create_book` tests are passing again, only then should we start making changes to the `create_author` or `create_book_with_author` function. The order in which we update these functions isn't important, we could choose to update `create_author` or `create_book_with_author` first, but it's vital to only update one function at a time so that we know where issues are coming from if they arise.

</br>
<details>
   <summary>Try out changing the <code>create_author</code>, <code>create_book_with_author</code> and <code>create_book</code> routes to import and use the <code>create_model</code> helper function, then expand this section to see how we finished up the refactor!</summary>

```py
# author_routes.py

# ...
from .route_utilities import create_model, validate_model
# ...

@bp.post("")
def create_author():
    request_body = request.get_json()
    return create_model(Author, request_body)

@bp.post("/<author_id>/books")
def create_book_with_author(author_id):
    author = validate_model(Author, author_id)
    
    request_body = request.get_json()
    request_body["author_id"] = author.id
    return create_model(Book, request_body)
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

Once our test suite is passing again, we're done with our `create_model` refactors! 
![Squirrel on a bench, raising its arms with the text "It's done!"](../assets/api-8-one-many/squirrel_its_done.jpg)

## Filtering Models Refactor

For this refactor, our end goal is to create a more generic filtering function `get_models_with_filters` in our `route_utilities.py` file. Our new function will need the following parameters to filter our desired models: 
- a class reference of the type of model we want to filter
- an _optional_ dictionary of filter names and values

### Identifying Dependencies & Testing

Just like in our `create_model` refactor above, when looking for dependencies, we should only see tests that use the `get_all` routes. This means we don't have existing functions that we need to write tests for, but we do need to invest some time thinking about our nominal and edge cases for our proposed function and writing a failing test suite to follow our TDD process.

For this refactor, we have only written one nominal test as an example in the `hello-books` repo, we leave it up to you to brainstorm what other cases are useful and write tests for them. Feel free to pitch test ideas with others in a study group, over Slack, or however best works for you!

<br>
<details>
   <summary>When you're done writing nominal and edge cases for the <code>get_models_with_filters</code> function, expand this section the nominal test we created.</summary>

```py
# test_route_utilities.py
from app.routes.route_utilities import validate_model, create_model, get_models_with_filters

#...

def test_get_models_with_filters_one_matching_book(two_saved_books):
    # Act
    result = get_models_with_filters(Book, {"title": "ocean"})

    # Assert
    assert result == [{
        "id": 1,
        "title": "Ocean Book",
        "description": "watr 4evr"
    }]
```

</details>
</br>

### Working with `hasattr` and `getattr`

Before we jump into the refactor, there are some tools that we want to get familiar with which will help us on our way.

Earlier in the lesson, we brought up the idea of filtering the records for a particular model by iterating over the keys of the dictionary returned by `request.get_json()` and applying only the filters it contains which are valid for the model. To do that, we need a way to check if our model has an attribute _before_ we add on to our query statement. Handily, python has some built-in methods we can use for this purpose!

We will be using a pair of functions, [`hasattr`](https://docs.python.org/3/library/functions.html#hasattr) and [`getattr`](https://docs.python.org/3/library/functions.html#getattr), to handle checking for the presence of an attribute on a model, then retrieving the attribute so that we can use it in a query statement. A short introduction to these functions is below, but you may need to do some extra research to complete this refactor.

#### More about `hasattr(object, name)`

`hasattr(object, name)` will return `True` or `False` depending on if the `object` argument contains an attribute with the same name as the string argument `name`. This means that if we have a collection of attribute names as strings, we can iterate over the data structure, using `hasattr` to check if an object contains a particular attribute before we take any other actions. 

For example, if we wanted to write a function that can check if a class contains all the attributes in a particular list we might write something like:

```py
class Cat:
    name = "Meoward"
    age = 12
    fur_length = "short"

attribute_list = ["name", "fur_length", "meow_volume"]

def has_all_attributes(cls, attributes):
    for attribute in attributes:
        if not hasattr(cls, attribute):
            return False

    return True

# The statement below will print `False` since `Cat`
# does not contain the attribute `meow_volume`
print(has_all_attributes(Cat, attribute_list)) 
```

#### More about `getattr(object, name)`

Once we know that an attribute exists on an object, the `getattr(object, name)` function can retrieve a reference to that attribute for us. If we try to use `getattr` on an attribute that doesn't exist an `AttributeError` will be raised. 

Using our `Cat` class above as an example again, the statement `Cat.age` is equivalent to calling `getattr(Cat, "age")`. 
```py
print(Cat.age) # Prints the value 12
print(getattr(Cat, "age")) # Prints the value 12
```

If we know the name of an attribute in advance, we don't gain much from this syntax, but it becomes extremely useful if we're iterating over a collection and don't know the contents ahead of time. Think about the places in our `get_all` `Book` and `Author` routes where we use `Class_Name.attribute_name` statements like `Book.title` or `Author.name` when building queries. In our generic function `get_models_with_filters`, if we have a `cls` parameter to represent the model class, then we can use `getattr` to replace each of these statements of the form `Class_Name.attribute_name` with something like: `getattr(cls, attribute_name)`

### Performing the refactor

Our test suite for `get_models_with_filters` should be failing, and we have tools for working with unknown attributes, so we're ready to write some code to make those tests pass!

Our goal is to have our route functions retrieve the request body, then pass it on to `get_models_with_filters` along with the name of the model class to filter. Our route functions should only have to return whatever our new helper function `get_models_with_filters` returns. 

This means that our new function has to perform the following steps:
1. Create an initial `query` variable using a select statement and our `cls` parameter
2. If the optional filters dictionary is not empty, iterate over the keys and values
3. For each key-value pair in the filters dictionary:
   1. Use `hasattr` to see if the key is an attribute on the model
   2. If `hasattr` returns `True`, update the `query` variable by creating a `where` statement using `getattr` and the value of the current filter
4. Use `db.session.scalars` to retrieve the models
5. Create a list of dictionaries representing the models by calling `to_dict` on each
6. Return the list of models

<br>
<details>
   <summary>Try out filling in the <code>get_models_with_filters</code> function, then expand this section to see how we implemented it.</summary>

```py
# route_utilities.py
def get_models_with_filters(cls, filters=None):
    query = db.select(cls)
    
    if filters:
        for attribute, value in filters.items():
            if hasattr(cls, attribute):
                query = query.where(getattr(cls, attribute).ilike(f"%{value}%"))

    models = db.session.scalars(query.order_by(cls.id))
    models_response = [model.to_dict() for model in models]
    return models_response
```

There are some things worth noting about this approach:
- Our code ensures we don't raise an error if an attribute doesn't exist, but we don't have a mechanism to let users know which, if any, filters were applied, or which filters were invalid. 
- The error handling for this function isn't very robust, it is a small but imperfect example of the kinds of abstractions we can use to D.R.Y. up our code. 

If you feel called to or want the practice, feel free to try providing the user more information, or try breaking the function and see what you could add to make it stronger!

</details>
</br>

Once our test suite for `get_models_with_filters` is passing, all tests should be passing until we begin refactoring our routes. As with the `create_model` refactor, we want to update our route functions one at a time and see all our tests passing again before we move on to update the next route.

<br>
<details>
   <summary>Give updating the <code>get_all_books</code> and <code></code> routes to import and use the <code>get_models_with_filters</code> helper function, then expand this section to see how we finished up the refactor!</summary>

```py
# author_routes.py

# ...
from .route_utilities import create_model, validate_model, get_models_with_filters
# ...

@bp.get("")
def get_all_authors():
    return get_models_with_filters(Author, request.args)
```

```py
# book_routes.py

# ...
from .route_utilities import create_model, validate_model, get_models_with_filters
# ...

@bp.get("")
def get_all_books():
    return get_models_with_filters(Book, request.args)
```
</details>
</br>

## Further Improvements

These are the last helper function refactors we'll work through in Learn, but that doesn't mean that there are no more improvements left to find. One area for improvement that we noticed is how `Book`'s PUT route can raise the same errors as `create_model`-how might we add error handling there? 

What other refactors can you find, and how would you address them to make our routes more resilient? 

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: 3199d93c-25f6-4e29-819b-99fbe4b0b1e8
* title: D.R.Ying Our Routes
##### !question

What options below are benefits or drawbacks of first checking for the presence of an attribute with `hasattr` then using `getattr` to update our query only when `hasattr` returns `True`? 

Select all options that are true.

##### !end-question
##### !options

a| The user knows exactly which of the filters they sent were applied.
b| We do not raise an `AttributeError` when we encounter an invalid filter.
c| The user is not informed when they send an invalid filter value.
d| The user does not know which of the filters they sent were applied.

##### !end-options
##### !answer

b|
c|
d| 

##### !end-answer
##### !hint

What information do we send back to the user? 

##### !end-hint
##### !hint

What happens when a filter is applied vs when a filter is ignored?

##### !end-hint
##### !explanation

1. False: we do not send back anything in the response that lest the user know which filters were applied
2. True
3. True
4. True

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: 3199d93c-25f6-5c29-819b-99fbh4b3b1e8
* title: D.R.Ying Our Routes
##### !question

What benefits do we get from refactoring repeated or similar model creation and model filtering code out of our route files?

Select all options that are true.

##### !end-question
##### !options

a| Our route files are as short as possible 
b| If we have to update the syntax for filtering models, we only need to update `route_utilities.py`
c| Business logic that is unique to each model and route is easier to read and find in the route files
d| If we have to update how a `Book` is created, we only need to update `route_utilities.py`

##### !end-options
##### !answer

b|
c|

##### !end-answer
##### !hint

Are our route files as condensed as they could be? Is that always helpful?

##### !end-hint
##### !hint

Where does the function that constructs a `Book` from a dictionary live?

##### !end-hint
##### !explanation

1. False: we could likely combine some statements to make our files even shorter, but shortness is not the goal; clear, easy to maintain code is the goal.
2. True
3. True
4. False: If attributes on the `Book` model change, then we would need to make changes to the `to_dict` method of the `Book` class.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->

