# Sequence Diagrams

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=fb131104-892b-45df-902c-ad1700506951&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goal

The goal of this lesson is to introduce a tool called _the sequence diagram_. The sequence diagram will help us see and take notes about how different parts of a system interact with each other.

Sequence diagrams are useful and commonly taught, but in practicality, they're not a skill that is used daily.

### !callout-info
## Formal Styling isn't the Goal
Formal sequence diagrams are usually very detailed and use a formal diagram syntax. This lesson will deprioritize those skills, and instead focus on sequence diagrams at a higher, more abstract level.
### !end-callout

## Sequence Diagrams Show Communication Over Time

Sequence diagrams are a kind of diagram that depict one scenario or event. For one given scenario, these diagrams clarify what objects or actors are involved, and how these objects or actors communicate with each other over time.

## Example: Logging In

For example, let's consider this diagram that describes the process of logging into the hit social media website, SocialMedia.com.

![Sequence Diagram showing the process of logging in. There are four vertical columns: User, SocialMedia.com Login Screen, SocialMedia.com Back-end Service, and SocialMedia.com Database Containing Users. There are the following horizontal arrows: 1. Arrow from User to Login Screen labeled "clicks on Login Button." 2. Arrow from Login Screen to Back-end Service labeled "Asks to validate and login user." 3. Arrow from Back-end Service to Database labeled "Checks if user is valid adn queries user details." 4. Arrow from Database to Back-end service labeled "Gives back user details." 5. Arrow from Back-end Service to Login Screen labeled "Sends back message confirming the user is logged in." 7. Arrow from Login Screen to User labeled "Shows 'Successfully logged in' message." ](../assets/intro-to-web-dev_sequence-diagrams_sequence-1.png)

In this diagram, the objects and actors involved are:

1. A user
1. The login screen for SocialMedia.com (the front-end layer)
1. The back-end service for SocialMedia.com (the back-end layer)
1. The user database

Follow the diagram above from top-to-bottom, focusing on the arrows. Take note of how the arrow is labeled, and which two processes it connects.

1. A user clicks on the "Login" button on the login screen.
1. The front-end layer sends a message to the back-end layer, asking the back-end to validate and login the user.
1. The back-end layer checks the database. Then it queries the database for user details.
1. The database sends user details back to the back-end layer.
1. The back-end layer sends a confirmation message back to the front-end layer.
1. The front-end layer creates and displays a "Successfully Logged In" message to the user.

## Vertical Lines Are Objects, Actors, or Processes

In sequence diagrams, each vertical column represents an object, actor, or process.

Because this curriculum encourages using sequence diagrams in the informal, abstract ways, examples of different objects, actors, or processes we may see are:

1. User, front-end, back-end API, database
1. End-user, client, server

## Horizontal Lines Are Messages Passed Inbetween

In sequence diagrams, each horizontal line is usually an arrow that represents a message being sent. **Message** is a generic term to mean one discrete piece of communication. Messages are often an HTTP request or HTTP response. However, messages can also be a function call, or an abstract message.

Here are some example messages we may see:

1. An HTTP request from a client to a server that asks for all user data
1. An HTTP response from a server to a client that contains all user data
1. A user filling out a login form and pressing the login button
1. A process from a back-end to itself to describe needing to validate the user
1. A red error message to say logging in was unsuccessful, from the front-end layer to the end-user

## Using Sequence Diagrams

To read a sequence diagram, follow the arrows from top to bottom. The top-most arrow is the message that is sent first.

### Example: Client-Server Diagram

Imagine the popular maps and directions website, AdaMaps.com. Here is a sequence diagram focusing on the client-server interactions as a user requests directions between "Seattle" and "Atlanta."

![Sequence Diagram showing a client-server diagram using "AdaMaps.com". There are three vertical columns: User, Browser open to AdaMaps.com, and AdaMaps.com Web Servers. There are the following horizontal arrows: 1. Arrow from User to Browser labeled "enters in 'Seattle' and 'Atlanta' and asks for directions." 2. Arrow from Browser to Web Servers labeled "Requests directions between Seattle and Atlanta." 3. Arrow from Web Servers to Browser labeled "Responds with driving routes between Seattle and Atlanta." 4. Arrow from Browser to User labeled "Shows two driving routes between Seattle and Atlanta."](../assets/intro-to-web-dev_sequence-diagrams_client-server-sequence-2.png)

