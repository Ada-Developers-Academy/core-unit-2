# POST /books Test

## Goals

Our goals for this lesson are to:
- Use fixtures to create test data
- Write tests that use test data

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`06c-using-setup` |`06d-read-one-book-test`|


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

**To be completed in a separate PR**