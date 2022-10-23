# Beerlover, a beer rating app ![Main](https://github.com/melimet/ratebeer/actions/workflows/main.yml/badge.svg) [![Maintainability](https://api.codeclimate.com/v1/badges/dd0c89d2857f2395a3fd/maintainability)](https://codeclimate.com/github/Melimet/ratebeer/maintainability) 
## Links
https://beerlover.fly.dev/ edit: beerlover was taken down due to fly.io only allowing hosting of 2 cloud instances for free 😭

## What?

Beerlover is a beer rating website with multiple cool functionalities made using Ruby on Rails. That's pretty much it I guess.

## How to run it? 

0. Have access to a linux terminal
1. Clone the repo with 
```
git clone https://github.com/Melimet/ratebeer.git
```

2. Install rbenv using [this guide](https://github.com/rbenv/rbenv#installation)
3. Install and set ruby to use version 3.1.2 with 
```
rbenv install 3.1.2 
rbenv global 3.1.2
```
3. Install rails with 
```
echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc
gem install bundler
gem install rspec
gem install rake
rbenv rehash
gem install rails -v 7.0.4
rbenv rehash
```

4. CD in to the repo that you cloned earlier and start the project with 
 ```
 rails s
 ```
Beermap page or weather api will not work, but that is only a small part of the project. If you really want to have weatherAPI and BeerMapping then you need to generate apikeys from [Weatherstack](https://weatherstack.com/) and [Beermapping](https://beermapping.com/api/)

With the apikeys in hand you can start the project via running and enjoy the amazing functionalities!
```
export BEERMAPPING_APIKEY="your apikey"
export WEATHERSTACK_APIKEY="your 2nd apikey"
rails s
```
 