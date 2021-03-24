# Designing a Request

## Learning Goals

- Define REST as an architecture style for applications/APIs that uses the HTTP protocol and uses client-server architecture
- Define the REST principle of "uniform interface"
- List all HTTP Request methods: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT, PATCH
- Define CRUD as a pattern of four basic functions of persisted data
- Compare the REST principle of "uniform interface" with CRUD and the HTTP Request methods

## Introduction

Imagine Eryn, a developer who's making the back-end API for an educational podcast app. The app will allow users to sign up as students or instructors. Students can browse different courses. Each course will have several class sessions, which will contain podcast episodes.

Eryn's current challenge is making the API that will give back the data about the episodes, class sessions, courses, instructors, and students. Eryn needs to create endpoints, or entry ways, so clients can send requests to her API and get back the data they need. But what makes a good endpoint, or good entryway into her API? How does Eryn know that she's making the right endpoints?

API design is a challenging, creative skill. Each endpoint should be designed to anticipate the needs of the clients who use the API. Each response should be designed to provide value to the client.

Ultimately, the skill of designing an API grows with practice and context. All design decisions are made to solve specific problems and projects.

Therefore, before we encounter those specific problems, we can learn different design principles. Design principles will help us understand guidelines to _aim_ for.

### !callout-warning

## Web API Design Principles: YMMV

These design principles are taught purposely on an introductory level. How REST API design principles are defined, talked about, and executed varies widely between different teams, products, and organizations.

### !end-callout

## Vocabulary and Synonyms

| Vocab             | Definition                                                                                                        | Synonyms | How to Use in a Sentence                                                                                                                                |
| ----------------- | ----------------------------------------------------------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| REST              | An architecture style for applications and APIs that uses the HTTP protocol and uses client-server architecture   | -        | "RESTful APIs follow the same patterns for endpoints and how to use them, if they all follow the same design guidelines"                                |
| Uniform Interface | A REST design principle that that prefers reliable and predictable endpoints, and doesn't prefer custom endpoints | -        | "The endpoints between different RESTful APIs are similar because they have a uniform interface."                                                       |
| CRUD              | "Create, Read, Update, Delete." An acronym that describes the four basic operations to work with saved resources  | -        | "A great place to start web development is to make the CRUD functionality of a resource. That way, the user can create, read, update, and delete data." |

## HTTP RESTful Web APIs

Representational state transfer, or **REST**, is a set of architectural design principles that define how to approach online data transmission. An API that adheres to these specific design principles is called _RESTful_.

| A _RESTful API_ will...                                                                                                                                                                       | A non-RESTful API will...                                                   |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| Use HTTP for requests and responses                                                                                                                                                           | Use a different protocol for requests/responses, such as SOAP               |
| Maintain statelessness in the server. The server will not track data about the client between requests; the client will track data about the server and send it back to the server each time. | Store data about the state of each client between requests                  |
| Return standard media types in responses, such as plain text, HTML, XML, and JSON                                                                                                             | Return non-standard media types                                             |
| Provide a uniform interface for the client                                                                                                                                                    | Prioritize custom and bespoke endpoints and responses for each user's needs |

### Uniform Interface

REST's most central feature is its emphasis on a **uniform interface**. A uniform interface implies that the technical ways that a client interacts with the API should be predictable. Some API designers could believe that each endpoint of an API, and each response, should be as custom as possible. Instead, REST prioritizes creating an API with a _uniform interface_, where many different clients can reliably and predictably use it.

REST believes that a uniform interface follows these guidelines:

| Guideline                                    | Description                                                                                                                                        | Example                                        |
| -------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| Resource-based Paths                         | Request URLs and paths should be based around a _resource_. Recall that resources are any piece of data to return, such as user data or web pages. | If there is a resource about dog data, `/dogs` |
| Manipulate Resources Through Representations | Clients can modify or delete resources on a server if they have a representation of it, such as an ID                                              | Deleting the Dog resource of ID 45             |
| Self-Descriptive Messages                    | HTTP requests and responses should include the information of how to be read, by carrying information about their format (usually as a header)     |

Let's revisit REST's name: "Representational state transfer." After considering the name and these guidelines, we may conclude:

- REST prioritizes _resources_ and _representations of resources_, and this will effect how URLs are made, what information to send with HTTP requests, and what we can expect from HTTP responses.
- REST prioritizes _statelessness_ on the server between requests. It maintains statelessness between requests by relying on HTTP requests to send any details about client state.

## Meaningful Endpoints to Access Resources

Recall that an _endpoint_ is an entrypoint URL to access a web API. For example, in the LocationIQ API, `/search` is the endpoint to access the API's search functionality.

Also recall that resources are any piece of data to return, such as user data or web pages.

