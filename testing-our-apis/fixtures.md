# Fixtures

## Goals

This lesson is a brief introduction to `pytest` [fixtures](https://docs.pytest.org/en/stable/fixture.html), which help us share setup and cleanup steps (our arrange steps) among multiple tests.

After this lesson we should be able to:

- Write simple test fixtures
- Declare that a test depends on a particular fixture

## Introduction

When testing Flask APIs, we will need to do some setup to tell our server to run in test mode. We'll also need to get a way to issue requests to our server from within our tests. The setup for these steps is the same for every test, so it would be nice if we could share this setup between multiple tests.

There are many ways we could do this.

We could write the setup logic once, then copy it into each test that needs it. But if we needed to make a change, we would have to modify every test!

We could write helper functions that we call from within each test. But if we have additional setup to do for certain tests, it might become more difficult to notice that we are using the shared setup in certain tests.

And if we have custom setup, it might be necessary to have custom cleanup. Now we need to have setup calls both at the beginning of the test, and at the end. What if we forget to add the cleanup code? This could lead to later tests failing in a way that can be difficult to track down!

It would be nice if we could package our setup and cleanup together as a single unit, and have our tests unambiguously declare that they use that setup and cleanup.

This is what `pytest` fixtures do!

## Vocabulary and Synonyms

| Vocab                | Definition                                                                                   | Synonyms                 | How to Use in a Sentence                                                                                                                  |
| -------------------- | -------------------------------------------------------------------------------------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Fixture              | Shared code used to perform setup and cleanup for tests.                                     | Setup code, Cleanup code | "We're doing a lot of the same setup and cleanup in these tests. Let's refactor that into fixtures that can be shared among all of them!" |
| Dependency           | In this context, a fixture listed as one of the parameters in a test function.               | -                        | "My test was failing because I forgot to list one of its dependencies in the parameter list."                                             |
| Dependency Injection | A way for code to explicitly declare and receive the resources it needs to run successfully. | -                        | "My tests receive the resources they need because `pytest` automatically injects the dependencies."                                       |

## Creating Basic Fixtures

We create a fixture with the `@pytest.fixture` decorator.

Let's create a small test file that we'll use to experiment for this lesson. We'll only use this test file during this lesson, and we'll delete it at the end. In the project root of our Hello Books API project, let's run `touch test_fixtures.py` to create a new file, then paste in the following code.

```python
import pytest

@pytest.fixture
def empty_list():
    return []

def test_len_of_empty_list(empty_list):
    assert isinstance(empty_list, list)
    assert len(empty_list) == 0
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                    |
| --------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `import pytest`                                     | Imports the `pytest` module                                                                                                                                                              |
| `@pytest.fixture`                                   | Applies the fixture decorator to the `empty_list` function. `pytest` will be able to use `empty_list` as a fixture in subsequent tests.                                                  |
| `def empty_list(): ...`                             | Declares the `empty_list` function, which returns an empty list.                                                                                                                         |
| `def test_len_of_empty_list( ... ): ...`            | Declares a test function that `pytest` will be able to detect. It begins with `test_`.                                                                                                   |
| `empty_test`                                        | This parameter matches the name of the `empty_list` fixture. When `pytest` runs this test it will first run the `empty_list` fixture and use the result as the value for this parameter. |

Because we're in the Hello Books API project, we know that the `pytest` command is available. Let's make sure our virtual environment is active. Then, let's run this test file with `pytest test_fixtures.py`.

Running the test file, we should see results similar to:

```
=========================== test session starts ===========================
platform darwin -- Python 3.9.2, pytest-6.2.2, py-1.10.0, pluggy-0.13.1
rootdir: .
collected 1 item

test_fixtures.py .                                                  [100%]

============================ 1 passed in 0.01s ============================
```

The test passed!

What does this tell us?

We see that the `test_len_of_empty_list` asserts a few things. The first is that the value in the `empty_list` parameter must be an instance of `list`. Second, the length of the value in `empty_list` must be zero. Both assertions must have been true, or else the test would have failed! But how did a value get passed in to the the test?

`pytest` did it by matching the name of the parameter `empty_list` to the function `empty_list` that we registered as a fixture with `@pytest.fixture`. Just before `pytest` runs a test, it looks at the parameters the test declares and tries to find a fixture with a matching name.

If a matching fixture is found, it is run, and the return value is used as the parameter value. If no matching fixture is found, `pytest` will report an error during the setup of that test. We can see this if we comment out the `empty_list` function, or even only the `@pytest.fixture` line, and try to run the test again.

## Fixtures With Dependencies

In our basic setup, we listed a dependency for our test by adding a parameter name. We can do the same for fixtures themselves.

Let's add the following fixture and test to our `test_fixtures.py` file.

```python
@pytest.fixture
def one_item(empty_list):
    empty_list.append("item")
    return empty_list

def test_len_of_unary_list(one_item):
    assert isinstance(one_item, list)
    assert len(one_item) == 1
    assert one_item[0] == "item"
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                                             |
| --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `@pytest.fixture`                                   | Registers the following function `one_item` as a fixture                                                                                                                                                                          |
| `def one_item( ... ): ...`                          | Declares the `one_item` function. It receives a parameter `empty_list` to which it appends the string `"item"` and then returns it.                                                                                               |
| `empty_list`                                        | The parameter to `one_item` which matches the name of the previously registered `empty_list` fixture. `pytest` will call the `empty_list` fixture, and pass the result in as this parameter whenever this fixture itself is used. |
| `def test_len_of_unary_list( ... ): ...`            | Declares a test function that `pytest` will be able to detect. It begins with `test_`.                                                                                                                                            |
| `one_item`                                          | This parameter matches the name of the `one_item` fixture. When `pytest` runs this test it will first run the `one_item` fixture, which itself depends on `empty_list`, and use the result as the value for this parameter.        |

As before, we can run the test file with `pytest test_fixtures.py` and we should see it pass, this time with two tests running.

Let's examine what this new test is doing.

We see that the `test_len_of_unary_list` asserts a few things about the `one_item` parameter. First, it must be an instance of `list`. Second, the length of the value in `one_item` must be one. Finally, it checks that the string `"item"` is in index zero. All three assertions must have been true.

`pytest` performed the same parameter name matching step that it did for `test_len_of_empty_list`. It found the `one_item` parameter and matched it to the fixture with the same name.

When it went to run that fixture it saw that the `one_item` fixture itself had a parameter `empty_list`. It once more checked for a matching fixture, and ran it. The result of `empty_list` (an empty list) was supplied as the parameter to `one_item`, which inserted the `"item"` value and returned the result. This result became the input to `test_len_of_unary_list`.

As before, if no matching fixture is found at any point in running the fixtures, `pytest` will report an error during the setup of the test it was trying to run.

By adding parameters to our fixtures, we can modularize our fixture setup. This lets us use the same parts of our setup in different, customized setups for a greater variety of tests!

## Fixtures With Cleanup

One more benefit about fixtures is their ability to keep setup and cleanup code together, and to ensure that if the setup code runs, so will the cleanup.

Let's add the following code to our `test_fixtures.py` file.

```python
class FancyObject:
    def __init__(self):
        self.fancy = True
        print(f"\nFancyObject: {self.fancy}")

    def or_is_it(self):
        self.fancy = not self.fancy

    def cleanup(self):
        print(f"\ncleanup: {self.fancy}")

@pytest.fixture
def so_fancy():
    fancy_object = FancyObject()

    yield fancy_object

    fancy_object.cleanup()

def test_so_fancy(so_fancy):
    assert so_fancy.fancy
    so_fancy.or_is_it()
    assert not so_fancy.fancy
```

| <div style="min-width:250px;"> Piece of Code </div> | Notes                                                                                                                                                                                                                                                                                                        |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `class FancyObject: ...`                            | Declares a class that has "setup" code (in `__init__`), and "cleanup" code (in `cleanup`). The setup and cleanup code is represented by printing out some messages.                                                                                                                                          |
| `@pytest.fixture`                                   | Registers the following function `so_fancy` as a fixture                                                                                                                                                                                                                                                     |
| `def so_fancy():`                                   | Declares the `so_fancy` function, which makes use of the `FancyObject` class                                                                                                                                                                                                                                 |
| `fancy_object = FancyObject()`                      | Creates a new `FancyObject` instance, which runs the code in the `__init__` function. The instance is assigned to the `fancy_object` variable.                                                                                                                                                               |
| `yield fancy_object`                                | Temporarily halts the `so_fancy` function, returning the `fancy_object` instance. The `yield` keyword is a Python keyword that lets functions suspend themselves (optionally returning a value) so that they can resume from the same spot later!                                                            |
| `fancy_object.cleanup()`                            | This code wil run when the `so_fancy` function resumes. It will perform the "cleanup" code for this instance.                                                                                                                                                                                                |
| `def test_so_fancy( ... ): ...`                     | Declares a test function that `pytest` will be able to detect. It begins with `test_`.                                                                                                                                                                                                                       |
| `so_fancy`                                          | This parameter matches the name of the `so_fancy` fixture. When `pytest` runs this test it will first run the `so_fancy` fixture. The value `yield`ed by `so_fancy` will be used as the value for this parameter. When the test completes, the `so_fancy` fixture will resume at the line after the `yield`. |

Let's run our updated test file, but this time, let's add the `-s` option to `pytest` so that we can see the effects of our `print` calls. Normally `pytest` suppresses `print` output. To add the option, we run the test command as `pytest -s test_fixtures.py`.

The tests should pass, and we will see output resembling:

```
=========================== test session starts ===========================
platform darwin -- Python 3.9.2, pytest-6.2.2, py-1.10.0, pluggy-0.13.1
rootdir: .
collected 3 items

test_fixtures.py ..
FancyObject: True
.
cleanup: False


============================ 3 passed in 0.01s ============================
```

After `test_fixtures.py` we see two dots, which are the first two tests passing.

The next line has `FancyObject: True`, which must have come from the `__init__` method of `FancyObject`. When the third test ran, `pytest` saw the `so_fancy` parameter and matched it to the `so_fancy` fixture. When the `so_fancy` fixture ran, it created a new instance of `FancyObject`, causing the `print` in the `__init__` to run.

Next, we see `.` on its own line. `pytest` printed this to indicate that the third test passed.

Since the third test passed, we can tell that the test function received the value from the `yield` statement in `so_fancy` fixture as the value in the `so_fancy` parameter. We successfully asserted that is _is_ fancy. Then after calling `or_is_it`, we asserted that it is no longer fancy. Once the test completed, `pytest` printed the `.` indicating success.

The last line of test output prints `cleanup: False`. This is from the `cleanup` method of our `FancyObject` instance. This was called when the `so_fancy` fixture resumed running _after_ the test completed. We can tell this is the same object instance that was passed in to our test, because we toggled the state of `fancy` in our test, and we see that the `False` in the output comes from `self.fancy`.

So with the `yield` keyword in our fixture, we were able to create an object, then give that object to our test to use, and finally cleanup that same object when the fixture resumed after the test. All of the setup and cleanup code related to that object is kept neatly together within the fixture, and all we had to do was list the fixture as a dependency to our test!

### !callout-info

## `yield` Creates Generators and Coroutines

The Python `yield` keyword is usually used for working with _generators_ and _coroutines_. We shouldn't try to use it in regular functions. `pytest` is taking care of some of the details behind the scenes to make it seem like our fixtures that use `yield` are being called like normal functions. In general, we can't do so in our own code.

<br />

Generators and coroutines are powerful features in Python, but are beyond the scope of this curriculum. We will only use `yield` in the context of fixtures. But generators and coroutines can be an interesting topic for further research. Follow your curiosity!

### !end-callout

## Summary

Fixtures let us move our setup and cleanup code into shared functions. These functions are clearly marked with the `@pytest.fixture` decorator so we can be confident that those functions are used for test setup and cleanup. We can declare that a test depends on a particular fixture by listing its name as a parameter to the test.

The examples we looked at in this lesson aren't very "useful", but in real cases where we use fixtures, we can perform more complicated setup. We could initialize the resources needed to test our API endpoints, or set up or tear down a test database, as we'll see in the next lesson!

### !callout-info

## Let's Cleanup Our Test File!

We can delete the `test_fixtures.py` file from our project now! Or we can set it aside in another folder if we'd like to refer back to it later. But let's be sure to remove it from this project since it was only being used as an example for this lesson!

### !end-callout

## Check for Understanding

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
### !challenge

* type: multiple-choice
* id: cb671089-b4e2-4f76-9c3f-ace9c2e88f4e
* title: Fixtures

##### !question

We want to write a test making use of a fixture. Assuming our test file imports `pytest`, which of the following correctly declares a fixture and a test that uses it?

##### !end-question

##### !options

* ```python
@pytest.fixture
def my_fixture():
    pass

def check_my_fixture(my_fixture):
    pass
```
* ```python
def my_fixture():
    pass

def test_my_fixture(my_fixture):
    pass
```
* ```python
@pytest.fixture
def my_fixture():
    pass

def test_my_fixture():
    my_fixture()
```
* ```python
@pytest.fixture
def my_fixture():
    pass

def test_my_fixture(my_fixture):
    pass
```
* ```python
@pytest.fixture
def my_fixture():
    pass

def test_my_fixture():
    pass
```

##### !end-options

##### !answer

* ```python
@pytest.fixture
def my_fixture():
    pass

def test_my_fixture(my_fixture):
    pass
```

##### !end-answer

##### !explanation

Here's an explanation for each option:

1. This option doesn't follow `pytest` naming conventions, so it will not be recognized as a test.
1. This option omits the `@pytest.fixture` decorator.
1. This option calls the fixture function directly. `pytest` disallows this and will raise an error.
1. This option is correct. It uses the decorator, follows `pytest` naming conventions, and declares the fixture as a dependency in its parameter list.
1. This option properly declares the fixture, but doesn't list it in the test parameter list.

##### !end-explanation

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->

<!-- Question Takeaway -->
<!-- prettier-ignore-start -->
### !challenge
* type: paragraph
* id: 43d9c16d
* title: Fixtures
##### !question

What was your biggest takeaway from this lesson? Feel free to answer in 1-2 sentences, draw a picture and describe it, or write a poem, an analogy, or a story.

##### !end-question
##### !placeholder

My biggest takeaway from this lesson is...

##### !end-placeholder
### !end-challenge
<!-- prettier-ignore-end -->
