# Digibank test task application

## Local deployment
1. `bundle install` to install dependencies
2. `bundle exec rake db:setup` to setup the DB.
3. `lefthook install` to install the lefthook
4. `rails s` to run the application

## Linting and testing
* `lefthook run lint` to run rubocop
* `lefthook run security_audit` to run bundle-audit, brakeman and bundle-leak
* `bundle exec rspec` to run test suit
