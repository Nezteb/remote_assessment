defmodule RemoteAssessment.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias RemoteAssessment.Repo
  alias RemoteAssessment.Users.User

  require Logger

  def get_two_users_above_threshold(min_points) do
    User
    |> where([u], u.points > ^min_points)
    |> limit(2)
    |> Repo.all()
  end

  def randomize_all_user_points do
    Repo.transaction(fn ->
      Repo.stream(User)
      |> Stream.chunk_every(1000)
      |> Task.async_stream(fn users ->
        Enum.map(users, fn user ->
          new_points = Enum.random(0..100)

          # Logger.debug(
          #   "Randomizing points for user: #{user.id}, before: #{user.points}, after: #{new_points}"
          # )

          update_user(user, %{
            points: new_points
          })
        end)
      end)
      |> Stream.run()
    end)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
