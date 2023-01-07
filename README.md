# Remote Coding Assessment

There are two ways to run/test this

## Docker

1. `make`
2. Open `http://localhost:4000/` to see two users as JSON
3. To query the GenServer directly: `make query`
4. `make down` when finished

To run tests:
1. `make test`

## Local Elixir + Postgres

1. `mix deps.get`
2. `mix ecto.setup`
3. `iex -S mix phx.server`
4. `RemoteAssessment.UserPointsUpdater.query_user_points()`
5. Open `http://localhost:4000/` to see two users as JSON

To run tests:
1. `mix test`

# TODO

- Actually add tests (didn't initially for time)
- OpenAPI spec (via `open_api_spex`)
- LiveView to view (and possibly edit?) all users
