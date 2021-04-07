# Web Applications and Layers

## Learning Goals

- Compare the difference between front-end, back-end, and full-stack programming
- Define API

## Introduction

Take thirty seconds to close your eyes, and picture logging into a social media site. What actions did you take? What did you need to click or tap? What kind of form shows up? When does the page change? Why did it change, and how did you know you were logged in?

Keep picturing this social media site, and imagine browsing your profile and your friend's profile. What pieces of data is shown for every user? What pages show your username? What pages show your email address? What pages show your profile picture? What data must change when you add a friend? What data must change when your friend changes their name?

Let's ponder one more time. What _is_ a web application? What are all of the pieces needed in order make a web app work? These questions help us frame how our own code fits into all of this.

## Vocabulary and Synonyms

| Vocab     | Definition                                                                                     | Synonyms                                    | How to Use in a Sentence                                                                                                                                                   |
| --------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Web App   | Application software that runs on a web server                                                 | Dynamic site, web site, site, app           | "I need to log onto that web app because it has all of my health insurance information," "My banking web app is slow, but I can pay my bills there"                        |
| End-user  | the person who actually uses a particular product                                              | User, client, customer                                        | "This app is designed for an end-user who needs to organize their calendar," "This app needs to ultimately serve the end-user, so we should consider the end-user's needs" |
| Front-end | a part of the system concerned with dealing with user interaction                              | "frontend," "front end," presentation layer | "The website on my browser Yelp.com is the front-end for Yelp, because it's what the end-user sees and interacts with."
| Back-end  | a part of the system concerned with running application logic and storing application data     | "backend," "back end," data access layer    | "The servers that determine what data gets back to the user is the back-end for Yelp."
| Web APIs  | Software built to translate messages between a user (often another program) and a _web server_ | API                                         | "If we use the Yelp API, we're able to query data that the Yelp databases store," "Yelp has an API that allows users to search for restaurants in a specific city"         |

## Web Applications

Web applications (or web apps) are application software that run over the Internet. When using a web app, a user interacts with the web app as _the client_. The web app connects to _a web server_. The web server returns responses back to the user (client).

Categories of web apps include:

- Social media
- Online stores
- Productivity tools, like Google Calendar
- Email providers
- Video and/or audio streaming platforms

They typically run on web browsers, such as Mozilla Firefox, Google Chrome, and Safari. Web apps are usually considered different from desktop software and mobile apps because of the platform, although these kinds of apps may also connect to a web server.

### !callout-secondary

## Mobile Web Apps

Native mobile apps (or apps built for smartphones that are usually distributed on app stores) are not web apps. However, mobile devices also have web browsers! Web apps that are built for smartphone browsers are called mobile web apps.

### !end-callout

### Web Applications Have Layers

As programmers, we value designing systems that follow the principle of _separation of concerns_. We love it when a piece of a system is reponsible for one thing, and it relies on other pieces of the system to be responsible for a different thing.

Web applications often follow the principle of separation of concerns by specifying different layers.

As an oversimplification, web apps commonly have these two layers:

