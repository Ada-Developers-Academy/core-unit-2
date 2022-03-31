# POST /books Test

## Goals

Our goals for this lesson are to:
- Use fixtures to create test data
- Write tests that use test data

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`06d-read-one-book-test` |`06e-post-books-test`|


# Syntax

Let's read through this test we can use in our tests/test_routes.py.

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

| <div style="min-width:250px;"> Piece of Code </div> | Notes|
|--|--|
|`def test_create_one_book(client):` | Continuing our best pytest practices, this test should start with the name `test_`, and it should describe the nature of this test.|
|`client.post("/books", json=...`|Sends an `POST` request to `/book` with the JSON request body passed in as the `json` keyword argument| 
| `response_body = response.get_json()`| Get the JSON response body with `response.get_json()|
|`assert response.status_code == 201`|Check for the expected status code|
|`assert response_body == "Book New Book successfully created"`|Check for the expected response body|