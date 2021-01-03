# cashbook-rails

```
docker-compose build
docker-compose run --rm app rails db:create
docker-compose run --rm app rails db:migrate
docker-compose run --rm app rails db:seed
docker-compose run --rm app rails g active_admin:webpacker
docker-compose up
```
