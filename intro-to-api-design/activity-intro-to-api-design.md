# Activity: Intro to API Design

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

Each prompt below describes a fictional back-end API that needs to be built.

With your group, for each prompt:

1. Read the prompt out loud
1. Fill out the API Server Description Template (located below the prompts)

Groups should feel free to reformat the template however works best for them.

If there is ample time left, consider filling out the template with more example endpoints.

## Prompts

1. A library app that allows users to own and organize a library of books by author and genre.
1. With your small group, pick one of the following web app descriptions and fill in the blank together:
   - A space program that specializes in storing information about planets, solar systems, and `blank`
   - A grocery store that specializes in delivering `blank`
   - A reservation system that reserves `blank` for guests/customers
   - A special hobby forum that allows users to have a library of `blank` and rank them

### !callout-info

## Explore and Discover

Especially for prompt #2, allow your group to explore, discover, and converse while converging on answers.

### !end-callout

## API Server Description Template

### Resources

- Resource A
- Resource B

### RESTful Endpoints

Pick one resource.

Describe the RESTful endpoints that are the CRUD operations of that one resource. Make decisions about what the request bodies should look like; there are no perfect answers.

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

1. Compare your answers to Prompt #1 with another small group. What was similar? What was different?
1. Compare your answers to Prompt #2 with another small group. What was similar? What was different?
1. Did any creative ideas, decisions, thoughts come out of prompt #2?
