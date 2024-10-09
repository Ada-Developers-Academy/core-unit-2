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

In `test_book_routes.py`, we have one test each for `get_all_books` and `get_one_book`. These are important to have, but we are missing several scenarios that would confirm each function's behavior. Also, while we already added tests covering `create_book` in the previous lesson, we should still consider whether our test cases cover enough scenarios to confirm the behavior of the code we're preparing to refactor.

Take a moment to brainstorm what other nominal or edge cases are needed to know whether each route works as expected under a variety of inputs. It may help to look at the implementation of the route functions and the `validate_book` function to see what paths our code takes depending on the input.

<br>

<details>
   <summary>When you're done brainstorming, expand this section to review our cases and new test code. </summary>

We want to add tests that check:
- When we have records, `get_all_books` returns a list containing a dictionary representing each `Book`
- When we have records and a `title` query in the request arguments, `get_all_books` returns a list containing only the `Book`s which match the query
  - There are similar considerations depending on whether we have a `description` query, or both a `title` and `description` query, but we'll leave those as tests for you to consider adding!
- When we call `get_one_book` with a numeric ID that doesn't have a record, we get the expected error message
- When we call `get_one_book` with a non-numeric ID, we get the expected error message

Our tests for `create_book` already have tests for both successful creation (which return a dictionary representation of the created book) and for error cases when the request is missing a required field.

```python
# When we have records, `get_all_books` returns a list containing a dictionary representing each `Book`
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

# When we have records and a `title` query in the request arguments, `get_all_books` returns a list containing only the `Book`s that match the query
def test_get_all_books_with_title_query_matching_none(client, two_saved_books):
    # Act
    data = {'title': 'Desert Book'}
    response = client.get("/books", query_string = data)
    response_body = response.get_json()

    # Assert
    assert response.status_code == 200
    assert response_body == []

# When we have records and a `title` query in the request arguments, `get_all_books` returns a list containing only the `Book`s that match the query
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

# When we call `get_one_book` with a numeric ID that doesn't have a record, we get the expected error message
def test_get_one_book_missing_record(client, two_saved_books):
    # Act
    response = client.get("/books/3")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 404
    assert response_body == {"message": "Book 3 not found"}

# When we call `get_one_book` with a non-numeric ID, we get the expected error message
def test_get_one_book_invalid_id(client, two_saved_books):
    # Act
    response = client.get("/books/cat")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 400
    assert response_body == {"message": "Book cat invalid"}
```

Additional tests can (and should) be included to test the various combinations of query parameters that could be passed to `get_all_books`. We'll leave those as an exercise for you to consider adding! Since we're focused on refactoring the code that builds a dictionary representation of a `Book` model, we'll move forward with the tests we've added here.

</details>

At this point, we have a solid test suite for our routes that will be affected by our changes! All of our tests, existing and new, should be passing. We can feel good about making updates with the knowledge that we can run our tests frequently and they will help us catch any issues that arise.

## Executing the Refactor

We know that we want to move our code that creates a dictionary from a `Book` model from the `get_all_books` and `get_one_book` functions, but where does that code belong? Since creating a dictionary from a `Book` requires specific knowledge about the `Book` class, it makes a lot of sense to add the function directly to the `Book` class. 

Planning our function further, we know that we need a book as input, and we want our function's output to be a dictionary with a key for each of the input `Book`'s attributes. Because we need an instance of a `Book` to take this action, we probably want this to be an instance function of our `Book` class. And since the function will be responsible for converting a `Book` instance to a dictionary, we'll name it `to_dict`.

### Writing Failing Tests for `to_dict`

Our first stop for this new function is to write some failing tests in `test_book_model.py`. Let's pause and come up with a list of cases that would be helpful to confirm `to_dict`'s behavior. After you're done, take a look at our new test cases below.

<br>

<details>
   <summary>New tests for <code>to_dict</code> in <code>test_book_model.py</code></summary>

```python
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

At this point, when we run our test suite we should see all of the tests in `test_book_routes.py` passing, and the new tests in `test_book_model.py` failing. Now we can start our cycle of making small changes and testing until we complete our refactor!

### Writing the `to_dict` Function

We know the expected input and output of `to_dict` and where we want to write it, so let's start out with some pseudocode. A set of steps could look like:

- Create an empty dictionary
- for each attribute in Book 
  - create a key with the attribute's name
  - set it to the value of the attribute
- return the dictionary

Next, we can add our function definition to `book.py`, then re-run our test suite to confirm our model tests are still failing.

```python
    # indented under the Book class definition
    def to_dict(self):
        pass
