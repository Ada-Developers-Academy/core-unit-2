# Environments and Env Vars

## Goals

Before we get to automated testing for our API, we'll need to learn about managing different environments.

Our goal is to:

1. Define what are development and testing environments
1. Define environment variables and manage them

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

No, really. "Environment" is a common concept among many different situations. When in doubt, clarify with questions!

### !end-callout

In the context of local project development and testing, there are two common patterns:

1. A _development environment_ dedicated for rapid development
1. A _testing environment_ dedicated for holding test data

| Name                    | Purpose                                                                                        | Differences                          |
| ----------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------ |
| Development environment | Dedicated to rapid development. Things will change often as the developer works on the project | Has a dedicated development database |
| Testing environment     | Dedicated to setting up the data for running test suites.                                      | Has a dedicated testing database     |

As developers, we'll have access to both environments. Whenever we run our Flask API, we can designate it to use a specific environment.

The environment that our Flask API uses will determine which database it accesses while it runs.

### Applying Environments: Dance Metaphor

When Aleesha dances, she picks an environment. Different environments are configured to use different resources.

Each environment has lighting. However, the lighting equipment doesn't, and shouldn't, be identical between the different environments:

- Her practice setup at home has some small LED lights
- The team's practice studio has adjustable ceiling lights
- The main performance stage has professional lighting equipment

Keeping these environments separate can help her have better expectations for what's available.

We can imagine Aleesha's practice room at home is like a _development environment_.

### Applying Environments at a High-Level

As we introduce testing into our Flask API development, we will want to setup a dedicated testing environment. This will make our testing experience more consistent and reliable.

## Environment Variables

Environment variables are strings that hold data outside of our application code. These variables are set at the environment level, and affect how an app is run.

Some examples include:

- Where the location of a database is
- Where the location of other resources are (such as other services part of a larger software system)
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
