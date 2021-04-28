# Activity: Solar System API: Tests

## Goal

Our coding skills improve with repetition.

Our goal is to practice creating a minimal Flask API in a pair or group setting.

Pairing with other programmers will help create stronger understanding of the material, and improved skill at working with others. Software teams thrive on collaboration, so working side-by-side with someone while coding is vital!

In this activity, we will build a Solar System API. This API will store information about different planets.

## Activity Instructions

### Setup

- Meet with your pair/group 👋
- Decide which members will take the driver and navigator roles. This should be a switch compared to the last activity.

The new driver may need to setup their database. Follow these steps:

1. Pull down all new Git commits
1. Activate the virtual environment
1. Install the dependencies
1. Create the database `solar_system_development`
1. Run `$ flask db upgrade`
1. Run `$ flask run` to confirm that the API is running as expected

### Driver/Navigator Roles

Driver and navigator roles should switch at least daily.

### Build

Fulfill the following requirements, with similar functionality to the Hello Books API:

1. Create a `.env` file.
1. Populate it with two environment variables: `SQLALCHEMY_DATABASE_URI` and `SQLALCHEMY_TEST_DATABASE_URI`. Set their values to the appropriate connection strings.
1. Create a test database with the correct, matching name.
1. Refactor the `create_app` method to:
   1. Check for a configuration flag
   1. Read the correct database location from the appropriate environment variables
1. Manually test that our development environment still works.
1. Create a `tests` folder with the files `tests/__init__.py`, `tests/conftest.py`, and `tests/test_routes.py`.
1. Populate `tests/conftest.py` with the recommended configuration.
1. Create a test to check `GET` `/planets` returns `200` and an empty array.
1. Confirm this test runs and passes.

After test setup, make a git commit. Then, recreate the following tests:

1. `GET` `/planets/1` returns a response body that matches our fixture
1. `GET` `/planets/1` with no data in test database (no fixture) returns a `404`
1. `GET` `/planets` with valid test data (fixtures) returns a `200` with an array including appropriate test data
1. `POST` `/planets` with a JSON request body returns a `201`

### !callout-info

## Testing with JSON Request Bodies

Recall that our `client` methods (`get`, `post`, `put`, etc.) can take in an optional keyword argument `json`.

### !end-callout