```

If everything looks good, we can convert our pseudocode to Python code. Try out writing the function yourself, then take a look at our implementation below.

<br>

<details>
   <summary>Complete <code>to_dict</code> function example</summary>

```python
    # indented under the Book class definition
    def to_dict(self):
        book_as_dict = {}
        book_as_dict["id"] = self.id
        book_as_dict["title"] = self.title
        book_as_dict["description"] = self.description

        return book_as_dict
```

</details>

When we run our tests now, we should see all tests passing–but we still have changes to make! 

### Replace Repeated Code

Let's USE. THAT. NEW. FUNCTION!!!

We'll update our existing functions `get_all_books`, `get_one_book`, and `create_book` one at a time, continuing our path of making a small change and testing before moving on. Focusing on one function at a time will help us by reducing the surface area where issues could arise while we make our changes.

Starting with `get_all_books`, we first want to remove the existing code that creates a dictionary. Tying it back to TDD, now that we've made this change, we want try to run our tests and make sure our `get_all_books` route tests are now failing.  

Next we'll add a call to `to_dict` in place of the old code and run the test suite again. We should see all tests are passing once more.

Try out replacing the code yourself, then take a look at our updated `get_all_books` below. 

<br>

<details>
   <summary>Updated <code>get_all_books</code> function example</summary>

```python
@books_bp.get("")
def get_all_books():
    # query filtering logic omitted for brevity

    books = ...  # database retrieval code omitted for brevity

    books_response = []
    for book in books:
        books_response.append(book.to_dict())
    return books_response
```

The change we made here was to replace the dictionary creation code with a call to `to_dict` on the `book` instance.

</details>

Once we've completed changes for `get_all_books`, we'll follow the same steps for `get_one_book`:
1. Delete the old dictionary creation code
2. Run unit tests and see them fail
3. Add a call to `to_dict` in place of the old code
4. Run the full test suite and see all tests pass

Try out making the updates for `get_one_book`, then check out our updated `get_one_book` function below.

<br>

<details>
   <summary>Updated <code>get_one_book</code> function</summary>

```python
@books_bp.get("/<book_id>")
def get_one_book(book_id):
    book = validate_book(book_id)

    return book.to_dict()
```

The change we made here was to replace the dictionary creation code with a call to `to_dict` on the `book` instance.

</details>

And one final time, we can make the same changes to `create_book`. Remember to "break" your test before switching to the new code, then run the full test suite to confirm all tests are passing. Make the changes yourself, then check out our updated `create_book` function below.

<br>

<details>
   <summary>Updated <code>create_book</code> function</summary>

```python
@books_bp.post("")
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

The change we made here was to replace the dictionary creation code with a call to `to_dict` on the `new_book` instance. We no longer need the `response` dictionary, which was mostly there for clarity in the previous implementation.

</details>

## Check for Understanding

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- prettier-ignore-start -->
### !challenge

* type: multiple-choice
* id: 98c3a7c5-e155-41b8-b864-48f750287505
* title: Extracting Helper Functions Pt. 2

##### !question

What is the primary goal of the refactor described in this lesson?

##### !end-question

##### !options

a| To improve the performance of the Book model
b| To convert a Book model into a dictionary using a reusable helper function
c| To add more attributes to the Book model
d| To remove the Book model from the project

##### !end-options

##### !answer

b|

##### !end-answer

### !end-challenge
<!-- prettier-ignore-end -->
<!-- ======================= END CHALLENGE ======================= -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- prettier-ignore-start -->
### !challenge

* type: multiple-choice
* id: 1dcdb383-6e15-459f-9153-c5e740bd39c6
* title: Extracting Helper Functions Pt. 2

##### !question

What should be done after refactoring the code to use the new `to_dict` function?

##### !end-question

##### !options

a| Remove all tests related to the Book model
b| Add new attributes to the Book model
c| Run the test suite to ensure all tests pass
d| Delete the Book model

##### !end-options

##### !answer

c|

##### !end-answer

##### !explanation

One of the benefits of having a robust test suite is that it can give us confidence that our changes haven't broken anything. After making changes to our code, we should always run our tests to ensure everything is still working as expected.

##### !end-explanation

### !end-challenge
<!-- prettier-ignore-end -->
<!-- ======================= END CHALLENGE ======================= -->
