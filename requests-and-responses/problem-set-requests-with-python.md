# Problem Set: Requests With Python

## Directions

Read the problem prompt, which will ask you to write Python code to find certain answers.

Once you found the answers, input them into the answers prompt below.

## Preparation: LocationIQ Forward Geocoding API

Use the [LocationIQ's Forward Geocoding API](https://locationiq.com/geocoding). Before starting this problem prompt:

1. Obtain an API key for LocationIQ's Forward Geocoding API
1. Familiarize yourself with the LocationIQ API Documentation
1. Familiarize yourself with the `requests` package
1. Open Postman for manual testing

![Screenshot of LocationIQ's feature on the Geocoding API](../assets/api-keys/api-keys_location-iq-geocoding.png)

## Problem Prompt

Create a Python program that finds the latitude and longitude coordinates for the [seven wonders of the New7Wonders of the World](https://en.wikipedia.org/wiki/New7Wonders_of_the_World), which are the following:

| Wonder              |
| ------------------- |
| Great Wall of China |
| Petra               |
| Colosseum           |
| Chichen Itza        |
| Machu Picchu        |
| Taj Mahal           |
| Christ the Redeemer |

### Extra Challenges

See if you can accomplish these extra challenges:

1. Organize your code into functions and helper functions
1. Use a `for` loop
1. Create this data structure to hold your answers. If your code is in a function, return this structure.

```python
{
    "Great Wall of China": {
        "latitude": "...",
        "longitude": "..."
    },
    "Petra": {
        "latitude": "...",
        "longitude": "..."
    },
    "Colosseum": {
        "latitude": "...",
        "longitude": "..."
    },
    "Chichen Itza": {
        "latitude": "...",
        "longitude": "..."
    },
    "Machu Picchu": {
        "latitude": "...",
        "longitude": "..."
    },
    "Taj Mahal": {
        "latitude": "...",
        "longitude": "..."
    },
    "Christ the Redeemer": {
        "latitude": "...",
        "longitude": "..."
    }
}
```

### !callout-warning

## Hint: Working with Rate Limits

Rapidly making several HTTP requests to the same endpoint may exceed our API rate limit. There are many ways to work with the rate limit. As a suggestion, one strategy is to consider the following:

1. How can we make requests more slowly?
1. Do research with the `time` package's `sleep` method. We recommend using `time.sleep(.25)` to begin your experiment

### !end-callout

## Answers

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: qSpZof
* title: Requests with Python
##### !question
What is the latitude of the first result of "Great Wall of China"?
##### !end-question
##### !answer
40.3587621
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: akyxCs
* title: Requests with Python
##### !question
What is the longitude of the first result of "Great Wall of China"?
##### !end-question
##### !answer
116.0136394
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 3 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: 1FFHRE
* title: Requests with Python
##### !question
What is the latitude of the first result of "Petra"?
##### !end-question
##### !answer
30.3273975
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 4 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: ljtnY8
* title: Requests with Python
##### !question
What is the longitude of the first result of "Petra"?
##### !end-question
##### !answer
35.4464006
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 5 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: tuzQ5B
* title: Requests with Python
##### !question
What is the latitude of the first result of "Colosseum"?
##### !end-question
##### !answer
41.8902614
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 6 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: VlMgQC
* title: Requests with Python
##### !question
What is the longitude of the first result of "Colosseum"?
##### !end-question
##### !answer
12.4930871035955
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 7 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: 15zxVD
* title: Requests with Python
##### !question
What is the latitude of the first result of "Chichen Itza"?
##### !end-question
##### !answer
20.68285195
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 8 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: eYXyJ0
* title: Requests with Python
##### !question
What is the longitude of the first result of "Chichen Itza"?
##### !end-question
##### !answer
-88.5687196355205
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 9 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: oUyrJr
* title: Requests with Python
##### !question
What is the latitude of the first result of "Machu Picchu"?
##### !end-question
##### !answer
-13.16441865
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 10 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: 8NjqBn
* title: Requests with Python
##### !question
What is the longitude of the first result of "Machu Picchu"?
##### !end-question
##### !answer
-72.5447639743184
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 11 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: wLOolT
* title: Requests with Python
##### !question
What is the latitude of the first result of "Taj Mahal"?
##### !end-question
##### !answer
27.1750123
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 12 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: Q7gxMD
* title: Requests with Python
##### !question
What is the longitude of the first result of "Taj Mahal"?
##### !end-question
##### !answer
78.0420968366132
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 13 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: DKHJBl
* title: Requests with Python
##### !question
What is the latitude of the first result of "Christ the Redeemer"?
##### !end-question
##### !answer
-22.9519173
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 14 -->
<!-- prettier-ignore-start -->
### !challenge
* type: short-answer
* id: I6BeBO
* title: Requests with Python
##### !question
What is the longitude of the first result of "Christ the Redeemer"?
##### !end-question
##### !answer
-43.210495
##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
