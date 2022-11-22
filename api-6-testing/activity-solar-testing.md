# Activity: Solar System API - Wave 06

Follow directions from your classroom instructor for completing this activity.

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: c93c671c-02c4-42e1-b719-5e9b9ec6d925
* title: Tests
##### !question

Check off all the endpoints you tested.

##### !end-question
##### !options

* `GET` `/planets/1` returns a `200` with a response body that matches our fixture
* `GET` `/planets/1` with no data in test database (no fixture) returns a `404`
* `GET` `/planets` with valid test data (fixtures) returns a `200` with an array including appropriate test data
* `POST` `/planets` with a JSON request body returns a `201`
* `PUT` `/planets/1` with a JSON request body returns a `200` with a response body that matches our fixture
* `DELETE` `/planets/1` with a JSON request body returns a `200` with a response body that matches our fixture

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->

### !challenge
* type: paragraph
* id: 1955db02-a681-490b-8f4f-cf084e227bf4
* title: Edge Cases
##### !question

Write at least 3 additional tests to test endpoints not covered by the list above at the bottom of `test_routes.py`. Describe the expected input and output for each test case below.

##### !end-question

### !end-challenge