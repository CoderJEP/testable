# Takehome for QA engineer position.

*IMPORTANT: Fork this repository!* 

## Task

We created a test school with a course that contains 4 lecture.
Your task is to write tests where you enroll in a course and complete it.
We've setup Rspec and Cucumber in this repo.
Feel free to choose one that fits you the best, or use any other e2e testing framework.


## Setup

Install dependencies for Rspec or Cucumber if you choose to use one of them:
```
gem install bundler
```

```
bundle install
```

## Test school base url:

* [takehome.zeachable.com](http://takehome.zeachable.com)

Feel free to reach out if you have any questions!

## Execution
```
bundle exec rspec ./spec/features/test_spec.rb
```

## Style Guide Enforcement
This repo uses Rubocop and Overcommit to enforce a basic Ruby Style Guide. Rubocop will be run against modified lines on every commit attempt. 

**Setup overcommit locally:**
```
 bundle exec overcommit --install
 ```
**To execute overcommit manually:**
```
 .git/hooks/pre-commit
 ```