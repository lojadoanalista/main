# Walk App/Lib Skeleton for mruby

POC to CloudWalk gems and libs, pure ruby implementation.

This repo is expected to be used mainly by the CloudWalk's CLI tool at the point of creating new applications, but feel free to use it for your purposes.

## What's inside?

- A small Ruby application that uses [da_funk](https://github.com/cloudwalkio/da_funk).
- Example test cases.
- All the scripts needed to make it work.

# Folders Structure

```
lib/
  main.rb             # Simple example application
test/
  integration/
    skeleton_test.rb  # Example of an integration test
  unit/
    skeleton_test.rb  # Example of an unit test
  test_helper.rb      # A small file to help testing this app
  test_run.rb         # The file that says which tests are to be executed
```

## Setup

1. Install Ruby(1.9.3 mruby compatible)
2. Bundle `bundle install`

## Running

Make sure you have either mruby or the CloudWalk CLI tool, then run `rake` to build the app, and one of the following commands to see it working, depending on your interests:

- `cloudwalk emulate`: to run the application in a graphical emulator in a separated window.
- `cloudwalk run`: to run the application in text mode in the same window.

## Deploying

In case you're using this skeleton from a new application created by our CLI, your application will be deployed to our servers after `git push`. Be sure to add all the files you require and to test everything before pushing, otherwise the deploy will be rejected.

## Test

1. Ruby Environment `rake test`
2. MRuby Environment `rake mtest`

## Customizing the app

To customize the application, read our docs at <https://docs.cloudwalk.io/en/cli> or check [da_funk's source code](https://github.com/cloudwalkio/da_funk).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# License
under the MIT License:

* http://www.opensource.org/licenses/mit-license.php
