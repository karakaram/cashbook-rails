# cashbook-rails

## Development

Initialize

```
docker-compose build
docker-compose run --rm app rails db:create
docker-compose run --rm app rails db:migrate
docker-compose run --rm app rails db:seed
docker-compose run --rm app rails g active_admin:webpacker
docker-compose up
```

Create Model

```
docker-compose exec app rails generate model ExpenseType name:string order:integer
docker-compose exec app rails generate model IncomeType name:string order:integer
docker-compose exec app rails generate model Expense admin_user:references expense_type:references name:string 'price:decimal{9,0}' paid_on:date
docker-compose exec app rails generate model Income admin_user:references income_type:references name:string 'price:decimal{9,0}' earned_on:date
docker-compose exec app rails generate model RegularExpense admin_user:references expense_type:references name:string 'price:decimal{9,0}'
docker-compose exec app rails generate model MonthlyExpense expense_type:references 'price:decimal{9,0}' paid_on:date
```

Migrate Database

```
docker-compose exec app rails db:migrate
```

Create Admin

```
docker-compose exec app rails generate active_admin:resource ExpenseType
docker-compose exec app rails generate active_admin:resource IncomeType
docker-compose exec app rails generate active_admin:resource Expense
docker-compose exec app rails generate active_admin:resource Income
docker-compose exec app rails generate active_admin:resource RegularExpense
docker-compose exec app rails generate active_admin:resource MonthlyExpense
```
