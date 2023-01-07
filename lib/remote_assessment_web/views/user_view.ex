defmodule RemoteAssessmentWeb.UserView do
  use RemoteAssessmentWeb, :view

  def render("index.json", %{result: {users, last_queried_time}}) do
    %{
      users: users,
      last_queried_time: last_queried_time
    }
  end
end
