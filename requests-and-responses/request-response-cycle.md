# Request-Response Cycle

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=d7d102bf-3020-4e34-b8e3-ad1000290ba0&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Learning Goals

- Explain how HTTP Requests, Responses, clients, and servers interact as part of the Request-Response Cycle
- Define HTTP Request and its parts: HTTP Request method, Path, Header fields, optional message body
- Define HTTP Response and its parts: Status Code, Header fields, optional message body
- List common HTTP status codes and their meanings: 200, 201, 301, 404, 500

## Introduction

Most web apps work by adhering to the client-server model:

1. The end-user's web browser is a client, and sends HTTP requests to a web server over the Internet
1. The web server sends an HTTP response for every request back to the client

Therefore, when we start _building_ web apps, we'll need a slightly deeper understanding about what an HTTP request and an HTTP response is. We can explore these details through learning about the request-response cycle.

## Vocabulary and Synonyms

| Vocab             | Definition                                                                  | Synonyms                                     | How to Use in a Sentence                                                                                                                              |
| ----------------- | --------------------------------------------------------------------------- | -------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| Sending a request | The act of sending an HTTP request from a client to a server                | Calling an API, making a request, requesting | "We make a request to the Yelp API to request restaurant review data," "After logging in, we need to call the Yelp API to get restaurant review data" |
| Endpoint          | Another name for the "path" of a resource, usually in the context of an API | Path, request URL, route                     | "Right now we're sending a `GET` request to the `/blog` endpoint"                                                                                     |

## Clients Make Requests, Servers Give Responses

The request-response cycle describes the movement of messages sent over the Internet. Clients make HTTP requests and send them to web servers. As a reply to each request, servers construct an HTTP response and sends it back.

HTTP requests usually request a _resource_. A **resource** is a term to describe data that can be sent over the Internet, whether it's a full website, a piece of JSON with specific data, some XML, or a string of text.

## Anatomy of an HTTP Request

An HTTP request is a string of text that is specifically formatted to follow HTTP rules. Every HTTP request has the following parts:

| Part of an HTTP Request | Description                                                                                                                                                                                               | Required? |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| HTTP Method             | A word that describes the operation that the client wants to perform. The request method implies the nature of the request, whether it's fetching a resource, sending new information, or something else. | Yes       |
| Path (or request URL)   | The URL that the requested resource is located at. Depending on context, this may include parts of the URL such as `http://`, `adadevelopersacademy.org/`, or not.                                        | Yes       |
| Query Parameters        | Key-value pairs that describe information that can make this request more specific. Query params ultimately affect and become part of the request URL.                                                    | No        |
| HTTP Headers            | Colon-separated pairs of information to describe additional details that the server may need                                                                                                              | No        |
| HTTP Body               | Additional resources that need to be sent to the server                                                                                                                                                   | No        |

Details and examples of these pieces are listed below.

### HTTP Request Methods

HTTP defines a set of request methods that each request can choose one of. Because most of these are _verbs_, HTTP methods are often called _HTTP verbs_.

Each request method implies the nature of the request.

| HTTP Method | Implied meaning                                                                                                         |
| ----------- | ----------------------------------------------------------------------------------------------------------------------- |
| `GET`       | Requests retrieving the data of a specified resource                                                                    |
| `POST`      | Requests submitting data to the server, and changing the state of the server. Usually associated with submitting forms. |
| `PUT`       | Requests replacing a resource with a new resource                                                                       |
| `PATCH`     | Requests replacing parts of a resource                                                                                  |
| `DELETE`    | Requests deleting a resource                                                                                            |

For the sake of practicality, this table doesn't cover the less frequently used methods `HEAD`, `CONNECT`, `OPTIONS`, and `TRACE`.

Examples of HTTP methods in requests include:

- Making a `GET` request to fetch the data of all videos in a playlist
- Making a `POST` request to submit a comment on a video
- Making a `PUT` request to submit edits to a video after trimming, cutting, and editing it
- Making a `PATCH` request to edit the title of a video
- Making a `DELETE` request to delete the comment on a video

### Path

The request URL or _path_ in an HTTP request is the path to a resource hosted online.

Again, the requested resource could be a website, a PDF file, an image file, or something else.

Examples:

