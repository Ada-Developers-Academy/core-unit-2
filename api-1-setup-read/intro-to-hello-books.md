# Intro to Hello Books API

The Lessons in the Building an API Learn Topics will walk-through building a Flask API with the companion repo [Hello Books API](https://github.com/AdaGold/hello-books-api).

<iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=3baea592-08f8-48eb-beb4-ae6a012e05e8&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe>

## Branches

The [Hello Books API repo](https://github.com/AdaGold/hello-books-api) has a git branch with the new code introduced in each lesson. At the top of a lesson that adds to the Hello Books API Flask application code, the starting branch and ending branch will be indicated in a table. For example, the next lesson, **Flask Setup**, starts with the *default* branch `01a-intro-to-flask` and ends with the branch `01b-flask-setup`. 

| Starting Branch | Ending Branch|
|--|--|
|`01a-intro-to-flask` |`01b-flask-setup`|

## Workflow Recommendation

As you work through the Building an API Learn Topics and learn to building an API with Flask, you will find a workflow that works for you. Here is one workflow recommendations:

1. Clone [Hello Books API](https://github.com/AdaGold/hello-books-api) directly (without forking).
1. Rename this project folder to `ada-hello-books-api` to make it clear it's the Ada maintained version.
1. When beginning a lesson, checkout the corresponding starting branch for that lesson.
1. Code along with the lesson **as much or as little as best supports your learning**. You may find it's best to watch all the videos without coding along. Alternatively, you may prefer to implement every new feature along with the reading and videos.
1. After finishing a lesson, you will not be able to switch branches until Git knows what to do with your existing changes. You should either:
   - `add` and `commit` your changes, or
   - use `git stash -u` to set aside any changes you've made
   
### !callout-info

## When to Commit, When to Stash

Committing your changes will add them to the local commit history. If you switch to a different branch, and then return to the branch in which you committed, you will see your changes as you left them. If you want to continue to see your changes in the branch, you should add and commit your changes.

<br>

Stashing your changes will store them in a temporary commit area, and the contents of the branch will revert back to what they looked like before you started working. If you switch to a different branch, and then return to the branch in which you were working, it will appear as though you did no work in that branch. If you want the branch to return to its starting point, you should stash your changes.

### !end-callout   


<!-- available callout types: info, success, warning, danger, secondary, star  -->
### !callout-info

## Video Lessons

You may notice small inconsistencies between the video lessons and the readings due to revisions to the `hello-books-api` and readings since the videos were recorded. 

The branch the instructor checks out in the video lesson may be different than the branch indicated in the reading. Follow the instructions in the reading. The code modeled in the video lesson should match the code in the reading.

The instructor may also highlight the recommendation to watch the video lesson in its entirety before implementing the code. We acknowledge that you know your learning best, and it might be best for your learning to code along.

### !end-callout

### Problems Sets

After completing all the lessons for a single topic, the problems set direct us to implement the new features introduced in that Learn Topic in our **own fork** of the [Hello Books API](https://github.com/AdaGold/hello-books-api). This additional practice will reinforce the new skills learned, provide an opportunity for debugging practice, and ensure our local flask set-up is working.

For this work, we should practice making small, atomic commits

## Class Activities

The Building an API has a companion pair project / class activity [Solar System API](https://github.com/AdaGold/solar-system-api) for additional skills practice.




