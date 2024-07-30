# Intro to Hello Books API

The lessons in the **Building an API** Learn topics will walk-through building a Flask API with the companion repo [Hello Books API](https://github.com/AdaGold/hello-books-api).

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=3baea592-08f8-48eb-beb4-ae6a012e05e8&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Branches

There are 10 separate Learn topics in the **Building an API** lesson series. The [Hello Books API repo](https://github.com/AdaGold/hello-books-api) has a git branch with the new code introduced in each lesson. As we learn how to build an API through this lesson series, the branches will be a way to look at new code introduced in each lesson. Think of it like bookmarks or milestones as we learn.

At the top of a lesson that adds to the Hello Books API Flask application code, the starting branch and ending branch will be indicated in a table. For example, the next lesson, **Flask Setup**, starts with the branch `01a-intro-to-flask` and ends with the branch `01b-flask-setup` (see example table below). While it is a convention in GitHub for the default branch to be the `main` branch, the default branch for the **Hello Books API** repository is `01a-intro-to-flask`.

We will use the provided branches as a reference, primarily through the GitHub web interface rather than by switching between branches in our local repository, and we will write our own code on a separate branch (more details on that below).

| Starting Branch | Ending Branch|
|--|--|
|`01a-intro-to-flask` |`01b-flask-setup`|

## Workflow Recommendation

As you work through the Building an API Learn topics and learn to build an API with Flask, you will find a workflow that works for you. Here are our workflow recommendations:

1. Fork and clone [Hello Books API](https://github.com/AdaGold/hello-books-api).
2. Since the default branch is `01a-intro-to-flask`, create a branch called `main` so that we will have our own branch to work on.
   1. `git checkout -b main` will create a branch called `main` and switch to that new branch.
   2. `git push -u` will push the branch we are on (our new branch `main`) to our remote fork and ensure the relationship between the remote branch and our local branch is created.
   3. Follow [Github's documentation](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-branches-in-your-repository/changing-the-default-branch#changing-the-default-branch) to change the default branch from `01a-intro-to-flask` to our new development branch `main` in the settings of our forked repo.
   * If stuck on these steps, reach out in #study-hall on Slack and someone will help out!
3. When beginning a lesson, look at the corresponding starting branch for that lesson in the Github web interface (see screenshot below).
4. Code along with the lesson **as much or as little as best supports your learning** on the `main` branch. 
5. After finishing a lesson, we should commit our changes on the `main` branch with a detailed commit message so that our changes are saved. Once a commit is created, we should push the new commit to our remote repo so that our changes are reflected there as well.
6. Now we're ready for our next lesson. We should switch to the next lesson's branch in the GitHub web interface for reference while continuing to make our changes on our local `main` branch. We can repeat these steps for all the lessons related to the Hello Books API.
   
![Explanation for how to view branch contents within the GitHub web view. The branch dropdown (displaying `01a-intro-to-flask` by default) is labeled "Use this dropdown to select the branch you'd like to view. After selecting the branch, the contents will be displayed in the GitHub web view." The list of branches is labeled "Available branches." A general info box states "After selecting a branch, click on a file to view it in the GitHub web view."](../assets/building-an-api/hello-books-api-branches-in-github.png)

_Fig. Use the project branches as a reference viewed through the GitHub web view rather than switching between branches in your code editor while working. ([Full size image](../assets/building-an-api/hello-books-api-branches-in-github.png))_

### Problems Sets

After completing all the lessons for a single topic, the problem sets direct us to implement the new features introduced in that Learn topic in our forked and cloned version of the [Hello Books API](https://github.com/AdaGold/hello-books-api). This additional practice will reinforce the new skills learned, provide an opportunity for debugging practice, and ensure our local flask set-up is working.

For this work, we should practice making small, atomic commits

## Class Activities

The Building an API lessons have a companion pair project, [Solar System API](https://github.com/AdaGold/solar-system-api), that we will work on during class activities for additional skills practice.