| Full Path                                                        | Abbreviated Path                 |
| ---------------------------------------------------------------- | -------------------------------- |
| `https://adadevelopersacademy.org/`                              | `/`                              |
| `https://adadevelopersacademy.org/who-is-ada/`                   | `/who-is-ada`                    |
| `https://adadevelopersacademy.org/blog/`                         | `/blog`                          |
| `https://adadevelopersacademy.org/fictional/not-real-image.jpg`  | `/fictional/not-real-image.jpg`  |
| `https://adadevelopersacademy.org/fictional/not-real/super-fake` | `/fictional/not-real/super-fake` |

### Endpoint

When talking about APIs, an **endpoint** is another name for a _path_ or _route_ that expects API requests. Consider these examples:

| Full Path                                      | Abbreviated Path/Endpoint | How to Use in a Sentence                                              |
| ---------------------------------------------- | ------------------------- | --------------------------------------------------------------------- |
| `https://adadevelopersacademy.org/`            | `/`                       | "We should send a request to the `/` endpoint"                        |
| `https://adadevelopersacademy.org/who-is-ada/` | `/who-is-ada`             | "The server is expecting requests sent to the `/who-is-ada` endpoint" |
| `https://adadevelopersacademy.org/blog/`       | `/blog`                   | "Right now we're sending a `GET` request to the `/blog` endpoint"     |

### !callout-info

## Going to a URL in a Browser Is a `GET` Request by Default

Imagine going to a web browser and going to the URL `https://adadevelopersacademy.org/`. When the browser visits this page, by default, the browser is making an HTTP request with the `GET` method to this path, and getting the website back as a response.

### !end-callout

### Query Params

Query parameters are key-value pairs that describe information that makes the request more specific.

Query parameters ultimately become formatted as a string as part of the request URL. The text-formatting happens in this pattern:

```
http://fake.org?example_1=value_1&example_2&value_2
```

... where there are two query param key-value pairs:

1. `example_1: value_1`
2. `example_2: value_2`.

Query params can be used for anything. However, query params are often used to specify a request. Here are some common examples:

| Example use case                                                                                                                                                           | Example key-value pair(s)     | <div style="min-width:250px;">request URL</div> |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- | ----------------------------------------------- |
| While online shopping, wanting to go to the second page of products                                                                                                        | `page`: `2`                   | `http://fake.org/products?page=2`               |
| While looking up apartments, condos, and houses, wanting to limit the number of listings to 50, and wanting to sort them by descending price                               | `limit`: `50`, `sort`: `desc` | `http://fake.org/listings?limit=50&sort=desc`   |
| After clicking an advertisement in an email, the request can send information about the _referral_ of this link, and signify that the user was referred here through email | `ref`: `email`                | `http://fake.org/advertised-product?ref=email`  |

### Headers

Headers attached to a request can provide additional information needed to give to the server about the request itself.

HTTP headers are most useful when giving information for how the client and server should connect, details about authentication and authorization, and formats of data sent between client and server. In basic and introductory settings, HTTP headers are less important to understand.

Here are some example headers:

| Example Header  | Purpose of Header                                                                           | <div style="min-width:150px;">Example Values</div> |
| --------------- | ------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| `User-Agent`    | Describes the client making the request on behalf of the end-user (usually the web browser) | `Mozilla/5.0`                                      |
| `Accept`        | Describes the types of contents that the client is able to understand                       | `text/html`, `image/*`                             |
| `Cache-Control` | Describes instructions for caching this request                                             | `max-age=0`, `no-cache`,                           |

### Optional Bodies

An HTTP request can optionally have a resource (website, JSON, XML, image, etc.) attached to its request body.

Here are example resources that would be attached a request body:

1. A `POST` request that holds the form data for a loan application that someone fills out online
1. A `POST` request that holds an image that someone is uploading as their profile picture

## Anatomy of an HTTP Response

An HTTP response is a string of text that follows HTTP rules. Every HTTP response has the following parts:

| Part of an HTTP Response | Description                                                                                  | Required? |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------- |
| Status Code              | A number that indicates if a request was successful or unsuccessful, and why                 | Yes       |
| Status Message           | A description attached to the status code                                                    | Yes       |
| HTTP Headers             | Colon-separated pairs of information to describe additional details that the client may need | No        |
| HTTP Body                | The resource that needs to be sent to the client                                             | No        |

### Status Codes and Status Messages

