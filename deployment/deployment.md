# Deployment

## Learning Goals

- Define software deployment

## Introduction

Our applications and web APIs are developed locally and available locally—they are only accessible while our local machines are running a server, and only through `localhost`.

If our personal machines are turned off, then our server isn't running, and our API isn't accessible.

How do we make our web apps available to the rest of the world?

## Vocabulary and Synonyms

| Vocab      | Definition                                          | Synonyms            | How to Use in a Sentence                                                                                                                                         |
| ---------- | --------------------------------------------------- | ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Deployment | The process of making software available to be used | Software deployment | "After I deploy this software, I can send my deployed app to my friends so they can use it!" "I can deploy software updates so my deployed app grows over time." |

## What is Deployment?

Software deployment is the process of making some software or application available for use, often to an end-user.

When we _deploy_ our apps, we will set up machines and web servers dedicated to running our web app. Then, users can access our apps regardless of what our own personal machines are doing!

We deploy apps using skills and tools in the realm of:

- DevOps (Software Development and IT Operations)
- Systems administration
- Database administration

These areas introduce the following kinds of questions:

- What kind of machine is running our web servers?
- What is installed on these machines? How do they manage dependencies?
- How do we push new code to these servers?
- How do we keep these servers available?
- How do we maintain these servers, when errors arise?

In this curriculum, we will choose specific deployment tools and services that answer these questions for us, so that we can focus on improving our web development skills.

### Example Platforms

The following are all examples of _Platforms as a Service_. The responsibility of these services is to create, manage, and maintain environments that run our deployed apps.

- AWS Elastic Beanstalk
- Heroku
- Windows Azure
- Google App Engine

### !callout-info

## Deploy to the Production Environment

The _production_ environment refers to the environment that runs our deployed, released application. This is where all our hard work gets made available to actual users!

### !end-callout

## When Do We Deploy?

We deploy and re-deploy apps whenever we want to release a new version of our application.

On large software products, we may deploy according to a release schedule.

### !callout-info

## Continuous Deployment

_Continuous deployment_ is a software engineering practice that values and encourages deploying frequently, favoring frequent, small updates over large, cumbersome ones. This practice gives us the phrase, "Deploy early and often!"

### !end-callout

## Our New Dev Workflow

Let's say we have an existing web application that is already deployed and already being used by people all over the world. Assuming we want to deploy early and often, our development workflow may look like this:

1. Begin a new feature
1. Do work in our local environment, using best practices for git and testing
1. Finish the new feature
1. Deploy the updated code with this new feature to the production environment

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: CRddW7
* title: Deployment
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
