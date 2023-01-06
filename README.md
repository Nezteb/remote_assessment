# RemoteAssessment

1. `mix deps.get`
2. `mix ecto.setup`
3. `iex -S mix phx.server`
4. Look for the PID in the UserPointsUpdater log
5. Run `RemoteAssessment.UserPointsUpdater.query_user_points(pid(0, 593, 0))` but with the correct PID