A well-designed RESTful API states that endpoints should be based on resources.

Imagine Eryn, who's making the back-end API for an educational podcast app. Eryn's educational app stores data about every student user, every instructor user, every different courses offered, and all class sessions within the courses.

Some example endpoints for Eryn may be:

- `/students`
- `/instructors`
- `/courses`
- `/classes`

## Meaningful HTTP Request Methods

The REST principle "self-descriptive messages" includes the princple of meaningful HTTP request methods. Well-designed RESTful APIs use HTTP request method in combination with resource-centered endpoints.

REST implies these meanings to HTTP methods:

| HTTP method | How it relates to a resource                                                                             |
| ----------- | -------------------------------------------------------------------------------------------------------- |
| `GET`       | Get a representation of the target resource's state.                                                     |
| `POST`      | Let the target resource process the representation enclosed in the request.                              |
| `PUT`       | Set the target resource's state to the state defined by the representation enclosed in the request.      |
| `DELETE`    | Delete the target resource's state.                                                                      |
| `PATCH`     | Update the target resource's state with the state defined by the representation enclosed in the request. |

## Create, Read, Update, Delete

**CRUD** is an acronym that means "Create, Read, Update, Delete." It describes four basic operations that developers want to do with stored resources.

For every resource, at a minimum, we developers should be able to create a single resource, retrieve and read the details of a single resource, update a resource with new data, and delete the resource.

The acronym CRUD is flexible, and it can be applied to data storage, APIs, web app functionality, or more. When applied to APIs, we could say that we'd like an API to be able to do all these things:

| Resource   | Create                                         | Read                                             | Update                               | Delete                               |
| ---------- | ---------------------------------------------- | ------------------------------------------------ | ------------------------------------ | ------------------------------------ |
| Student    | Create a student profile and save it to the db | Read the data from a student profile from the db | Update a student's profile in the db | Delete a student profile from the db |
| Instructor | Create an instructor and save it               | Read an instructor                               | Update an instructor                 | Delete an instructor                 |
| Course     | Create a course                                | Read a course                                    | Update a course                      | Delete a course                      |
| Class      | Create a class                                 | Read a class                                     | Update a class                       | Delete a class                       |

## Combining REST, CRUD, and Designing an Endpoint

We can combine the concepts from REST and CRUD and describe a formulaic set of API endpoints. These endpoints would be familiar to web developers because they follow the patterns of _uniform interface_.

### Student Resource

Eryn's app needs to store every student's name, contact information, courses that they're enrolled in, and classes that they attend.

In this table, each row describes a different endpoint. We can read each row from left to right like, "If a client sends an HTTP request with the `Endpoint HTTP Method` method to the `Endpoint Path` path, the API server will `Endpoint Description`, and respond with `Expected Response`."

| Endpoint HTTP Method | Endpoint Path                                                        | Request Body                 | Endpoint Description                                                           | Part of CRUD |
| -------------------- | -------------------------------------------------------------------- | ---------------------------- | ------------------------------------------------------------------------------ | ------------ |
| `POST`               | `/students`                                                          | New student data             | Creates and saves a new student to the database                                | Create       |
| `GET`                | `/students`                                                          | -                            | Get the data of all students, in a list                                        | Read         |
| `GET`                | `/students/<student_id>`, where `<student_id>` is a number like `13` | -                            | Get the data of the student with ID #13                                        | Read         |
| `PUT`                | `/students/<student_id>`, where `<student_id>` is a number like `13` | Updated student data         | Replaces the student ID #13 resource with the student data in the request body | Update       |
| `PATCH`              | `/students/<student_id>`, where `<student_id>` is a number like `13` | Part of updated student data | Updates the student ID #13 resource with the student data in the request body  | Update       |
| `DELETE`             | `/students/<student_id>`, where `<student_id>` is a number like `13` | -                            | Deletes the student ID #13 resource                                            |

## Examples

Let's observe more examples with Eryn's app. Eryn wants to build endpoints for the remaining resources: Instructor, Course, and Class.

For each example, take notes:

- Which parts did you expect?
- Which parts are unexpected?
- Would you be able to recreate this table? If you said no, what would you need to know in order to say yes?

### Instructor Resource

Eryn's app needs to store every instructor's name, contact information, and courses that they manage.

