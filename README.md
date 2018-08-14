[![CircleCI](https://circleci.com/gh/edgibbs/truss-interview.svg?style=svg)](https://circleci.com/gh/edgibbs/truss-interview)

## Build and Run Instructions

Incomplete but functional (mostly doesn't handle any durations, but didn't want to push past ~4 hour limit)

Solution was built in Ruby 2.5.1 with bundler. Ran mostly in Mac OS 10.13,
but should work in linux as well according to Circle CI builds.

Build with:

```sh
bundle install
```

Can run with:

```sh
cat sample.csv | ./normalizer > output.csv
```

## Notes
Spent a good deal of time spinning with Ruby's internal CSV library.
After that not too bad other than remembering all sorts of fun
programming tasks like UTF-8 conversion and time zones.
TDD with rspec, crude functional test is running on CircleCI just
checking that commands work and that invalid lines are removed.
CircleCI was added just for fun, I usually just go with Travis, but
it seemed like a fine time to experiment.

