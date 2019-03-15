## TradeStation

TradeStation is a full stack web application that allows users to simulate stock trades (paper trade) by providing accurate stock prices and charts via a 3rd party API.  TradeStation saves user transactions and calculates a total profit/loss value when a trade is fully or partially closed.  Because all open and closed trades are recorded in a Rails API, users can easily test strategies and track results.

## TradeStation API

The TradeStation API is responsible for storing user created trades and performing calculations to return an accurate total profit loss after each transaction.  It was built using Ruby on Rails and interacts with a relational database (PostgreSQL).

## Technologies Used

-Ruby -Rails -PostgreSQL

## Planning & Process

I began building the TradeStation API by generating a scaffold and migration for Trades after defining necessary tables in an ERD.  I then migrated the table into the schema and tested it's functionality with curl-scripts. Next I added an account balance row to the user model and created a one to many relationship between user and trades by adding a user reference to the trades table.  In order to add calculation functionality, I created a calculation class that inherits from protected controller and has methods that derive a total profit/loss value. To use those methods in the trades controller, I had to change the class inheritance of the trades controller from protected to calculation.

## Future Considerations

As TradeStation is further developed I will add account balance calculations, broker fee calculations, and aws integration.

## Deployed Sites

API: https://lit-reef-77205.herokuapp.com/

Client: https://mverost44.github.io/stock-app-client/

## Link to ERD

ERD: https://www.lucidchart.com/publicSegments/view/6c988b5f-f131-4808-b904-a021fb1e397e/image.png

## Available Routes
```
Prefix Verb   URI Pattern                Controller#Action
         trades GET    /trades(.:format)          trades#index
                POST   /trades(.:format)          trades#create
          trade GET    /trades/:id(.:format)      trades#show
                PATCH  /trades/:id(.:format)      trades#update
                PUT    /trades/:id(.:format)      trades#update
                DELETE /trades/:id(.:format)      trades#destroy
       examples GET    /examples(.:format)        examples#index
                POST   /examples(.:format)        examples#create
        example GET    /examples/:id(.:format)    examples#show
                PATCH  /examples/:id(.:format)    examples#update
                PUT    /examples/:id(.:format)    examples#update
                DELETE /examples/:id(.:format)    examples#destroy
  closed_trades GET    /closed-trades(.:format)   trades#index_closed
        sign_up POST   /sign-up(.:format)         users#signup
        sign_in POST   /sign-in(.:format)         users#signin
       sign_out DELETE /sign-out(.:format)        users#signout
change_password PATCH  /change-password(.:format) users#changepw
```

## Repos

Client: https://github.com/mverost44/stock-app-client

API: https://github.com/mverost44/stock-app-api

## Setup & Installation

1. Fork and Clone this repository
2. Run `bundle install`
3. Create a .env file and store generated secret keys as `SECRET_KEY_BASE_<DEVELOPMENT|TEST>` using `bundle exec rails secret`
4. Setup your database:

```
- bin/rails db:drop (if it already exists)
- bin/rails db:create
- bin/rails db:migrate
- bin/rails db:seed
- bin/rails db:examples
```
5. You can use `bin/rails server` to run on localhost!
