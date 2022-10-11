# What is Refactoring?

## Goals

Now that we have a set of endpoints and tests that ensure their functionality, we’re in a great place to examine our Hello Books code and refactor. Before we start making changes in the code, let’s set the stage as to how and why we refactor.

Our goals will be to:
1. Describe what refactoring is
1. Describe the benefits of refactoring

## Introduction
Let’s take a moment to take in the image below. This "pocket tool" is a Wenger 16999 Giant Swiss Army knife, an edition which contains every tool that was in previous Swiss Army knives. 

![A picture of a pocket tool with 87 fold out implements, that are all partially or fully extended.](../assets/api-7-refactoring/api-7-refactoring_what-is-refactoring_giant-pocket-tool.jpg)  
*Fig. Wenger 16999 Giant Swiss Army Knife*  [(source)](https://www.amazon.com/Wenger-16999-Swiss-Knife-Giant/dp/B001DZTJRQ/)

It _works_, but how easily can you find and use what you need? Is this a better tool because it has a lot of functions, or would we be better served with multiple smaller tool kits?

Often, we may find that our code seems closer to the image above than to a curated set of tools; holding onto extra variables or functions that duplicate tasks. This is normal, especially in early drafts of our solutions! But then, how do we combat the chaos? 

## Defining Refactoring

Refactoring isn't a single action – it's the process of examining our code with a critical eye for best practices, then making incremental changes to create code that’s easier to read and maintain over time. Ideally it’s part of a coding cycle where we write tests, write code to pass those tests, then make small improvements to our functions, using our tests to validate our changes.

Put another way, in refactoring we want to:
1. Review code critically
2. Plan opportunities for improvement 
3. Make small changes and confirm code behavior with tests

Let’s take a closer look at these steps for refactoring. 

### Review code critically

To find places for improvement in code we need to go beyond understanding what the code is doing. We need to be asking questions about _how_ the code is performing actions. 

We want to be reviewing our code with questions in mind like: 
- "Does this data need to be held by multiple variables?" 
- "Is there another type of loop that could fit better?" 
- "Are these two functions doing similar tasks?"
- "Do I notice any other code smells I should look at more closely?"

### !callout-secondary

## What are code smells?

“Code smells" is a common term for patterns that can indicate issues with code and often comes up when talking about refactoring. There are many lists of common code smells out there, and they can be a handy checklist when refactoring code. If you’re interested in learning more, we encourage you to follow your curiosity!

### !end-callout

We may find we’re really happy with how the code is laid out, but if not we can move forward in the refactoring process.

### Plan opportunities for improvement 

Once we've identified code we want to refactor, we should plan our approach to reduce the chance of breaking working code. We want look at:
- what is dependent on our changing code to be aware of what other functionality we could affect
- our test coverage to ensure we have tests around all scenarios that could be affected (writing new tests as needed)
- what our approach could look like, writing out pseudocode to help us uncover anything we might have missed in our previous steps (such as if there are any new edge cases we need to consider). 

### Make changes and confirm with tests

At this point we should start a cycle of making a single small improvement, then running our test suite to ensure our functionality hasn’t changed. If we make our changes and our tests are failing, we should practice our debugging skills, making use of the debugger and tests to help pinpoint what changed.

As we go, we may find that we need to add more tests, or pivot our approach slightly. All of this is normal, and as long as we have a strong test suite, we can continue to iterate and have peace of mind that our code is still behaving as expected. 

### !callout-info

## Tests give us the security to refactor with confidence!

Without tests, we could still make changes, but we couldn’t use automation to help us check if there were side effects. We would have to take the time to manually test each scenario every time we made a change if we wanted to ensure our code still behaved as expected.

### !end-callout

We’ll dive into applying these refactoring strategies to Hello Books soon, but first let’s roll back to _why_ we want to do this work.

## The Benefits of Refactoring!

So far we’ve made claims that refactoring makes code “easier to read” and “easier to maintain”, but what does that actually boil down to? Below we’ve listed some direct effects of refactoring, along with how they benefit us as coders in our day to day.  

Shorter functions:
- Less code to read! Less time to read and understand what a function is doing

Enforcing single-responsibility for our functions:
- Less branching logic in a function: makes it easier to reason about what a function does, and what the output will be for any given input
- Easier to test the function: if the function does one thing, there are less edge cases for that particular function that will need to be thought through and tested.
- The code is more reusable: if a function does multiple things, and only one of the effects is needed in another part of the software, we can’t reuse the existing code as-is.

Reducing duplicated code:
- Less places to make changes if code needs to updated
- Less code = less places where we could have bugs
- It’s easier to find the code you are looking for if there is only one function that does that task.

## Summary

Refactoring is an opportunity for us to revisit our code so that it is easier for ourselves and others to work with in the long run. Rather than a single task, refactoring is a series of steps we perform when our code is working and we have tests to confirm its behavior. By analyzing our code, planning where we can improve, then making small code changes between test runs until tests are passing again, we can refactor our code and be confident that our changes did not break something.

We may not see all the benefits of refactoring when working alone or on smaller projects, but building these practices into our workflows yields stronger code that’s both easier to share and easier for other folks to understand.

## Check for Understanding

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 43d9c16e
* title: Refactoring
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
