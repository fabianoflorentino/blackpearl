# Black Pearl

[![Brakeman](https://github.com/fabianoflorentino/blackpearl/actions/workflows/brakeman.yml/badge.svg)](https://github.com/fabianoflorentino/blackpearl/actions/workflows/brakeman.yml)
[![RSpec](https://github.com/fabianoflorentino/blackpearl/actions/workflows/rspec.yml/badge.svg)](https://github.com/fabianoflorentino/blackpearl/actions/workflows/rspec.yml)
[![Rubocop](https://github.com/fabianoflorentino/blackpearl/actions/workflows/rubocop.yml/badge.svg)](https://github.com/fabianoflorentino/blackpearl/actions/workflows/rubocop.yml)

## Project to Study Software Development

This project is a simple application to study software development using Ruby on Rails. The main goal is to learn how to build a web api application using the Ruby on Rails framework.

This project are inspired by the [Rinha de Backend](https://github.com/zanfranceschi/rinha-de-backend-2024-q1) project. The project is a api application to manage a customers credit and debit transactions.

## Architecture

```mermaid
graph LR
  user(User)
  black_pearl_api_1(API Black Pearl)
  black_pearl_api_2(API Black Pearl)
  load_balancer(Load Balancer)
  database[(Database)]

  subgraph Proxy
    load_balancer
  end

  subgraph Application
    load_balancer
    black_pearl_api_1
    black_pearl_api_2

  end

  subgraph Data
    database
  end

  user --> load_balancer -.-> black_pearl_api_1 & black_pearl_api_2
  black_pearl_api_1 & black_pearl_api_2 -.-> database

  classDef default fill: #808B96, stroke: #000000, color: #ffffff
  classDef black_pearl fill: #000000, stroke: #ffffff, color: #ffffff
  classDef load_balancer fill: #009900, stroke: #ffffff, color: #ffffff
  classDef database fill: #336791, stroke: #ffffff, color: #ffffff
  classDef application fill: #2C3E50, stroke: #000000, color: #ffffff

  class user default
  class Application application
  class Proxy application
  class Data application
  class load_balancer load_balancer
  class black_pearl_api_1 black_pearl
  class black_pearl_api_2 black_pearl
  class database database
```
