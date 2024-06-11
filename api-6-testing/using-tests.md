# GET /books Test

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=7971fa94-cbbf-46ee-9f48-ad1d015959e0&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Goals

Our goals for this lesson are to:
- Describe the pytest syntax used to define automated tests in Flask
- Practice writing and running automated tests in Flask with pytest
- Write a test that is expected to fail to help verify functionality

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`06b-test-setup` |`06c-using-tests`|

<details>
   <summary>Expand to see the new test related features <code>Hello Books API</code> should have before this lesson</summary>

* A `hello_books_test` database
* A `.env` file that contains:

```
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
```

* A `tests` directory that contains:
    * `__init__.py`
    * `conftest.py`
        * This file is populated.
    * `test_book_routes.py`

</details>
<br>

## Reading Code

Let's get to reading some test code! Let's reframe the three sections of a test for our Flask API:

| Section | Description                                                                                                                                                                                                                                                     |
| ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Arrange | Arrange all required conditions for the test. If we need test data in the test database, we should save it here.                                                                                                                                                |
| Act     | We need to send an HTTP request to our Flask API, so we should determine the HTTP method, path, request body, and any query params here.                                                                                                                        |
| Assert  | At a minimum, we should confirm the expected HTTP response status code, and the shape of the HTTP response body (if one exists). We could also check the details of the response body, or look for changes in the database if our request should have made updates to our data. |

### Syntax

Let's read through this test we can use in our `tests/test_book_routes.py`.

```python
def test_get_all_books_with_no_records(client):
    # Act
    response = client.get("/books")
    response_body = response.get_json()

    # Assert
    assert response.status_code == 200
    assert response_body == []
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                   |
| --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `def test_get_..._no_records( ... ):`               | Continuing our best pytest practices, this test should start with the name `test_`, and it should describe the nature of this test. The name is shortened here for formatting purposes. |
| `client`                                            | We pass in the `client` fixture here, which we registered in `conftest.py`. pytest automatically tries to match each test parameter to a fixture with the same name.                    |
| `client.get("/books")`                              | This sends an HTTP request to `/books`. It returns an HTTP response object, which we store in our local variable `response`                                                             |
| `response_body = response.get_json()`               | We can get the JSON response body with `response.get_json()`                                                                                                                            |
| `assert response.status_code == 200`                | Every `response` object will have a `status_code`. We can read that status code and check it against the expected status code.                                                          |
| `assert response_body == []`                        | We can check all of the parts of the response body that we need to verify. We can check its contents, size, values, etc!                                                                |

Add this test to `tests/test_book_routes.py`, and let's run it!

## Running Tests

To run our Flask tests, we can use the same methods as for any other test. From the command line we can run:

```bash
(venv) $ pytest
```

Or we can run them through the VS Code test panel.

We should see this already-implemented route pass!

![Screenshot of pytest test result: 1 test passed](../assets/api-6-testing/api-6-testing_passing-get-books.png)

Notice that we did _not_ need to run the Flask server to run the tests!

### Verify Broken Tests Can Fail

We haven't seen a failing test yet, because we are writing tests for already built functionality.

Let's verify that we can trust our tests to fail, by making them fail temporarily.

Let's go to our `app/routes/book_routes.py` file and temporarily break our `/books` endpoint. One way we can break this route is to return a response with a status code `418` before doing anything else in the function.

```python
@books_bp.get("")
def get_all_books():
    return make_response("I'm a teapot!", 418)
```

Let's confirm that our test now fails:

![Screenshot of pytest test result: test_get_one_book fails because of AssertionError, which checks if 418 is equal to 200](../assets/api-6-testing/api-6-testing_broken-get-books.png)

The test fails! We can read through these test failures and see that our test _expected_ a status code of `200`, but _actually_ got status `418`.

### !callout-secondary

## Revert Those Changes

Revert the changes that made the test fail, and return Hello Books back to a working state!

### !end-callout

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: bbc37084-f5de-4805-bd0a-17c78f009c74
* title: `GET` `/books` Test
##### !question

Select all of the actions below which we would take in the `Assert` step of a test.  

##### !end-question
##### !options

a| Send an HTTP request to our Flask API
b| Confirm the HTTP response status code
c| Save test data in the test database
d| Check the details of the response body

##### !end-options
##### !answer

b|
d|

##### !end-answer
##### !hint

What actions do we take in each of the arrange, act, and assert steps of a test for an API route?

##### !end-hint
##### !explanation

* Send an HTTP request to our Flask API - This would be our Act step, taking the action to call our API
* Confirm the HTTP response status code - Confirming the response status code is part of our Assert step since we are checking if the results of our action step are as expected. 
* Save test data in the test database - Setting up data for tests is part of the Arrange step of a test
* Check the details of the response body - Checking the details of the response body is part of our Assert step since we are checking if the results of our action step are as expected.

##### !end-explanation
### !end-challenge
<!-- prettier-ignore-end -->
