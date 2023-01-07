defmodule RemoteAssessment.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RemoteAssessment.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        points: 0
      })
      |> RemoteAssessment.Users.create_user()

    user
  end
end
