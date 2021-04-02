# Testing APIs

## Goal

- Describe the pytest syntax used to define automated tests in Flask
- Practice running automated tests in Flask with pytest

## Introduction

We can continue to use tests and pytest to test our Flask APIs! Reading, writing, and using pytest for a Flask API isn't very different from using pytest outside a Flask API. There are a few main differences we can cover in this lesson:

1. We will need to configure our Flask projects to use pytest and a test database
1. Our tests will verify that for every HTTP request, we get back the expected HTTP response
1. We can use pytest fixtures to set up test helpers and test data

This lesson will walkthrough how to refactor our project to use tests with the command `(venv) $ pytest`.

Then, we will read, write, and use tests.

## Hello Books API

### Before This Lesson

This lesson uses the Hello Books API.

<details style="max-width: 700px; margin: auto;">
    <summary>
        Before beginning this lesson, the Hello Books API should have the following.
    </summary>

- A `hello_books_development` database
- A `hello_books_test` database
- A `book` table defined in both databases
- A `Book` model defined

An `.env` file that contains:

```
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
```

Endpoints defined for these RESTful routes. They handle missing books:

- `GET` to `/books`
- `POST` to `/books`
- `GET` to `/books/<book_id>`
- `PUT` to `/books/<book_id>`
- `DELETE` to `/books/<book_id>`

The `Book` model and table should have the following columns:

- `id`
- `title`
- `description`

</details>

## Vocabulary and Synonyms

| Vocab | Definition | Synonyms | How to Use in a Sentence |
| ----- | ---------- | -------- | ------------------------ |

## Navigating Our New `tests` Folder

Create a `tests` folder, and the following files:

- `tests/__init__.py`
- `tests/conftest.py`
- `tests/test_routes.py`

We can do so with the following commands:

```
(venv) $ mkdir tests
(venv) $ touch tests/__init__.py tests/conftest.py tests/test_routes.py
```

Let's consider what these will do:

| File             | Responsibility of this file                                                                                 |
| ---------------- | ----------------------------------------------------------------------------------------------------------- |
| `__init__.py`    | Establishes our `tests` package, so it can be properly connected with the rest of the app folders and files |
| `conftest.py`    | A conventional Flask file that will hold test configurations and common test helper functions               |
| `test_routes.py` | This file will hold the tests for the code in our `app/routes.py` file.                                     |

### `conftest.py`

Let's briefly cover the contents of a `conftest.py` file, and then copy the contents of it into our own project.

