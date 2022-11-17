# Activity: Solar System API - Wave 07

Follow directions from your classroom instructor for completing this activity.

## Identifying Dependencies

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: fe39847e-49db-415f-9b7b-36fe199bc83d
* title: `to_dict` refactor
<!-- * points: [1] (optional, the number of points for scoring as a checkpoint) -->
<!-- * topics: [python, pandas] (Checkpoints only, optional the topics for analyzing points) -->

##### !question

Write down your dependencies for the `to_dict` refacotr.

##### !end-question

##### !placeholder



##### !end-placeholder

<!-- other optional sections -->
<!-- !hint - !end-hint (markdown, hidden, students click to view) -->
<!-- !rubric - !end-rubric (markdown, instructors can see while scoring a checkpoint) -->
<!-- !explanation - !end-explanation (markdown, students can see after answering correctly) -->

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->

<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: cfe8e4b8-e3b1-433b-b627-74af3cac4dea
* title: `from_dict` refactor
<!-- * points: [1] (optional, the number of points for scoring as a checkpoint) -->
<!-- * topics: [python, pandas] (Checkpoints only, optional the topics for analyzing points) -->

##### !question

Write down your dependencies for the `from_dict` refacotr.

##### !end-question

##### !placeholder



##### !end-placeholder

<!-- other optional sections -->
<!-- !hint - !end-hint (markdown, hidden, students click to view) -->
<!-- !rubric - !end-rubric (markdown, instructors can see while scoring a checkpoint) -->
<!-- !explanation - !end-explanation (markdown, students can see after answering correctly) -->

### !end-challenge
<!-- >>>>>>>>>>>>>>>>>>>>>> BEGIN CHALLENGE >>>>>>>>>>>>>>>>>>>>>> -->
<!-- Replace everything in square brackets [] and remove brackets  -->

### !challenge

* type: paragraph
* id: 94f0021c-9b97-4aa2-adfb-6c661ff5c243
* title: `validate_model` refactor
<!-- * points: [1] (optional, the number of points for scoring as a checkpoint) -->
<!-- * topics: [python, pandas] (Checkpoints only, optional the topics for analyzing points) -->

##### !question

Write down your dependencies for the `validate_model` refacotr.

##### !end-question

##### !placeholder



##### !end-placeholder

<!-- other optional sections -->
<!-- !hint - !end-hint (markdown, hidden, students click to view) -->
<!-- !rubric - !end-rubric (markdown, instructors can see while scoring a checkpoint) -->
<!-- !explanation - !end-explanation (markdown, students can see after answering correctly) -->

### !end-challenge

<!-- ======================= END CHALLENGE ======================= -->
<!-- ======================= END CHALLENGE ======================= -->

## Refactoring Checklist

<!-- prettier-ignore-start -->
### !challenge
* type: tasklist
* id: 89180cb5-e695-489a-a275-bb75e040c765
* title: Refactor
##### !question

Check off each refactor you completed.

##### !end-question
##### !options

* Refactor the code in `routes.py` that converts a `Planet` model into a `Dictionary` to a resuseable helper function named `to_dict` in the `Planet` model's class
* Refactor the code for creating a `Planet` model in the `create_planet` route to use the class method `from_dict` in `planet.py` that converts a dictionary into an instance of our `Planet` model class.
* Refactor the function `validate_planet` into a more flexible function `validate_model` which can be used for any model class.

##### !end-options
### !end-challenge
<!-- prettier-ignore-end -->