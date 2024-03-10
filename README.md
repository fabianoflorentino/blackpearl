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

### Database

```mermaid
erDiagram
  CUSTOMER ||--o{ TRANSACTION : has_many

  CUSTOMER {
    UUID id
    STRING name
    INT limit
    INT balance
    STRING email
    STRING password
    DATETIME created_at
    DATETIME updated_at
  }

  TRANSACTION {
    UUID id
    UUID customer_id
    STRING kind
    INT amount
    TEXT description
    DATETIME created_at
    DATETIME updated_at
  }
```

## Endpoints

### CUSTOMER

- `GET /customers`: List all customers
- `GET /customers/:id`: Show a customer
- `POST /customers`: Create a customer
- `PATCH /customers/:id`: Update a customer
- `DELETE /customers/:id`: Delete a customer

### Customer Parameters

| Parameter | Type | Description | Required | Observations |
| :--- | :---: | :--- | :---: | :--- |
| name | string | Customer name | true | Customer name must have maximum 100 characters |
| limit | integer | Customer limit | true | Customer limit must be greater than 0 |
| email | string | Customer email | true | Customer email must be a valid email |
| password | string | Customer password | true | Customer password must have minimum 8 characters |

#### Customer Request Example

`cURL`

```shell
curl --location --request POST 'http://localhost:9999/customers' \
--header 'Content-Type: application/json' \
--data '{
  "customer": {
    "name": "John Doe",
    "limit": 1000,
    "email": "customer@example.com",
    "password": "12345678"
  }
}'
```

### EXTRACT

- `GET /customers/:customer_id/extract`: List all transactions of a customer

### TRANSACTION

- `POST /customers/:customer_id/transactions`: Create a transaction for a customer

### Transaction Parameters

| Parameter | Type | Description | Required | Observations |
| :--- | :---: | :--- | :---: | :--- |
| kind | string | Transaction kind (c for credit, d for debit) | true | Transaction kind must be c or d |
| amount | integer | Transaction amount | true | Transaction amount must be greater than 0 |
| description | text | Transaction description | true | Transaction must have maximum 10 characters |

#### Transaction Request Example

`cURL`

```shell
curl --location 'http://localhost:9999/customers/5c515ff2-7236-4543-8cf4-92c02acc86bc/transactions' \
--header 'Content-Type: application/json' \
--data '{
  "transaction": {
    "amount": 2,
    "kind": "d",
    "description": "debt"
  }
}'
```