```python
import pytest
from app import create_app
from app import db


@pytest.fixture
def app():
    app = create_app({"TESTING": True})

    with app.app_context():
        yield app

    with app.app_context():
        db.drop_all()


@pytest.fixture
def client(app):
    return app.test_client()
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                       |
| --------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `import pytest`                                     | We'll be utilizing pytest fixtures to set up our test app                                                                                                                                                   |
| `from app import ... db`                            | We should import `create_app` and `db` in order to configure those when running the tests                                                                                                                   |
| `@pytest.fixture`                                   | We'll create and use a pytest fixture named `app`, which will be used in our `client` fixtured (defined below)                                                                                              |
| `app = create_app( ... )`                           | When we run our tests, this line will run and create an `app` object. It's using the same `create_app` function defined in our `app/__init__.py` file!                                                      |
| `{"TESTING": True}`                                 | Here, we're passing in a dictionary to represent a "test config" object. If we check the current implementation of `create_app()` in `app/__init__.py`, it uses this argument only to check if it's truthy. |
| `with app.app_context():`                           | This syntax designates that the following code should have an _application context_, or in this case, have access to utilities such as `db`.                                                                |
| `yield app`                                         | This is pytest fixture syntax which executes the actual test at this moment. `yield app` finishes executing once the test has actually be run.                                                              |
| `with app....: db.drop_all()`                       | After the test runs, this code specifies that we should clear our test database from any data that was saved inside our test.                                                                               |
| `@pytest.fixture`                                   | We're setting up a second test fixture...                                                                                                                                                                   |
| `def client(app):`                                  | This fixture is named `client`. It will request the existing `app` fixture to run, first. It will be responsible for making a test client, which will be able to simulate a client making HTTP requests.    |

### !callout-secondary

## Practical Tip: Reading > Writing

Understanding how to read this code is more valuable than learning how to write it. Realistically, on many projects, test environments are set up. However, it's valuable to read this code in order to:

- Have a better understanding of how the app runs, which will lead to better debugging
- Get familiar with the process of setting it up, in anticipation of future projects

### !end-callout

## Reading Tests

Let's reframe the anatomy of a test for our Flask API:

| Step    | Description                                                                                                                                                                                                                    |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Arrange | Arrange all required conditions for the test. If we need test data in the test database, we should save them here.                                                                                                             |
| Act     | We need to send an HTTP request to our Flask API, so we should determine the HTTP method, path, request body, and any query params here.                                                                                       |
| Assert  | At the minimum, we should check that the HTTP response's status code is what we expect, and the shape of the HTTP response body. We could also check the details of the response body, and also the database if it's relevant. |

### The `client` Fixture

We will use the `client` fixture defined in `tests/conftest.py` in all tests that need to make an HTTP request.

Here are a few ways we'll use `client`:

| Example Usage                      | Description                                                                        |
| ---------------------------------- | ---------------------------------------------------------------------------------- |
| `client.get("my request path")`    | Sends a `GET` request to `"my request path"`. Returns the HTTP response.           |
| `client.post("my request path")`   | Sends a `POST` request to `"my request path"`. Returns the HTTP response.          |
| `client.put("my request path")`    | Sends a `PUT` request to `"my request path"`. Returns the HTTP response.           |
| `client.delete("my request path")` | Sends a `DELETE` request to `"my request path"`. Returns the HTTP response.        |
| `client.put(... , json={ ... })`   | The keyword argument `json` sends the attached dictionary as the HTTP request body |

### Syntax

Let's read through this test we can use for our Hello Books API.

```python
def test_get_all_books_with_no_records(client):
    response = client.get("/books")
    response_body = response.get_json()

    assert response.status_code == 200
    assert response_body == []
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                              |
| --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `def test_get_all_books_with_no_records( ... ):`    | Continuing our best pytest practices, this test should start with the name `test_`, and it should describe the nature of this test |
| `..._no_records(client):`                           | We pass in the `client` fixture here. pytest will automatically search and detect the fixture with the same name                   |
| `client.get("/books")`                              | This sends an HTTP request to `/books`. It returns an HTTP response object, which we store in our local variable `response`        |
| `response_body = response.get_json()`               | We can get the JSON response body with `response.get_json()`                                                                       |
| `assert response.status_code == 200`                | Every `response` object will have a `status_code`. We can read that status code and check it against the expected status code.     |
| `assert response_body == []`                        | We can check all of the parts of response body that we need to verify. We can check it's contents, size, values, etc!              |

Add this test to `tests/test_routes.py`, and now let's run them!

## Running Tests

To run the tests, we use:

```bash
(venv) $ pytest
```

We should see this already-implemented route pass!

![Screenshot of pytest test result: 1 test passed](../assets/testing-apis/testing-apis_passing-get-books.png)

Notice that we do _not_ need to run the Flask server to run the tests!

### Verify Broken Tests Can Fail

We haven't seen a failing test yet, because we are writing tests for already built functionality.

Let's verify that we can trust our tests to fail, by making them fail temporarily.

Let's go to our `app/routes.py` file and temporarily break our `/books` endpoint. One way we can break this route is to return a response with a status code `418` immediately.

```python
@books_bp.route("", methods=["GET", "POST"])
def books():
    return Response("This is one broken response!", status=418)
```

Let's confirm that our test now fails:

![Screenshot of pytest test result: test_get_one_book fails because of AssertionError, which checks if 418 is equal to 200](../assets/testing-apis/testing-apis_broken-get-books.png)

