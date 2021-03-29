# Flask Setup

## Goals

The goal of this lesson is to introduce the setup steps for a Flask project, and pair each setup step with any commands or instructions that must be run.

## Format

This lesson covers:

1. How to install dependencies
   - Inside a virtual environment
   - From `requirements.txt`
1. How to run, stop, and restart a Flask server
1. How to read the server logs
1. Considerations for where different parts of code go

## Install Dependencies

Whenever we work on a Python project, we need to be considerate of how we manage dependencies. Working with the `flask` package is enough reason to visit virtual environments.

### In a Virtual Environment

At the very beginning of a Python project, we will either:

1. Clone the project repo onto our machine, which creates a project folder
1. Create a new, empty project folder

Once we `cd` into the project folder, we can create a virtual environment. To make a conventional virtual environment named `venv`, we can use the following command:

```
$ python3 -m venv venv
```

We can activate and deactivate this virutal environment with these commands:

```bash
### Activate ###
$ source venv/bin/activate
(venv) $
(venv) $ # should see (venv) now

### Deactivate ###
(venv) $ deactivate
$
$ # should stop seeing (venv)
```

### From `requirements.txt`

Python projects will conventionally record all of their project dependencies in a file named `requirements.txt`.

These files will list the exact packages and their version numbers to download and install into this environment.

Here is a sample `requirements.txt`:

```
alembic==1.5.4
autopep8==1.5.5
click==7.1.2
Flask==1.1.2
Flask-Migrate==2.6.0
Flask-SQLAlchemy==2.4.4
itsdangerous==1.1.0
Jinja2==2.11.3
Mako==1.1.4
MarkupSafe==1.1.1
psycopg2==2.8.6
pycodestyle==2.6.0
python-dateutil==2.8.1
python-dotenv==0.15.0
python-editor==1.0.4
six==1.15.0
SQLAlchemy==1.3.23
toml==0.10.2
Werkzeug==1.0.1
```

At the beginning of the project, or after any updates to this file, we install all dependencies with:

```bash
(venv) $ pip install -r requirements.txt
```

If we've introduced a new dependency into this project, we should update our `requirements.txt` file. This way, our team members can also learn which exact packages are required now.

To update the `requirements.txt` file, we use this command:

```bash
(venv) $ pip freeze > requirements.txt
```

## Running, Stopping, and Restarting the Server

Building an API means that we're building a web server. A web server needs to be _running_ in order to be accessible to clients. When a server is running, we'll know the full request URL for HTTP requests.

### Running the Server

When a server starts running, it runs start-up commands, such as rebuilding the app from its configuration files.

To run a Flask server, we run this command:

```bash
(venv) $ flask run
```

### !callout-info

## Default Flask Server URL is `localhost:5000`

By default, running Flask servers will be available on `localhost:5000`. This means that our clients will send HTTP requests to `localhost:5000`. "Localhost" is a special name used to refer to the computer itself.

### !end-callout

Once we start running a server, the current Terminal tab begins to _tail_ the server logs. The servers will log status updates about the server's operations.

In order for us to run command-line commands like git, we'll need to open a new Terminal window, tab, or stop the server.

### Stopping the Server

When we stop a server, the server runs its shut down operations. Then, it's unavailable to clients.

To stop a Flask server, we return to the Terminal tab or window that is running the server, and we either:

- Use `ctrl` + `c`
- Close or quit the terminal tab or window

### "Restarting" the Server

"Restarting the server" usually means stopping and starting the server again.

## Reading the Server Logs

We can use the server logs to debug our server code. Any error messages that our server needs to print will go here.

The server logs update in real-time. These are the logs immediately after receiving a `GET` request to `localhost:5000/`, which produced a `200` response.

![](../assets/building-an-api_flask-setup_server-logs-200.png)

These are the logs immediately after a `GET` request to `localhost:5000/i-didnt-define-this-endpoint-in-my-server-code`, which produced a `404` response.

![](../assets/building-an-api_flask-setup_server-logs-404.png)

