# Deploying to Render

<!-- FLASK UPDATE -->
<!-- <iframe src="https://adaacademy.hosted.panopto.com/Panopto/Pages/Embed.aspx?pid=8285322f-7fe1-45a7-8206-aff701709f35&autoplay=false&offerviewer=true&showtitle=true&showbrand=true&captions=true&interactivity=all" height="405" width="720" style="border: 1px solid #464646;" allowfullscreen allow="autoplay"></iframe> -->

## Goal

Our goal for this lesson is to:
* Practice the process of deploying a Flask API to Render.

We will outline the following steps in order to do an initial deploy to Render:

1. Create a Render account
2. Connect our Render account to our GitHub account
3. Configure our Flask app for Render
4. Create a Render app via their web launcher
5. Create a PostgreSQL database in Render
6. Initialize the database
7. Set the environment variables for our Render app
8. Verify

Then, we will cover these topics on continuous deployment to Render:

1. General Render tools
2. General Render debugging strategies

## Branches

| Starting Branch | Ending Branch|
|--|--|
|`08c-route-utilities-refactors` <br><br> Any branch after connecting the database will work |`09a-deploying-to-render`|

### Intro to Render

[Render](https://render.com/) is one Platform as a Service (PaaS). We can use Render services to deploy our Flask API. After we successfully deploy, our API will be available to the whole Internet!

![Screenshot of Render.com's splash page](../assets/deployment/render-splashpage.png)

We are choosing Render as a deployment platform because:

- It is a trusted, popular platform with a large, supportive community
- It has free features that fulfill our needs
  - It supports Python and Flask deployment
  - It supports Postgres databases
- It is appropriate for small, individual projects (as well as large ones)
- It uses Git as part of its development workflow
- It has a simple user interface

## Create a Render Account

Create an account on [Render](https://dashboard.render.com/register?next=%2Fregister).

Render will send a verification message to the email you use to register. The email will include a link that brings you to your dashboard.

![Screenshot of Account Verification Email from Render](../assets/deployment/deployment_render-verification-email.png)

As a new user, our dashboard should display a quick start guide. 

![Screenshot of the Render New User Dashboard](../assets/deployment/render-dashboard-no-projects.png)

Once we have added applications, our dashboard will change to show a list of all our deployed applications. 

![Screenshot of the Render Dashboard with several apps listed in it](../assets/deployment/render-dashboard-successfully-deployed-services.png)

## Connect Render Account to GitHub

Connecting our Render account with our GitHub account allows us to link our project repository to our Render application. 

To connect our Render and GitHub accounts, we can click on our user profile in the upper righthand corner of Render, then select "Account Settings". 

![Screenshot of User Dropdown Menu](../assets/deployment/render-user-dropdown-settings.png)

Under the Profile section of the Account Settings page, click the "Connect GitHub" button and sign in to GitHub as prompted. 

![Screenshot of Profile Section](../assets/deployment/render-account-security-github-not-connected.png)
_([Full size image](../assets/deployment/render-account-security-github-not-connected.png))_

When we have successfully linked our GitHub account to Render, the "Connect GitHub" button will be replaced with our GitHub username and an option to disconnect our GitHub account.

![Screenshot of Successful GitHub Connection](../assets/deployment/render-account-security-github-connected.png)
_([Full size image](../assets/deployment/render-account-security-github-connected.png))_


## Configure Our Flask App for Render

Although Render will do a lot of the work of hosting, running, and maintaining our API server, we need to add a small amount of configuration to our project.

### Check Dependencies for `gunicorn`

We will use a Python package named [gunicorn](https://pypi.org/project/gunicorn/) to launch our Flask API on Render.

`gunicorn` is capable of running Flask apps so that they can handle multiple simultaneous requests, which is very important for production web applications. Web frameworks often come with a small, built-in development server (in this case, our `flask run` command), but we shouldn't use that when deploying our app to be used publicly.

We should confirm that the package `gunicorn` is in the project's `requirements.txt` file.

If `gunicorn` does _not_ appear in our `requirement.txt`, we can install it locally by activating our virtual environment and running the command:

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

To create our Render app, click the "New" button in the top navigation bar, and then choose "Web Service". 

![Create New Web Service Button Screenshot](../assets/deployment/render-new-menu.png)
_([Full size image](../assets/deployment/render-new-menu.png))_

Next, we want to connect our web service to our Hello Books API GitHub repository. Although we linked our Render account to GitHub earlier, we may need to add some additional permissions to allow Render to view our GitHub repositories. To do so, we can click the "GitHub" button under the "Connect Git Provider" message.

![Screenshot of Connect Github Account button to Web Service on Render](../assets/deployment/render-first-webservice-connect-github.png)
_([Full size image](../assets/deployment/render-first-webservice-connect-github.png))_

This will take us to a Github configuration page asking us to choose which repositories we want Render to be able to access. Select "All repositories" then click the green "Install" button at the bottom of the page.

![Screenshot of Github repository access configuration page](../assets/deployment/github-install-render.png)
_([Full size image](../assets/deployment/github-install-render.png))_

Now we should see any repos we have in our Github account displayed in the "Source Code" section. We can use the search bar to find our Hello Books API GitHub repository. Once we find and select our repo in the list, click the "Connect" button below the repo list to link our project repository to our new application. 

Note that we should use _our fork_ of the Hello Books API repo which is listed under our GitHub username. So we should search for `your-github-username/hello-books-api`. We are working with the AdaGold version only for the purposes of this walk-through. 

![Screenshot of selecting the AdaGold/hello-books-api Repo](../assets/deployment/render-search-for-hello-books-repo.png)
_([Full size image](../assets/deployment/render-search-for-hello-books-repo.png))_

When we land on the next set up page, enter `your-app-name` into the "Name" field to create an app with the name `your-app-name`. 

Replace `your-app-name` with the desired name of the app.

![Screenshot of web service deployment page after adding the app name](../assets/deployment/render-set-webservice-name.png)
_([Full size image](../assets/deployment/render-set-webservice-name.png))_

Note that the app name must be unique across all Render apps, not just our own apps. As a result, the name `hello-books-api` is already taken, as it was used in this walk-through! We will need to come up with our own name that has a unique touch. If we try to choose a name that has already been taken, Render will tack on random characters to create a unique name.

Next, we should confirm that the "Language" field is set to "Python 3". When deploying a web service to Render, it will try to be helpful and set the "Language" field for you, but it doesn't always select the correct option. You can click the current value of "Language" to see a drop down of the languages supported by Render and choose a new value if necessary.

We also want to change the "Branch" field to choose which branch we want to pull our code from to create our deployed application. Most of the time we will select `main`, and this should be the branch we pick for our individual repos. The example Hello Books API repo doesn't have a `main` branch, we have named branches per-lesson. In this example deployment, we will choose a branch that includes all the code and latest changes we want to be a part of our deployed app. For the purposes of our example, we'll use `09a-deploying-to-render`. 

![Screenshot of Render after selecting the language and choosing the branch 08b-nested-routes](../assets/deployment/render-set-language-and-branch.png)
_([Full size image](../assets/deployment/render-set-language-and-branch.png))_

Next, we need to alter the "Start Command" field which defaults to the value `$ gunicorn app:app`. This field defines where in our code the `gunicorn` package should look to find what it needs to start our Flask web server. 

Update the "Start Command" field to `$ gunicorn "app:create_app()"`.

![Screenshot of changing app start command to gunicorn "app:create_app()"](../assets/deployment/render-update-start-command.png)
_([Full size image](../assets/deployment/render-update-start-command.png))_

In the "Instance Type" section, Render will have a paid option selected by default. We want to ensure that the "Free" tier is selected before proceeding.

![Screenshot of the Instance Type section with the Free tier selected"](../assets/deployment/render-choose-instance-type.png)
_([Full size image](../assets/deployment/render-choose-instance-type.png))_

Finally, scroll down to the bottom of the page and click the "Deploy Web Service" button.

![Screenshot of Create Web Service Button in Render](../assets/deployment/render-deploy-webservice-button.png)
_([Full size image](../assets/deployment/render-deploy-webservice-button.png))_

### !callout-warning

## Render Free App Limits

Render's free tier only supports a single full stack application (front end app, backend app, and Postgres database). If we want to deploy a second app, we will need to suspend or delete any other apps we have deployed. 

### !end-callout

If a prompt for payment information appears after clicking the Deploy Web Service button, we can dismiss the popup and then double check that the `Instance Type` selection is set to `Free`. By default, one of the paid tiers is selected, and we'll be prompted for payment information unless we change the setting.

### Our New Render App

At this point, our app will try to build, but won't successfully deploy because we are missing required environment variables like `SQLALCHEMY_DATABASE_URI`. If everything is going as expected, we will see a `==> Running 'gunicorn "app:create_app()"'` message, followed by a red error `"Error: Either 'SQLALCHEMY_DATABASE_URI' or 'SQLALCHEMY_BINDS' must be set."`

![Screenshot of the error message in the logs of a deploying Render app](../assets/deployment/render-deploy-messages-failed-env-vars-not-set.png)
_([Full size image](../assets/deployment/render-deploy-messages-failed-env-vars-not-set.png))_

Our Render app is not connected to a Postgres database yet. Until that step is completed, we cannot finish deploying our app to make HTTP requests with our routes successfully.

### !callout-info

## Render Still Ignores Files

Since we are using GitHub to give Render access to our code, this means Render will _not_ have access to any files listed in our `.gitignore`, including our `.env` file. This means our environment variables, which include our connection strings, are unseen by Render! We'll learn how to tell our app where to find our database later in this lesson.

### !end-callout

### Verify in the Dashboard

We can verify our app was created by navigating to our main [Render dashboard](https://dashboard.render.com/).

Our new app is now listed! Under the "Status" field it should read `Failed deploy`. We'll visit this dashboard whenever we need to see or update details of our Render apps. 

![Screenshot of the Render dashboard with the new hello-books-api app listed](../assets/deployment/render-dashboard-showing-failed-deploy.png)
_([Full size image](../assets/deployment/render-dashboard-showing-failed-deploy.png))_

We can access the individual app's dashboard by clicking on the app in our list of services. If we click on our app in our main dashboard, it will bring us to the "Events" section of our app-specific dashboard. The Events section will also confirm that our app failed to deploy. We should see a red circle with an `X` in it with a `Deploy failed...` message. The `Deploy failed...` message will also include the commit hash and commit message of your connected Github repo's latest commit. 

![hello-books-api app dashboard with deploy failed message](../assets/deployment/render-events-log-showing-deploy-failed.png)
_([Full size image](../assets/deployment/render-events-log-showing-deploy-failed.png))_

## Create a Database in Render

Now that we've created our hello-books-api Render app for the first time, we need to set up a Postgres database that can be connected to our Render app.

To create a new Postgres database, click the "New" button in the top navigation bar, then choose "PostgreSQL". 

![Screenshot of selecting new PostgreSQL service](../assets/deployment/render-new-menu-postgresql.png)
_([Full size image](../assets/deployment/render-new-menu-postgresql.png))_

Just as with our web service, we need to give our database a name. Enter `your-database-name` into the "Name" field. 

Replace `your-database-name` with the desired name of the Postgres database. 

![Screenshot of new PostgreSQL database with name hello-books-api-db](../assets/deployment/render-set-new-db-name.png)
_([Full size image](../assets/deployment/render-set-new-db-name.png))_

Finally, scroll down to the bottom of the current page. Like we did with our webservice, we need to ensure that we select the "Free" tier under the "Instance Type" section, then click _Create Database_. 

![Screenshot of Create Database button on Render](../assets/deployment/render-set-instance-type-and-create-button.png)
_([Full size image](../assets/deployment/render-set-instance-type-and-create-button.png))_

The free database tier is time limited, and Render will remove your database, along with any data, after a set period of time unless the plan is upgraded to a paid tier. This is fine for our purposes now when we're gaining deployment experience, but we should keep this mind if we want to deploy any projects that we would like to have run for a longer time. We can always create a new database when the original is removed, but we would need to plan ahead in order to migrate any data from the original database that we would like to preserve.

Render will bring us to our new database's "Info" section. The "Status" field will show that it is "Creating" the database. Creating the database may take several minutes. 

![Screenshot of hello-books-api database being created](../assets/deployment/render-database-info-creating-db.png)
_([Full size image](../assets/deployment/render-database-info-creating-db.png))_

Once the database is successfully created, the "Status" field will change to "Available." 

![Screenshot of hello-books-api database with status available](../assets/deployment/render-database-info-db-available.png)
_([Full size image](../assets/deployment/render-database-info-db-available.png))_

### Verify in the Dashboard

We can verify that our Postgres database was successfully created by visiting the [Render dashboard](https://dashboard.render.com/).

Our new database should now be listed, along with our application.

![Screenshot of the Render dashboard showing the new hello-books-api-db database](../assets/deployment/render-dashboard-db-exists-api-failed-deploy.png)
_([Full size image](../assets/deployment/render-dashboard-db-exists-api-failed-deploy.png))_

### Setup and Initialize the Render Database

We now have our database, but it is empty. Just as we did with the [Postgres database on our local machine](../api-3-database-models-read/models-setup.md), we need to perform a database migration to update the Render database to our latest schema.

To perform the migration, click on the database where it is listed in the Render dashboard to open the database's info and settings. Then click the "Connect" button in the upper right hand corner and select "External Connection". Copy the "External Database URL." 

![Screenshot of Connect window with External Database URL copied](../assets/deployment/render-copy-external-db-connection.png)
_([Full size image](../assets/deployment/render-copy-external-db-connection.png))_

Your external database URL will look something like the following:

```
postgres://YOUR_DATABASE_USERNAME:YOUR_DATABASE_PASSWORD@DB_HOSTNAME.oregon-postgres.render.com/YOUR_DATABASE
```

Render generated `YOUR_DATABASE_USERNAME` and `YOUR_DATABASE` when we first set up our database. We can find what they are by checking our database's "Info" page and scrolling down to the "Connections" subsection. 

![Screenshot of the Connections section on the Info page for our Render Postgres Database](../assets/deployment/render-database-info-connections.png)
_([Full size image](../assets/deployment/render-database-info-connections.png))_

In our case `YOUR_DATABASE_USERNAME` is `hello_books_api_db_jx8j_user` (listed as the "Username" on our database's dashboard) and `YOUR_DATABASE` is `hello_books_api_db_jx8j` (listed as the "Database" on our database's dashboard).

`YOUR_DATABASE_PASSWORD` and `DB_HOSTNAME` correspond to the Password and Hostname fields, and will each be a long series of random characters. 

Navigate to the `.env` file in our project's root directory in VS Code. Comment out the existing `SQLALCHEMY_DATABASE_URI` and create a new `SQLALCHEMY_DATABASE_URI` variable that will hold our external database URL. 

```
# SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
SQLALCHEMY_DATABASE_URI=postgres://YOUR_DATABASE_USERNAME:CONNECTION-STRING.oregon-postgres.render.com/YOUR_DATABASE
```

We need to modify the start of our external database URL to work with the version of SQLAlchemy we are using. Update the beginning of our external database URL from `postgres` to `postgresql+psycopg2`.

```
# SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_development
SQLALCHEMY_TEST_DATABASE_URI=postgresql+psycopg2://postgres:postgres@localhost:5432/hello_books_test
SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://YOUR_DATABASE_USERNAME:CONNECTION-STRING.oregon-postgres.render.com/YOUR_DATABASE
```

With our `SQLALCHEMY_DATABASE_URI` variable value updated to point to our external database in Render, we can apply the generated migrations to our new Render database by running the following in our terminal.

```
(venv) $ flask db upgrade
```

After running the command, we should see a message that reads
```
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
```
as well as `Running upgrade -> <hash number>` for each migration file that was successfully applied. 

This will migrate the empty database in our remote Postgres connection to the latest schema configuration we have generated from our models. 

### !callout-info

## Updating the SQLALCHEMY_DATABASE_URI Configuration Key

`SQLALCHEMY_DATABASE_URI` is a [SQLAlchemy Configuration Key](https://flask-sqlalchemy.palletsprojects.com/en/3.1.x/config/) which allows us to customize certain settings in our app.

<br>

The value we assign to `app.config['SQLALCHEMY_DATABASE_URI']` determines which Postgres database our app runs against. When we change our `.env` so this configuration key references our remote database URL, our app shifts to run against and store data in our Render database instead of our locally hosted Postgres database. 

<br>

If we want to go back to running our app against our local Postgres database, we need to undo the changes in our `.env` file so that our code once again references our local Postgres instance.
### !end-callout

### Confirm the Migration

We should now be able to connect to our Render database with `psql` and confirm our `author` and `book` tables were created. Connect to Postgres with:

```
psql -U postgres
```

Once in the Postgres interactive terminal we can run `\c RENDER_EXTERNAL_DATABASE_URL` to connect to the database where `RENDER_EXTERNAL_DATABASE_URL` is the external database URL we copied from our Render database's dashboard earlier. We can list the database with `\dt` which should show us `book`, `author`, and `alembic_version`. 

We can display the columns of the `book` table by running `\d book` which will show `id`, `title`, `description`, and `author_id`. 

We can display the columns of the `author` table by running `\d author` which will show `id` and `name`.  

Now that we've confirmed the migration was successful, we can go back to Render and set up the environment variables that our web service requires!

## Set Environment Variables in Render

Our Render database now has the correct schema but it is still not connected to our deployed application.

Our current app sets the `SQLALCHEMY_DATABASE_URI` configuration setting using the environment variable `SQLALCHEMY_DATABASE_URI` in our `.env` file. Our Flask code accesses this environment variable with the code `os.environ.get("SQLALCHEMY_DATABASE_URI")`.

Instead of giving Render our `.env` file, we need to add our environment variables to Render using the Render dashboard.

### Find the Internal Database URL in Render

First, let's find the internal connection string that will connect to our Render database to our deployed application. 

In our database's dashboard on Render, click on the "Connect" button in the upper right corner and copy the value of the "_Internal_ Database URL."

![Screenshot of the Connections section on the Info page for our Render Postgres Database](../assets/deployment/render-copy-internal-db-connection.png)
_([Full size image](../assets/deployment/render-copy-internal-db-connection.png))_

### Set the Environment Variables in Render

Next, we need to make a `SQLALCHEMY_DATABASE_URI` environment variable in our web service application. 

Navigate to our web service application's dashboard, and click Environment in the left panel.

![Screenshot of hello-books-api dashboard](../assets/deployment/render-webservice-settings-environment.png)
_([Full size image](../assets/deployment/render-webservice-settings-environment.png))_

In the "Environment" section:

1. Click "Add Environment Variable" in the "Environment Variables" section
2. Set the key as `SQLALCHEMY_DATABASE_URI`
3. Set the value of this variable to the internal connection string we copied
4. Modify the value of the internal connection string so that the beginning reads `postgresql+psycopg2` instead of `postgres`
5. Click "Save, rebuild, and deploy"

![Screenshot of the Render dashboard at the Settings tab, showing the detail of revealed Config vars. The SQLALCHEMY_DATABASE_URI variable is present](../assets/deployment/render-webservice-environment-add-db-internal-uri.png)
_([Full size image](../assets/deployment/render-webservice-environment-add-db-internal-uri.png))_

Updating the app's environment variables will trigger our app to re-deploy. Re-deployment may take several minutes to complete. 

To find out when our app is deployed we can check: 
- our webservice's info page at the "Logs" tab, where we should see a `"Your service is live 🎉"` message when the deployment is complete. 
- our app's dashboard, where we should see an event containing a green circle with a check mark that says "Deploy live...". The `Deploy live...` message will also include the commit hash and commit message of your connected Github repo's latest commit.
- our main [Render dashboard](https://dashboard.render.com/). Under the "Status" field for our API, it should read `Deployed`.

![Screenshot of the Render Dashboard with a database and a webservice successfully deployed](../assets/deployment/render-dashboard-successfully-deployed-services.png)
_Render Dashboard with the webservice and database successfully deployed ([Full size image](../assets/deployment/render-dashboard-successfully-deployed-services.png))_


## Verify

Our Flask project is on a Render machine, running, and connected to an initialized database. Now is the time to verify whether our API is accessible by web!

### Use the Browser

We can use the browser to make `GET` requests to any endpoint defined in our project, now using our deployed Render URL instead of `localhost`.

We can find our URL on our deployed application's dashboard, listed just under the name of our web service application. Render URLs will take the form `https://your-app-name.onrender.com` Our demonstration has the URL `https://hello-books-api-1.onrender.com`. We suspend or remove deployed projects when not in use, so we should expect to see an error if we try navigating to the demonstration URL.

![Screenshot of Render URL for deployed hello-books-api application with copy to clipboard message](../assets/deployment/render-copy-deployed-webservice-url.png)
_([Full size image](../assets/deployment/render-copy-deployed-webservice-url.png))_

### !callout-warning

## Routing Configurations May Result in a `404 Not Found`
Recall that Flask routes are very picky about `/` characters. Some browsers will try to put a `/` character at the end of an address automatically. Depending on how our routes are set up, this might result in a route mismatch.

<br />

Also note that our API does not define the endpoint for our base URL, thus sending a `GET` request to our base Render URL `https://your-app-name.onrender.com/` will result in a `404 Not Found` error. However sending a `GET` request to `https://your-app-name.onrender.com/books` should return a `200 OK` status code because our project defines that route.

<br />

Our Flask API isn't _intended_ to be used through a web browser. It's meant to be used programmatically. It's convenient if testing through a browser works, but if it doesn't we can move on to test with Postman.

### !end-callout

Instead of `localhost:5000/books`, we can visit `https://your-app-name.onrender.com/books`, where `your-app-name` is the name of your deployed Render app.

![Screenshot of the browser open to the deployed API, showing a response of an empty JSON array](../assets/deployment/browser-hitting-books-endpoint-no-results.png)
_([Full size image](../assets/deployment/browser-hitting-books-endpoint-no-results.png))_

### !callout-info

## No Book Data

Our app has zero books listed when we go to `/books`, even though our app is deployed correctly and connected to our Postgres database correctly.

<br />


<details>

<summary>Why are there no books listed?</summary>

<br />

Recall that our deployed app is connected to a Postgres database that we created a few steps ago! We have not added any book data to our Render database. Even if our local database is full of books, our Render app's database connection string points at the Render database. 

</details>

### !end-callout

### Use Postman

We can use Postman to make and verify all sorts of HTTP requests to our API!

### Use Render Logs

During local development on our own machines, when we ran `$ flask run`, the server's logs were output into our terminal. We could see the details about every HTTP request our server received and every HTTP response it returned. We could also see output for any errors.

We can access the server logs of our Render app from our app's Render dashboard by finding the "More" menu and selecting "Logs."

It reports the HTTP requests, responses, and errors that our Render app encounters.

![Screenshot of the Render logs, showing examples of different HTTP requests and responses](../assets/deployment/render-webservice-dash-show-requests-in-logs.png)
_([Full size image](../assets/deployment/render-webservice-dash-show-requests-in-logs.png))_

## Updating the Render Remote Workflow

When we practice _continuous deployment_, we must adopt the practice of regularly updating the Git history of our Render app.

We can summarize our local development workflow like this:

1. Activate our virtual environment
1. Pull down any new commits from Git
1. Run tests
1. Write code
1. Make Git commits
2. Push our Git history to the `origin` remote, which is our repo on GitHub
3. Verify our deployment

## General Deployment Tools

We can continue to use the browser and Postman to create HTTP requests and check their HTTP responses!

### Render Tools in the Dashboard

The Render dashboard includes:

- Access to app dashboards for deployed apps
- Access to the Render logs
- Management of environment variables
- "Events" which will show the timeline of recent deployments

## General Render Debugging Strategies

Sometimes, after deployment, our deployed app doesn't behave as expected. This could be a bug, and it could also be our web server catching an exception.

Our deployed apps can encounter problems ranging from:

- Problems with our own Flask code, such as broken syntax or buggy features
- Our database not being connected or initialized properly
- Our Render machine not downloading and installing the correct dependencies
- Render.com itself being down, or improper use of Render tools

In those situations, here is a starting point for debugging and determining what is causing the deployment error:

| <div style="min-width:200px;">Debugging Action</div>                          | Details                                                                                                                                                                                                                                            |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Check the logs                            | The logs will show error messages that the web server outputs. These messages could share details such as Python `NameError`s, database connection errors, problems with running the Flask app, problems with downloading the right packages, etc. |
| See if you can recreate it locally        | Attempt to recreate the problem locally, by running `$ flask run` on your own local machine. Error messages may be more detailed on our local machine. Also, concluding that you're **unable to recreate the issue** is valuable in itself!        |
| Check the status of the Git history       | Confirm that the remote Git history is up-to-date.                                                                                                                        |
| Internet research!                        | Render has a large community of support, and a lot of documentation on deploying Flask apps and using Postgres databases. Be sure to use the Internet and to rubber duck with others.                                                              |
| Take notes of each debugging attempt      | It can be challenging to remember what you've tried on the Render machine. Write down and record all of the ways you've attempted to fix the problem.                                                                                              |
| Rubber duck, and post questions on Slack! | Debugging deployment usually depends on context. Rubber duck and connect with folks who are deploying similar projects to you!                                                                                                                     |
### Running `gunicorn` locally

Running your app locally with `gunicorn` can be a great way to help troubleshoot whether the commands and values we've supplied in the Render configuration are working. 

To do so, we need to set the required environment variables, such as the `SQLALCHEMY_DATABASE_URI`. Any of the values we've been setting in the `.env` file are being loaded by the `dotenv` library to look as though they are environment variables. Nothing is loading the values in the `.env` when `gunicorn` is hosting our flask app, so we need to set them ourselves. 

Environment variables can be set for the duration of a single command by listing them as name-value pairs before the actual command to run. To invoke gunicorn locally, we might use the command:   

```sh
$ SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://postgres@localhost:5432/hello_books_development gunicorn "app:create_app()"
```

The command above will: 
1. set a temporary environment variable named `SQLALCHEMY_DATABASE_URI` to the value `postgresql+psycopg2://postgres@localhost:5432/hello_books_development`. This environment variable will not exist in the environment after the command that follows completes.
2. invoke `gunicorn` with the command line argument `"app:create_app()"` to tell `gunicorn` how we want to start up our application.

## Check for Understanding

<!-- prettier-ignore-start -->
### !challenge
* type: checkbox
* id: CSpfam
* title: Deploying to Render
##### !question

Check all of the options that are recommended debugging steps when troubleshooting our deployed application.

##### !end-question
##### !options

* Try to recreate the issue on your local machine
* Check the Render server logs
* Check the local server logs
* Confirm that recent, working code is pushed up to the `origin` remote
* Copy and paste the error messages and look it up on the Internet
* Push all code to the `Render` remote

##### !end-options
##### !answer

* Try to recreate the issue on your local machine
* Check the Render server logs
* Confirm that recent, working code is pushed up to the `origin` remote
* Copy and paste the error messages and look it up on the Internet

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