The test fails! We can read through these test failures and see that our test _expected_ a status code of `200`, but _actually_ got status `418`.

### !callout-secondary

## Revert Those Changes

Revert the changes that made the test fail, and return Hello Books back to a working state!

### !end-callout

## Tests That Need Test Data

Let's consider a second test in `tests/test_routes.py`.

When we make a `GET` request to `/books/1`, we expect a response of `200`, with a JSON response body.

The JSON response body should include the keys `"id"`, `"title"`, and `"description"`.

```python
def test_get_one_book(client):
    response = client.get("/books/1")
    response_body = response.get_json()

    assert response.status_code == 200
    assert response_body == {
        "id": "",
        "title": "",
        "description": ""
    }
```

However, this test isn't complete yet. We have only empty strings to expect for our response body's id, title, and description.

What _do_ we expect the book with `id` `1` to be? If we run this test right now, we actually get a 404! To answer this question, let's see one way to populate the test database.

### Adding Test Data with Fixtures

In our "Arrange" step of each step, we should set up its test data. pytest's test fixture feature will help us create test data. With fixtures, we can:

1. Define fixture functions that describe what is saved in the test database in `conftest.py`
1. "Request" as many fixtures as we need per test

### Example Fixture: Creating Two Books

Many of our features may benefit from having two books saved into the database. Inside of `tests/conftest.py`, we can make a fixture that expresses saving two books to the database:

```python
@pytest.fixture
def two_saved_books(app):
    ocean_book = Book(title="Ocean Book",
                      description="watr 4evr")
    mountain_book = Book(title="Mountain Book",
                         description="i luv 2 climb rocks")

    db.session.add_all([ocean_book, mountain_book])
    # Alternatively, we could do
    # db.session.add(ocean_book)
    # db.session.add(mountain_book)

    db.session.commit()
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                         |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `@pytest.fixture`                                   | Each fixture starts with this decorator                                                                       |
| `def two_saved_books(...):`                         | We can name our fixtures whatever we want. `two_saved_books` is good enough, although we could think of more! |
| `def two_saved_books(app):`                         | This fixture needs to request to use the `app` fixture, defined above, so we have access to our Flask app     |
| `ocean_book = ...`                                  | We can make our first `Book` instance...                                                                      |
| `mountain_book = ...`                               | ... and our second `Book` instance                                                                            |
| `db.session.add_all([ ... , ... ])`                 | We can use the `add_all()` function to add a list of instances                                                |
| `db.session.commit()`                               | This line commits and saves our book to the database                                                          |

#### Requesting Fixtures in Tests

To actually use this fixture in a test, we need to request this fixture by name.

```python
def test_get_one_book(client, two_saved_books):
    response = client.get("/books/1")
    # ...
```

We must add the `two_saved_books` fixture to our test. We can comma-separate as many fixtures as this single test needs.

#### Completing Our Test

Our test still fails!

We get this test failure:

```
E       AssertionError: assert {'description... 'Ocean Book'} == {'description..., 'title': ''}
E         Differing items:
E         {'title': 'Ocean Book'} != {'title': ''}
E         {'id': 1} != {'id': ''}
E         {'description': 'watr 4evr'} != {'description': ''}
E         Use -v to get the full diff
```

![Screenshot of pytest test result: test_get_one_book failed because of AssertionError between two book dictionaries](../assets/testing-apis/testing-apis_failing-fixture-comparison.png)

We should conclude that we need to update our test itself, finally!

```python
def test_get_one_book(client, two_saved_books):
    response = client.get("/books/1")
    response_body = response.get_json()

    assert response.status_code == 200
    assert response_body == {
        "id": 1,
        "title": "Ocean Book",
        "description": "watr 4evr"
    }
```

### !callout-success

## We Passed the Test!

Success! We passed this test. Congratulations! 🎉

### !end-callout

![Screenshot of pytest test result: 2 tests in tests/test_routes.py passed](../assets/testing-apis/testing-apis_passing-get-books-1.png)

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: CfBygr
* title: Testing APIs
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
