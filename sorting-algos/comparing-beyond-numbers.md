## Comparing Things Beyond Numbers

Often we need to sort items which are not numeric. How does one sort Student objects, or Slack Channels? The answer is Ruby's Spaceship Operator `<=>`!

The spaceship operator compares two objects `a <=> b` and returns

- -1 if a < b
- 0 if a == b
- 1 if a > b

When you make a class you can override the `def <=> (b)` method provided by Ruby's object class. In the class below we overrode the inherited method. If a student is being compared with a non-student object the method will use the student name and the String class' implementation of `<=>`. If the other object is an instance of Student, then the method will return -1 if the current student's name comes earlier than `other_value`. If they have the same name then the method will return 0 and if the current student comes later it will return 1.

```ruby
class Student
  attr_reader :name, :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def <=> (other_value)
    if other_value.class != Student
      return name <=> other_value
    end

    if name < other_value.name
      return -1
    elsif name == other_value.name
      if grade < other_value.grade
        return -1
      elsif grade > other_value.grade
        return 1
      end

      return 0
    elsif name > other_value.name
      return 1
    end
  end
end
```

Then once this method exists you can sort a list of students by doing the following.

```ruby
list = [Student.new('Zane', 11), Student.new('Alice', 9), Student.new('Carmen', 12)]

# reorders the list to:
# Alice, Carmen, Zane
list.sort!
```

While `<=>` is a **ruby specific** method, many languages have similar methods to compare different objects and arrange ordering.