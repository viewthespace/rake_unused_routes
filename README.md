[![CircleCI](https://circleci.com/gh/viewthespace/rake_unused_routes.svg?style=svg)](https://circleci.com/gh/viewthespace/rake_unused_routes)
[![Code Climate](https://codeclimate.com/repos/585f1177508ac60076005e46/badges/bfd930692c43034fec1f/gpa.svg)](https://codeclimate.com/repos/585f1177508ac60076005e46/feed)

# RakeUnusedRoutes

Identify unused routes within your rails routes.rb file by reading in a csv file of all controllers hit within a given time period.  The csv file can most easily be generated with New Relic.  

This gem is inspired by [newrelic_route_check](https://github.com/livingsocial/newrelic_route_check)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rake_unused_routes'
```

And then execute:

    $ bundle


## Usage

### Generate CSV file

The easiest way to generate a CSV file is by exporting all controllers from the all transactions page within newrelic.  To get there:

1. Navigate to Transactions
1. Select "Last 7 Days ending now" within time picker
1. Pick type Web
1. Click "Show all transactions table"
1. Click "Export as CSV" 

![New Relic Transactions](https://vts-monosnap.s3.amazonaws.com/Transactions_-_VTS_Production_-_New_Relic_2016-12-22_17-48-43__eprql.png)

Place the exported file under $RAILS_ROOT/tmp/ with the name controller_summary.csv

### Generate unused routes

Run:

```
rake unused_routes
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viewthespace/rake_unused_routes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