1. The user uses the form on AdaMaps.com and enters in "Seattle" and "Atlanta," and asks for directions
1. The client (browser) requests directions between Seattle and Atlanta from the AdaMaps.com server
1. The AdaMaps.com server responds with the two driving routes between Seattle and Atlanta that it found
1. The browser displays the two driving routes between Seattle and Atlanta and lists the directions

### Example: End-user, Front-end, Back-end, Database Diagram

Imagine the successful email service provider, MyEmail.com. A user wants to view all of their emails. This sequence diagram focuses on the interactions between user, front-end, back-end, and database layers.

![Sequence Diagram showing the process of accessing email. There are four vertical columns: User, MyEmail.com's website, MyEmail.com's Back-end Service, and MyEmail.com Database Containing Emails. There are the following horizontal arrows: 1. Arrow from User to website labeled "clicks the button 'Get All Emails'." 2. Arrow from website to Back-end Service labeled "Requests all emails for this user" 3. Arrow from Back-end Service to Database labeled "Queries all emails for this user." 4. Arrow from Database to Back-end service labeled "Gives back the data of all emails for this user." 5. Arrow from Back-end Service to website labeled "Sends back a list of all email data." 7. Arrow from website to User labeled "Shows a list of all email subject lines." ](../assets/intro-to-web-dev_sequence-diagrams_front-end-back-end-email.png)

### !callout-info

## Relationship between Front-end and Client, Back-end and Server

If you notice a relationship between front-end and client, and back-end and server, you're onto something! This pattern is not a coincidence.
<br/>
Although there are plenty of exceptions, we see a pattern that:

- The web browser is both the front-end layer and the client
- The front-end layer communicates with the back-end layer following the client-server model

### !end-callout

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: Coou7j
* title: Sequence Diagrams
##### !question

Given this diagram, order these following options in sequential order. The first message sent should be listed first, and the last message sent should be listed last.

![Sequence Diagram showing a client-server diagram using "AdaMaps.com". There are three vertical columns: User, Browser open to AdaMaps.com, and AdaMaps.com Web Servers. There are the following horizontal arrows: 1. Arrow from User to Browser labeled "enters in 'Center for Wooden Boats' and 'Seattle Art Museum' and asks specifically for public transportation options." 2. Arrow from Browser to Web Servers labeled "Requests public transportation directions between CWB and SAM." 3. Arrow from Web Servers to Browser labeled "Responds with four public transportation routes between CWB and SAM for the current time." 4. Arrow from Browser to User labeled "Shows four bus routes between CWB and SAM."](../assets/intro-to-web-dev_sequence-diagrams_client-server-sequence-1.png)

##### !end-question
##### !answer

1. User enters information and asks for directions
1. Browser open to AdaMaps.com requests public transportation directions between CWB and SAM
1. AdaMaps.com web servers respond with many different public transportation routes
1. Web browser shows some routes to the user

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: BTzpCD
* title: Sequence Diagrams
##### !question

Given this diagram, order these following options in sequential order. The first message sent should be listed first, and the last message sent should be listed last.

![Sequence Diagram showing the process of submitting a comment to a blog post. There are four vertical columns: User, AdaNails.com's Blog, AdaNails.com's Back-end Service, and AdaNails.com Database Containing Blog Posts and Comments. There are the following horizontal arrows: 1. Arrow from User to Blog labeled "types a comment in the comment box and clicks the button 'Submit Comment'." 2. Arrow from Blog to Back-end Service labeled "Sends the comment data and the blog post data." 3. Arrow from Back-end Service to Database labeled "tells the database to save this comment." 4. Arrow from Database to Back-end service labeled "Sends back a message saying the comment was saved successfully." 5. Arrow from Back-end Service to Blog labeled "Sends back the blog post and the comment data." 7. Arrow from Blog to User labeled "Shows 'comment posted' and the updated blog post." ](../assets/intro-to-web-dev_sequence-diagrams_back-end-front-end-blog-comment.png)

##### !end-question
##### !answer

1. User submits a comment
1. The front-end layer of AdaNails.com sends a message containing the comment data
1. The AdaNails.com back-end sends a message to save the comment
1. The database sends a message indicating that the comment was saved successfully
1. The back-end layer sends a message containing data about the blog and comment
1. The front-end layer sends a message showing visual feedback about the comment

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