These are the logs immediately after a `GET` request to `localhost:5000/broken-endpoint-with-broken-server-code`, which raised an error in our server code.

![](../assets/building-an-api_flask-setup_server-logs-500.png)

We can focus on the error message at the bottom here to trace our error:

```bash
  File "/hello_world_api/app/routes.py", line 17, in broken_endpoint
    return 10 / 0
ZeroDivisionError: division by zero
```

In this example, it seems that we have a `ZeroDivisionError` caused in a method named `broken_endpoint`, on line 17, in the file `/hello_world_api/app/routes.py`.

## Where Does Code Go: Endpoints

When we work on Flask projects, there could be anywhere between one file, to hundreds of files and folders.

Where our code that defines endpoints will **depend on the project**.

### !callout-warning

## Every Project Structure is Different

Flask does not enforce one specific file and folder structure. We'll have to go exploring to figure out where to put our code for each project.

### !end-callout

This curriculum will provide a suggested project structure and location:

```
.
├── README.md
├── app
│   ├── __init__.py
│   └── routes.py
└── requirements.txt
```

Inside each `app` folder, there will be a file named `routes.py`. The responsibility of this file is to define the endpoints.

## Where Does Code Go: Config

As we develop our Flask projects, we'll need to reconfigure the app to suit our needs better. Configurations to the app can include things like, "Where's the location to our database?," "How do we load different data models?," or "How can we set up template views, called Blueprints?"

Where our code that defines any configuration, again, **heavily depends on the project**.

This curriculum will provide a suggested project structure and location:

```
.
├── README.md
├── app
│   ├── __init__.py
│   └── routes.py
└── requirements.txt
```

Inside each `app` folder, there will be a file named `__init__.py`. The responsibility of this file is to define the start-up logic for the Flask server.

### !callout-info

## Changing Configurations is Rare

It isn't often that developers need to fuss with configurations; web developers should become familiar of configuration files. It's more important to know _where_ existing configurations are made, rather than being able to write fresh and new configurations.

### !end-callout

In a sample Flask application, there may be a file (possibly `app/__init__.py`) that looks like this:

```python
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()


def create_app():
    app = Flask(__name__)
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
    app.config["SQLALCHEMY_DATABASE_URI"] = "... Some Path to Postgres Database ..."

    db.init_app(app)
    migrate.init_app(app, db)

    with app.app_context():
        db.create_all()

    return app
```

This code:

- Creates a `db` reference and a `migrate` reference, which will be used to work with the db
- Creates a function named `create_app()`
- Creates a `app` reference, which is the instance of our Flask app
- Configures the app's connection to a database
- Initializes our database and migration features

## Dev Workflow

Our modified dev workflow for Flask development may now look like this:

1. `cd` into a project root folder
1. Activate a virtual environment
1. Check git status
1. Start the server
1. Cycle frequently between:
   1. Writing code
   1. Checking git statuses and making git commits
   1. Debugging with Postman, server logs, VS Code, and more
1. Stop the server
1. Deactivate the virtual environment

## Check for Understanding

<!-- Question 1 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: Lg4wGD
* title: Flask Setup
##### !question

Arrange the options below so that they match these terms in this order:

1. Command to create a virtual environment
1. Command to install the project's dependencies
1. Command to start running the Flask server

##### !end-question
##### !answer

1. `$ python3 -m venv venv`
1. `$ pip install -r requirements.txt`
1. `$ flask run`

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->

<!-- Question 2 -->
<!-- prettier-ignore-start -->
### !challenge
* type: ordering
* id: kzm8zw
* title: Flask Setup
##### !question

Arrange the options below so that they match these terms in this order:

1. The location where clients should send HTTP requests, for a default Flask server
1. The location where the server logs print
1. The location for Python code that defines routes and configuration

##### !end-question
##### !answer

1. `localhost:5000`
1. Terminal
1. It depends on the project

##### !end-answer
### !end-challenge
<!-- prettier-ignore-end -->
