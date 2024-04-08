# Intro to Flask

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=ac3c84a5-41fe-44ea-832c-ad10004eb723&autoplay=false&offerviewer=true&showtitle=true&showbrand=false&start=0&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Goals

Our goal for this lesson is to learn about Flask from a high-level perspective, in preparation for our new Flask development skills.

## Vocabulary and Synonyms

| Vocab                     | Definition                                                            | Synonyms                 | How to Use in a Sentence                                                                                                                                                  |
| ------------------------- | --------------------------------------------------------------------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Web Application Framework | A software framework designed to support web application development. | framework, web framework | "There are many popular web frameworks, such as Ruby on Rails, Django, and AngularJS," "Ruby on Rails, Django, and AngularJS all differ in approaches to web development" |

## Web Application Framework

Web application frameworks are _software frameworks_ that provide a pattern for how to build a web application.

Web application development deals with a number of questions. At a technical level:

- how does an API server run?
- how does the API server receive and send requests?
- how are endpoints defined?
- how do we deal with web sessions or caching?
- how do we keep an API secure?

The good news is that the framework deals with these problems so that we don't need to!

Frameworks may be opinionated, and may guide developers to follow certain design or syntax patterns. We'll often see web frameworks provide patterns to:

- define endpoints
- read HTTP requests
- define HTTP responses
- specify where to put all of this code

The web application framework we will be learning about is Flask. Much of our learning about Flask will be us learning how Flask needs us to write code to enable us to do the above things.

## Flask

[Flask](https://palletsprojects.com/p/flask/) is a popular web application framework. The application code is written in Python.

We will use Flask to build back-end APIs.

### Documentation

It will be valuable to take a moment to get familiar with the [Flask documentation](https://flask.palletsprojects.com/en/3.0.x/). In the documentation, we should be able to find:

- Directions for installation
- A quickstart guide, which contains details about:
  - Debug mode
  - Routing
  - Accessing Request Data
  - About Responses
  - Logging
- A tutorial
- Information about testing Flask apps
- The [detailed API reference](https://flask.palletsprojects.com/en/3.0.x/#api-reference), which contains documentation on objects and functions defined by Flask

### !callout-info

## This Curriculum Prioritizes JSON Responses Over HTML

Flask is able to render HTML templates, and many Flask tutorials will revolve around that. This curriculum will prioritize using Flask to return JSON instead of HTML. However, follow your curiosity!

### !end-callout

## What to Expect

Flask development isn't very different from writing any other Python code. However, since we're creating the back-end to a full web application. We should expect to:

- build APIs
- connect to databases
- manage dependencies
- research more Flask patterns

### Building APIs

When building APIs, we should expect to practice all the Python syntax we've learned so far, and continue to learn more as needed! We'll be practicing all of our API vocabulary, and writing code to match it.

### Connecting to Databases

We want our APIs to work with stored data, so we'll bring our database skills into our development process. Our API will need configuration information to find our databases and our tables. We'll also adopt some new patterns to help us model data.

### Managing Dependencies

Although Flask is the name of the framework, we'll be introducing literally a dozen more packages. These packages each provide solutions to specific API issues. For example, one package we'll use will help us define endpoints with clean, concise syntax.

Because there will be more dependencies, we'll need to manage them. Expect:

- Installing packages
- Looking up package documentation and examples
- Using virtual environments

### Researching More Flask Patterns

This curriculum will teach an introductory level of Flask.

There are many alternative approaches and patterns for problem-solving with Flask to explore on our own. Independently researching alternative Flask patterns will:

- expose us to more problem-solving strategies
- help us read more code
- connect us to the Flask and greater web developer communities, which are always changing and shifting
