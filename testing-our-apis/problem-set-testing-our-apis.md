# Problem Set: Testing Our APIs

## Directions

Complete all directions below.

There is no submission for this assignment.

On your machine, keep:

- Your completed repo
- A list of any questions you weren't able to research independently

## Practice

Continue your independent Hello Books API.

Fulfill the following requirements, with the same functionality presented in this topic:

1. Create a `.env` file.
1. Populate it with two environment variables: `SQLALCHEMY_DATABASE_URI` and `SQLALCHEMY_TEST_DATABASE_URI`. Set their values to the appropriate connection strings.
1. Create a test database with the correct, matching name.
1. Refactor the `create_app` method to:
   1. Check for a configuration flag
   1. Read the correct database location from the appropriate environment variables
1. Manually test that our development environment still works.
1. Create a `tests` folder with the files `tests/__init__.py`, `tests/conftest.py`, and `tests/test_routes.py`.
1. Populate `tests/conftest.py` with the recommended configuration.
1. Create a test to check `GET` `/books` returns `200` and an empty array.
1. Confirm this test runs and passes.

After test setup, make a git commit. Then, recreate the following tests:

1. `GET` `/books/1` returns a response body that matches our fixture
1. `GET` `/books/1` with no data in test database (no fixture) returns a `404`
1. `GET` `/books` with valid test data (fixtures) returns a `200` with an array including appropriate test data
1. `POST` `/books` with a JSON request body returns a `201`

### !callout-info

## Testing with JSON Request Bodies

Recall that our `client` methods (`get`, `post`, `put`, etc.) can take in an optional keyword argument `json`.

### !end-callout
