# Deploying to Render

## Goal

Our goal for this lesson is to:
* Practice the process of deploying a Flask API to Render.

We will outline the following steps in order to do an initial deploy to Render:

1. Create a Render account
2. Connect our Render account to our Github account
3. Configure our Flask app for Render
4. Create a Render app via their web launcher
5. Create a PostgreSQL database in Render
6. Setup and initialize the database in Render via the CLI
7. Set the environment variables for our Render app
8. Verify

Then, we will cover these topics on continuous deployment to Render:

1. General Render tools
2. General Render debugging strategies

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`08b-nested-routes` <br> Any branch after connecting the database will work |`09a-deploying-to-render`|

### Intro to Render

[Render](https://render.com/) is one Platform as a Service (PaaS). We can use Render services to deploy our Flask API. After we successfully deploy, our API will be available to the whole Internet!

![Screenshot of Render.com's splash page](../assets/deployment/deployment_render-splash.png)

We are choosing Render as a deployment platform because:

- It is a trusted, popular platform with a large, supportive community
- It has free features that fulfill our needs
  - It supports Python and Flask deployment
  - It supports Postgres databases
- It is appropriate for small, individual projects (as well as large ones)
- It uses Git as part of its development workflow
- It has a simple user interface

## Create a Render Account

Create an account on [Render](https://dashboard.render.com/register?next=%2Fregisterundefined).

Render will send a verification message to the email you use to register. The email will include a link that brings you to your dashboard.

![Screenshot of Account Verification Email from Render](../assets/deployment/deployment_render-verification-email.png)

As a new user, our dashboard should display a quick start guide. 

![Screenshot of the Render New User Dashboard](../assets/deployment/deployment_render-new-user-dash.png)

Once we have added applications, our dashboard will change to show a list of all our deployed applications. 

![Screenshot of the Render Dashboard with three apps listed in it](../assets/deployment/deployment_dashboard-with-apps-render.png)

## Connect Render Account to Github

Connecting our Render account with our Github account allows us to link our project repository to our Render application. 

To connect our Render and Github accounts, we can click on our user profile in the upper righthand corner of Render, then select _Account Settings_. 

![Screenshot of User Dropdown Menu](../assets/deployment/deployment_account-settings-render.png)

Under the Profile section of the Account Settings page, click the _Connect Github_ button and sign in to Github when prompted. 

![Screenshot of Profile Section](../assets/deployment/deployment_profile-connect-github-render.png)

When we have successfully linked your Github account to Render, the _Connect Github_ button will be replaced with our Github username and an option to disconnect our Github account.

![Screenshot of Successful Github Connection](../assets/deployment/deployment_profile-with-connected-github-render.png)


## Configure Our Flask App for Render

Although Render will do a lot of the work of hosting, running, and maintaining our API server, we need to add a small amount of configuration to our project.

### Check Dependencies for `gunicorn`

We will use a Python package named [gunicorn](https://pypi.org/project/gunicorn/) to launch our Flask API on Heroku.

`gunicorn` is capable of running Flask apps so that they can handle multiple simultaneous requests, which is very important for production web applications.

We should confirm that the package `gunicorn` is in the project's `requirements.txt` file.

If `gunicorn` does _not_ appear in our `requirement.txt`, we can add it by installing it locally with:

```bash
(venv) $ pip install gunicorn
```

After it has installed, we can update our `requirements.txt` by running:

```bash
(venv) $ pip freeze > requirements.txt
```

Render makes use of our `requirements.txt` file to install our app dependencies, so it is very important to ensure that all of our dependencies are properly listed.

If we needed to update our `requirements.txt`, we should be sure to add and commit this change.

## Create a Render App

For each project we deploy, we will need to create and manage a Render app. Our Render app will give us visibility, access, and tools to manage our deployed app.

To create your Render app, click the _New_ button in the top navigation bar, and then choose _Web Service_. 

![Create New Web Service Button Screenshot](../assets/deployment/deployment_new_web_service_render.png)

Next, we can use the search bar to find our Hello Books API Github repository. Click the _Connect_ button next to our project repository to link it to our new application. 

Note that we should use our _fork_ of the Hello Books API repo which is listed under our Github username. So we should search for `your-github-username/hello-books-api`. We are working with the AdaGold version only for the purposes of this demo. 

![Screenshot of selecting the AdaGold/hello-books-api Repo](../assets/deployment/deployment_connect-app-to-repo-render.png)

Enter `your-app-name` into the _Name_ field to create an app with the name `your-app-name`. 

Replace `your-app-name` with the desired name of the app.

![Screenshot of Render after adding the app name](../assets/deployment/deployment_connect-app-to-repo-render.png)

Note that the app name must be unique across all Render apps, not just our own apps. As a result, the name `hello-books-api` is already taken, as it was used in this walk-through! We will need to come up with our own name that has a unique touch.

<!-- Add comment about Render tacking on random characters for non-unique names-->

Next, change the _Branh_ field to set which branch we want to pull our code from for our deployed applicaton. Most of the time we will choose `main`, but in the case of the Hello Books API repo, we don't have a `main` branch. Instead we'll want to choose the branch we are currently working in which holds all of our latest changes. For us, that is `08b-nested-routes`. If you are working off a different branch, use that branch. 

![Screenshot of Render after adding choosing branch 08b-nested-routes](../assets/deployment/deployment_choose-web-service-name-render.png)

Next, we need to alter the _Start Command_ field which defaults to the value `$ gunicorn app: app`. This field defines how our Flask web server will start. 

Update the _Start Command_ field to `$ gunicorn "app:create_app()"`.

![Screenshot of changing app start command to gunicorn "app:create_app()"](../assets/deployment/deployment_change-start-command-render.png)

Finally, scroll down to the bottom of the page and click the _Create Web Service_ button.

![Screenshot of Creating Web Service in Render](../assets/deployment/deployment_create-web-service-render.png)


<!-- available callout types: info, success, warning, danger, secondary, star  -->
### !callout-warning

## Render Free App Limits

Render's free tier only supports a single full stack application (front end app, backend app, and Postgres database). If we want to deploy a second app, we will need to suspend or delete any other apps we have deployed. 

### !end-callout

### Our New Render App

Render will now begin to build our app. This may take several minutes. If our app successfully deploys, we will see a  `Your service is live 🎉` message appear in the logs section at the bottom of the screen.

![Screenshot of the your service is live message in the logs of a successfully deployed Render app](../assets/deployment/deployment_successful-deployment-logs-render.png)

Our Render app is not connected to a Postgres database yet, so we cannot make HTTP requests with our routes successfully at this stage.

### !callout-info

## Render Still Ignores Files

Since we are using Github to give Render access to our code, this means Render will _not_ have access to any files listed in our `.gitignore`, including our `.env` file. This means our environment variables, which include our connection strings, are unseen by Render! We'll learn how to tell our app where to find our database later in this lesson.

### !end-callout

### Verify in the Dashboard

We can verify our app was created by navigating to our primary [Render dashboard](https://dashboard.render.com/).

Our new app is now listed! We'll visit this dashboard whenever we need to see or update details of our Render apps. 

![Screenshot of the Render dashboard with the new hello-books-api app listed](../assets/deployment/deployment_render-dashboard-new-app.png)

## Create a Database in Render

Now that we've created our Render app for the first time, we need to tell the app we're interested in adding a Postgres database to our deployed Render app.

To create a new Postgres database, click the _New_ button in the top navigation bar, then choose _PostgreSQL_. 

![Screenshot of selecting new PostgreSQL service](../assets/deployment/deployment_new-postgres-db-render.png)

Just as with our web service, we need to give our database a name. Enter `your-database-name` into the _Name_ field. 

Replace `your-database-name` with the desired name of the Postgres database. 

![Screenshot of new PostgreSQL database with name hello-books-api-db](../assets/deployment/deployment_set-postgres-db-name-render.png)

Finally, scroll down to the bottom of the current page and click _Create Database_. 

![Screenshot of Create Database button on Render](../assets/deployment/deployment_create-database-render.png)

Render will bring us to our new database's _Info_ section. The _Status_ field will show that it is in the process of creating the database. Creating the database may take several minutes. 

![Screenshot of hello-books-api database being created](../assets/deployment/deployment_status-creating-render.png)

Once the database is successfully created, the _Status_ field will change to Available. 

![Screenshot of hello-books-api database with status available](../assets/deployment/deployment_database-with-available-status-render.png)

### Verify in the Dashboard

We can verify that our Postgres database was successfully created by visiting the [Render dashboard](https://dashboard.render.com/).

Our new database should now be listed above our application.

![Screenshot of the Render dashboard showing the new hello-books-api-db database](../assets/deployment/deployment_dashboard-with-db-and-web-service-render.png)

### Setup and Initialize the Render Database

We now have our database, but it is empty. Just as we did with the [Postgres database on our local machine](../api-3-database-models-read/models-setup.md), we need to perform a database migration to update the Render database to our latest schema.

To perform the migration, click on our database in the Render dashboard to open the database's info and settings. Then click the _Connect_ button in the upper right hand corner of the window and select _External Connection_. Copy the External Database URL. 

![Screenshot of Connect window with External Database URL copied](../assets/deployment/deployment_external-database-url-render.png)

Your external database URL will look something like the following:

```
postgres://YOUR_DATABASE_USERNAME:CONNECTION-STRING.oregon-postgres.render.com/YOUR_DATABASE
```
`YOUR_DATABASE_USERNAME` and `YOUR_DATABASE` were generated by Render when we first set up our database. We can find what they are by checking our database's _Info_ page and scrolling down to the _Connections_ subsection. 

![Screenshot of the Connections section on the Info page for our Render Postgres Database](../assets/deployment/deployment_render-db-connections-section.png)

In our case `YOUR_DATABASE_USERNAME` is `hello_books_api_db_h25f_user` (listed as the Username on our database's dashboard) and `YOUR_DATABASE` is `hello_books_api_db_h25f` (listed as the Database on our database's dashboard).

`CONNECTION-STRING` will be a long series of random characters. 

Navigate to the `.env` file in our project's root directory in VS Code. Create a new environment variable `RENDER_DATABASE_URL` to hold our external database URL. 

```
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
RENDER_DATABASE_URL = postgres://YOUR_DATABASE_USERNAME:CONNECTION-STRING.oregon-postgres.render.com/YOUR_DATABASE
```

We need to modify the start of our external database URL to work with the version of SQLAlchemy we are useing. We can update the beginning of our external database URL from `postgres` to `postgresql+pyscopg2`.

```
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
RENDER_DATABASE_URL = postgresql+psycopg2://YOUR_DATABASE_USERNAME:CONNECTION-STRING.oregon-postgres.render.com/YOUR_DATABASE
```

In `app/__init__.py` we now want to update the setting 

Now that our Flask app is on Heroku and can connect to a database, we need to initialize the database in Heroku once.

We can run the following:



This will migrate the empty database in our remote Postgres connection to the latest schema configuration we have generated from our models.

To create the tables, we can connect our new Render database to 

To create the tables, we first scroll down our new database's page on Render, and copy the _External Database URL_ field under the _Connections_ section. 

![Copy external connection string of Postgres database](../assets/deployment/deployment_copy-external-database-url-render.png)

Then navigate to the `.env` file of your project on your local machine. 

## Set Environment Variables in Heroku

Our current app sets the `SQLALCHEMY_DATABASE_URI` environment variable using our `.env` file. Our Flask code accesses this environment variable with the code `os.environ.get("SQLALCHEMY_DATABASE_URI")`.

Instead of giving Heroku our `.env` file, we need to add our environment variables to Heroku using the Heroku dashboard.

### Find the Database URL in Heroku

First, let's find the connection string that will connect to our Heroku database, instead of a local database.

When we added the Postgres database add-on above, Heroku created this connection string.

In the Heroku dashboard, i n the "Settings" tab, there is a section titled "Config Vars."

![Screenshot of the Heroku dashboard at the Settings tab](../assets/deployment/deployment_heroku-app-settings.png)

Once we locate this section, we should:

1. Click "Reveal Config Vars"
1. Find the automatically generated variable named "DATABASE_URL"
1. Copy the value of this connection string

![Screenshot of the Heroku dashboard, where the environment/config variable named DATABASE_URL is expanded in a right modal](../assets/deployment/deployment_heroku-config-var-database-url-detail.png)

### Set the Environment Variables in Heroku

Now, let's set the `SQLALCHEMY_DATABASE_URI` variable.

In the "Config Vars" section:

1. Create a new environment variable named `SQLALCHEMY_DATABASE_URI`
1. Set the value of this variable to the connection string we copied

![Screenshot of the Heroku dashboard at the Settings tab, showing the detail of revealed Config vars. The SQLALCHEMY_DATABASE_URI variable is present](../assets/deployment/deployment_heroku-reveal-config-vars.png)

## Verify

Our Flask project is on a Heroku machine, running, and connected to an initialized database. Now is the time to verify whether our API is accessible by web!

### Use the Browser

We can use the browser to make `GET` requests to any endpoint defined in our project, now using our deployed Heroku URI instead of `localhost`.

### !callout-warning

## Routing Configurations May Result in a `404 Not Found`
Recall that Flask routes are very picky about `/` characters. Some browsers will try to put a `/` character at the end of an address automatically. Depending on how our routes are set up, this might result in a route mismatch.

<br />

Our Flask API isn't _intended_ to be used through a web browser. It's meant to be used programmatically. It's convenient if testing through a browser works, but if it doesn't we can move on to test with Postman.

### !end-callout

Instead of `localhost:5000/books`, we can visit `https://your-app-name.herokuapp.com/books`, where `your-app-name` is the name of our Heroku app.

![Screenshot of the browser open to the deployed API, showing a response of an empty JSON array](../assets/deployment/deployment_deployed-books.png)

### !callout-info

## No Book Data

Our app has zero books listed when we go to `/books`, even though our app is deployed correctly and connected to our Postgres database correctly.

<br />


<details>

<summary>Why are there no books listed?</summary>

<br />

Recall that our deployed app is connected to a Postgres database that we created a few steps ago! We have not added any book data to our Heroku database. Even if our local database is full of books, our Heroku app's database connection string points at the Heroku database. 

</details>

### !end-callout

As a convenient shortcut, the Heroku CLI gives us this command to automatically open our Heroku app in the browser:

```bash
$ heroku open
```

This command needs to be run inside of our project folder.

### Use Postman

We can use Postman to make and verify all sorts of HTTP requests to our API!

### Use Heroku Logs

During local development on our own machines, when we ran `$ flask run`, the server's logs were output into our terminal. We could see the details about every HTTP request our server received and every HTTP response it returned. We could also see output for any errors.

We can access the server logs of our Heroku app from the Heroku dashboard by finding the "More" menu and selecting "View logs."

![Screenshot of the Heroku dashboard, focusing on the "More" menu, which lists the option to View logs](../assets/deployment/deployment_heroku-view-logs-menu.png)

It reports the HTTP requests, responses, and errors that our Heroku app encounters.

![Screenshot of the Heroku logs, showing examples of different HTTP requests and responses](../assets/deployment/deployment_heroku-logs.png)

Alternatively, we can access the server logs using the Heroku CLI and running:

```bash
$ heroku logs
```

If we want to see the logs output in real time, we can run:

```bash
$ heroku logs --tail
```

This option is useful when we are troubleshooting an issue. If we can recreate the error, we'll be able to see the server log information related to the error just as if we were running the application locally.

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: bDUwQW
* title: Deploying to Render
##### !question

Consider the steps for doing the initial deploy to Render.

Check off all the topics that we've briefly touched on so far.

##### !end-question
##### !options

* Create a Render account and connect our Render account to our Github account
* Create a Render web service app
* Create a Postgres database in Render
* Connect our local database to our web service app
* Set the environment variable for our Render database in Render
* Initialize the Render database by 

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->

## Updating the Heroku Remote Workflow

When we practice _continuous deployment_, we must adopt the practice of regularly updating the Git history of our Heroku app.

We can summarize our local development workflow like this:

1. Activate our virtual environment
1. Pull down any new commits from Git
1. Run tests
1. Write code
1. Make Git commits
1. Push our Git history to the `origin` remote, which is our repo on GitHub
1. **Push our Git history to the `heroku` remote**, which is our Heroku app
1. Verify our deployment

## General Deployment Tools

We can continue to use the browser and Postman to create HTTP requests and check their HTTP responses!

### Heroku Tools in the Dashboard

The Heroku dashboard includes:

- Access to the Heroku logs
- Access to the Heroku console (which acts as a terminal on our Heroku machine)
- Management of environment variables
- Management of collaborators on this Heroku app
- History of "Latest Activity," which will show the timeline of recent deployments

### Command-Line Tools

The following are great Heroku CLI commands to keep handy:

| <div style="min-width:200px;">Command</div>              | Explanation                                                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `heroku logs --tail` | Starts tailing the Heroku logs in the current terminal window, displaying real-time updates                                                                           |
| `heroku run python3` | Runs the `python3` repl on the Heroku machine running our app                                                                                                       |
| `heroku pg:psql`     | Runs the `psql` CLI on the Heroku machine running our app. We can use this to execute `psql` commands, and check, add, update, or delete the data that our app uses. |

## General Heroku Debugging Strategies

Sometimes, after deployment, our deployed app doesn't behave as expected. This could be a bug, and it could also be our web server catching an exception.

Our deployed apps can encounter problems ranging from:

- Problems with our own Flask code, such as broken syntax or buggy features
- Our database not being connected or initialized properly
- Our Heroku machine not downloading and installing the correct dependencies
- Heroku.com itself being down, or improper use of Heroku tools

In those situations, here is a starting point for debugging and determining what is causing the deployment error:

| <div style="min-width:200px;">Debugging Action</div>                          | Details                                                                                                                                                                                                                                            |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Check the logs                            | The logs will show error messages that the web server outputs. These messages could share details such as Python `NameError`s, database connection errors, problems with running the Flask app, problems with downloading the right packages, etc. |
| See if you can recreate it locally        | Attempt to recreate the problem locally, by running `$ flask run` on your own local machine. Error messages may be more detailed on our local machine. Also, concluding that you're **unable to recreate the issue** is valuable in itself!        |
| Check the status of the Git history       | Confirm that the remote Git history is up-to-date. Check that working code has been recently pushed to the `heroku` remote.                                                                                                                        |
| Internet research!                        | Heroku has a large community of support, and a lot of documentation on deploying Flask apps and using Postgres databases. Be sure to use the Internet and to rubber duck with others.                                                              |
| Take notes of each debugging attempt      | It can be challenging to remember what you've tried on the Heroku machine. Write down and record all of the ways you've attempted to fix the problem.                                                                                              |
| Rubber duck, and post questions on Slack! | Debugging deployment usually depends on context. Rubber duck and connect with folks who are deploying similar projects to you!                                                                                                                     |

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: multiple-choice
* id: oOMsqS
* title: Deploying to Heroku
##### !question

Which of the following is a command we can use to access the Heroku Postgres repl?

##### !end-question
##### !options

* `heroku pg:psql`
* `heroku python3`
* `heroku run python3`
* `heroku open SQLALCHEMY_DATABASE_URI`

##### !end-options
##### !answer

* `heroku pg:psql`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 3 -->
<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: CSpfam
* title: Deploying to Heroku
##### !question

Check all of the options that are recommended debugging steps.

##### !end-question
##### !options

* Try to recreate the issue on your local machine
* Check the Heroku server logs
* Check the local server logs
* Confirm that recent, working code is pushed up to the `heroku` remote
* Copy and paste the error messages and look it up on the Internet
* Push all code to the `origin` remote

##### !end-options
##### !answer

* Try to recreate the issue on your local machine
* Check the Heroku server logs
* Confirm that recent, working code is pushed up to the `heroku` remote
* Copy and paste the error messages and look it up on the Internet

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
