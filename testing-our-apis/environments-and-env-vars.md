# Environments and Env Vars

## Goals

Before we get to automated testing for our API, we'll need to learn about managing different environments.

Our goals are:

1. Define development and testing environments
1. Define environment variables

## Introduction

Aleesha dances on a dance team. Aleesha ends up dancing in a lot of different places:

- She works on, practices, and learns how to dance at home
- She rehearses with her teammates at a dance studio, where they use a shared practice room
- She dances on stage at the big performances, where multiple teams and an audience share the space

Although Aleesha is _dancing_ in all of them, depending on her goal, she uses a different _environment_.

## Environments

In software, the word "environment" is used in many different ways. The meaning of "environment" changes based on the context.

### !callout-secondary

## Realistic Expectations

No, really. "Environment" can mean many different things in many different situations. When in doubt, clarify with questions!

### !end-callout

In the context of local project development and testing, we will commonly use two environments according to the following pattern:

1. A _development environment_ dedicated to rapid development
1. A _testing environment_ dedicated to holding test data

| Name                    | Purpose                                                                                        | <div style="min-width:200px">Configuration Details</div>                          |
| ----------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------ |
| Development environment | Dedicated to rapid development. Things will change often as we work on the project | Has a dedicated development database where we can add sample data we will use during development. May enable a debugging mode with detailed logging and error reports. |
| Testing environment     | Dedicated to running test suites.                                      | Has a dedicated testing database containing specific data used to exercise our test suite.     |

As developers, we access both environments.

As we develop our Flask API, we will work in our development environment. As we make changes to our code, we will test it frequently using our test environment. 

These two environments could exist on different machines. In practice, it is usually more convenient to have a way to run under either environment from our own developer machine. This allows us to test our code as we are working on it, minimizing the chance of breaking previous functionality (called a _regression_).

Whenever we run our Flask API, we can designate which environment to use.

We will customize how we set certain configuration settings in our Flask API—such as the database it will access—based on the environment.

### Applying Environments: Dance Metaphor

When Aleesha dances, she picks an environment. Different environments are configured to use different resources.

Each environment has lighting. However, the lighting equipment doesn't, and shouldn't, be identical between the different environments:

- Her practice setup at home has some small LED lights
- The team's practice studio has adjustable ceiling lights
- The main performance stage has professional lighting equipment

Keeping these environments separate helps Aleesha and the other dancers focus on doing specific things in each environment.

We can imagine Aleesha's practice room at home is like a _development environment_.

### !callout-info

## More Environments Are Possible

For now, we will focus on development and test environments. But there are other environments that are also useful.

<br />

We can have _staging_ environments, which are more like the practice studio used by Aleesha's whole team. It's a place where all the work they've done individually comes together and can be seen working as a whole. Since this is a shared space involving multiple people, it's harder to make changes here.

<br />

We will also have a _production_ environment. This is the main performance stage, where the rest of the world sees our hard work. Once the performance starts, we _really_ don't want to make changes!

### !end-callout

### Applying Environments at a High-Level

As we introduce testing into our Flask API development, we want it to be easy for our tests to run using our test environment settings.

Having dedicated test settings is important so that our tests can run under the actual conditions we want to test. Making this change automatic will help us avoid running tests using the wrong data.

This will make our testing experience more consistent and reliable.

## Environment Variables

We will use environment variables to store information about values that change between environments.

Environment variables are strings that hold data outside of our application code. The environments we use provide ways to set these kinds of values.

Within our code, we can examine these variables, and either use them directly as data, or use them to make decisions about how our code should behave.

Some examples include:

- The location of a database (a connection string)
- Locations of other resources (such as other services that are part of a larger software system)
- Various configurations about how to run the app, such as debugging mode
- API keys

### Managing Environment Variables

Environment variables may hold a lot of values related to configuration.

Additionally, environment variables often hold _sensitive and secret data_.

In both of these cases, we will need to manage them. Managing environment variables lets us:

- Keep them organized together, rather than as constant variables throughout the project code
- Control their visibility

It's often the case that we _must_ keep environment variables secret to the public. Because our codebases are often online, it may be necessary to **not commit environment variables to source control**.

Different tools, packages, and practices will give us ways to manage and hide our environment variables.
