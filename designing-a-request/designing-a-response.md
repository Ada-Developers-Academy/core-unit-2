# Designing a Response

## Learning Goals

## Introduction

Imagine Eryn, a developer who's making the back-end API for an educational podcast app. The app will allow users to sign up as students or instructors. Students can browse different courses. Each course will have several class sessions, which will contain podcast episodes.

Eryn's current challenge is to ensure that her API server can handle any HTTP request, and to give back a response each time that is full of value to the client.

### !callout-info

## Assume HTTP Response Bodies in JSON

For this lesson, let's assume that our APIs will always return JSON-formatted HTTP response bodies.

### !end-callout

## Vocabulary and Synonyms

- Response Headers
- Response Body
- HTTP Status Code

## Anticipating Possible Outcomes

A client calling an API wants to always receive a meaningful HTTP response. This includes anticipating different kinds of situations. We can ask ourselves for every endpoint, what is the best HTTP response based on the HTTP response?

Assuming a RESTful API design, let's list the considerations for each endpoint based around a resource named Resource.

| Description                                                                    | CRUD   | Request Method | Path                          | Request Body                                                      |
| ------------------------------------------------------------------------------ | ------ | -------------- | ----------------------------- | ----------------------------------------------------------------- |
| What is the response for successfully creating a new resource?                 | Create | `POST`         | `/resources`                  | Valid resource data                                               |
| What is the response for _unsuccessfully_ creating a new resource?             | Create | `POST`         | `/resources`                  | _Invalid_ resource data, such as missing a required attribute     |
| What is the response for reading the details of a resource?                    | Read   | `GET`          | `/resources/1`                | -                                                                 |
| What is the response for reading the details of a resource that doesn't exist? | Read   | `GET`          | `/resources/08342tacocat2341` | -                                                                 |
| What is the response for updating a resource successfully?                     | Update | `PUT`          | `/resources/1`                | Valid resource data                                               |
| What is the response for updating a resource _successfully_?                   | Update | `PUT`          | `/resources/1`                | _Invalid_ resource data, such as violating a data type constraint |
| What is the response for updating a resource that doesn't exist?               | Update | `PUT`          | `/resources/08342tacocat2341` | Valid resource data                                               |
| What is the response for deleting a resource successfully?                     | Delete | `DELETE`       | `/resources/1`                | -                                                                 |
| What is the response for deleting a resource that doesn't exist?               | Delete | `DELETE`       | `/resources/08342tacocat2341` | Valid resource data                                               |

For a more advanced web API, we can also consider the following questions:

- For each endpoint, what is the response when a user is not logged in?
- For each endpoint, what is the response when a user is logged in, but they aren't authorized?

## Meaningful Status Codes

The first way to design HTTP responses so they are full of valuable meaning is to use meaningful status codes.

Recall that status codes are three digit numbers. The numbers indicate the kind of response it is. We can use these status codes to indicate to the client if:

- Their HTTP request was successfully handled in our API
- Their HTTP request requested something that our server doesn't understand how to handle
- Their HTTP request requested something that raised an error or caused a problem on our server

| Status Code Range | Indicates...                                                                                                                     |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 100-199           | Informational response; not frequently used                                                                                      |
| 200-299           | Successful response; the request was successfully accomplished                                                                   |
| 300-399           | Redirects; the requested resource has been moved, or something similar                                                           |
| 400-499           | Client errors; the request itself that the client sent has some sort of problem for some reason                                  |
| 500-599           | Server errors; the server received the request, but it ran into an error and cannot create a successful response for some reason |

There is a number of pre-defined HTTP status codes and status messages. [MDN has a full list of all HTTP status codes and messages](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status). We should feel great about looking through this list and picking and choosing the best pre-defined HTTP status code.

#### Common HTTP Status Codes

Here is a list of the most common HTTP status codes.

| Status Code | Status Message          | Meaning                                                                                                         |
| ----------- | ----------------------- | --------------------------------------------------------------------------------------------------------------- |
| `200`       | `OK`                    | The request has succeeded. Implies that the fetched resource is in the response body.                           |
| `201`       | `Created`               | The request has succeeded and a new resource has been created as a result                                       |
| `301`       | `Moved Permanently`     | The URL of the requested resource has been changed permanently                                                  |
| `400`       | `Bad Request`           | The server could not understand the request due to invalid syntax.                                              |
| `404`       | `Not Found`             | The server can not find the requested resource, whether the URL is invalid, or that the resource doesn't exist. |
| `500`       | `Internal Server Error` | The server has encountered a situation it doesn't know how to handle                                            |

## Meaningful Response Bodies in JSON

HTTP response bodies could potentially be a JSON data structure.

### The Shape of the JSON Response Body

When we consider creating a JSON response body, we'll ask ourselves the question:

- What data structure should this response be? Should it be a list or a dictionary?
- If it's a dictionary, what keys exist? What are their values?
- If it's a list, then what data structure is each item?

## Conventional Outcomes

## Examples

## Check for Understanding
