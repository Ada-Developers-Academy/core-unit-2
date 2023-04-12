# Designing Responses

## Goals

The goal for this lesson is to:

- combine knowledge about RESTful APIs and HTTP responses
- emphasize that specific HTTP responses should be anticipated and sent for various different edge cases, such as not finding a resource
- gain more familiarity with designing and shaping JSON
- see real examples of different HTTP responses from different web APIs

There aren't specific rules, patterns, or best practices to teach about designing API responses. However, comfort and practice with HTTP responses, especially in edge-case scenarios, will make us stronger developers.

## Introduction

Imagine Eryn, a developer who's making the back-end API for an educational podcast app. The app will allow users to sign up as students or instructors. Students can browse different courses. Each course will have several class sessions, which will contain podcast episodes.

Eryn's current challenge is to ensure that her API server can handle any HTTP request and to give back a response each time that is full of value to the client.

### !callout-info

## Assume HTTP Response Bodies in JSON

For this lesson, let's assume that our APIs will always return JSON-formatted HTTP response bodies.

### !end-callout

## Vocabulary and Synonyms

- Response Headers
- Response Body
- HTTP Status Code

## Anticipating Possible Outcomes Lets Us Gracefully Handle Errors

A client calling an API wants to always receive a meaningful HTTP response. We can ask ourselves for every HTTP request, what is the best HTTP response?

Assuming a RESTful API design, let's list the considerations for each endpoint based around a resource.

| CRUD   | **_What is the response for..._**                     |
| ------ | ----------------------------------------------------- |
| Create | successfully creating a new resource?                 |
| Create | **_unsuccessfully_** creating a new resource?         |
| Read   | reading the details of a resource?                    |
| Read   | reading the details of a resource that doesn't exist? |
| Update | updating a resource successfully?                     |
| Update | updating a resource **_unsuccessfully_**?             |
| Update | updating a resource that doesn't exist?               |
| Delete | deleting a resource successfully?                     |
| Delete | deleting a resource that doesn't exist?               |

For a more advanced web API, we can also consider the following questions:

- For each endpoint, what is the response when a user is not logged in?
- For each endpoint, what is the response when a user is logged in, but they aren't authorized?

## Meaningful Status Codes

Great HTTP responses have meaningful status codes that describe the result of the HTTP request.

We can use these status codes to indicate to the client if:

- Their HTTP request was successfully handled in our API
- Their HTTP request requested something that our server doesn't understand how to handle
- Their HTTP request requested something that raised an error or caused a problem on our server

For every situation, it's a good idea to check the [list of standard HTTP status codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) to decide the most appropriate one.

| Status Code Range | Indicates...                                                                                                                     |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 100-199           | Informational response; not frequently used                                                                                      |
| 200-299           | Successful response; the request was successfully accomplished                                                                   |
| 300-399           | Redirects; the requested resource has been moved, or something similar                                                           |
| 400-499           | Client errors; the request itself that the client sent has some sort of problem for some reason                                  |
| 500-599           | Server errors; the server received the request, but it ran into an error and cannot create a successful response for some reason |

### Common HTTP Status Codes

Here is a list of the most common HTTP status codes.

| Status Code | <div style="min-width:150px;">Status Message</div> | Meaning                                                                                                         |
| ----------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `200`       | `OK`                                               | The request has succeeded. Implies that the fetched resource is in the response body.                           |
| `201`       | `Created`                                          | The request has succeeded and a new resource has been created as a result                                       |
| `301`       | `Moved Permanently`                                | The URL of the requested resource has been changed permanently                                                  |
| `400`       | `Bad Request`                                      | The server could not understand the request due to invalid syntax.                                              |
| `404`       | `Not Found`                                        | The server can not find the requested resource, whether the URL is invalid, or that the resource doesn't exist. |
| `500`       | `Internal Server Error`                            | The server has encountered a situation it doesn't know how to handle                                            |

## The Shape of the JSON Response Body

When we consider creating a JSON response body, we should ask these questions about the client needs:

- What is the client expecting?
- What does the client need to know?
- What's the best way to structure what the client needs to know?

Once we understand the client's needs, then we'll ask these questions about structure:

- What data structure should this response be? Should it be a list or a dictionary?
- If it's a dictionary, what keys exist? What are their values?
- If it's a list, then what data structure is each item?

After considering all of these things, it is up to our creativity to determine the best JSON response body.

### Example: `GET` `/students/66`

In Eryn's educational podcast app, there is the resource, students. Eryn's app stores every student's name, contact information, courses that they're enrolled in, and classes that they attend.

The student data looks like this in a JSON file:

```json
[
  {
    "student_id": 66,
    "full_name": "Imaani Moyer",
    "email_address": "imaani@moyer.com",
    "courses": ["Pre-Calculus", "AP Art", "Intro to Programming"]
  },
  {
    "student_id": 67,
    "full_name": "Fatima Mahar",
    "email_address": "fmahar@email.com",
    "courses": ["Physics","Intermediate Programming", "Statistics"]
  },
  {
    "student_id": 69,
    "full_name": "Jazmin Guerrero",
    "email_address": "jguerrero@email.com",
    "courses": ["Pre-Calculus", "Middle Eastern Studies", "Intro to Programming"]
  }
]
```

Imagine a client sending the HTTP request below to Eryn's API:

- `GET` `/students/66`

The client only needs to know the student's name, contact info, and courses they're enrolled in.

From RESTful routes, let's answer the questions from above:

