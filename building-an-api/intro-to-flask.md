# Intro to Flask

## Goals

Our goal for this lesson is to learn about Flask on a high-level, in preparation for our new Flask development skills.

## Vocabulary and Synonyms

| Vocab                     | Definition                                                            | Synonyms                 | How to Use in a Sentence                                                                                                                                                  |
| ------------------------- | --------------------------------------------------------------------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Web Application Framework | A software framework designed to support web application development. | framework, web framework | "There are many popular web frameworks, such as Ruby on Rails, Django, and AngularJS," "Ruby on Rails, Django, and AngularJS all differ in approaches to web development" |

## Web Application Framework

Web application frameworks are _software frameworks_ that provide a pattern for how to build a web application.

Web application development deals with these problems frequently: On the technical level,

- how does an API server run?
- how does the API server receive and send requests?
- how are endpoints defined?
- how do we deal with web sessions or caching?
- how do we keep an API secure?

Frameworks may be opinionated, and may guide developers to follow certain design or syntax patterns. We'll often see web frameworks provide patterns to:

- defining endpoints
- reading HTTP requests
- defining HTTP responses
- where to put all of this code

## Flask

[Flask](https://palletsprojects.com/p/flask/) is a popular web application framework. The application code is written in Python.

We will use Flask to build back-end APIs.

### Documentation

It will be valuable to briefly get familiar with the [Flask documentation](https://flask.palletsprojects.com/en/1.1.x/). In the documentation, we should be able to find:

- Directions for installation
- A quickstart guide, which contains details about:
  - Debug mode
  - Routing
  - Accessing Request Data
  - About Responses
  - Logging
- A tutorial
- Information about testing Flask apps
- The [detailed API reference](https://flask.palletsprojects.com/en/1.1.x/#api-reference), which contains documentation on objects and functions defined by Flask

_Note: Written in March 2021_

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

Expect to learn and practice all the Python syntax to build APIs! We'll be practicing all of our API vocabulary, and writing code to match it.

### Connecting to Databases

We want our APIs to work with stored data, so we'll bring our database skills into our development. Our API will need special configuration to find our databases and our tables. We'll be adopting some more patterns to help us model data.

### Managing Dependencies

Although Flask is the name of the framework, we'll be introducing literally a dozen more packages. These packages all present specific solutions to our API problems. For example, one package we'll use will help us define endpoints with clean, concise syntax.

Because there will be more dependencies, we'll need to manage them. Expect:

- Installing packages
- Looking up package documentation and examples
- Using virtual environments

### Researching More Flask Patterns

This curriculum will teach an introductory level of Flask.

There will be a desire for alternative approaches to problem-solving in Flask. Researching alternative Flask patterns will:

- expose us to more problem-solving strategies
- help us read more code
- connect us to the current Flask community and web dev community, which are always changing and shifting
