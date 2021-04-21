# Sequence Diagrams

## Goal

The goal of this lesson is to introduce a tool called _the sequence diagram_. The sequence diagram will help us see and take notes about how different parts of a system interact with each other.

Sequence diagrams are useful and commonly taught, but in practicality, they're not a skill that is used daily.

Formal sequence diagrams are usually very detailed and use a formal diagram syntax. This lesson will deprioritize those skills, and instead focus on sequence diagrams at a higher, more abstract level.

## Sequence Diagrams Show Communication Over Time

Sequence diagrams are a kind of diagram that depict one scenario or event. For one given scenario, these diagrams clarify what objects or actors are involved, and how these objects or actors communicate with each other over time.

## Example: Logging In

For example, let's consider this diagram that describes the process of logging into a web app.

![Sequence Diagram showing the process of logging in. There are four vertical columns: User, SocialMedia.com Login Screen, SocialMedia.com Back-end Service, and SocialMedia.com Database Containing Users. There are the following horizontal arrows: 1. Arrow from User to Login Screen labeled "clicks on Login Button." 2. Arrow from Login Screen to Back-end Service labeled "Asks to validate and login user." 3. Arrow from Back-end Service to Database labeled "Checks if user is valid adn queries user details." 4. Arrow from Database to Back-end service labeled "Gives back user details." 5. Arrow from Back-end Service to Login Screen labeled "Sends back message confirming the user is logged in." 7. Arrow from Login Screen to User labeled "Shows 'Successfully logged in' message." ](../assets/intro-to-web-dev_sequence-diagrams_sequence-1.png)

In this diagram, the objects and actors involved are:

1. An end-user
1. A login screen (the front-end layer)
1. A service dedicated to validating users (a back-end service part of the back-end layer)
1. The user database

<!-- Note: The ideal version of this sequence would rename "ValidateUser" service to a more generic name, and not use the CapitalCamel naming conventions, but generically label the processes -->

Follow the diagram above from top-to-bottom, focusing on the arrows. Take note of how the arrow is labeled, and which two processes it connects.

1. A user clicks on the "Login" button on the login screen
1. Clicking this button makes the login screen send a message named `validateUser(userId, password)` to the back-end service named `ValidateUser`. This indicates that the login screen is asking the `ValidateUser` service to validate the user.
1. The back-end service `ValidateUser` sends a message named `checkUserDetails` to the database. This indicates that the back-end service is asking for user details from the database.
1. The database sends a message back to the `ValidateUser` back-end service with the user details (labeled User Details).
1. The back-end service continues doing interesting logic around logging in the user; it needs to ask itself to validate the user now, with an arrow labeled `validateUser()` pointing to itself
1. The back-end service sends a result back to the Login Screen. This message, labeled `result`, will carry the results of the login process
1. The Login Screen finally gives a message back to the end-user named `showMessage`. The message the login screen shows to the user is probably about if the user has logged in or not.

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

![Sequence Diagram showing a client-server diagram using "AdaMaps.com". There are three vertical columns: User, Browser open to AdaMaps.com, and AdaMaps.com Web Servers. There are the following horizontal arrows: 1. Arrow from User to Browser labeled "enters in 'Seattle' and 'Atlanta' and asks for directions." 2. Arrow from Browser to Web Servers labeled "Requests directions between Seattle and Atlanta." 3. Arrow from Web Servers to Browser labeled "Responds with driving routes between Seattle and Atlanta." 4. Arrow from Browser to User labeled "Shows two driving routes between Seattle and Atlanta."](../assets/intro-to-web-dev_sequence-diagrams_client-server-sequence-2.png)

### Example: End-user, Front-end, Back-end, Database Diagram

![Sequence Diagram showing the process of accessing email. There are four vertical columns: User, MyEmail.com's website, MyEmail.com's Back-end Service, and MyEmail.com Database Containing Emails. There are the following horizontal arrows: 1. Arrow from User to website labeled "clicks the button 'Get All Emails'." 2. Arrow from website to Back-end Service labeled "Requests all emails for this user" 3. Arrow from Back-end Service to Database labeled "Queries all emails for this user." 4. Arrow from Database to Back-end service labeled "Gives back the data of all emails for this user." 5. Arrow from Back-end Service to website labeled "Sends back a list of all email data." 7. Arrow from website to User labeled "Shows a list of all email subject lines." ](../assets/intro-to-web-dev_sequence-diagrams_front-end-back-end-email.png)

### !callout-info

## Relationship between Front-end and Client, Back-end and Server

If you notice a relationship between front-end and client, and back-end and server, you're onto something! This pattern is not a coincidence. Although there are plenty of exceptions, it is fair to notice that front-end layers are often describing what's displayed on a web browser. A front-end layer may need to communicate with a back-end layer by sending a request following the client-server model. In this case, the front-end is the client, and the back-end is the server. More details on these messages are covered in detail about HTTP requests and responses.

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

1. User
1. Web-browser (client) sends a request to the server 
1. Server decides
1. Server sends a response to the client
1. Web-browser shows user

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

1. User
1. Front-end sends a message to the back-end
1. Back-end accesses the database and
1. Back-end sends a message back to the front-end
1. Front-end shows to the user

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