1. Back-end layer, or a part of the system concerned with running application logic (such as calculating or filtering data) and storing application data (such as storing all user data, usually into a database).
1. Front-end layer, or a part of the system concerned with dealing with user interaction (such as what the user sees, doesn't see, and what they can click on or do).

## Back-end

The back-end layer (commonly referred to as "back-end") is responsible for having access to data relevant to a web application, and then sending the correct to the front-end when needed.

This often means that the back-end can connect to a _database_. In this case, the back-end can usually insert data into the database and the appropriate tables, read data, update data, and delete data. The back-end usually also contains the business logic and additional rules to work with the application data.

Here's a list of responsibilities that a back-end could have:

- Creates a new user and saves it to the user table in the database
- When a user purchases a product, find the product data in the product table, calculate the price, and create a new bill for the user that is stored on their profile
- When a user reviews a product, create a new review and store the review data in the reviews table, and then update the product data to include the new review
- When a user browses through products, the algorithm for what products to feature, and in what order

### Examples

Let's consider different web applications and what their back-end layers could look like:

| Web app description | Back-end layer will...                                                                                                                                                                                                                                                     |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Social media site   | fetch and modify the data stored about users, photos, posts, events, groups, friends, and more. Contains the logic and algorithms for what posts to show.                                                                                                                  |
| Online store        | fetch and modify the data about products (product description, stock, images, categories), reviews, users and past order history, and more. Contains the logic for how to bill users, calculate shipping and taxes appropriately, and algorithms for recommended products. |
| Calendar app        | fetch and modify the data about users and their events. Contains the logic for converting time zones, how the duration of a single event, and generating video call links.                                                                                                 |

## APIs

Application programming interfaces, or APIs, are services (software) that help translate messages that go from Software A to Software B. This is an abstract definition, so let's talk more specifically about web APIs.

Web APIs are APIs built to translate messages between a user (usually another program) and a _web server_ specifically.

### Examples

Let's consider different web APIs. These web APIs are part of a web app's back-end layer. Users can send messages to a web server through these APIs.

| Web API                                                                | What the web API enables users to do                                                                                                                                         |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Yelp's Fusion API](https://www.yelp.com/fusion)                       | Within Yelp's databases, search for businesses by keyword, location, category, price level; get reviews for a specific business; get autocomplete suggestions for a business |
| [The Movie Database API](https://www.themoviedb.org/documentation/api) | Within TMDB's databases, get data or images about movies, TV shows, or actors                                                                                                |
| [Twitter API](https://developer.twitter.com/en/docs/twitter-api)       | Within Twitter's databases, get tweets from a specific user, look at analytics for a search topic or keyword, or measure tweet performance                                     |

## Front-end

The front-end layer (commonly referred to as "front-end") for a web app is responsible for containing the logic that works with user interaction.

The front-end layer determines:

- What a user sees or doesn't see in the web browser
- What a user can or cannot do in the web browser
- What happens after each user interaction

Here's a list of responsibilities that a front-end could have:

- Where is the "sign up" button, and what information does the user need to fill and send?
- After a user purchases a product, what do they see? Do they see a "success" message or an "error" message? Do they go back to their home, or back to shopping?
- When a user reviews a product, do they see five stars to click? Or do they see a dropdown menu? Or do they type their review completely?
- When a user is browsing products, do products show up in a row, or a grid? How many show up at one time?

### Examples

Let's consider different web applications and what their front-end layer could look like:

| Web app description | Front-end layer will...                                                                                                                                                                                       |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Social media site   | arranges how data about users, photos, posts, events, and groups are shown on a social media timeline page. Determines what the user sees and does when they make social media posts.                         |
| Online store        | arranges how data about a product, its description, images, and reviews look on a web browser. Determines how coupons and sales, products out of stock, and other special messages get displayed to the user. |
| Calendar app        | arranges how the calendar looks like between viewing one day, one week, or one month at a time.                                                                                                               |

## Back-end and Front-end Interaction

These two layers are meant to interact with each other. Here is a simplified description of how the end-user, front-end, back-end, and database all interact with each other

1. An end-user (the person who actually uses a particular product) interacts with the front-end of a web app through their web browser
1. The front-end communicates with a web server, usually by sending a message to a back-end web API
1. The back-end web API communicates with a database for any stored data

### Examples

Here's an abbreviated summary of how the different actors in one web app may communicate with each other.

| Web app           | End-user                                                  | Front-end                                         | Back-end                                                 | Database                                               |
| ----------------- | --------------------------------------------------------- | ------------------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------ |
| Social media site | College student who wants to see pictures of best friends | Arranges the view of all pictures of best friends | Fetches and organizes the data of all friend's pictures  | Holds all of the picture data that friends have posted |
| Online store      | Online shopper looking for bath robes                     | Arranges the view of all bath robe products       | Fetches and organizes the data of all bath robe products | Holds all of the data of all bath robe products        |

## Full-stack

A back-end developer is a web developer who specializes in programming the back-end layer. A front-end developer specializes in coding front-ends. A full-stack developer is a developer who has expertise in both back-end and front-end development. Their skills range the "full stack" of technology that makes up a web app.

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: o6D5Qq
* title: Web Applications and Layers
##### !question

Imagine an audio streaming web app.

Arrange the options below so that they match these terms in this order:

1. End-user
1. Front-end layer
1. Back-end layer
1. Database

##### !end-question
##### !answer

1. A casual music listener who wants to discover new music
1. The part of a web-app that lays out where the play and pause button are, and the button that says to start a "new recommended music" radio station
1. The part of a web-app that determines what tracks and artists should be on the "new recommended music" radio station, and fetches all of the data of these tracks
1. The part of a web-app that stores all of the audio data

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: XE1Gi7
* title: Web Applications and Layers
##### !question

Imagine a video sharing web app.

Arrange the options below so that they match these terms in this order:

1. End-user
1. Front-end layer
1. Back-end layer
1. Database

##### !end-question
##### !answer

1. An aspiring video editor who wants to upload their travel videos
1. The part of a web-app that says to upload a video, a user must drag and drop the video file into the page and then press "Upload"
1. The part of a web-app that checks if the video meets all of the requirements and determines if uploading the video is successful or unsuccessful
1. The part of a web-app that stores all of the video data

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
