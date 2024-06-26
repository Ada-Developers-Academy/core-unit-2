# Resolving Schema Conflicts

### !callout-info

### Source: Miguel Grinberg's Blog

This solution and explanation to resolving schema conflicts is taken from [Miguel Grinberg's blog](https://blog.miguelgrinberg.com/post/resolving-database-schema-conflicts). 
</br>
</br>
We made a few minor changes to the wording, we changed the example model from `User` to `Book`, and we changed the names of the two developers to Ada instructors.

### !end-callout

## Goals

Our goal for this lesson is to describe one method for resolving database schema conflicts.

## Introduction

If you work on a project that uses database migrations with other developers, it is likely that you have experienced migration conflicts at some point. These occur when two or more developers are merging unrelated features to the master source control branch at around the same time, with each feature requiring different changes to the database.

### !callout-info

## Avoid Conflicts

No matter how careful we are, we will encounter conflicts. 

However, here are a few tips to help avoid conflicts in the database schema:
* `git pull` often
  * especially, `git pull` before applying changes to the model with `flask db migrate`
* Work on updates to the models together
  * We strongly recommend using pair programming for every change you make to a model in a group project.
  * Even if working on separate models, conflicts to the database schema can arise.

### !end-callout

### !callout-info

## Drop Database

This resource outlines a solution for resolving database schema conflicts. 

While less ideal, it is perfectly reasonable to resolve database schema conflicts for our development database by recreating the database and the migrations with the following commands:

```bash
$ psql -U postgres postgres
$ drop database hello_books_development;
$ create database hello_books_development;
$ \q
$ rm -rf migrations
$ flask db init
$ flask db migrate -m "Recreate model migrations"
$ flask db upgrade
```

### !end-callout

### !callout-info

## This Lesson is a Resource

This lesson is a resource to use when you run into database schema conflicts. We highly recommend that you wait until you run into a conflict to review the content below. You can skip to one solution to resolving a database schema conflict [here](#how-to-resolve-a-schema-conflict-with-a-merge).

### !end-callout

## The Problem

Let's say we have a team of two developers working on different features of a library application. Audrey, for example, needs to add the author attribute to books, while Trenisha needs to add an ISBN (a number used to track book barcodes) to each book. The two developers start working on their features at about the same time, each on a freshly cloned copy of the team's git repository.

At the time Audrey and Trenisha clone the project to start their work, the project has a Book model that looks like this:

```python
class Book(db.Model):
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    title: Mapped[str]
    description: Mapped[str]
```

They are using Flask-SQLAlchemy as ORM, and Flask-Migrate to track migrations to the database. The database migration history at the time both developers begin working on their features includes a single migration:

```
$ flask db history
<base> -> f9e86c06ab0d (head), add book table
```

Now Audrey and Trenisha get to work on their features. Audrey needs to add an author to the Book model, so one of the very first things she does is to edit the model as follows:

```python
class Book(db.Model):
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    title: Mapped[str]
    description: Mapped[str]
    author: Mapped[str]
```

Immediately after editing the model, she generates and applies a database migration, to make this change on her development database:

```
$ flask db migrate -m "add author to book"
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.ddl.postgresql] Detected sequence named 'book_id_seq' as owned by integer column 'book(id)', assuming SERIAL and omitting
INFO  [alembic.autogenerate.compare] Detected added column 'book.author'
  Generating /hello-books-
  api/migrations/versions/bf69b044cdfc_add_author_to_book.py ...  done

$ flask db upgrade
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.runtime.migration] Running upgrade f9e86c06ab0d -> bf69b044cdfc, add author to book
```

She then checks the database migration history to make sure the change was applied:

```
$ flask db history
f9e86c06ab0d -> bf69b044cdfc (head), add author to book
<base> -> f9e86c06ab0d, add book table
```

So Audrey happily goes off to work on adding authors.

Meanwhile, Trenisha needs to add an ISBN for all the books, so starting from the same Book model as Audrey, she makes the following change on her development environment:

```python
class Book(db.Model):
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    title: Mapped[str]
    description: Mapped[str]
    isbn: Mapped[int]
```

And she also creates a database migration for this change:

```
$ flask db migrate -m "add isbn to book"
INFO  [alembic.autogenerate.compare] Detected added column 'book.isbn'
  Generating migrations/versions/73c1f8470b04_add_isbn_to_book.py ... done

$ flask db history
f9e86c06ab0d -> 73c1f8470b04 (head), add isbn to book
<base> -> f9e86c06ab0d, add book table
```

Let's assume that Trenisha finishes her work first, and pushes the book changes to the upstream repository. 

When Audrey completes her work on the book author, she tries to push to master and gets an error that tells her that her source tree is out of date. So she does a `git pull`, and then tries to push again. This time the push succeeds. To apply to new migrations she runs `flask db upgrade`, and sees that it fails silently:

```
$ flask db upgrade
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
```

Sure enough, she did not realize this, but even her own source tree got into a weird state after she pulled in Trenisha's change:

```
$ flask db history
f9e86c06ab0d -> bf69b044cdfc (head), add author to book
f9e86c06ab0d -> 73c1f8470b04 (head), add isbn to book
<base> -> f9e86c06ab0d (branchpoint), add book table
```

So what happened here? As you see above, the migration history is not linear anymore. Migration `f9e86c06ab0d` was the starting migration for both Audrey and Trenisha, so both their migrations are based on this change, creating a branched migration history with two heads.

It's interesting to note that when Audrey pulled Trenisha's change git did not complain. These schema migrations are stored each in its own file, so git did not see conflicts in Audrey's change and allowed her change to be merged, causing the project to break. Not nice, right?

Notice that in Audrey's database, there is no `isbn` column.

```
$ SELECT * FROM book;
 id | title | description | author 
----+-------+-------------+--------
(0 rows)
```

Likewise in Trenisha's database, there is no `author` column.



## How to Resolve a Schema Conflict with a Merge

Let's help Audrey with her situation. Because she applied her migration before pulling in Trenisha's changes, her database is aligned with one of the two branched heads in the migration history. Trenisha's migration is in the other branch, so it can't be applied through an upgrade.

There are a couple of ways to unlock Audrey's database. Recent releases of Alembic and Flask-Migrate support the merge command, which creates yet another migration that joins these multiple heads, creating a diamond shape. To get everything back in order with a merge, you need to run this command:

```
$ flask db merge heads -m "merge migrations with isbn and author"
  Generating /hello-books-api/migrations/versions/009c1afa3037_merge_migrations_with_isbn_and_author.py ...  done
```

And then after that, doing an upgrade works fine:

```
$ flask db upgrade
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.runtime.migration] Running upgrade f9e86c06ab0d -> 73c1f8470b04, add isbn to book
INFO  [alembic.runtime.migration] Running upgrade bf69b044cdfc, 73c1f8470b04 -> 009c1afa3037, merge migrations with isbn and author
```

If you look at the updated migration history, you will notice that the branches remain in the history behind the new merge migration:

```
$ flask db history
bf69b044cdfc, 73c1f8470b04 -> 009c1afa3037 (head) (mergepoint), merge migrations with isbn and author
f9e86c06ab0d -> bf69b044cdfc, add author to book
f9e86c06ab0d -> 73c1f8470b04, add isbn to book
<base> -> f9e86c06ab0d (branchpoint), add book table
```

Committing this new migration and pushing it to the team's git repository will address the problem and allow the deployment script to apply the migrations correctly.


### !callout-info

## How to Resolve a Schema Conflict By Editing the Migration History

For a second solution to resolving database schema conflicts, see the second solution in [Miguel Grinberg's blog post](https://blog.miguelgrinberg.com/post/resolving-database-schema-conflicts).

### !end-callout