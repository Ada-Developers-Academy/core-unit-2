# Activity: Solar System API: Setup, Read

## Goal

Our coding skills improve with repetition.

Our goal is to practice creating a minimal Flask API in a pair or group setting.

Pairing with other programmers will help create stronger understanding of the material, and improved skill at working with others. Software teams thrive on collaboration, so working side-by-side with someone while coding is vital!

In this activity, we will build a Solar System API. This API will store information about different planets.

## Activity Instructions

### Setup

- Follow instructions from class on how to find pair/group assignments
- Meet with your pair/group 👋
- Choose one member to fork [the Solar System API repo](https://github.com/AdaGold/solar-system-api)
- Add all members to the forked repo as collaborators (through the repo settings)
- Decide which members will take the driver and navigator roles

### Driver/Navigator Roles

Driver and navigator roles should switch at least daily.

Decide who will be the driver today. The person who most desires to practice confidence today should drive first.

### Build

1. Clone the forked repo and `cd` into it
1. Recreate the following setup steps of [the Solar System API repo](https://github.com/AdaGold/solar-system-api):
   1. Create a virtual environment and activate it
   1. Install the dependencies
   1. Define a `Planet` class with the attributes `id`, `name`, and `description`, and one additional attribute
   1. Create a list of `Planet` instances

1. Create the following endpoints, with similar functionality presented in the Hello Books API:
   1. As a client, I want to send a request to get all existing planets, so that I can see a list of planets, with their `id`, `name`, `description`, and other data of the planet.
   1. As a client, I want to send a request to get one existing planet, so that I can see the `id`, `name`, `description`, and other data of the planet.

### Workflow

1. Create commits as you go
1. Push commits before the next activity
1. Finish this functionality with your pair before the next activity

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: f66175ea-4462-4500-ab28-c3a9af991a55
* title: Create, Read
##### !question

Check off all the endpoints you created and tested.

##### !end-question
##### !options

* Read all planets
* Read one planet

##### !end-options
##### !answer∂

* Read all planets
* Read one planet

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
