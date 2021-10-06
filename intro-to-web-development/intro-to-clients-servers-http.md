# Intro to Clients, Servers, HTTP

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=49cd0726-a1de-49f8-93fc-ad17004ec014&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Learning Goals

- Define client
- Define web server
- Explain that HTTP is a protocol that specifies how data is communicated (sent and received through the request-response cycle)
- Define request-response cycle

## Introduction

Web developers develop programs that operate over Internet connections. The Internet connects users to other users, and users to other machines. In order to make better web apps in the future, getting a **definition-level** understanding of different pieces of the Internet now will help us.

### Format: Brief Definitions

The format of this lesson is to introduce several concepts on the **definition** level. This curriculum purposely does not go deeper into this material.

Understanding how data is sent over the Internet is useful for us web developers, but ultimately not necessary. Learning about Internet infrastructure as a web dev is similar to learning about how clothing materials get shipped between different manufacturers as a clothes designer. It's useful context for deep understanding, but almost irrelevant for entry-level roles.

We recommend taking this material and learning it on the definition level, and applying it to your every day Internet-browsing life. Additionally, follow your curiosity!

## Vocabulary and Synonyms

| Vocab      | Definition                                                                                                               | How to Use in a Sentence                                                                                                                       |
| ---------- | ------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Client     | Within the client-server model, a computer who sends a request for a resource to a server, and receives back a response  | "The client needs the data about news articles, so it will request that data from the server"                                                  |
| Server     | Within the client-server model, a computer who receives requests for a resource from a client, and sends back a response | "The server needs to respond to the client with their requested resources. The server will give back data about news articles."                |
| Web Server | Within the client-server model, a server that is specifically connected to a client over the web                         | "The web browser needs to get news article data, but it seems like the web servers are offline and down, and we can't establish a connection." |
| HTTP       | A specific protocol that determines how a clients and web servers communicate                                            | "The requests and responses between a web browser and web server must follow HTTP. They are HTTP requests and HTTP responses."                 |
| Request-Response Cycle | The cycle of communication between a client making a request and a server responding back.     | "We encounter the request-response cycle any time we log into a social media website or look up cat gifs on a search engine."                 |

## Client-Server Model

How can two computers send data to each other? One way that two machines can send data to each other is following the _client-server model_.

![Different clients (desktop, smartphone, smart tablet) sending a request to a server and receiving a response back. There are the following horizontal arrows: 1. Arrow from the client to the server labelled "request." 2. Arrow from the server to the client labelled "response."](../assets/intro-to-web-development/intro-to-web-dev_client-server.png)

The **client-server model** describes a setup between (at least) two different machines. This model states that for any given interaction between two computers, the communication is setup like this:

1. One computer is the **client** in the relationship
1. Another computer is the **server** in the relationship
1. The _client_ computer asks for a specific piece of data or action by sending a **request** to the _server_ computer
   - The request from the client has details like "what should the server do, and how?"
1. The _server_ computer receives the request from the client. The server computer tries to fulfill the request.
1. The _server_ eventually gives back a **response** answer and sends it back to the client
   - The response from the server has details like "what is the status of the server," and possibly the requested data
1. The _client_ receives this response

### Example 1: Meghan Requests All Weather Data

Meghan and Francis are roommates. Meghan owns a computer, and Francis owns a computer. Francis collects information about weather, and stores it on their computer. Follow this story, where Meghan needs to get the weather data from Francis's computer.

1. Meghan logs onto her computer, and makes a _request_ for all weather data.
1. Meghan's computer becomes a _client_ and sends this this request to Francis's computer.
1. Francis's computer is now a _server_. Francis's computer receives the request.
1. Because the request asks for all weather data, Francis's computer finds all the weather data.
1. Then, it creates a _response_, which includes the weather data.
1. Then, Francis's computer sends back this response to the client, Meghan's computer.
1. Meghan's computer receives the response from the server.
1. Meghan herself reads the weather data through her own computer.

### Example 2: Meghan Requests Next Week's Weather Data

Meghan can make a second request for very specific data:

1. Meghan needs the weather data for only the next seven days from Francis's computer. Meghan's computer, as a _client_, makes a _request_ for this data.
1. Francis's computer is the _server_. Francis's computer finds all of the data that the request asked for. Francis's computer creates a _response_ and that includes this data.
1. Then, Francis's computer sends back the response to Meghan's computer, the client.
1. Meghan's computer receives only the necessary data.

### Example 3: Meghan Requests Non-Existing Weather Data

Meghan can make even a third request that Francis's computer can't deal with:

1. Meghan wants to get the data about what the weather will be in the year 2050. Meghan's computer, the _client_, makes a request for this data.
1. Francis's computer, the _server_, receives this request. Francis's computer looks for the weather data from 2050, and concludes that it can't give back this data. Francis's computer creates a _response_, and it only includes the message, "I don't know!"
1. Meghan's computer receives the response "I don't know!" from Francis's computer.

### The Cycle Repeats as Necessary

This request-response cycle of communication repeats as necessary! A client can make one, two, dozen, or hundreds of requests to a server. They will always get back the same number of responses.

The client-server model allows client machines to take the lead and request for data or changes exactly when they want it.

One server can potentially listen for requests to come in from one, two, or hundreds of different clients.

### Client-Server Model Applied to Internet Users

The client-server model is the model that a lot of communication over the Internet uses. In this scenario, we often use the term _web server_ instead of server. A **web server** is a machine (computer) that _hosts_ and _serves_ a website or data specifically over the Internet.

When applied to many Internet interactions:

- The **client** is a user's _web browser_ (such as Mozilla Firefox, Google Chrome, or Safari)
- The **web server** is a server that hosts a website, such as Facebook.com or Instagram.com, and all of its server data and logic
- The client sends requests to the web server about getting data or changing data on the website
- The web server then sends responses to the client about the requested data or the requested change
- This cycle of interaction and communication between client and server makes up the request-response cycle