| Considerations                                                                    | Notes                                                                                                                                                 |
| --------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| What is the client expecting?                                                     | JSON response body about a single student with the id `66`                                                                                            |
| What does the client need to know?                                                | The student's name, contact info, and a list of courses they're enrolled in.                                                                          |
| What's the best way to structure what the client needs to know?                   | key-value pairs                                                                                                                                       |
| What data structure should this response be? Should it be a list or a dictionary? | Dictionary                                                                                                                                            |
| If it's a dictionary, what keys exist? What are their values?                     | `"name"` should be the student's `full_name`, `"contact_info"` should be the student's `email_address`, `"courses"` should be a list of courses |
| If it's a list, then what data structure is each item?                            | -                                                                                                                                                     |

From this information, Eryn may represent the student data like this:

```json
{
  "id": 66,
  "name": "Imaani Moyer",
  "contact_info": "imaani@moyer.com",
  "courses": ["Pre-Calculus", "AP Art", "Intro to Programming"]
}
```

Or even this:

```json
{
  "student_id": 66,
  "full_name": "Imaani Moyer",
  "email_address": "imaani@moyer.com",
  "courses": ["Pre-Calculus", "AP Art", "Intro to Programming"]
}
```

### Example: `GET` `/students/08342tacocat2341` Not Found

What should the web API return when the client requests a student resource, but that student doesn't exist? Imagine a client sending this request:

- `GET` `/students/08342tacocat2341`

What should the response body be? Eryn has at least two meaningful options:

1. JSON that holds details about the error: the student isn't found
1. Don't send back a response body

If Eryn pursues the first option, she might pick a dictionary whose key-value pairs describe the error:

```json
{
  "error": "The student was not found"
}
```

Depending on what she anticipates her clients' needs are, she might add more details. She will need to do research and make assumptions in order to figure out what's best:

```json
{
  "success": false,
  "msg": "Student not found"
}
```

Or, of course, Eryn could choose to not send back any data besides a status code.

### !callout-info

## Response Bodies Are Optional

RESTful APIs send back self-descriptive responses. Sometimes, an HTTP status code and message is all you need!

### !end-callout

## Example Outcomes

We can combine meaningful HTTP statuses and intentional response bodies to create an example pattern.

**How a RESTful API ultimately implements it is based on the context of the API**. This table is not industry-standard at all, but only an example.

| Description                                                                    | Request Body                                                      | Response Status   | Response Body                                 |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------- | ----------------- | --------------------------------------------- |
| What is the response for successfully creating a new resource?                 | Valid resource data                                               | `201 Created`     | JSON with the new resource                    |
| What is the response for _unsuccessfully_ creating a new resource?             | _Invalid_ resource data, such as missing a required attribute     | `400 Bad Request`          | JSON with details about the missing attribute |
| What is the response for reading the details of a resource?                    | -                                                                 | `200 OK`          | JSON with the resource                        |
| What is the response for reading the details of a resource that doesn't exist? | -                                                                 | `404 Not Found`   | -                                             |
| What is the response for updating a resource successfully?                     | Valid resource data                                               | `200 OK`          | -                                             |
| What is the response for updating a resource _unsuccessfully_?                 | _Invalid_ resource data, such as violating a data type constraint | `400 Bad Request` | JSON with details about the error             |
| What is the response for updating a resource that doesn't exist?               | Valid resource data                                               | `404 Not Found`   | -                                             |
| What is the response for deleting a resource successfully?                     | -                                                                 | `200 OK`          | -                                             |
| What is the response for deleting a resource that doesn't exist?               | Valid resource data                                               | `404 Not Found`   | -                                             |

## Examples: Slack Web API

Let's consider what the [Slack Web API](https://api.slack.com/web) responds with. Slack describes their web API like so:

> The Slack Web API is an interface for querying information from and enacting change in a Slack workspace.

We can look at the documentation for the different endpoints in the [Slack API Methods Documentation](https://api.slack.com/methods).

Let's consider these two endpoints in the Slack API:

1. [`chat.postMessage`](https://api.slack.com/methods/chat.postMessage)
2. [`chat.delete`](https://api.slack.com/methods/chat.delete)

For these two endpoints, we should use the documentation to answer these four questions:

1. What is the situation for a successful response?
2. What is the response for a successful response?
3. What is the situation for an unsuccessful response?
4. What is the response for an unsuccessful response?

_Note: Written in March 2021._

### `chat.postMessage` Successful and Unsuccessful Responses

This endpoint's responsibility is to "post a message to a public channel, private channel, or direct message/IM channel."

The situation for a successful response is when the request successfully posts a message. The example response that the documentation lists is:

```json
{
  "ok": true,
  "channel": "C1H9RESGL",
  "ts": "1503435956.000247",
  "message": {
    "text": "Here's a message for you",
    "username": "ecto1",
    "bot_id": "B19LU7CSY",
    "attachments": [
      {
        "text": "This is an attachment",
        "id": 1,
        "fallback": "This is an attachment's fallback"
      }
    ],
    "type": "message",
    "subtype": "bot_message",
    "ts": "1503435956.000247"
  }
}
```

An example situation for an unsuccessful response is when there are too many attachments included. The example response that the documentation lists is:

```json
{
  "ok": false,
  "error": "too_many_attachments"
}
```

### `chat.delete` Successful and Unsuccessful Responses

This endpoint's responsibility is to "delete a message from a conversation."

The situation for a successful response is when the request successfully deletes a message. The example response that the documentation lists is:

```json
{
  "ok": true,
  "channel": "C024BE91L",
  "ts": "1401383885.000061"
}
```

An example situation for an unsuccessful response is when the message isn't found. The example response that the documentation lists is:

```json
{
  "error": "message_not_found",
  "ok": false
}
```

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: LUCeiR
* title: Designing a Response
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
