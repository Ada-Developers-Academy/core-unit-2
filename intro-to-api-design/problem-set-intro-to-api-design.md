# Problem Set: Intro to API Design

## Directions

Complete all questions below.

## Practice

Design a fictional app back-end using the prompts below.

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: LWmOjQ
* title: Intro to API Design
##### !question

Decide the overall concept of your app.

Get inspired by the following prompts:

- A data management app that lets users organize something special in their collection...
- A matchmaking app between different users who need each other for some reason...
- A journal app that lets users record something specific over time...

... Or use a completely different API idea! However, for the sake of this exercise, your API concept must be compatible with the rest of this problem set.

Describe your app concept in 3-4 sentences. Use this format:

> The name of this app is... . The responsibility of this app is to... . This app is different because... . Users will be able to... .

##### !end-question
##### !placeholder

The name of this app is... . The responsibility of this app is to... . This app is different because... . Users will be able to... .

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->

### !callout-success

## Record Your Ideas!

Did you come up with some interesting ideas for a future API? Write them down; you'll thank yourself later.

### !end-callout

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: R157h5
* title: Intro to API Design
##### !question

List 1-4 _resources_ (entities) that may exist in this app.

Examples include:

- Collectibles
- Users
- Journal Entries

##### !end-question
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 3 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: n01Cfp
* title: Intro to API Design
##### !question

Pick one resource from your app concept.

Describe all RESTful endpoints that are the CRUD operations of that one resource.

For each endpoint, include:
- A description of the endpoint
- The HTTP Method
- The path

Describe these endpoints below. Check the hint for a formatting tip.

##### !end-question
##### !hint

We could format our information like this:

```
Create one Adie: POST /adies
Get all Adies: GET /adies
Get one Adie: GET /adies/199
...
```

##### !end-hint
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 4 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: lT9jOj
* title: Intro to API Design
##### !question

Pick one resource from your app concept.

Describe an HTTP request and HTTP response in detail for each scenario. Include request method, path, request body, response code, and response body. Make decisions about what the request and response bodies should look like; there are no perfect answers.

1. Requesting a resource that exists
1. Requesting a resource that does not exist
1. Requesting a list of resources
1. Deleting a resource that exists
1. Deleting a resource that does not exist
1. Creating a new resource

Describe each scenario below. Be sure to include the example JSON request bodies and the example JSON response bodies.

Check the hint for a formatting tip.

##### !end-question
##### !hint

We could format our information like this:

```
1. Requesting an Adie that exists
HTTP Request: GET /adies/199, no request body
HTTP Response: 200 OK
Response body:

{
    "name": "Ada Lovelace",
    "adie_id": 199,
    "favorite_subject": "Math"
}

2. Requesting an Adie that does not exist
HTTP Request: ...
Request body: ...
HTTP Response: ...
Response body: ...
```

##### !end-hint
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 5 -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: gCqR8f
* title: Intro to API Design
##### !question

In your own notes, create a diagram to describe the request-response cycle for one endpoint. In this diagram, label:

- Client
- API Server
- A HTTP Request and its details
- A HTTP Response and its details

Describe the diagram below in 1-2 sentences.

##### !end-question
##### !placeholder

This diagram shows the client making a request to...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