### !callout-info

## "Client" and "Server" Are Relative Terms

The terms "client" and "server" are always describing a relationship. One machine can be a client in one relationship, and then a server in another relationship. 

In fact, your own computer may act as _both_ the client and the server when we begin making our own requests! Look forward to diving into this in the future!

### !end-callout

## Metaphor: Why We Need a Protocol of Communication

The client-server model helps us understand how two computers can talk to each other over the Internet. But what are the details of this communication? What can a request and response look like, in technical terms?

Let's imagine a scenario to help us imagine those details.

Meghan and Francis are (still) roommates. They need to send each other messages. Sometimes, Meghan likes to tell Francis to have a good day, and other times Meghan needs tell Francis to clean up the sink. However, Meghan needs to consider the best way to get Francis to read the message.

Where should Meghan leave the note: on the fridge or on Francis's shoes? Should the note be on a white piece of paper, or a bright yellow sticky note? Should Meghan start the note with "To Francis," or "Dearest Francis"? Should Meghan sign the note? How long should Meghan wait for a response? And if Francis doesn't clean the sink after two weeks, what does Meghan do?

Does this even have to happen over notes? Could Meghan text or call Francis, or record a dance and show it to them?

Meghan and Francis need a _protocol_. A _protocol_ is a set of rules that define the format of data exchange.

When Meghan and Francis establish a protocol, they'll know the exact rules of communication between them, so Meghan can say what she needs to say and be heard, and so can Francis.

## The Protocol of the Web

**Hypertext Transfer Protocol, or HTTP**, is the protocol of communication over the web. It's the specific set of rules that websites follow in order to send and receive data.

HTTP is a protocol that always assumes the _client-server model_. Again, this means that the client is usually a user's _web browser_, and the server is a _web server_.

HTTP defines the exact technical ways that:

- A client opens a network connection to a web server
- A request looks and behaves
- A response looks and behaves

A request that follows HTTP rules is called an HTTP request. A response that follows HTTP rules is called an HTTP response.

## Example: Clients, Servers, and HTTP

Let's combine clients, servers, and HTTP into one story. Imagine that Meghan is using a fictional social media website named bookface.com.

1. When Meghan is on her computer, she visits bookface.com on her browser Mozilla Firefox.
1. When she clicks the button "Get All Posts," her browser acts as a _client_. The browser makes an HTTP request to the bookface.com servers. The HTTP request has details that say, "The client wants a list of all posts."
1. The bookface.com server receives this HTTP request that asks for all posts, and needs to create an HTTP response with this data. The server talks to all of the end-points, the databases, and services it needs to, and then constructs the appropriate HTTP response. Then, it sends the HTTP response back to the client.
1. Meghan's browser, the client, receives the response. Because the response contains the bookface post data, the browser says, "I need to read this response and display all posts."

An hour later, Meghan wants to update her status.

1. Meghan finds the form on bookface.com that lets her write a new post inside of her browser. She types, "Hello, World! I'm on bookface.com!"
1. Meghan presses the button that says "Post." At this point, the browser (aka the client), makes another HTTP request to the bookface.com servers. _This_ HTTP request has details that say, "The client wants to post 'Hello, World! I'm on bookface.com!'."
1. The bookface.com server receives this HTTP request. When the server looks at this request, it is programmed to create a new post with the correct text, user data, timestamps, and any other information. Then, the server is programmed to save this to the database.
1. Next, the server needs to give back an HTTP response. The server responds with the message, "The post was created successfully."
1. Meghan's browser, the client, receives this response. The browser sees the message, "The post was created successfully." Then, the web browser changes, and there is a new yellow box that says "Post created."

### !callout-info

## HTTPS

HTTPS, or Hypertext Transfer Protocol Secure, is an extension of HTTP. Many implementations of HTTP (particularly early ones) did not have the best security. Because HTTP deals with how data travels between computers, data can be breached during that process. HTTPS's technical details address a lot of security concerns. This curriculum will not go into any more details, except give the tip to always prefer HTTPS when possible.

### !end-callout

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: hfC1bo
* title: Intro to Clients, Servers, HTTP
##### !question

Read through this scenario. Then, match the terms below.

Connie watched a great dance video on a video hosting website, TubeYou.com. She presses the "like" button on this video.

From the scenario, identify the client, server, HTTP Request, and HTTP Response. Arrange the options below so that they match these terms in this order:

1. Client
1. HTTP Request
1. Server
1. HTTP Response
1. None of the Above

##### !end-question
##### !answer

1. Connie's web browser
1. HTTP message that requests to change the number of likes on this video, and the number of likes that Connie has given
1. TubeYou.com
1. HTTP message that says that a change in the number of likes on this video has successfully changed
1. Connie

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: dJql0c
* title: Intro to Clients, Servers, HTTP
##### !question

Read through this scenario. Then, match the terms below.

Steven wants to learn a new recipe for a breakfast meal. Steven goes onto manyrecipes.com and clicks on the recipe "Together Breakfast."

From the scenario, identify the client, server, HTTP Request, and HTTP Response. Arrange the options below so that they match these terms in this order:

1. Client
1. HTTP Request
1. Server
1. HTTP Response
1. None of the Above

##### !end-question
##### !answer

1. Steven's browser
1. HTTP message that asks for the data for the "Together Breakfast" recipe
1. manyrecipes.com
1. HTTP message that contains the data for the "Together Breakfast" recipe
1. HTTP message that contains the data for all recipes that Steven has viewed before

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: Yz8o5c
* title: Intro to Clients, Servers, HTTP
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
