# Extracting Helper Functions Pt. 2

## Goals
Our goal for this lesson is to refactor the code in the `book_routes.py` file that converts a `Book` model into a `Dictionary` to a reusable helper function named `to_dict` in the `Book` model's class.

To do this we will follow the same steps of planning then executing a refactor as outlined in the previous lesson. 

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`07a-from-dict-refactor` |`07b-to-dict-refactor`|

<br>

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

The `Book` class should have the following functions:
- `from_dict`

Our test folder should have 2 files: 
- `test_book_routes.py`
- `test_book_model.py`

</details>

## Planning the Refactor

Let's turn our attention back to the other refactoring candidate we identified in the previous section: building a dictionary representation of a `Book` model.

### Identifying Code to Refactor

In the previous lesson, we observed that there are multiple places in our current routes that need to build a dictionary representation of the `Book` models with which they interact. For example, our `create_book` and `get_one_book` both have some variation of the following code in common:

```python
response = {
    "id": book.id,
    "title": book.title,
    "description": book.description
}
```

This repeated code is what we're looking to replace by refactoring it into a helper function. Since the operation is specific to the `Book` model, it makes sense to add this function to the `Book` class. And because the function will be responsible for converting a `Book` instance to a dictionary, we'll name it `to_dict`.

So let's move forward with refactoring the repeated code into a single helper function that can be used anywhere we need to build a dictionary representation of a `Book` model!

### Identifying Dependencies

We've flagged the code we want to refactor, next we need to identify our dependencies. 

Looking through the `Hello Books` project, there are three routes that produce a dictionary representation of a `Book` model:
- `create_book`
- `get_all_books`
- `get_one_book`

Unlike the situation with `from_dict`, where we found model instances in a fixture, and needed to understand whether or not to update it, here, we don't have any test code that makes a dictionary from a `Book` model. There are dictionary representations of books in some of the tests, but they are there specifically to check the output of the routes. They were not built from an existing `Book` model instance.

As a result, we can move on to the next step of our refactor knowing that we only need to double check the test coverage for those three routes that will be affected by our changes.

### Checking for Tests

We know our dependencies, so at this point we need to move over to our test files. Our goal is to ensure we have tests covering nominal and edge cases for each dependency we found.

If we navigate to `test_routes.py`, we'll find that we have one test for each of the dependent functions, `test_get_all_books_with_no_records` and `test_get_one_book`. These are important to have, but we are missing several scenarios that would confirm each function's behavior.

Take a moment to brainstorm what other nominal or edge cases are needed to know our route works as expected under a variety of inputs. It may help to look at the route functions and the `validate_book` function to see what paths our code takes depending on the input.  

<details>
   <summary>When you're done brainstorming, expand this section to review our cases and new test code. </summary>

We want to add tests that check:
- When we have records, `read_all_books` returns a list containing a dictionary representing each `Book`
- When we have records and a `title` query in the request arguments, `read_all_books` returns a list containing only the `Book`s which match the query
- When we call `read_one_book` with a numeric ID that doesn't have a record, we get the expected error message
- When we call `read_one_book` with a non-numeric ID, we get the expected error message

```python
# When we have records, `read_all_books` returns a list containing a dictionary representing each `Book`
def test_get_all_books_with_two_records(client, two_saved_books):
    # Act
    response = client.get("/books")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 200
    assert len(response_body) == 2
    assert response_body[0] == {
        "id": 1,
        "title": "Ocean Book",
        "description": "watr 4evr"
    }
    assert response_body[1] == {
        "id": 2,
        "title": "Mountain Book",
        "description": "i luv 2 climb rocks"
    }

# When we have records and a `title` query in the request arguments, `read_all_books` returns a list containing only the `Book`s which match the query
def test_get_all_books_with_title_query_matching_none(client, two_saved_books):
    # Act
    data = {'title': 'Desert Book'}
    response = client.get("/books", query_string = data)
    response_body = response.get_json()

    # Assert
    assert response.status_code == 200
    assert response_body == []

# When we have records and a `title` query in the request arguments, `read_all_books` returns a list containing only the `Book`s which match the query
def test_get_all_books_with_title_query_matching_one(client, two_saved_books):
    # Act
    data = {'title': 'Ocean Book'}
    response = client.get("/books", query_string = data)
    response_body = response.get_json()

    # Assert
    assert response.status_code == 200
    assert len(response_body) == 1
    assert response_body[0] == {
        "id": 1,
        "title": "Ocean Book",
        "description": "watr 4evr"
    }

# When we call `read_one_book` with a numeric ID that doesn't have a record, we get the expected error message
def test_get_one_book_id_not_found(client, two_saved_books):
    # Act
    response = client.get("/books/3")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 404
    assert response_body == {"message":"book 3 not found"}

# When we call `read_one_book` with a non-numeric ID, we get the expected error message
def test_get_one_book_id_invalid(client, two_saved_books):
    # Act
    response = client.get("/books/cat")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 400
    assert response_body == {"message":"book cat invalid"}
```

</details>
</br>

At this point, we have a solid test suite for our routes that will be affected by our changes! All of our tests, existing and new, should be passing. We can feel good about making updates with the knowledge that we can run our tests frequently and they will help us catch any issues that arise.