| Endpoint HTTP Method | Endpoint Path                                                                | Request Body                    | Endpoint Description                                                                | Part of CRUD |
| -------------------- | ---------------------------------------------------------------------------- | ------------------------------- | ----------------------------------------------------------------------------------- | ------------ |
| `POST`               | `/instructors`                                                               | New instructor data             | Creates and saves a new instructor to the database                                  | Create       |
| `GET`                | `/instructors`                                                               | -                               | Get the data of all instructors, in a list                                          | Read         |
| `GET`                | `/instructors/<instructor_id>`, where `<instructor_id>` is a number like `5` | -                               | Get the data of the instructor with ID #5                                           | Read         |
| `PUT`                | `/instructors/<instructor_id>`, where `<instructor_id>` is a number like `5` | Updated instructor data         | Replaces the instructor ID #5 resource with the instructor data in the request body | Update       |
| `PATCH`              | `/instructors/<instructor_id>`, where `<instructor_id>` is a number like `5` | Part of updated instructor data | Updates the instructor ID #5 resource with the instructor data in the request body  | Update       |
| `DELETE`             | `/instructors/<instructor_id>`, where `<instructor_id>` is a number like `5` | -                               | Deletes the instructor ID #5 resource                                               |

### Course Resource

Eryn's app needs to store every course's name, a description, the instructors who manage the course, the students enrolled in the class, and the classes inside the course.

| Endpoint HTTP Method | Endpoint Path                                                     | Request Body                | Endpoint Description                                                         | Part of CRUD |
| -------------------- | ----------------------------------------------------------------- | --------------------------- | ---------------------------------------------------------------------------- | ------------ |
| `POST`               | `/courses`                                                        | New course data             | Creates and saves a new course to the database                               | Create       |
| `GET`                | `/courses`                                                        | -                           | Get the data of all courses, in a list                                       | Read         |
| `GET`                | `/courses/<course_id>`, where `<course_id>` is a number like `26` | -                           | Get the data of the course with ID #26                                       | Read         |
| `PUT`                | `/courses/<course_id>`, where `<course_id>` is a number like `26` | Updated course data         | Replaces the course ID #26 resource with the course data in the request body | Update       |
| `PATCH`              | `/courses/<course_id>`, where `<course_id>` is a number like `26` | Part of updated course data | Updates the course ID #26 resource with the course data in the request body  | Update       |
| `DELETE`             | `/courses/<course_id>`, where `<course_id>` is a number like `26` | -                           | Deletes the course ID #26 resource                                           |

### Class Resource

Eryn's app needs to store every class's name, a description, the course that the class belongs to, the date and time of the class, and every student who attended it.

| Endpoint HTTP Method | Endpoint Path                                                    | Request Body               | Endpoint Description                                                        | Part of CRUD |
| -------------------- | ---------------------------------------------------------------- | -------------------------- | --------------------------------------------------------------------------- | ------------ |
| `POST`               | `/classes`                                                       | New class data             | Creates and saves a new class to the database                               | Create       |
| `GET`                | `/classes`                                                       | -                          | Get the data of all classes, in a list                                      | Read         |
| `GET`                | `/classes/<class_id>`, where `<class_id>` is a number like `171` | -                          | Get the data of the class with ID #171                                      | Read         |
| `PUT`                | `/classes/<class_id>`, where `<class_id>` is a number like `171` | Updated class data         | Replaces the class ID #171 resource with the class data in the request body | Update       |
| `PATCH`              | `/classes/<class_id>`, where `<class_id>` is a number like `171` | Part of updated class data | Updates the class ID #171 resource with the class data in the request body  | Update       |
| `DELETE`             | `/classes/<class_id>`, where `<class_id>` is a number like `171` | -                          | Deletes the class ID #171 resource                                          |

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: 
* title: Designing a Request
##### !question

Eryn has designed a RESTful API. The API has a resource named "Volunteers," and stores their names, contact information, if they are a mentor, and if they are a teaching assistant.

A client would like to be able to get a list of all volunteers. Which of the following endpoints will the client most likely use?

##### !end-question
##### !options

* `GET` method to `/volunteers`
* `POST` method to `/volunteers`
* `GET` method to `/volunteers/all`
* `PATCH` method to `/volunteers`

##### !end-options
##### !answer

* `GET` method to `/volunteers`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: 
* title: Designing a Request
##### !question

Eryn has designed a RESTful API. The API has a resource named "Volunteers," and stores their names, contact information, if they are a mentor, and if they are a teaching assistant.

A client is sending this HTTP request.

- HTTP Method: `POST`
- Path: `/volunteers`
- Request body:

```json
{
  "full_name": "Caelan Winter",
  "contact": "caelan@winter.com",
  "is_mentor": false,
  "is_teaching_assistant": true
}
```

What is the operation that the client is most likely requesting?

##### !end-question
##### !options

* Create a new volunteer with the `full_name` "Caelan Winter"
* Read the data from the volunteer with the `full_name` "Caelan Winter"
* Set the data from the volunteer with the `full_name` "Caelan Winter" with this representation
* Delete the data from the volunteer with the `full_name` "Caelan Winter"

##### !end-options
##### !answer

* Create a new volunteer with the `full_name` "Caelan Winter"

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
