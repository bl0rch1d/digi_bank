# Digibank test task application

## Local deployment
1. `bundle install` to install dependencies
2. `bundle exec rake db:setup` to setup the DB.
3. `lefthook install` to install the lefthook
4. `rails s` to run the application
5. Log in to the account using users from `db/seeds/users_with_transaction_history.seeds.rb` or `db/seeds/users_with_empty_balance.seeds.rb`

## Linting and testing
* `lefthook run lint` to run rubocop
* `lefthook run security_audit` to run bundle-audit, brakeman and bundle-leak
* `bundle exec rspec` to run test suite
