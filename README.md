# RemoteAssessment

1. `mix deps.get`
2. `mix ecto.setup`
3. `iex -S mix phx.server`
4. `RemoteAssessment.UserPointsUpdater.query_user_points()`
5. Open `http://localhost:4000/` to see two users as JSON

# TODO

- Actually add tests (didn't initially for time)
- OpenAPI spec (via `open_api_spex`)
- LiveView to view (and possibly edit?) all users
