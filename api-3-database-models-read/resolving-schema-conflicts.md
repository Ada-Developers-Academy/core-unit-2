# Instructor: Resolving Schema Conflicts

***Solution needs to be verified and updated with `Book` model examples***

### !callout-info

### Source: Miguel Grinberg's Blog

This solution and explanation to resolving schema conflicts is taken from [Miguel Grinberg's blog](https://blog.miguelgrinberg.com/post/resolving-database-schema-conflicts). 
</br>
</br>
We have only changed the example model from `User` to `Book` and the names of the two developers.

### !end-callout

## Goals

Our goal for this lesson to describe one method for resolving database schema conflicts.

### !callout-info

## Resource

This lesson is a resource to use when you run into database schema conflicts. You can review it now, or wait to review it until you run into a conflict.

### !end-callout

## Introduction

If you work on a project that uses database migrations with other developers, it is likely that you have experienced migration conflicts at some point. These occur when two or more developers are merging unrelated features to the master source control branch at around the same time, with each feature requiring different changes to the database.

## The Problem

Let's say we have a team of two developers working on different features of an application. Audrey, for example, needs to implement the user authentication subsystem, while Trenisha needs to add avatars for each user. The two developers start working on their features at about the same time, each on a freshly cloned copy of the team's git repository.

At the time Audrey and Trenisha clone the project to start their work, the project has a User model that looks like this:

```python
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128))
```

They are using Flask-SQLAlchemy as ORM, and Flask-Migrate to track migrations to the database. The database migration history at the time both developers begin working on their features includes a single migration:

```
$ flask db history
<base> -> 279ebc64991a (head), add user table
```

Now Audrey and Trenisha get to work on their features. Audrey needs to add password hashes to the User model, so one of the very first things she does is to edit the model as follows:

```python
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128))
    password_hash = db.Column(db.String(64))
```

Immediately after editing the model, she generates and applies a database migration, to make this change on her development database:

```
$ flask db migrate -m "add password hashes to users"


INFO  [alembic.autogenerate.compare] Detected added column 'user.password_hash'
  Generating migrations/versions/d3868407e935_add_password_hashes_to_users.py ... done

$ flask upgrade
INFO  [alembic.runtime.migration] Running upgrade 279ebc64991a -> d3868407e935, add password hashes to users
```

She then checks the database migration history to make sure the change was applied:

```
$ flask db history
279ebc64991a -> d3868407e935 (head), add password hashes to users
<base> -> 279ebc64991a, add user table
```

So Audrey happily goes off to work on adding password hashes.

Meanwhile, Trenisha needs to add avatar URLs for all the users, so starting from the same User model as Audrey, she makes the following change on his development environment:

```python
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128))
    avatar = db.Column(db.String(256))
```

And she also creates a database migration for this change:

```
$ flask db migrate -m "add user avatars"
INFO  [alembic.autogenerate.compare] Detected added column 'user.avatar'
  Generating migrations/versions/678d339a120f_add_user_avatars.py ... done

$ flask db history
279ebc64991a -> 678d339a120f (head), add user avatars
<base> -> 279ebc64991a, add user table
```

Let's assume that Trenisha finishes his work first, and pushes the user avatar changes to the upstream repository. This commit triggers an automatic deployment to a staging server, where Trenisha goes and checks that user avatars are working fine. She finds no problems, so she goes to find other work.

When Audrey completes her work on user authentication, she tries to push to master and gets an error that tells her that her source tree is out of date. So she does a git pull --rebase, and then tries to push again. This time the push succeeds, so then she anxiously waits for the staging server to update so that she can check her work before moving on. But something bad happened, the deployment to the staging server failed horribly.

Can you see why? When Audrey goes to check the logs of the failed deployment, this is what she finds:

```
$ flask db upgrade
Traceback (most recent call last):
    ...
alembic.script.revision.MultipleHeads: Multiple heads are present for given argument 'head';
678d339a120f, d3868407e935
```

And sure enough, she did not realize this, but even her own source tree got into a weird state after she pulled in Trenisha's change:

```
$ flask db history
279ebc64991a -> 678d339a120f (head), add user avatars
279ebc64991a -> d3868407e935 (head), add password hashes to users
<base> -> 279ebc64991a (branchpoint), add user table
```

So what happened here? As you see above, the migration history is not linear anymore. Migration 279ebc64991a was the starting migration for both Audrey and Trenisha, so both their migrations are based on this change, creating a branched migration history with two heads.

It's interesting to note that when Audrey pulled Trenisha's change git did not complain. These schema migrations are stored each in its own file, so git did not see conflicts in Audrey's change and allowed her change to be merged, causing the project to break. Not nice, right?

## How to Detect Schema Conflicts Before They are Committed
Before I tell you how to untangle this schema mess, let's think about Audrey's actions. Could she or her team have done anything different to prevent conflicts like this from ever appearing in the team's repository?

There are certainly ways to prevent this type of conflicts. A migration history test could be written to find this and other problems with migrations. This is a test that creates an empty database, and simply applies all the migrations in order, to ensure that they all run fine. The test can then downgrade the database all the way back to its initial state, to also test downgrades, something that very few people check. A migration history test can be included as part of the application's unit test suite, or as a source control pre-commit check.

## How to Resolve a Schema Conflict with a Merge

<details>
    <summary>Expand for instructions on how to resolve a schema conflict with a merge</summary>

While detecting these conflicts before they are pushed to the shared repository is important, let's not forget about Audrey's situation. Because she applied her migration before pulling in Trenisha's changes, her database is aligned with one of the two branched heads in the migration history. Trenisha's migration is in the other branch, so it can't be applied through an upgrade.

There are a couple of ways to unlock Audrey's database. Recent releases of Alembic and Flask-Migrate support the merge command, which creates yet another migration that joins these multiple heads, creating a diamond shape. To get everything back in order with a merge, you need to run this command:

```
$ flask db merge -m "merge migrations from Audrey and Trenisha" 678d339a120f d3868407e935
  Generating migrations/versions/66fd23fca675_merge_migrations_from_mary_and_david.py ... done
```

And then after that, doing an upgrade works fine:

```
$ flask db upgrade
INFO  [alembic.runtime.migration] Running upgrade 279ebc64991a -> 678d339a120f, add user avatars
INFO  [alembic.runtime.migration] Running upgrade 678d339a120f, d3868407e935 -> 66fd23fca675, merge migrations from audrey and trenisha
```

If you look at the updated migration history, you will notice that the branches remain in the history behind the new merge migration:

```
$ flask db history
678d339a120f, d3868407e935 -> 66fd23fca675 (head) (mergepoint), merge migrations from audrey and trenisha
279ebc64991a -> 678d339a120f, add user avatars
279ebc64991a -> d3868407e935, add password hashes to users
<base> -> 279ebc64991a (branchpoint), add user table
```

Committing this new migration and pushing it to the team's git repository will address the problem and allow the deployment script to apply the migrations correctly.

</details>

## How to Resolve a Schema Conflict By Editing the Migration History

<details>
    <summary>Expand for instructions on how to resolve a schema conflict with a merge</summary>


"Let's look at the state of the migration history on Audrey's environment when she found she had a conflict:

```
$ flask db history
279ebc64991a -> 678d339a120f (head), add user avatars
279ebc64991a -> d3868407e935 (head), add password hashes to users
<base> -> 279ebc64991a (branchpoint), add user table
```

Her database is synced to migration d3868407e935, which is one of the two heads:

```
$ flask db current
d3868407e935 (head)
```

To unlock the migration history, all that needs to be done is to alter the order of the migrations, so that these two migrations by Trenisha and Audrey happen one after the other. Because Trenisha was first to commit her migration, the correct thing to do is to move Audrey's migration after Trenisha's.

The first step to reorder the migrations is to move the database back one migration, so that it isn't inside Audrey's branch anymore:

```
$ flask db downgrade
INFO  [alembic.runtime.migration] Running downgrade d3868407e935 -> 279ebc64991a, add password hashes to users
```

With this command, the changes that Audrey made to her database are removed. The next step involves manual editing of Audrey's migration script, which is in file `migrations/versions/d3868407e935_add_password_hashes_to_users.py`. The first few lines of this script are:

```python
"""add password hashes to users

Revision ID: d3868407e935
Revises: 279ebc64991a
Create Date: 2016-02-09 22:13:25.135581

"""


# revision identifiers, used by Alembic.
revision = 'd3868407e935'
down_revision = '279ebc64991a'

# ...
```

The important part here is the revision that is set as the down_revision, which is the migration that comes right before it in the history. To move this migration script after Trenisha's, all that needs to be done is to replace revision 279ebc64991a with Trenisha's revision code, which is 678d339a120f. After you edit the two occurrences of the previous migration, the migration script should look like this:

```python
"""add password hashes to users

Revision ID: d3868407e935
Revises: 678d339a120f
Create Date: 2016-02-09 22:13:25.135581

"""

# revision identifiers, used by Alembic.
revision = 'd3868407e935'
down_revision = '678d339a120f'

# ...
```

And with that change saved, the migration history has been reordered and is again nice and sequential:

```
$ flask db history
678d339a120f -> d3868407e935 (head), add password hashes to users
279ebc64991a -> 678d339a120f, add user avatars
<base> -> 279ebc64991a, add user table
```

And now an upgrade cleanly applies Trenisha's migration and then Audrey's:

```
$ flask db upgrade
INFO  [alembic.runtime.migration] Running upgrade 279ebc64991a -> 678d339a120f, add user avatars
INFO  [alembic.runtime.migration] Running upgrade 678d339a120f -> d3868407e935, add password hashes to users
```

At this point, the schema migrations are back in order and can be pushed to the team's repository to address the breakage.
</details>