Status codes and status messages are parts of an HTTP response to give an overview report about the result of the HTTP request.

There is a number of pre-defined HTTP status codes and status messages. [MDN has a full list of all HTTP status codes and messages](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status).

Status codes are three digit numbers. The numbers, namely the first digit, indicate the kind of response it is.

| Status Code Range | Indicates...                                                                                                                     |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 100-199           | Informational response; not frequently used                                                                                      |
| 200-299           | Successful response; the request was successfully accomplished                                                                   |
| 300-399           | Redirects; the requested resource has been moved, or something similar                                                           |
| 400-499           | Client errors; the request itself that the client sent has some sort of problem for some reason                                  |
| 500-599           | Server errors; the server received the request, but it ran into an error and cannot create a successful response for some reason |

#### Common HTTP Status Codes

Here is a list of the most common HTTP status codes.

| Status Code | <div style="min-width:150px;">Status Message</div> | Meaning                                                                                                         |
| ----------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `200`       | `OK`                                               | The request has succeeded. Implies that the fetched resource is in the response body.                           |
| `201`       | `Created`                                          | The request has succeeded and a new resource has been created as a result                                       |
| `301`       | `Moved Permanently`                                | The URL of the requested resource has been changed permanently                                                  |
| `404`       | `Not Found`                                        | The server can not find the requested resource, whether the URL is invalid, or that the resource doesn't exist. |
| `500`       | `Internal Server Error`                            | The server has encountered a situation it doesn't know how to handle                                            |

### !callout-secondary

## I'm a Teapot

Fun fact: HTTP status code and message [`418 I'm a Teapot`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/418) is an April Fool's Day joke that started in 1998. It's worth exploring all of the different HTTP status codes and messages!

### !end-callout

### Headers

Just like HTTP requests, HTTP responses can have HTTP headers. At this level of depth, HTTP headers in responses look and work almost identically as they do in requests.

### Optional Message Bodies

Also similar to HTTP requests, HTTP responses can have a resource (website, JSON, XML, image, etc.) attached to its response body. However, HTTP responses tend to utilize the body much more frequently than requests do.

Here are example resources that would be attached a response body:

1. After the client requests for all videos within a specific playlist, a response that holds the data of all videos within that playlist
1. After the client posts a comment with invalid data, a response that holds an error message stating that the comment was invalid

## Examples of Requests and Responses

The beauty of the request-response cycle is to witness the story it tells _solely_ through the parts of the HTTP request and HTTP responses itself.

1. Imagine Ari, who is on a video sharing platform, tubeyou.com. She is making a request to see all of the popular videos for the day. When she clicks "Popular Videos," her web browser will make an HTTP request.

| Request Method | Request Path                       | Request Body |
| -------------- | ---------------------------------- | ------------ |
| `GET`          | `http://tubeyou.com/popularvideos` | -            |

Imagine that the website tubeyou.com is online, alive, and kicking. The server sends back this response.

| Response Status and Message | Response Body                                                                                   |
| --------------------------- | ----------------------------------------------------------------------------------------------- |
| `200 OK`                    | A web page that has all of the video titles, thumbnails, and links to the top videos of the day |

2. Now, imagine Ari is editing the title of a video they created and uploaded. When they submit the web form to update the title, the browser makes this request.

| Request Method | <div style="min-width:200px;">Request Path</div> | Request Body                                                                                 |
| -------------- | ------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| `PATCH`        | `http://tubeyou.com/aris-video`                  | JSON that includes the new title of the video: `{ "new_title": "Ari's Updated Video Title"}` |

tubeyou.com wants to respond that the update was successful.

| Response Status and Message | Response Body |
| --------------------------- | ------------- |
| `200 OK`                    | -             |

3. Finally, imagine Ari is going to view a specific video, but this video was recently deleted.

| Request Method | Request Path                                     | Request Body |
| -------------- | ------------------------------------------------ | ------------ |
| `GET`          | `http://tubeyou.com/this-video-no-longer-exists` | -            |

The server needs to respond that there is no resource found at that path that it can return.

| Response Status and Message | Response Body                                                                                                             |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `404 Not Found`             | JSON that includes redundant detail about where this error came from: `{ "error": {"message": "Video No Longer Exists"}}` |

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: LZR9GV
* title: Request-Response Cycle
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