## Executing the Refactor

We know that we want to move our code that creates a dictionary from a `Book` model from the `read_all_books` and `read_one_book` functions, but where does that code belong? Since creating a dictionary from a `Book` requires specific knowledge about the `Book` class, it makes a lot of sense to add the function directly to the `Book` class. 

Planning our function further, we know that we need a book as input, and we want our function's output to be a dictionary with a key for each of the input `Book`'s attributes. Because we need an instance of a `Book` to take this action, we probably want this to be an instance function of our `Book` class.

### Write failing tests for `to_dict`

If we're following Test Driven Development (TDD), our next step is to write tests for `to_dict` that will fail until we write our new function. We'll create a new file `test_models.py` and add tests to cover nominal and edge cases for the `to_dict` function.

Let's pause to think through what cases we might test for the `to_dict` function and what data we need to arrange and check those cases. When you're ready, check out our `test_models.py` code below.

<details>
   <summary>Complete <code>test_models.py</code> example</summary>

```python
from app.models.book import Book

def test_to_dict_no_missing_data():
    # Arrange
    test_data = Book(id = 1,
                    title="Ocean Book",
                    description="watr 4evr")

    # Act
    result = test_data.to_dict()

    # Assert
    assert len(result) == 3
    assert result["id"] == 1
    assert result["title"] == "Ocean Book"
    assert result["description"] == "watr 4evr"

def test_to_dict_missing_id():
    # Arrange
    test_data = Book(title="Ocean Book",
                    description="watr 4evr")

    # Act
    result = test_data.to_dict()

    # Assert
    assert len(result) == 3
    assert result["id"] is None
    assert result["title"] == "Ocean Book"
    assert result["description"] == "watr 4evr"

def test_to_dict_missing_title():
    # Arrange
    test_data = Book(id=1,
                    description="watr 4evr")

    # Act
    result = test_data.to_dict()

    # Assert
    assert len(result) == 3
    assert result["id"] == 1
    assert result["title"] is None
    assert result["description"] == "watr 4evr"

def test_to_dict_missing_description():
    # Arrange
    test_data = Book(id = 1,
                    title="Ocean Book")

    # Act
    result = test_data.to_dict()

    # Assert
    assert len(result) == 3
    assert result["id"] == 1
    assert result["title"] == "Ocean Book"
    assert result["description"] is None
```

</details>
</br>

At this point, when we run our test suite we should see all of the tests in `test_routes.py` passing, and all of the tests in `test_models.py` failing. Now we can start our cycle of making small changes and testing until we complete our refactor!

### Write the `to_dict` function

We know the expected input and output of `to_dict` and where we want to write it, so let's start out with some pseudocode. A set of steps could look like:

```python
  # Create an empty dictionary
  # for each attribute in Book 
  #   create a key with the attribute's name
  #   set it to the value of the attribute
  # return the dictionary
```

Next, we can add our function definition to `book.py`, then re-run our test suite to confirm our model tests are still failing.

```python
def to_dict(self):
    pass
```

If everything looks good, we can convert our pseudocode to python code. Try out writing the function yourself, then take a look at our implementation below.

<details>
   <summary>Complete <code>to_dict</code> function example</summary>

```python
def to_dict(self):
    book_as_dict = {}
    book_as_dict["id"] = self.id
    book_as_dict["title"] = self.title
    book_as_dict["description"] = self.description

    return book_as_dict
```

</details>
</br>

When we run our tests now, we should see all tests passing – but we still have changes to make! 

### Replace Repeated Code

Let's USE. THAT. NEW. FUNCTION!!! We'll update our existing functions `read_all_books` and `read_one_book` one at a time, continuing our path of making a small change and testing before moving on. Focusing on one function at a time will help us by reducing the surface area where issues could arise while we make our changes.

Starting with `read_all_books`, we first want to remove the existing code that creates a dictionary. Tying it back to TDD, now that we've made this change, we want try to run our tests and make sure our `read_all_books` route tests are now failing.  

Next we'll add a call to `to_dict` in place of the old code and run the test suite again. We should see all tests are passing once more.

Try out replacing the code yourself, then take a look at our updated `read_all_books` below. 

<details>
   <summary>Updated <code>read_all_books</code> function example</summary>

```python
@books_bp.route("", methods=["GET"])
def read_all_books():
    
    title_query = request.args.get("title")
    if title_query:
        books = Book.query.filter_by(title=title_query)
    else:
        books = Book.query.all()

    books_response = []
    for book in books:
        books_response.append(book.to_dict())
    return jsonify(books_response)
```

</details>
</br>

Once we've completed changes for `read_all_books`, we'll follow the same steps for `read_one_book`:
1. Delete the old dictionary creation code
2. Run unit tests and see them fail
3. Add a call to `to_dict` in place of the old code
4. Run the full test suite and see all tests pass

Try out making the updates for `read_one_book`, then check out our updated `read_one_book` function below.

<details>
   <summary>Updated <code>read_one_book</code> function</summary>

```python
@books_bp.route("/<book_id>", methods=["GET"])
def read_one_book(book_id):
    book = validate_book(book_id)
    return book.to_dict()
```

</details>
</br>

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 43d9c16h
* title: Refactoring
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->