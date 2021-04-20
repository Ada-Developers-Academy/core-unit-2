# Activity: Solar System API: Update, Delete

## Goal

Our coding skills improve with repetition.

Our goal is to practice creating a minimal Flask API in a pair or group setting.

Pairing with other programmers will help create stronger understanding of the material, and improved skill at working with others. Software teams thrive on collaboration, so working side-by-side with someone while coding is vital!

In this activity, we will build a Solar System API. This API will store information about different planets.

## Activity Instructions

### Setup

- Meet with your pair/group 👋
- Decide which members will take the driver and navigator roles. This should be a switch compared to the last activity.

The new driver may need to setup their database. Follow these steps:

1. Pull down all new Git commits
1. Activate the virtual environment
1. Install the dependencies
1. Create the database `solar_system_development`
1. Run `$ flask db upgrade`
1. Run `$ flask run` to confirm that the API is running as expected

### Driver/Navigator Roles

Driver and navigator roles should switch at least daily.

### Build

Create the following endpoints, with similar functionality presented in the Hello Books API:

As a client, I want to send a request...

1. ... with valid planet data to update one existing planet and get a success response, so that I know the API updated the planet data.
1. ... to delete one existing planet and get a success response, so that I know the API deleted the planet data.

### Part Two

After learning about 404s and more Flask queries, fulfill these features.

As a client, I want to send a request...

1. ... trying to get one non-existing planet and get a 404 response, so that I know the planet resource was not found.
1. ... trying to update one non-existing planet and get a 404 response, so that I know the planet resource was not found.
1. ... trying to delete one non-existing planet and get a 404 response, so that I know the planet resource was not found.

### Workflow

1. Create commits as you go
1. Push commits before the next activity
1. Finish this functionality with your pair/group before the next activity
