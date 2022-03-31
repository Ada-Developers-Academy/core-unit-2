# Intro to Hello Books API

The Lessons in the Building an API Learn Topics will walk-through building a Flask API with the companion repo [Hello Books API](https://github.com/AdaGold/hello-books-api).

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
    * Do not make commits -- *This is likely the only time we'll ever suggest not making commits*
1. When starting the lesson, remove any changes you've made using `git stash`. `git stash` resets files to the previous commit point. By not leaving any of your own changes, it makes it possible to checkout the next lesson's branch without introduing conflicts.

<!-- available callout types: info, success, warning, danger, secondary, star  -->
### !callout-info

## Video Lessons

You may notice small inconsistencies between the video lessons and the readings due to revisions to the `hello-books-api` and readings since the videos were recorded. For instance, the branch the instructor checks out in the video lesson may be different than the branch indicated in the reading. Follow the instructions in the reading. The code modeled in the video lesson should match the code in the reading.

### !end-callout

### Problems Sets

After completing all the lessons for a single topic, the problems set direct us to implement the new features introduced in that Learn Topic in our **own fork** of the [Hello Books API](https://github.com/AdaGold/hello-books-api). This additional practice will reinforce the new skills learned, provide an opportunity for debugging practice, and ensure our local flask set-up is working.

For this work, we should practice making small, atomic commits

## Class Activities

The Building an API has a companion pair project / class activity [Solar System API](https://github.com/AdaGold/solar-system-api) for additional skills practice.




