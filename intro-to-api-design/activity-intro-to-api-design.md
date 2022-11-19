# Activity: Intro to API Design - Designing a Solar System API

## Goal

Our goal is to practice designing an API, focusing on the endpoints and potential responses that would fit under conventional RESTful design principles.

### !callout-info

## No Perfect Answers

This work is intentionally collaborative and creative. Please keep in mind that there are no perfect answers!

### !end-callout

## Preparation

First, get into small groups, ideally between 2-3 people.

Groups will need to collaborate on taking notes, filling tables, and making diagrams. Each group should get paper, whiteboards, and/or collaborative documents.

## Activity Instructions

The below describes a back-end API that needs to be built.

With your group:

1. Read the prompt out loud
1. Fill out the API Server Description Template (located below the prompts) in Google Docs, Google Slides, etc.

Groups should feel free to reformat the template however works best for them.

If there is ample time left, consider filling out the template with more example endpoints.

## Prompt

An internal app that allows astronauts to: 
- view information on all planets
- view information on one planet by its id 
- create a planet
- delete one planet its id
- update one planet by "planting a flag" on its surface by its id

- view information on all moons
- view information on one moon by its id 
- create a moon
- delete one moon its id
- update one moon by "planting a flag" on its surface by its id


## API Server Description Template

### Resources

- Planets
- Moons

### RESTful Endpoints

Describe the RESTful endpoints that are outlined in the prompt above for both planets and moons. Make decisions about what the request bodies should look like; there are no perfect answers!

| Description | HTTP Method | Path | Example JSON Request Body |
| ----------- | ----------- | ---- | ------------------------- |
| -           | -           | -    | -                         |

### Scenarios

Pick one resource.

Describe an HTTP request and HTTP response in detail for each scenario. Include request method, path, request body, response code, and response body. Make decisions about what the request and response bodies should look like; there are no perfect answers.

1. Requesting a resource that exists
1. Requesting a resource that does not exist
1. Requesting a list of resources
1. Deleting a resource that exists
1. Deleting a resource that does not exist
1. Creating a new resource

### Optional Diagram

Create a diagram to describe the request-response cycle for one endpoint. In this diagram, label:

- Client
- API Server
- A HTTP Request and its details
- A HTTP Response and its details

## How to Review

1. Compare your answers to the prompt with another small group. What was similar? What was different?
1. Did any creative ideas, decisions, thoughts come out of the prompt?
