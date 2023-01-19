# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RemoteAssessment.Repo.insert!(%RemoteAssessment.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

number_of_users_to_seed = 1_000_000

# if chunk size is 50_000, "postgresql protocol can not handle 150000 parameters, the maximum is 65535"
# because we are inserting 3 parameters for each user, so 50_000 * 3 = 150_000
# ideal chunk size is 65535 / 3 = 21_845, so we'll round to 20_000
chunk_size = 20_000

IO.puts("Starting to seed #{number_of_users_to_seed} users!")

now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
users = List.duplicate(%{points: 0, inserted_at: now, updated_at: now}, number_of_users_to_seed)

Enum.chunk_every(users, chunk_size)
|> Enum.reduce(0, fn users_chunk, acc ->
  RemoteAssessment.Repo.insert_all(RemoteAssessment.Users.User, users_chunk)

  new_acc = acc + chunk_size
  percentage_done = Decimal.div(new_acc, number_of_users_to_seed) |> Decimal.mult(100) |> Decimal.round() |> Decimal.to_string(:normal)
  IO.puts("Insert users: #{new_acc} / #{number_of_users_to_seed} (#{percentage_done}%)")

  new_acc
end)

IO.puts("Done seeding #{number_of_users_to_seed} users!")
